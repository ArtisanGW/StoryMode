// node --test tests/wowhead-quest-series.test.mjs
import assert from "node:assert/strict";
import test from "node:test";
import { balanced, filterSeries, listRows, parseCsv, seriesRows, seriesStatus, snippet, toCsv } from "../_Dev/tools/wowhead-quest-series.mjs";

const step = (id, name) => [{ id, name }];
const steps = (count, firstID) => Array.from({ length: count }, (_, index) => step(firstID + index, `Quest ${firstID + index}`));

test("status by number of steps", () => {
  assert.equal(seriesStatus(2), null);
  assert.deepEqual([3, 5, 6, 9, 10, 14, 15, 40].map(seriesStatus), ["routine", "routine", "immersive", "immersive", "epic", "epic", "legendary", "legendary"]);
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

test("seriesRows keeps 3+ steps once, with faction and classes", () => {
  const scan = {
    starts: {
      10: { id: 10, name: "Quest 10", side: 1, level: 12, reqlevel: 10, category: 40 },
      20: { id: 20, name: "Quest 20", side: 3 },
      30: { id: 30, name: "Quest 30", side: 2, reqclass: 128 | 1024 },
      40: { id: 40, name: "Quest 40", side: 3 },
      50: { id: 50, name: "Quest 50", side: 3 },
    },
    series: {
      10: { steps: steps(3, 10) },
      20: { steps: steps(2, 20) },
      30: { steps: [...steps(15, 30), [{ id: 98, name: "Left" }, { id: 99, name: "Right" }]] },
      40: { steps: steps(3, 10) },
      50: { steps: [] },
    },
  };
  const rows = seriesRows(scan);
  assert.deepEqual(rows.map((row) => row.id), [30, 10]);
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

test("snippet parses as a script", () => {
  assert.doesNotThrow(() => new Function(snippet()));
});
