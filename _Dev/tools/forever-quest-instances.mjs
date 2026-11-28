// Which dungeon or raid each WoW Forever story quest belongs to, so a quest
// card can say "Uldaman" where the game's tag only says "Dungeon".
//
//   node _Dev/tools/forever-quest-instances.mjs <quest_template.sql> [root] [--build 1.60.1.70938]
//
// <quest_template.sql> is AzerothCore's world table (azerothcore-wotlk,
// data/sql/base/db_world/quest_template.sql), whose QuestSortID files each
// Classic quest under a zone or dungeon. Forever's Map and AreaTable tables
// (wago.tools, kept in .forever-scan-cache) say which areas are dungeons and
// raids. Writes Data/Forever/ForeverQuestInstances.lua: quest ID -> the
// dungeon's area ID, whose name the game gives in the player's language
// (C_Map.GetAreaInfo).
//
// A quest filed under its dungeon's area, or under a subzone of the same
// name outside it (AzerothCore files Uldaman's quests under the Badlands'
// Uldaman, area 1517), gets that dungeon. Forever's own quests aren't in
// AzerothCore, and Classic ones it files under a city: they get the dungeon
// their objective line names, or else the one dungeon the rest of their
// chapter belongs to (a Classic one only if the story marks it, instance =). Quests filed under a
// city or a class (the Dungeon Set 2 starters) keep the game's plain tag.

import { readFile, writeFile, mkdir } from "node:fs/promises";
import { existsSync } from "node:fs";
import path from "node:path";

const args = process.argv.slice(2);
const sqlFile = args.find((a) => !a.startsWith("--"));
const root = args.filter((a) => !a.startsWith("--"))[1] || ".";
const build = args.includes("--build") ? args[args.indexOf("--build") + 1] : "1.60.1.70938";
if (!sqlFile) throw new Error("usage: forever-quest-instances.mjs <quest_template.sql> [root] [--build x]");

function parseCsv(text) {
  const rows = [];
  let row = [], field = "", quoted = false;
  for (let i = 0; i < text.length; i++) {
    const c = text[i];
    if (quoted) {
      if (c === '"') { if (text[i + 1] === '"') { field += '"'; i++; } else quoted = false; } else field += c;
    } else if (c === '"') quoted = true;
    else if (c === ",") { row.push(field); field = ""; }
    else if (c === "\n") { row.push(field); rows.push(row); row = []; field = ""; }
    else if (c !== "\r") field += c;
  }
  if (field || row.length) { row.push(field); rows.push(row); }
  const [header, ...body] = rows;
  return body.map((r) => Object.fromEntries(header.map((k, i) => [k, r[i]])));
}

async function db2(table) {
  const cache = path.join(root, ".forever-scan-cache", `${table}-${build}.csv`);
  if (!existsSync(cache)) {
    const response = await fetch(`https://wago.tools/db2/${table}/csv?build=${build}`);
    if (!response.ok) throw new Error(`${table}: ${response.status}`);
    await mkdir(path.dirname(cache), { recursive: true });
    await writeFile(cache, await response.text());
  }
  return parseCsv(await readFile(cache, "utf8"));
}

// Dungeon and raid areas: the area a dungeon map names, and every area on it.
const maps = await db2("Map");
const areas = new Map((await db2("AreaTable")).map((a) => [Number(a.ID), a]));
const instanceMaps = new Map(maps.filter((m) => m.InstanceType === "1" || m.InstanceType === "2").map((m) => [Number(m.ID), m]));
const topOf = (area) => { let a = area; while (a && Number(a.ParentAreaID)) a = areas.get(Number(a.ParentAreaID)) || null; return a || area; };
const instance = new Map();   // area ID -> main area ID of its dungeon
for (const m of instanceMaps.values()) if (Number(m.AreaTableID)) instance.set(Number(m.AreaTableID), Number(m.AreaTableID));
for (const [id, a] of areas) {
  if (!instanceMaps.has(Number(a.ContinentID)) || instance.has(id)) continue;
  instance.set(id, Number(topOf(a).ID));
}
// A dungeon's own area is the one its map names, or one on the map named like
// the map ("The Deadmines" on map Deadmines). Other maps' areas (Forever's world
// raids copy whole zones, Desolace and all) aren't dungeons for our purpose.
const nameOf = (id) => areas.get(id)?.AreaName_lang || "";
const plain = (s) => (s || "").toLowerCase().replace(/^the /, "").trim();
const realMain = new Set();
for (const m of instanceMaps.values()) if (Number(m.AreaTableID)) realMain.add(Number(m.AreaTableID));
for (const [id, a] of areas) {
  const m = instanceMaps.get(Number(a.ContinentID));
  if (!m || Number(a.ParentAreaID)) continue;
  const area = plain(a.AreaName_lang), map = plain(m.MapName_lang);
  if (area && (area === map || map.includes(area) || area.includes(map))) realMain.add(id);
}
const isRealDungeon = (id) => realMain.has(id) && !/^\*|^Unused|^Test /.test(nameOf(id));
// One name per dungeon: the area its map names, else its first own area
// (the Sunken Temple's map has both "Sunken Temple" and "The Temple of Atal'Hakkar").
const mapOfArea = new Map();
for (const m of instanceMaps.values()) if (Number(m.AreaTableID)) mapOfArea.set(Number(m.AreaTableID), Number(m.ID));
for (const id of realMain) if (!mapOfArea.has(id)) mapOfArea.set(id, Number(areas.get(id)?.ContinentID));
const canonical = new Map();   // map ID -> its one area
for (const m of instanceMaps.values()) { const id = Number(m.AreaTableID); if (id && realMain.has(id)) canonical.set(Number(m.ID), id); }
for (const id of [...realMain].sort((x, y) => x - y)) { const map = mapOfArea.get(id); if (!canonical.has(map)) canonical.set(map, id); }
const canon = (id) => canonical.get(mapOfArea.get(id)) || id;
const byName = new Map();
for (const main of new Set(instance.values())) if (isRealDungeon(main) && !byName.has(nameOf(main))) byName.set(nameOf(main), main);
const resolveSort = (sort) => {
  if (sort <= 0) return null;
  if (instance.has(sort)) { const main = instance.get(sort); return isRealDungeon(main) ? byName.get(nameOf(main)) || main : null; }
  const a = areas.get(sort);
  return a && Number(a.ParentAreaID) ? byName.get(a.AreaName_lang) || null : null;
};

