// Outside sources for WoW Forever data the game client can't give us, used by
// forever-quest-scan.mjs:
//   - the cmangos Classic database (cmangos/classic-db on GitHub): every
//     Classic creature's model and who starts each quest, for the portraits
//     of Classic quest givers;
//   - Wowhead's WoW Forever data: its search and tooltips (no human check)
//     for Forever's own NPCs and for quest objectives in each language. Its
//     NPC pages, which hold an NPC's model, refuse scripts, so those are read
//     in a browser (see wowheadModelSnippet).

import { createReadStream } from "node:fs";
import { mkdir, readFile, writeFile, readdir } from "node:fs/promises";
import { createInterface } from "node:readline";
import { createGunzip } from "node:zlib";
import path from "node:path";

const BROWSER_HEADERS = { "User-Agent": "Mozilla/5.0" };
const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

// ---------------------------------------------------------------------------
// cmangos Classic database
// ---------------------------------------------------------------------------

// The tables and columns read from the dump (other columns are dropped).
const CMANGOS_COLUMNS = {
  creature_template: ["Entry", "Name", "ModelId1", "ModelId2", "ModelId3", "ModelId4"],
  creature_questrelation: ["id", "quest"],
  creature_involvedrelation: ["id", "quest"],
  gameobject_template: ["entry", "name"],
  gameobject_questrelation: ["id", "quest"],
  gameobject_involvedrelation: ["id", "quest"],
  quest_template: ["entry", "MinLevel", "QuestLevel", "RequiredClasses", "RequiredRaces", "PrevQuestId", "NextQuestId",
    "ExclusiveGroup", "BreadcrumbForQuestId", "NextQuestInChain", "Title"],
};
const CMANGOS_VERSION = 2;

// Each (...) row of an INSERT's VALUES list, as strings.
function* sqlRows(text) {
  let i = 0;
  while (i < text.length) {
    if (text[i] !== "(") { i++; continue; }
    i++;
    const row = [];
    let current = "";
    let quoted = false;
    while (i < text.length) {
      const c = text[i];
      if (quoted) {
        if (c === "\\") { current += text[i + 1]; i += 2; continue; }
        if (c === "'") {
          if (text[i + 1] === "'") { current += "'"; i += 2; continue; }
          quoted = false; i++; continue;
        }
        current += c; i++; continue;
      }
      if (c === "'") { quoted = true; i++; continue; }
      if (c === ",") { row.push(current.trim()); current = ""; i++; continue; }
      if (c === ")") { row.push(current.trim()); i++; break; }
      current += c; i++;
    }
    yield row;
  }
}

// Reads a cmangos dump (.sql.gz): creatures and their models, objects, who
// starts and ends each quest, and each quest's title, levels, races, classes
// and place in its chain. The result is cached as JSON.
export async function loadCmangos(dumpFile, cacheDir) {
  const cacheFile = path.join(cacheDir, "cmangos.json");
  try {
    const cached = JSON.parse(await readFile(cacheFile, "utf8"));
    if (cached.source === path.basename(dumpFile) && cached.version === CMANGOS_VERSION) return cached;
  } catch { /* no cache yet */ }

  const columns = {};
  const rows = Object.fromEntries(Object.keys(CMANGOS_COLUMNS).map((table) => [table, []]));
  const keep = (table, list) => {
    const at = CMANGOS_COLUMNS[table].map((name) => columns[table].indexOf(name));
    for (const row of list) rows[table].push(at.map((i) => row[i]));
  };
  let table = null;
  let insert = null;
  const lines = createInterface({ input: createReadStream(dumpFile).pipe(createGunzip()), crlfDelay: Infinity });
  for await (const line of lines) {
    if (insert) {
      insert.body += "\n" + line;
      if (line.trimEnd().endsWith(";")) { keep(insert.table, sqlRows(insert.body)); insert = null; }
      continue;
    }
    const create = line.match(/^CREATE TABLE `(\w+)`/);
    if (create) { table = CMANGOS_COLUMNS[create[1]] ? create[1] : null; if (table) columns[table] = []; continue; }
    if (table && line.startsWith("  `") && !rows[table].length) { columns[table].push(line.split("`")[1]); continue; }
    const values = line.match(/^INSERT INTO `(\w+)`(?: \([^)]*\))? VALUES/);
    if (values && CMANGOS_COLUMNS[values[1]]) {
      const body = line.slice(values[0].length);
      if (body.trimEnd().endsWith(";")) keep(values[1], sqlRows(body));
      else insert = { table: values[1], body };
    }
  }

  const creatures = {};
  for (const [entry, name, ...models] of rows.creature_template) {
    creatures[Number(entry)] = { name, models: models.map(Number).filter((model) => model > 0) };
  }
  const objects = Object.fromEntries(rows.gameobject_template.map(([entry, name]) => [Number(entry), name]));
  const relation = (list) => {
    const out = {};
    for (const [who, quest] of list) (out[Number(quest)] ||= []).push(Number(who));
    return out;
  };
  const quests = {};
  for (const [entry, minLevel, level, classes, races, prev, next, group, breadcrumbFor, nextInChain, title] of rows.quest_template) {
    quests[Number(entry)] = {
      title, minLevel: Number(minLevel), level: Number(level), classes: Number(classes), races: Number(races),
      prev: Number(prev), next: Number(next), group: Number(group), breadcrumbFor: Number(breadcrumbFor), nextInChain: Number(nextInChain),
    };
  }
  const result = {
    source: path.basename(dumpFile),
    version: CMANGOS_VERSION,
    creatures,
    objects,
    quests,
    starts: relation(rows.creature_questrelation),
    ends: relation(rows.creature_involvedrelation),
    objectStarts: relation(rows.gameobject_questrelation),
    objectEnds: relation(rows.gameobject_involvedrelation),
  };
  await mkdir(cacheDir, { recursive: true });
  await writeFile(cacheFile, JSON.stringify(result));
  return result;
}

