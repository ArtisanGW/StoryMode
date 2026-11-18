// Checks the NPC and place names in Locales against the game's own names on
// WoW Forever: NPCs from Wowhead's Forever tooltips in each language, places
// from Forever's AreaTable (wago.tools). Prints what differs; --apply writes
// the official names (an NPC's own key, a place's own key, and a place that is
// one part of a "Place, Zone" string), and replaces an NPC's old translation
// inside that language's longer strings too.
//
//   node _Dev/tools/official-npc-place-names.mjs [root] [--cmangos ClassicDB.sql.gz] [--apply]
//
// NPC IDs come from the cmangos Classic database when given (the creature that
// gives a quest, for Classic NPCs) and else from Wowhead's search. Wowhead has
// no Italian for Forever, so Italian NPC names come from its Retail data, for
// NPCs Retail still names the same.

import { mkdir, readFile, readdir, writeFile } from "node:fs/promises";
import path from "node:path";
import { WOWHEAD_LOCALES, loadCmangos, wowheadNpcs } from "./forever-lookups.mjs";

const args = process.argv.slice(2);
const root = path.resolve(args.find((arg, i) => !arg.startsWith("--") && args[i - 1] !== "--cmangos") || process.cwd());
const option = (name) => (args.includes(`--${name}`) ? args[args.indexOf(`--${name}`) + 1] : null);
const apply = args.includes("--apply");
const cacheDir = path.join(root, ".localization-cache");
const LOCALES = ["deDE", "esES", "esMX", "frFR", "itIT", "koKR", "ptBR", "ruRU", "zhCN", "zhTW"];
const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