// AzerothCore's quests: ID -> QuestSortID.
const sql = await readFile(sqlFile, "utf8");
const columns = [...sql.slice(sql.indexOf("CREATE TABLE"), sql.indexOf(") ENGINE")).matchAll(/^\s+`(\w+)`/gm)].map((m) => m[1]);
const iID = columns.indexOf("ID"), iSort = columns.indexOf("QuestSortID"), iInfo = columns.indexOf("QuestInfoID");
const sorts = new Map();
const raidTagged = new Set();   // QuestInfo 62, 88, 89: the game tags these Raid
const rows = sql.slice(sql.indexOf("INSERT INTO"));
for (let i = rows.indexOf("("); i >= 0; i = rows.indexOf("(", i + 1)) {
  const values = [];
  let field = "", quoted = false, j = i + 1;
  for (; j < rows.length; j++) {
    const c = rows[j];
    if (quoted) {
      if (c === "\\") { field += rows[++j]; continue; }
      if (c === "'") { if (rows[j + 1] === "'") { field += "'"; j++; } else quoted = false; continue; }
      field += c; continue;
    }
    if (c === "'") { quoted = true; continue; }
    if (c === ",") { values.push(field); field = ""; continue; }
    if (c === ")") { values.push(field); break; }
    field += c;
  }
  if (values.length === columns.length) {
    sorts.set(Number(values[iID]), Number(values[iSort]));
    if ([62, 88, 89].includes(Number(values[iInfo]))) raidTagged.add(Number(values[iID]));
  }
  i = j;
}

// The Forever stories' quests, by chapter, and their objective lines.
const toc = await readFile(path.join(root, "StoryMode_Camelot.toc"), "utf8");
const files = toc.split("\n").map((l) => l.trim().replace(/\\/g, "/")).filter((l) => /^Data\/(Storylines|Forever|ClassQuests|Professions)\/.*\.lua$/.test(l));
const objectives = new Map([...(await readFile(path.join(root, "Data/Forever/ForeverQuestText.lua"), "utf8")).matchAll(/^\s*\[(\d+)\] = "((?:[^"\\]|\\.)*)"/gm)].map((m) => [Number(m[1]), m[2]]));
const chapters = [];   // [{ key, file, ids: [[id, ...alternatives]] }]
const storyZones = new Map();   // file -> the dungeons its zone line names
const marked = new Set();       // quests the story data marks as dungeon or raid quests (instance =)
for (const file of files) {
  let chapter = null;
  for (const line of (await readFile(path.join(root, file), "utf8")).split("\n")) {
    const z = line.match(/^ {4}zone = "([^"]+)"/);
    if (z) storyZones.set(file, z[1].split(" / ").map((n) => n.trim()));
    const c = line.match(/^\s+chapter = "([^"]+)"/);
    if (c) { chapter = { key: `${file}|${c[1]}`, file, ids: [] }; chapters.push(chapter); continue; }
    const q = line.match(/^\s+\{ id = (\d+),([^\n]*)/);
    if (!q || !chapter) continue;
    const ids = [Number(q[1])];
    if (/instance = "/.test(q[2])) marked.add(Number(q[1]));
    if (/instance = "raid"/.test(q[2])) raidTagged.add(Number(q[1]));
    const forever = q[2].match(/foreverId = (\d+)/); if (forever) ids.push(Number(forever[1]));
    const alt = q[2].match(/altIds = \{([^}]*)\}/); if (alt) for (const x of alt[1].split(",")) if (x.trim()) ids.push(Number(x));
    chapter.ids.push(ids);
  }
}
const names = [...byName.keys()].sort((a, b) => b.length - a.length);
// The objective names its dungeon, in any case and with or without "The".
const fromObjective = (id) => {
  const text = (objectives.get(id) || "").toLowerCase();
  const hits = new Set(names.filter((n) => text.includes(plain(n))).map((n) => byName.get(n)));
  return hits.size === 1 ? [...hits][0] : null;
};

