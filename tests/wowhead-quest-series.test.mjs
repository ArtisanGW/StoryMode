// node --test tests/wowhead-quest-series.test.mjs
import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";
import { CSV_FILE, GIVERS_SNIPPET_FILE, REWARDS_SNIPPET_FILE, SNIPPET_FILE, balanced, filterSeries, giverRows, giversSnippet, listRows, parseCsv, questStarts, readQuestList, rewardRows, rewardsSnippet, seriesQuestIDs, seriesRows, seriesStatus, snippet, toCsv } from "../_Dev/tools/wowhead-quest-series.mjs";

const step = (id, name) => [{ id, name }];
const steps = (count, firstID) => Array.from({ length: count }, (_, index) => step(firstID + index, `Quest ${firstID + index}`));

test("status by number of steps", () => {
  assert.equal(seriesStatus(1), null);
  assert.deepEqual([2, 3, 5, 6, 9, 10, 14, 15, 40].map(seriesStatus), ["trivial", "routine", "routine", "immersive", "immersive", "epic", "epic", "legendary", "legendary"]);
});

test("balanced skips brackets inside strings", () => {
  const text = 'x = [{"name":"a ] b","list":[1,[2]]},"\\"]"] tail';
  assert.equal(balanced(text, 4), '[{"name":"a ] b","list":[1,[2]]},"\\"]"]');
});

test("listRows reads the quest Listview, inline or by variable", () => {
  const inline = 'new Listview({"template":"npc","id":"npcs","data":[{"id":1}]});\n' +
    'new Listview({"template":"quest","id":"quests","data":[{"id":7,"name":"Kobold [Camp]","side":1}]});';
  assert.deepEqual(listRows(inline), [{ id: 7, name: "Kobold [Camp]", side: 1 }]);
  const byVariable = "var listviewquests = [{id:7,name:'Kobold Camp Cleanup'}];\nnew Listview({template:'quest',id:'quests',data:listviewquests});";
  assert.deepEqual(listRows(byVariable), [{ id: 7, name: "Kobold Camp Cleanup" }]);
  assert.equal(listRows("<html>no list</html>"), null);
});

test("seriesRows keeps 2+ steps once, with faction and classes", () => {
  const scan = {
    starts: {
      10: { id: 10, name: "Quest 10", side: 1, level: 12, reqlevel: 10, category: 40 },
      20: { id: 20, name: "Quest 20", side: 3 },
      25: { id: 25, name: "Quest 25", side: 3 },
      30: { id: 30, name: "Quest 30", side: 2, reqclass: 128 | 1024 },
      40: { id: 40, name: "Quest 40", side: 3 },
      50: { id: 50, name: "Quest 50", side: 3 },
    },
    series: {
      10: { steps: steps(3, 10) },
      20: { steps: steps(2, 20) },
      25: { steps: steps(1, 25) },
      30: { steps: [...steps(15, 30), [{ id: 98, name: "Left" }, { id: 99, name: "Right" }]] },
      40: { steps: steps(3, 10) },
      50: { steps: [] },
    },
  };
  const rows = seriesRows(scan);
  assert.deepEqual(rows.map((row) => row.id), [30, 10, 20]);
  assert.equal(rows[2].status, "trivial");
  assert.equal(rows[0].status, "legendary");
  assert.equal(rows[0].faction, "Horde");
  assert.equal(rows[0].classes, "MAGE DRUID");
  assert.match(rows[0].quest_ids, / 98\/99$/);
  assert.match(rows[0].quest_names, / \| Left \/ Right$/);
  assert.deepEqual([rows[1].faction, rows[1].classes, rows[1].level, rows[1].min_level, rows[1].zone_id], ["Alliance", "", 12, 10, 40]);
  assert.throws(() => seriesRows({ starts: { 1: { id: 1 } }, series: {} }), /no side/);
});

test("CSV round trip keeps commas, quotes and line breaks", () => {
  const rows = seriesRows({
    starts: { 1: { id: 1, side: 3 } },
    series: { 1: { steps: [step(1, 'The "Big", Bad'), step(2, "Two\nlines"), step(3, "Three")] } },
  });
  const [row] = parseCsv(toCsv(rows));
  assert.equal(row.name, 'The "Big", Bad');
  assert.equal(row.quest_names, 'The "Big", Bad | Two\nlines | Three');
  assert.equal(row.quest_ids, "1 2 3");
});

test("filters match what a faction and class can do", () => {
  const rows = [
    { id: "1", faction: "Alliance", classes: "", status: "routine" },
    { id: "2", faction: "Horde", classes: "", status: "epic" },
    { id: "3", faction: "Both", classes: "DEATHKNIGHT", status: "epic" },
    { id: "4", faction: "Both", classes: "", status: "legendary" },
  ];
  const ids = (filters) => filterSeries(rows, filters).map((row) => row.id);
  assert.deepEqual(ids({ faction: "horde" }), ["2", "3", "4"]);
  assert.deepEqual(ids({ className: "Death Knight" }), ["1", "2", "3", "4"]);
  assert.deepEqual(ids({ className: "mage" }), ["1", "2", "4"]);
  assert.deepEqual(ids({ faction: "Alliance", className: "mage", status: "Epic" }), []);
});

