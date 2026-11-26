// node --test tests/wowhead-quest-series.test.mjs
import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";
import { REWARDS_SNIPPET_FILE, SNIPPET_FILE, balanced, filterSeries, listRows, parseCsv, readQuestList, rewardRows, rewardsSnippet, seriesRows, seriesStatus, snippet, toCsv } from "../_Dev/tools/wowhead-quest-series.mjs";

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
});

test("readQuestList splits by level while Wowhead cuts the list, and keeps rows outside 1-80", async () => {
  const rowsAt = (low, high, count) => Array.from({ length: count }, (_, index) => ({ id: low * 10000 + index, level: low + (index % (high - low + 1)) }));
  const lower = rowsAt(1, 40, 600);
  const upper = rowsAt(41, 80, 700);
  const lists = {
    "/forever/quests": [...lower, ...upper].slice(0, 999).concat({ id: 7, level: 0 }),
    "/forever/quests/min-level:1/max-level:80": [...lower, ...upper].slice(0, 1000),
    "/forever/quests/min-level:1/max-level:40": lower,
    "/forever/quests/min-level:41/max-level:80": upper,
  };
  const page = (rows) => `<script>new Listview({"template":"quest","id":"quests","data":${JSON.stringify(rows)}});</script>`;
  const realFetch = globalThis.fetch;
  const realLog = console.log;
  globalThis.fetch = async (url) => ({ status: lists[url] ? 200 : 404, headers: { get: () => null }, text: async () => (lists[url] ? page(lists[url]) : "") });
  console.log = () => {};
  try {
    const rows = await readQuestList("", 0);
    assert.equal(rows.length, 600 + 700 + 1);
    assert.ok(rows.some((row) => row.id === 7), "a row outside levels 1-80 is kept from the cut list");
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
