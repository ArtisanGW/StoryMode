// Where each quest giver of the series stands, read from QuestieDB's data
// (the addon, as installed in the game's AddOns folder).
//
//   node _Dev/tools/questiedb-quest-givers.mjs <QuestieDB folder> [root]
//     Writes _Dev/forever-quest-givers.csv: per quest of the series in the
//     series CSV, the game's map (uiMapID) and where on it its giver (an NPC
//     or an object) stands, x and y from 0 to 100.
//
// QuestieDB keeps its data in its .toc, as "## X-<Kind>-<id>-<field>: <value>"
// lines: base64 CBOR, a value too long for one line split as "~N~" and then
// "-1" to "-N" parts. Quests' field 2 is startedBy ({ npcIDs, objectIDs,
// itemIDs }); NPCs' field 7 and objects' field 4 are spawns ({ [areaID] =
// { { x, y }, ... } }). support/Forever/Zones/areaIdToUiMapId.lua turns
// areas into the game's maps (its override list first). Its corrections
// (src/corrections) are Lua run in game and are left out.

import { readFile, writeFile } from "node:fs/promises";
import path from "node:path";
import { pathToFileURL } from "node:url";
import { CSV_FILE, parseCsv, seriesQuestIDs, toCsv } from "./wowhead-quest-series.mjs";

export const GIVERS_CSV_FILE = path.join("_Dev", "forever-quest-givers.csv");
const GIVER_COLUMNS = ["id", "map", "x", "y"];
const STARTED_BY = 2;
const NPC_SPAWNS = 7;
const OBJECT_SPAWNS = 4;

// One CBOR value (RFC 8949), as the game's C_EncodingUtil.SerializeCBOR
// writes a Lua table: a list as an array, other tables as maps.
export function decodeCbor(bytes) {
  const view = new DataView(bytes.buffer, bytes.byteOffset, bytes.byteLength);
  let offset = 0;
  const take = (size, read) => {
    const value = read(offset);
    offset += size;
    return value;
  };
  const argument = (info) => {
    if (info < 24) return info;
    if (info === 24) return take(1, (at) => view.getUint8(at));
    if (info === 25) return take(2, (at) => view.getUint16(at));
    if (info === 26) return take(4, (at) => view.getUint32(at));
    if (info === 27) return take(8, (at) => Number(view.getBigUint64(at)));
    throw new Error(`CBOR: length ${info} at byte ${offset}`);
  };
  const halfFloat = (bits) => {
    const exponent = (bits >> 10) & 31;
    const fraction = bits & 1023;
    const sign = bits & 32768 ? -1 : 1;
    if (exponent === 0) return sign * fraction * 2 ** -24;
    if (exponent === 31) return fraction ? NaN : sign * Infinity;
    return sign * (1 + fraction / 1024) * 2 ** (exponent - 15);
  };
  const item = () => {
    const initial = take(1, (at) => view.getUint8(at));
    const major = initial >> 5;
    const info = initial & 31;
    if (major === 0) return argument(info);
    if (major === 1) return -1 - argument(info);
    if (major === 2 || major === 3) {
      const size = argument(info);
      const part = take(size, (at) => bytes.subarray(at, at + size));
      return major === 2 ? part : new TextDecoder().decode(part);
    }
    if (major === 4) return Array.from({ length: argument(info) }, () => item());
    if (major === 5) {
      const map = {};
      for (let count = argument(info); count > 0; count--) {
        const key = item();
        map[key] = item();
      }
      return map;
    }
    if (major === 6) {
      argument(info);
      return item();
    }
    if (info === 20) return false;
    if (info === 21) return true;
    if (info === 22 || info === 23) return null;
    if (info === 25) return halfFloat(take(2, (at) => view.getUint16(at)));
    if (info === 26) return take(4, (at) => view.getFloat32(at));
    if (info === 27) return take(8, (at) => view.getFloat64(at));
    throw new Error(`CBOR: simple value ${info} at byte ${offset}`);
  };
  return item();
}

// A Lua table's [key, value] pairs, keys as numbers: a list came as an array
// (its keys 1 to n), any other table as a map.
const luaPairs = (table) =>
  Array.isArray(table) ? table.map((value, index) => [index + 1, value]) : Object.entries(table || {}).map(([key, value]) => [Number(key), value]);