// The cmangos model of the creature called npc that gives one of quests:
// the quest's own starter or ender of that name first, else the only model
// any creature of that name has, else the only quest giver of that name.
export function cmangosModel(db, npc, quests) {
  const same = (id) => db.creatures[id]?.name.toLowerCase() === npc.toLowerCase() && db.creatures[id].models.length;
  for (const [relation, label] of [[db.starts, "starts"], [db.ends, "ends"]]) {
    for (const quest of quests) {
      const hit = (relation[quest] || []).find(same);
      if (hit) return { creature: hit, model: db.creatures[hit].models[0], how: `${label} quest ${quest}` };
    }
  }
  const named = Object.keys(db.creatures).filter(same);
  const models = new Set(named.map((id) => db.creatures[id].models[0]));
  if (models.size === 1) return { creature: Number(named[0]), model: [...models][0], how: "the only creature of that name" };
  const givers = new Set(Object.values(db.starts).flat());
  const giving = named.filter((id) => givers.has(Number(id)));
  const giverModels = new Set(giving.map((id) => db.creatures[id].models[0]));
  if (giverModels.size === 1) return { creature: Number(giving[0]), model: [...giverModels][0], how: "the only quest giver of that name" };
  return null;
}

// ---------------------------------------------------------------------------
// Wowhead
// ---------------------------------------------------------------------------

// Wowhead's language IDs (no Italian).
export const WOWHEAD_LOCALES = { enUS: 0, koKR: 1, frFR: 2, deDE: 3, zhCN: 4, esES: 6, ruRU: 7, ptBR: 8, zhTW: 10, esMX: 11 };

async function json(url, tries = 3) {
  for (let attempt = 1; ; attempt++) {
    try {
      const response = await fetch(url, { headers: BROWSER_HEADERS, signal: AbortSignal.timeout(20000) });
      if (response.status === 404) return null;
      if (!response.ok) throw new Error(`HTTP ${response.status}`);
      return await response.json();
    } catch (error) {
      if (attempt >= tries) throw new Error(`${url}: ${error.message}`);
      await sleep(2000 * attempt);
    }
  }
}