test("snippets parse as scripts, and the saved one matches the tool", async () => {
  assert.doesNotThrow(() => new Function(snippet()));
  const root = new URL("../", import.meta.url);
  assert.equal(await readFile(new URL(SNIPPET_FILE, root), "utf8"), snippet() + "\n", "run: node _Dev/tools/wowhead-quest-series.mjs snippet .");
  const progress = await readFile(new URL("_Dev/snippets/wowhead-quest-series-progress.js", root), "utf8");
  assert.doesNotThrow(() => new Function(progress));
  assert.doesNotThrow(() => new Function(rewardsSnippet()));
  assert.equal(await readFile(new URL(REWARDS_SNIPPET_FILE, root), "utf8"), rewardsSnippet() + "\n", "run: node _Dev/tools/wowhead-quest-series.mjs rewards-snippet .");
  const questIDs = seriesQuestIDs(parseCsv(await readFile(new URL(CSV_FILE, root), "utf8")));
  assert.doesNotThrow(() => new Function(giversSnippet(questIDs)));
  assert.equal(await readFile(new URL(GIVERS_SNIPPET_FILE, root), "utf8"), giversSnippet(questIDs) + "\n", "run: node _Dev/tools/wowhead-quest-series.mjs givers-snippet .");
});

test("readQuestList splits by level, then by required level, while Wowhead cuts the list at 1000", async () => {
  // A fake Wowhead: one pool of quests, filtered by the URL's levels and cut at 1000 rows.
  // A quest outside levels 1-80 is only found in the unfiltered list's first 1000.
  const quests = [
    { id: 9999, level: 0, reqlevel: 1 },
    ...Array.from({ length: 1300 }, (_, index) => ({ id: 1 + index, level: 1 + (index % 59), reqlevel: 1 })),
    ...Array.from({ length: 1100 }, (_, index) => ({ id: 5000 + index, level: 60, reqlevel: index % 61 })),
  ];
  const range = (url, name, fallback) => {
    const match = url.match(new RegExp(`min-${name}:(\\d+)/max-${name}:(\\d+)`));
    return match ? [Number(match[1]), Number(match[2])] : fallback;
  };
  const page = (rows) => `<script>new Listview({"template":"quest","id":"quests","data":${JSON.stringify(rows)}});</script>`;
  const realFetch = globalThis.fetch;
  const realLog = console.log;
  globalThis.fetch = async (url) => {
    const [lowLevel, highLevel] = range(url, "level", [-Infinity, Infinity]);
    const [lowRequired, highRequired] = range(url, "req-level", [-Infinity, Infinity]);
    const rows = quests.filter((quest) => quest.level >= lowLevel && quest.level <= highLevel
      && quest.reqlevel >= lowRequired && quest.reqlevel <= highRequired).slice(0, 1000);
    return { status: 200, headers: { get: () => null }, text: async () => page(rows) };
  };
  console.log = () => {};
  try {
    const rows = await readQuestList("", 0);
    assert.equal(new Set(rows.map((row) => row.id)).size, rows.length, "each quest once");
    assert.equal(rows.length, quests.length, "every quest, the level-60 ones split by required level");
  } finally {
    globalThis.fetch = realFetch;
    console.log = realLog;
  }
});

test("rewardRows: the series' quests with their rewards, by quest ID", () => {
  const scan = { quests: {
    5: { xp: 390, money: 0, items: [], choices: [], reputation: [[72, 25]] },
    182: { xp: 355, money: 120, items: [[961, 3]], choices: [[2047, 1], [2048, 1]], reputation: [[47, 100], [87, -250]] },
    999: { xp: 1, money: 1, items: [], choices: [], reputation: [] },
  } };
  const rows = rewardRows(scan, [{ quest_ids: "182 5/6" }]);
  assert.deepEqual(rows.map((row) => row.id), [5, 182], "only the series' quests that Wowhead's list has");
  assert.deepEqual(rows[1], { id: 182, xp: 355, money: 120, items: "961:3", choices: "2047:1 2048:1", reputation: "47:100 87:-250" });
});

// Quest 7's map, as Wowhead's page writes it (2026-11-26), and quest 2's, started by an item.
const mapperPage = (objectives) => `<script>var g_mapperData = {};\nvar myMapper = new Mapper(${JSON.stringify({ parent: "x", objectives, zones: [[12, 2]] })});</script>`;

test("questStarts: where the page's map puts the quest giver", () => {
  const kobolds = mapperPage({ 12: { zone: "Elwynn Forest", mappable: 1, levels: [[
    { type: 1, point: "start", name: "Marshal McBride", coord: [48.8, 41.6], coords: [[48.8, 41.4], [48.8, 41.6]], id: 197 },
    { type: 1, point: "end", name: "Marshal McBride", coord: [48.8, 41.6], id: 197 },
  ]] } });
  assert.deepEqual(questStarts(kobolds), [{ zone: 12, x: 48.8, y: 41.6 }]);
  const itemStart = mapperPage({ 331: { zone: "Ashenvale", levels: [[{ type: 1, point: "end", name: "Senani Thunderheart", coord: [73.6, 61.4] }]] } });
  assert.deepEqual(questStarts(itemStart), [], "started by an item: no giver on the map");
  assert.deepEqual(questStarts("<html>no map</html>"), []);
});

test("giverRows: the game's map for Wowhead's zone, others counted", () => {
  const scan = { givers: { 7: [{ zone: 1584, x: 1, y: 2 }, { zone: 12, x: 48.8, y: 41.6 }], 2: [], 8: [{ zone: 16591, x: 10, y: 20 }] } };
  const { rows, skipped } = giverRows(scan, [{ quest_ids: "7 2/8" }]);
  assert.deepEqual(rows, [{ id: 7, map: 1429, x: 48.8, y: 41.6 }], "the zone the game has a map of: Elwynn Forest, map 1429");
  assert.deepEqual(skipped, { noGiver: 1, otherMap: 1 });
});