const unescapeLua = (value) => value.replace(/\\(n|"|\\)/g, (_, c) => (c === "n" ? "\n" : c));
const escapeLua = (value) => value.replace(/\\/g, "\\\\").replace(/\n/g, "\\n").replace(/"/g, '\\"');
const escapeRegex = (value) => value.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
const ENTRY = /^L\["((?:[^"\\]|\\.)*)"\] = "((?:[^"\\]|\\.)*)"/gm;

async function readLocale(locale) {
  const text = await readFile(path.join(root, "Locales", `${locale}.lua`), "utf8");
  return new Map([...text.matchAll(ENTRY)].map((m) => [unescapeLua(m[1]), unescapeLua(m[2])]));
}

async function cached(name, compute) {
  const file = path.join(cacheDir, name);
  try { return JSON.parse(await readFile(file, "utf8")); } catch { /* not cached */ }
  const value = await compute();
  await mkdir(cacheDir, { recursive: true });
  await writeFile(file, JSON.stringify(value));
  return value;
}

// ---------------------------------------------------------------------------
// NPC names
// ---------------------------------------------------------------------------

async function storyNpcNames() {
  const names = new Set();
  async function walk(dir) {
    for (const entry of await readdir(dir, { withFileTypes: true })) {
      const full = path.join(dir, entry.name);
      if (entry.isDirectory()) { await walk(full); continue; }
      if (!entry.name.endsWith(".lua")) continue;
      const text = await readFile(full, "utf8");
      for (const m of text.matchAll(/\bnpc = "((?:[^"\\]|\\.)*)"/g)) names.add(unescapeLua(m[1]));
      for (const m of text.matchAll(/^\s+\["((?:[^"\\]|\\.)*)"\] = \{ mapID/gm)) names.add(unescapeLua(m[1]));
    }
  }
  await walk(path.join(root, "Data"));
  return names;
}

async function npcIds(names) {
  const db = option("cmangos") ? await loadCmangos(path.resolve(option("cmangos")), path.join(root, ".forever-scan-cache")) : null;
  const givers = db ? new Set(Object.values(db.starts).flat()) : new Set();
  const byName = new Map();
  if (db) {
    for (const [id, creature] of Object.entries(db.creatures)) {
      const key = creature.name.toLowerCase();
      if (!byName.has(key)) byName.set(key, []);
      byName.get(key).push(Number(id));
    }
  }
  const searchFile = path.join(cacheDir, "wowhead-npc-search.json");
  let search = {};
  try { search = JSON.parse(await readFile(searchFile, "utf8")); } catch { /* first run */ }
  const ids = new Map();
  let blocked = false;
  await mkdir(cacheDir, { recursive: true });
  for (const name of names) {
    const entries = (byName.get(name.toLowerCase()) || []).sort((a, b) => a - b);
    const id = entries.find((entry) => givers.has(entry)) || entries[0];
    if (id) { ids.set(name, id); continue; }
    if (search[name] === undefined && !blocked) {
      try {
        search[name] = (await wowheadNpcs(name)).map((npc) => npc.id);
        await writeFile(searchFile, JSON.stringify(search));
      } catch (error) {
        // Wowhead's search refuses scripts after a while; check what's found.
        blocked = true;
        console.warn(`Wowhead's search stopped answering (${error.message}); NPCs not found yet are skipped. Run again later.`);
      }
      await sleep(1500);
    }
    if (search[name]?.[0]) ids.set(name, search[name][0]);
  }
  return ids;
}

async function officialNpcNames(ids) {
  const file = path.join(cacheDir, "official-npc-names.json");
  let names = {};
  try { names = JSON.parse(await readFile(file, "utf8")); } catch { /* first run */ }
  let fetched = 0;
  const tooltipName = async (url) => {
    const response = await fetch(url, { headers: { "User-Agent": "Mozilla/5.0" }, signal: AbortSignal.timeout(20000) }).catch(() => null);
    const name = response?.ok ? (await response.json().catch(() => ({}))).name : null;
    if (++fetched % 200 === 0) await writeFile(file, JSON.stringify(names));
    await sleep(150);
    // Wowhead puts names it has no translation for in brackets, and writes
    // French punctuation with non-breaking spaces the locale files don't use.
    return name && !/^\[.*\]$/.test(name) ? name.replace(/[\u00A0\u202F]/g, " ") : "";
  };
  // Four NPCs at a time; each one's languages one after another.
  const queue = [...ids];
  await Promise.all(Array.from({ length: 4 }, async () => {
  for (let next = queue.shift(); next; next = queue.shift()) {
    const [name, id] = next;
    if (names[`${id}:enUS`] === undefined) names[`${id}:enUS`] = await tooltipName(`https://nether.wowhead.com/forever/tooltip/npc/${id}`);
    for (const [locale, number] of Object.entries(WOWHEAD_LOCALES)) {
      const key = `${id}:${locale}`;
      if (names[key] !== undefined || !number) continue;
      names[key] = await tooltipName(`https://nether.wowhead.com/forever/tooltip/npc/${id}?locale=${number}`);
    }
    // Italian only from Wowhead's Retail data, and only while Retail still
    // calls the NPC what Forever does.
    if (names[`${id}:itIT`] === undefined) {
      const retailEnglish = await tooltipName(`https://nether.wowhead.com/tooltip/npc/${id}`);
      names[`${id}:itIT`] = retailEnglish === name ? await tooltipName(`https://nether.wowhead.com/tooltip/npc/${id}?locale=9`) : "";
    }
  }
  }));
  await mkdir(cacheDir, { recursive: true });
  await writeFile(file, JSON.stringify(names));
  return names;
}

// ---------------------------------------------------------------------------
// Place names
// ---------------------------------------------------------------------------

function csvRows(text) {
  const rows = [];
  let row = [], field = "", quoted = false;
  for (let i = 0; i < text.length; i++) {
    const c = text[i];
    if (quoted) {
      if (c === '"' && text[i + 1] === '"') { field += '"'; i++; }
      else if (c === '"') quoted = false;
      else field += c;
    } else if (c === '"') quoted = true;
    else if (c === ",") { row.push(field); field = ""; }
    else if (c === "\n") { row.push(field.replace(/\r$/, "")); rows.push(row); row = []; field = ""; }
    else field += c;
  }
  if (field || row.length) { row.push(field); rows.push(row); }
  return rows;
}

async function areaNames(build, locale) {
  return cached(`AreaTable-${build}-${locale}.json`, async () => {
    const response = await fetch(`https://wago.tools/db2/AreaTable/csv?build=${build}&locale=${locale}`, {
      headers: { "User-Agent": "Mozilla/5.0" }, signal: AbortSignal.timeout(120000),
    });
    if (!response.ok) throw new Error(`AreaTable ${locale}: HTTP ${response.status}`);
    const [header, ...rows] = csvRows(await response.text());
    const id = header.indexOf("ID");
    const name = header.indexOf("AreaName_lang");
    return Object.fromEntries(rows.filter((row) => row[name]).map((row) => [row[id], row[name].replace(/[\u00A0\u202F]/g, " ")]));
  });
}

// English area name → its official name in each language, when every area
// of that English name has the same one.
async function placeNames() {
  const idsFile = await readFile(path.join(root, "Data", "Forever", "ForeverQuestIDs.lua"), "utf8");
  const build = option("build") || idsFile.match(/WoW Forever ([\d.]+)'s/)?.[1];
  const english = await areaNames(build, "enUS");
  const byEnglish = new Map();
  for (const [id, name] of Object.entries(english)) {
    if (/^UNUSED|^\[|^zz/i.test(name)) continue;
    if (!byEnglish.has(name)) byEnglish.set(name, []);
    byEnglish.get(name).push(id);
  }
  const official = new Map();
  for (const locale of LOCALES) {
    const local = await areaNames(build, locale);
    for (const [name, ids] of byEnglish) {
      const forms = new Set(ids.map((id) => local[id]).filter(Boolean));
      if (forms.size !== 1) continue;
      if (!official.has(name)) official.set(name, {});
      official.get(name)[locale] = [...forms][0];
    }
  }
  return official;
}

// ---------------------------------------------------------------------------

// Strings a Retail story uses: Retail names some NPCs and places differently
// (Sturmwind, Trollbann), so only strings that Classic-era and Forever stories
// alone use take Forever's names.
async function retailStrings() {
  const used = new Set();
  async function walk(dir) {
    for (const entry of await readdir(dir, { withFileTypes: true })) {
      const full = path.join(dir, entry.name);
      if (entry.isDirectory()) { await walk(full); continue; }
      if (!entry.name.endsWith(".lua")) continue;
      const text = await readFile(full, "utf8");
      const header = text.split(/\n\s*(?:startQuest|chapters|prereqs)\s*=/)[0];
      const versions = header.match(/gameVersions\s*=\s*\{([^}]*)\}/)?.[1] || "";
      const classicSide = /\b(classicEra|tbc|forever)\s*=\s*true/.test(versions) || /ClassQuests|[\\/]Forever[\\/]/.test(full);
      if (classicSide) continue;
      for (const m of text.matchAll(/"((?:[^"\\]|\\.)*)"/g)) used.add(unescapeLua(m[1]));
    }
  }
  await walk(path.join(root, "Data"));
  return used;
}
const retailUsed = await retailStrings();
const english = await readLocale("enUS");
const locales = Object.fromEntries(await Promise.all(LOCALES.map(async (locale) => [locale, await readLocale(locale)])));
const findings = [];      // { locale, key, ours, official, kind }
const updates = new Map(); // locale → Map(key → new value)
const phrases = new Map(); // locale → [[old, new]] NPC names inside longer strings
const setUpdate = (locale, key, value) => {
  if (!updates.has(locale)) updates.set(locale, new Map());
  updates.get(locale).set(key, value);
};

const npcNames = [...await storyNpcNames()].filter((name) => english.get(name) === name);
const ids = await npcIds(npcNames);
const officialNpcs = await officialNpcNames(ids);
for (const name of npcNames) {
  const id = ids.get(name);
  if (!id || officialNpcs[`${id}:enUS`] !== name) continue;
  const retail = retailUsed.has(name);
  for (const locale of LOCALES) {
    const official = officialNpcs[`${id}:${locale}`];
    const ours = locales[locale].get(name);
    if (!official || !ours || ours === official) continue;
    findings.push({ kind: "npc", locale, key: name, ours, official, id, retail });
    if (retail) continue;
    setUpdate(locale, name, official);
    if (ours.length >= 4 && ours !== name) {
      if (!phrases.has(locale)) phrases.set(locale, []);
      phrases.get(locale).push([ours, official]);
    }
  }
}

const places = await placeNames();
const SPLIT = /\s*[,，、]\s*/;
for (const [key, value] of english) {
  const parts = value.split(", ");
  if (!parts.some((part) => places.has(part))) continue;
  const retail = retailUsed.has(value);
  // Forever has no Italian place names (its Italian table is English).
  for (const locale of LOCALES.filter((l) => l !== "itIT")) {
    const ours = locales[locale].get(key);
    if (!ours) continue;
    const ourParts = ours.split(SPLIT);
    parts.forEach((part, index) => {
      const official = places.get(part)?.[locale];
      if (!official || ours.includes(official)) return;
      findings.push({ kind: "place", locale, key, ours, official, part, retail });
      if (retail) return;
      // One place per string, or a "Place, Zone" string split the same way:
      // the matching part takes the official name.
      if (parts.length === 1) setUpdate(locale, key, official);
      else if (ourParts.length === parts.length && /[,，、]/.test(ours)) {
        const separators = ours.match(/\s*[,，、]\s*/g);
        const fixed = ourParts.map((p, i) => (i === index ? official : p));
        const current = updates.get(locale)?.get(key);
        const base = current ? current.split(SPLIT) : fixed;
        base[index] = official;
        setUpdate(locale, key, base.map((p, i) => p + (separators[i] || "")).join(""));
      }
    });
  }
}

const byKind = (kind) => findings.filter((finding) => finding.kind === kind);
console.log(`Checked ${npcNames.length} NPC names (${ids.size} found on Wowhead or in cmangos) and ${places.size} place names.`);
console.log(`${byKind("npc").length} NPC and ${byKind("place").length} place translations differ from Forever's; `
  + `${findings.filter((f) => f.retail).length} of them are also in Retail stories and keep Retail's names.`);
for (const finding of findings) {
  console.log(`${finding.locale}  ${finding.kind === "npc" ? `${finding.key} (${finding.id})` : `${finding.key} [${finding.part}]`}: ${finding.ours} → ${finding.official}`
    + (finding.retail ? "   (Retail story too: kept)" : finding.kind === "place" && !updates.get(finding.locale)?.has(finding.key) ? "   (by hand)" : ""));
}
await mkdir(path.join(root, "_Dev", "reports"), { recursive: true });
await writeFile(path.join(root, "_Dev", "reports", "official-npc-place-names.json"), JSON.stringify(findings, null, 1));

if (apply) {
  for (const locale of LOCALES) {
    const file = path.join(root, "Locales", `${locale}.lua`);
    const text = await readFile(file, "utf8");
    const direct = updates.get(locale) || new Map();
    const swaps = (phrases.get(locale) || []).sort((a, b) => b[0].length - a[0].length);
    let changed = 0;
    const out = text.replace(ENTRY, (raw, rawKey, rawValue) => {
      const key = unescapeLua(rawKey);
      let value = direct.get(key) ?? unescapeLua(rawValue);
      if (!direct.has(key) && key !== value && !retailUsed.has(key)) {
        for (const [from, to] of swaps) value = value.replace(new RegExp(escapeRegex(from), "g"), to);
      }
      const line = `L["${rawKey}"] = "${escapeLua(value)}"`;
      if (line !== raw) changed++;
      return line;
    });
    if (changed) { await writeFile(file, out); console.log(`${locale}: ${changed} strings updated`); }
  }
}