const luaList = (table) => luaPairs(table).filter(([, value]) => value != null).map(([, value]) => value);

// The toc's "X-" lines as one store: key -> its value, split ones joined.
export function readStore(tocText) {
  const lines = new Map();
  for (const match of tocText.matchAll(/^## (X-[^:]+): (.*?)\r?$/gm)) lines.set(match[1], match[2]);
  return (key) => {
    const value = lines.get(key);
    const parts = value?.match(/^~(\d+)~$/);
    if (!parts) return value;
    return Array.from({ length: Number(parts[1]) }, (_, index) => {
      const part = lines.get(`${key}-${index + 1}`);
      if (part === undefined) throw new Error(`${key} declares ${parts[1]} parts but part ${index + 1} is missing`);
      return part;
    }).join("");
  };
}

const field = (store, kind, id, fieldIndex) => {
  const value = store(`X-${kind}-${id}-${fieldIndex}`);
  return value === undefined ? undefined : decodeCbor(Buffer.from(value, "base64"));
};

// areaID -> uiMapID from areaIdToUiMapId.lua: its override list, then the main one.
export function readUiMaps(luaText) {
  const tables = [...luaText.matchAll(/ZoneDB\.private\.(\w+) = \[\[return \{([\s\S]*?)\n\}\]\]/g)];
  const uiMapOf = {};
  for (const name of ["areaIdToUiMapId", "areaIdToUiMapIdOverride"]) {
    const table = tables.find((match) => match[1] === name);
    if (!table) throw new Error(`areaIdToUiMapId.lua has no ${name}`);
    for (const match of table[2].matchAll(/\[(\d+)\] = (\d+)/g)) uiMapOf[match[1]] = Number(match[2]);
  }
  return uiMapOf;
}

// Where a quest's giver stands: its NPCs', then its objects' first spawn on a
// map the game has (an instance's spawns sit at -1, -1). null for a quest
// started by an item, or with no such spawn.
export function questGiver(store, uiMapOf, questID) {
  const startedBy = field(store, "Quest", questID, STARTED_BY);
  if (!startedBy) return null;
  const starters = [
    ...luaList(luaPairs(startedBy).find(([slot]) => slot === 1)?.[1]).map((id) => field(store, "Npc", id, NPC_SPAWNS)),
    ...luaList(luaPairs(startedBy).find(([slot]) => slot === 2)?.[1]).map((id) => field(store, "Object", id, OBJECT_SPAWNS)),
  ];
  for (const spawns of starters) {
    for (const [areaID, points] of luaPairs(spawns)) {
      const map = uiMapOf[areaID];
      const point = luaList(points).find(([x, y]) => x >= 0 && y >= 0);
      if (map && point) return { map, x: Number(point[0].toFixed(2)), y: Number(point[1].toFixed(2)) };
    }
  }
  return null;
}

async function main() {
  const [questieFolder, rootArgument] = process.argv.slice(2);
  if (!questieFolder) {
    console.log("Usage: node _Dev/tools/questiedb-quest-givers.mjs <QuestieDB folder> [root]");
    process.exitCode = 1;
    return;
  }
  const root = path.resolve(rootArgument || process.cwd());
  const store = readStore(await readFile(path.join(questieFolder, "QuestieDB_Forever.toc"), "utf8"));
  const uiMapOf = readUiMaps(await readFile(path.join(questieFolder, "support", "Forever", "Zones", "areaIdToUiMapId.lua"), "utf8"));
  const questIDs = seriesQuestIDs(parseCsv(await readFile(path.join(root, CSV_FILE), "utf8")));
  const rows = questIDs.map((id) => ({ id, ...questGiver(store, uiMapOf, id) })).filter((row) => row.map);
  const csvFile = path.join(root, GIVERS_CSV_FILE);
  await writeFile(csvFile, toCsv(rows, GIVER_COLUMNS));
  console.log(`Wrote where ${rows.length} of the series' ${questIDs.length} quest givers stand to ${csvFile}; the others start from an item, stand in an instance or aren't in QuestieDB.`);
}

if (import.meta.url === pathToFileURL(process.argv[1]).href) {
  main().catch((error) => {
    console.error(error.message);
    process.exitCode = 1;
  });
}