const result = new Map();   // quest ID -> area ID
const how = { sort: 0, objective: 0, chapter: 0 };
for (const chapter of chapters) {
  const found = new Map();
  for (const ids of chapter.ids) {
    for (const id of ids) {
      const filed = sorts.has(id) ? resolveSort(sorts.get(id)) : null;
      const area = filed || fromObjective(id);
      if (area) { found.set(ids[0], area); how[filed ? "sort" : "objective"]++; break; }
    }
  }
  // Forever's own quests with nothing to go by take the chapter's one dungeon.
  const dungeons = new Set(found.values());
  for (const ids of chapter.ids) {
    for (const [i, id] of ids.entries()) if (found.has(ids[0])) result.set(id, found.get(ids[0]));
    if (!found.has(ids[0]) && dungeons.size === 1 && (marked.has(ids[0]) || !ids.some((id) => sorts.has(id)))) {
      for (const id of ids) result.set(id, [...dungeons][0]);
      how.chapter++;
    }
  }
  // Last, a story whose zone names one dungeon ("Wetlands / Excavation Site: Wetlands")
  // gives it to its dungeon quests (instance =) nothing else placed.
  const zoneDungeons = new Set((storyZones.get(chapter.file) || []).map((n) => byName.get(n)).filter(Boolean));
  for (const ids of chapter.ids) {
    if (zoneDungeons.size !== 1 || result.has(ids[0]) || !marked.has(ids[0]) || ids.some((id) => sorts.has(id))) continue;
    for (const id of ids) result.set(id, [...zoneDungeons][0]);
    how.zone = (how.zone || 0) + 1;
  }
}

// A raid quest filed under a city or zone (Onyxia's attunement, filed under
// Stormwind and the Badlands) takes its story's one raid, when the story places
// its other quests in only one.
const isRaid = (area) => instanceMaps.get(mapOfArea.get(canon(area)))?.InstanceType === "2";
const files2 = new Map();
for (const c of chapters) files2.set(c.file, [...(files2.get(c.file) || []), ...c.ids]);
for (const ids of files2.values()) {
  const raids = new Set(ids.map((x) => result.get(x[0])).filter((a) => a && isRaid(a)).map(canon));
  if (raids.size !== 1) continue;
  for (const x of ids) if (!result.has(x[0]) && x.some((id) => raidTagged.has(id))) {
    for (const id of x) result.set(id, [...raids][0]);
    how.raid = (how.raid || 0) + 1;
  }
}
// Quests about a raid that nothing above can place: Onyxia's head goes to a
// capital, so their objective names the city, not the lair.
const BY_HAND = new Map([
  [7490, 2159],  // Victory for the Horde: Onyxia's Lair
  [7495, 2159],  // Victory for the Alliance: Onyxia's Lair
]);
const storyIDs = new Set(chapters.flatMap((c) => c.ids.flat()));
for (const [id, area] of BY_HAND) if (storyIDs.has(id)) result.set(id, area);
for (const [id, area] of result) result.set(id, canon(area));
const lines = [...result].sort((a, b) => a[0] - b[0]).map(([id, area]) => `    [${id}] = ${area},  -- ${nameOf(area)}`);
const out = [
  "local addonName, SM = ...",
  "",
  "-- AUTO-GENERATED by _Dev/tools/forever-quest-instances.mjs. Do not edit by hand.",
  "-- The dungeon or raid each Forever story quest belongs to, as an area ID: the",
  `-- game names it in the player's language. From AzerothCore's quest_template and`,
  `-- Forever ${build}'s Map and AreaTable (wago.tools); Forever's own quests by the`,
  "-- dungeon their objective names or their chapter's one dungeon.",
  "",
  "SM.ForeverQuestInstances = {",
  ...lines,
  "}",
  "",
].join("\n");
await writeFile(path.join(root, "Data/Forever/ForeverQuestInstances.lua"), out);
const count = {};
for (const area of result.values()) count[nameOf(area)] = (count[nameOf(area)] || 0) + 1;
console.log(`Wrote Data/Forever/ForeverQuestInstances.lua: ${result.size} quest IDs (${how.sort} by quest_template, ${how.objective} by objective, ${how.chapter} by chapter, ${how.zone || 0} by story zone, ${how.raid || 0} by story raid).`);
console.log(Object.entries(count).map(([n, c]) => `${n} ${c}`).join(", "));
