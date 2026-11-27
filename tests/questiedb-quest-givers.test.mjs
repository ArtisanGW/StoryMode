// node --test tests/questiedb-quest-givers.test.mjs
import assert from "node:assert/strict";
import test from "node:test";
import { decodeCbor, questGiver, readStore, readUiMaps } from "../_Dev/tools/questiedb-quest-givers.mjs";

const base64 = (bytes) => Buffer.from(bytes).toString("base64");

test("decodeCbor reads the game's CBOR: lists, maps, numbers, nil", () => {
  // QuestieDB's Marshal McBride spawn: { [12] = { { 48.92, 41.61 } } } (float64s).
  assert.deepEqual(decodeCbor(Buffer.from("oQyBgvtASHXCj1wo9vtARM4UeuFHrg==", "base64")), { 12: [[48.92, 41.61]] });
  assert.deepEqual(decodeCbor(Buffer.from([0x82, 0xf6, 0x81, 0x20])), [null, [-1]]);
  assert.equal(decodeCbor(Buffer.from([0xf9, 0x3e, 0x00])), 1.5, "half float");
  assert.equal(decodeCbor(Buffer.from([0x63, 0x61, 0x62, 0x63])), "abc");
});

// A toc as QuestieDB's: quest 7 started by NPC 197 (real lines), its spawn
// split in two parts; quest 8 by an NPC in an instance and one in Dun Morogh
// (area 1, so its spawns came as a list); quest 9 by an object; quest 10 by
// an item only.
const npcSpawn = "oQyBgvtASHXCj1wo9vtARM4UeuFHrg==";
const toc = [
  "## Title: QuestieDB",
  "## X-Quest-7-2: gYEYxQ==",
  "## X-Npc-197-7: ~2~",
  `## X-Npc-197-7-1: ${npcSpawn.slice(0, 10)}`,
  `## X-Npc-197-7-2: ${npcSpawn.slice(10)}\r`,
  `## X-Quest-8-2: ${base64([0x81, 0x82, 0x18, 0x64, 0x18, 0x65])}`,
  `## X-Npc-100-7: ${base64([0xa1, 0x19, 0x06, 0x30, 0x81, 0x82, 0x20, 0x20])}`,
  `## X-Npc-101-7: ${base64([0x81, 0x81, 0x82, 0x18, 0x2a, 0x18, 0x32])}`,
  `## X-Quest-9-2: ${base64([0x82, 0xf6, 0x81, 0x05])}`,
  `## X-Object-5-4: ${base64([0xa1, 0x0c, 0x81, 0x82, 0x0a, 0x14])}`,
  `## X-Quest-10-2: ${base64([0x83, 0xf6, 0xf6, 0x81, 0x19, 0x04, 0xd2])}`,
].join("\n");

const zonesLua = `local ZoneDB = QuestieLoader:ImportModule("ZoneDB")
ZoneDB.private.areaIdToUiMapIdOverride = [[return {
    [1584] = 0, -- an instance kept off the map
}]]

ZoneDB.private.areaIdToUiMapId = [[return {
    [1] = 1426, -- Dun Morogh
    [12] = 1429, -- Elwynn Forest
    [1584] = 242,
}]]
`;

test("readUiMaps: the override list wins", () => {
  assert.deepEqual(readUiMaps(zonesLua), { 1: 1426, 12: 1429, 1584: 0 });
});

test("questGiver: the first NPC, then object, spawn on a map the game has", () => {
  const store = readStore(toc);
  const uiMapOf = readUiMaps(zonesLua);
  assert.deepEqual(questGiver(store, uiMapOf, 7), { map: 1429, x: 48.92, y: 41.61 }, "Kobold Camp Cleanup: Marshal McBride");
  assert.deepEqual(questGiver(store, uiMapOf, 8), { map: 1426, x: 42, y: 50 }, "past the instance, area 1 as a list");
  assert.deepEqual(questGiver(store, uiMapOf, 9), { map: 1429, x: 10, y: 20 }, "an object");
  assert.equal(questGiver(store, uiMapOf, 10), null, "started by an item");
  assert.equal(questGiver(store, uiMapOf, 11), null, "not in QuestieDB");
  assert.throws(() => readStore("## X-Npc-1-7: ~2~\n## X-Npc-1-7-1: AA==")("X-Npc-1-7"), /part 2 is missing/);
});