// Wowhead's Forever NPC IDs for an NPC name (exact matches; Wowhead may keep
// several), each with its tooltip's level line, zone and first coordinates.
export async function wowheadNpcs(name) {
  const search = async (query) => (await json(`https://www.wowhead.com/forever/search/suggestions-template?q=${encodeURIComponent(query)}`))?.results || [];
  let results = await search(name);
  // Wowhead's search ignores names with an apostrophe in them (Da'grosh).
  if (!results.some((result) => result.type === 1) && name.includes("'")) results = await search(name.replace(/'/g, ""));
  const ids = results.filter((result) => result.type === 1 && result.name.toLowerCase() === name.toLowerCase()).map((result) => result.id);
  const npcs = [];
  for (const id of ids.slice(0, 5)) {
    const tip = await json(`https://nether.wowhead.com/forever/tooltip/npc/${id}`);
    npcs.push({
      id,
      tooltip: (tip?.tooltip || "").replace(/<[^>]+>/g, "|").replace(/\|+/g, "|").trim(),
      zone: tip?.map?.zone ?? null,
      coords: tip?.map?.coords?.["0"]?.[0] ?? null,
    });
    await sleep(300);
  }
  return npcs;
}

// Scripts to paste into the console of any Wowhead page in a browser
// (Wowhead's NPC and quest pages refuse scripts outside one). They read a page
// every few seconds, stop at Wowhead's human check (complete it, then paste
// the script again: it carries on), and copy what they read as JSON.
/* global window, copy */
async function readModels(ids) {
  window.__models = window.__models || {};
  for (const id of ids) {
    if (window.__models[id] !== undefined) continue;
    const response = await fetch("/forever/npc=" + id);
    const page = await response.text();
    if (!response.ok || /Human Verification/i.test(page.slice(0, 3000))) {
      console.log("Stopped at " + id + ": complete Wowhead's check and paste this again.");
      break;
    }
    const match = page.match(/&quot;typeId&quot;:(\d+),&quot;displayId&quot;:(\d+)/) || page.match(/"typeId":(\d+),"displayId":(\d+)/);
    window.__models[id] = match ? Number(match[2]) : null;
    await new Promise((resolve) => setTimeout(resolve, 5000));
  }
  copy(JSON.stringify(window.__models));
  console.log("Copied " + Object.keys(window.__models).length + " models; save them as a .json file for --displays.");
}

async function readQuestFacts(ids) {
  window.__facts = window.__facts || {};
  for (const id of ids) {
    if (window.__facts[id]) continue;
    const response = await fetch("/forever/quest=" + id);
    const page = await response.text();
    if (!response.ok || /Human Verification/i.test(page.slice(0, 3000))) {
      console.log("Stopped at " + id + ": complete Wowhead's check and paste this again.");
      break;
    }
    const facts = ((page.match(/WH\.markup\.printHtml\("(\[ul\][^"]{0,2500})/) || [])[1] || "").replace(/\\\//g, "/");
    const pick = (label) => (facts.match(new RegExp(label + ":\\s*(.*?)\\[/li\\]")) || [])[1] || "";
    const who = (text) => [...text.matchAll(/\[url=\/?(?:forever\/)?(?:npc|object)=\d+[^\]]*\]([^[]*)/g)].map((m) => m[1]);
    window.__facts[id] = {
      side: pick("Side").replace(/\[[^\]]*\]/g, "").trim(),
      races: [...pick("Races?").matchAll(/race=(\d+)/g)].map((m) => Number(m[1])),
      classes: [...pick("Class(?:es)?").matchAll(/class=(\d+)/g)].map((m) => Number(m[1])),
      start: who(pick("Start")),
      end: who(pick("End")),
    };
    await new Promise((resolve) => setTimeout(resolve, 6000));
  }
  copy(JSON.stringify(window.__facts));
  console.log("Copied the facts of " + Object.keys(window.__facts).length + " quests; save them as a .json file for --facts.");
}

export const wowheadModelSnippet = (ids) => `(${readModels.toString()})(${JSON.stringify(ids)});`;
export const wowheadFactsSnippet = (ids) => `(${readQuestFacts.toString()})(${JSON.stringify(ids)});`;

// Wowhead shows the game's $ tokens as <name>, <class>, <race> (in each
// language) and <male/female>; turn them back into tokens.
const TOKEN_WORDS = {
  N: ["name", "nom", "nombre", "nome", "имя", "이름", "名字"],
  C: ["class", "classe", "clase", "klasse", "класс", "직업", "职业", "職業"],
  R: ["race", "raza", "raça", "volk", "rasse", "раса", "종족", "种族", "種族"],
};

function toTokens(text) {
  let out = text;
  for (const [token, words] of Object.entries(TOKEN_WORDS)) {
    for (const word of words) out = out.replace(new RegExp(`<${word}>`, "giu"), `$${token}`);
  }
  return out.replace(/<([^<>/]+)\/([^<>/]+)>/g, (_, male, female) => `$G${male}:${female};`);
}

function decodeEntities(text) {
  return text.replace(/&lt;/g, "<").replace(/&gt;/g, ">").replace(/&quot;/g, '"').replace(/&#39;/g, "'")
    .replace(/&nbsp;/g, " ").replace(/&amp;/g, "&");
}

// A quest's objective line from its Wowhead tooltip: the first line after the
// header (which may hold the level), in the given language. Forever's data
// first, then Classic's for quests Forever's pages lack.
export async function wowheadObjective(questID, locale = "enUS") {
  const number = WOWHEAD_LOCALES[locale];
  if (number === undefined) throw new Error(`Wowhead has no ${locale}`);
  for (const env of ["forever", "classic"]) {
    const tip = await json(`https://nether.wowhead.com/${env}/tooltip/quest/${questID}${number ? `?locale=${number}` : ""}`);
    // The objective runs from the first line after the header to the
    // requirements (in the tooltip's language, so: the line ending in a colon
    // after an empty line), its paragraphs joined with $B$B as the game does.
    const lines = (tip?.tooltip || "").split(/<br\s*\/?>/i).slice(1).map((line) => decodeEntities(line.replace(/<[^>]+>/g, "")).trim());
    const start = lines.findIndex((line) => line);
    let end = lines.findIndex((line, i) => i > start && /[:：]$/.test(line) && !lines[i - 1]);
    if (end < 0) end = lines.length;
    const objective = start < 0 ? [] : lines.slice(start, end);
    while (objective.length && !objective[objective.length - 1]) objective.pop();
    const text = objective.join("$B");
    // Wowhead shows text it has no translation for in English, in brackets.
    const untranslated = text.startsWith("[");
    if (text && !untranslated && !/[:：]$/.test(text)) return { text: toTokens(text), env, name: tip.name };
  }
  return null;
}

// ---------------------------------------------------------------------------
// Story data: who gives each quest and the models the stories know
// ---------------------------------------------------------------------------

const luaString = (value) => `"${value.replace(/\\/g, "\\\\").replace(/"/g, '\\"')}"`;
const unescapeLua = (value) => value.replace(/\\(["\\])/g, "$1");

// Every story table in Data: its key (SM.<key>), file and npcDisplayIDs.
export async function storyTables(root) {
  const tables = new Map();
  async function walk(dir) {
    for (const entry of await readdir(dir, { withFileTypes: true })) {
      const full = path.join(dir, entry.name);
      if (entry.isDirectory()) { await walk(full); continue; }
      if (!entry.name.endsWith(".lua")) continue;
      const text = await readFile(full, "utf8");
      for (const match of text.matchAll(/^SM\.(\w+) = \{\n([\s\S]*?)^\}/gm)) {
        const block = match[2].match(/^ {4}npcDisplayIDs = \{\n([\s\S]*?)^ {4}\},?$/m)?.[1] || "";
        const models = new Map([...block.matchAll(/\["((?:[^"\\]|\\.)+)"\] = (\d+)/g)].map((m) => [unescapeLua(m[1]), Number(m[2])]));
        tables.set(match[1], { file: full, models });
      }
    }
  }
  await walk(path.join(root, "Data"));
  return tables;
}

// Adds models to stories' npcDisplayIDs (entries: { key, npc, model }), under
// a comment naming where they come from. Names a story already has are kept.
export async function addStoryModels(root, entries, source) {
  const comment = `        -- Quest givers' models from ${source}.`;
  const byKey = new Map();
  for (const entry of entries) {
    if (!byKey.has(entry.key)) byKey.set(entry.key, new Map());
    byKey.get(entry.key).set(entry.npc, entry.model);
  }
  const tables = await storyTables(root);
  const added = new Map();
  for (const [key, models] of byKey) {
    const file = tables.get(key)?.file;
    if (!file) throw new Error(`No story table SM.${key}`);
    const lines = (await readFile(file, "utf8")).split("\n");
    const start = lines.findIndex((line) => line.startsWith(`SM.${key} = {`));
    const end = lines.findIndex((line, i) => i > start && line.startsWith("}"));
    const block = lines.findIndex((line, i) => i > start && i < end && line.startsWith("    npcDisplayIDs = {"));
    let newLines;
    if (block >= 0) {
      const close = lines.findIndex((line, i) => i > block && i < end && /^ {4}\},?$/.test(line));
      const have = lines.slice(block, close).join("\n");
      newLines = [...models].filter(([npc]) => !have.includes(`[${luaString(npc)}]`)).map(([npc, model]) => `        [${luaString(npc)}] = ${model},`);
      if (newLines.length) lines.splice(close, 0, ...(have.includes(comment) ? [] : [comment]), ...newLines);
    } else {
      const at = lines.findIndex((line, i) => i > start && i < end && /^ {4}(prereqs|chapters) = \{/.test(line));
      newLines = [...models].map(([npc, model]) => `        [${luaString(npc)}] = ${model},`);
      lines.splice(at, 0, "    npcDisplayIDs = {", comment, ...newLines, "    },", "");
    }
    if (newLines.length) {
      await writeFile(file, lines.join("\n"));
      added.set(path.relative(root, file), (added.get(path.relative(root, file)) || 0) + newLines.length);
    }
  }
  return added;
}
