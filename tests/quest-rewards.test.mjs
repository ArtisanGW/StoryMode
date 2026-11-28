// node --test tests/quest-rewards.test.mjs
import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";
import { blizzardDifferences, checkAgainstBlizzard, difficultyTable, eglinkRewards, mergeQuest, mergeRewards, newestQuests, questXP, reputationAmount, roundQuestXP, wowheadRewards } from "../_Dev/tools/quest-rewards.mjs";
import { parseCsv } from "../_Dev/tools/wowhead-quest-series.mjs";

const readTable = async (name) => difficultyTable(await readFile(new URL(`../_Dev/client-tables/${name}.csv`, import.meta.url), "utf8"));
const questXPTable = await readTable("QuestXP");
const factionRewardTable = await readTable("QuestFactionReward");

test("difficultyTable reads a client table by row ID and difficulty", () => {
  const table = difficultyTable("ID,Difficulty_0,Difficulty_1,Difficulty_2\n1,0,10,25\n2,0,-50,-125\n");
  assert.deepEqual(table, { 1: [0, 10, 25], 2: [0, -50, -125] });
});

test("roundQuestXP rounds to 5, 10, 25 and 50 by size, halves up", () => {
  assert.deepEqual([0, 42, 43, 100].map(roundQuestXP), [0, 40, 45, 100]);
  assert.deepEqual([104, 105, 494, 500].map(roundQuestXP), [100, 110, 490, 500]);
  assert.deepEqual([512, 513, 840, 1000].map(roundQuestXP), [500, 525, 850, 1000]);
  assert.deepEqual([1024, 1025, 6175, 9950].map(roundQuestXP), [1000, 1050, 6200, 9950]);
  assert.equal(roundQuestXP(2066.25), 2050, "a multiplied value's fraction is dropped first");
});

test("questXP: the table's value times the multiplier, rounded", () => {
  assert.equal(questXPTable[10][5], 840);
  assert.equal(questXP(10, 5, 1, questXPTable), 850, "Riverpaw Gnoll Bounty (11): 840 rounds to 850");
  assert.equal(questXP(22, 7, 2.375, questXPTable), 6200, "The Defias Brotherhood (166): 2600 x 2.375 = 6175, paid as 6200");
  assert.equal(questXP(60, 5, undefined, questXPTable), 6600, "no multiplier counts as 1");
  assert.equal(questXP(-1, 5, 1, questXPTable), undefined, "a level the table has no row for");
});

test("reputationAmount: tiers up and down, and the override", () => {
  assert.equal(reputationAmount({ factionId: 72, tier: 5 }, factionRewardTable), 100);
  assert.equal(reputationAmount({ factionId: 72, tier: 3 }, factionRewardTable), 50);
  assert.equal(reputationAmount({ factionId: 87, tier: -3 }, factionRewardTable), -250);
  assert.equal(reputationAmount({ factionId: 93, tier: 0, override: 25000 }, factionRewardTable), 250);
  assert.equal(reputationAmount({ factionId: 92, tier: 0, override: -125000 }, factionRewardTable), -1250);
  assert.equal(reputationAmount({ factionId: 549, tier: 0 }, factionRewardTable), 0);
});

test("newestQuests keeps the wanted quests, each from the newest build that has it", () => {
  const buildFiles = [
    { build: "1.60.1.71139", quests: { 11: { level: 10, rewards: { money: 2 } } } },
    { build: "1.60.1.70862", quests: { 11: { level: 10, rewards: { money: 1 } }, 12: { level: 12, rewards: {} }, 13: { level: 13 } } },
  ];
  assert.deepEqual(newestQuests(buildFiles, [11, 13, 99]), {
    11: { build: "1.60.1.71139", level: 10, rewards: { money: 2 } },
    13: { build: "1.60.1.70862", level: 13, rewards: {} },
  });
});

test("eglinkRewards turns one EG Link quest into amounts", () => {
  const quest = { level: 10, rewards: {
    xpDifficulty: 5, xpMultiplier: 1, money: 25,
    items: [{ itemId: 3681, count: 2 }], choices: [{ itemId: 2249, count: 1 }, { itemId: 287059, count: 1 }],
    reputation: [{ factionId: 21, tier: 3 }, { factionId: 87, tier: -3 }, { factionId: 549, tier: 0 }],
  } };
  assert.deepEqual(eglinkRewards(quest, questXPTable, factionRewardTable), {
    xp: 850, money: 25, items: [[3681, 2]], choices: [[2249, 1], [287059, 1]], reputation: [[21, 50], [87, -250]],
  });
  assert.deepEqual(eglinkRewards({ level: -1, rewards: { xpDifficulty: 5 } }, questXPTable, factionRewardTable),
    { xp: undefined, money: 0, items: [], choices: [], reputation: [] });
});

test("wowheadRewards rounds Wowhead's XP as the server does", () => {
  assert.deepEqual(wowheadRewards({ id: "5708", xp: "690", money: "0", items: "", choices: "1:2 3:4", reputation: "72:-25" }),
    { xp: 700, money: 0, items: [], choices: [[1, 2], [3, 4]], reputation: [[72, -25]] });
});

test("mergeQuest takes each field from EG Link, then Wowhead", () => {
  const eglink = { xp: 850, money: 0, items: [], choices: [[2249, 1]], reputation: [] };
  const wowhead = { xp: 840, money: 25, items: [[3681, 1]], choices: [[9, 1]], reputation: [] };
  assert.deepEqual(mergeQuest(eglink, wowhead), {
    rewards: { xp: 850, money: 25, items: [[3681, 1]], choices: [[2249, 1]], reputation: [] },
    sources: { xp: "eglink", money: "wowhead", items: "wowhead", choices: "eglink", reputation: "none" },
  });
  assert.deepEqual(mergeQuest(undefined, wowhead).sources, { xp: "wowhead", money: "wowhead", items: "wowhead", choices: "wowhead", reputation: "none" });
  assert.deepEqual(mergeQuest(eglink, undefined).rewards, { xp: 850, money: 0, items: [], choices: [[2249, 1]], reputation: [] });
  assert.equal(mergeQuest({ ...eglink, xp: undefined }, wowhead).rewards.xp, 840, "EG Link without XP: Wowhead's");
});

test("mergeRewards writes the CSV's rows and counts each field's source", () => {
  const eglinkQuests = { 11: { level: 10, rewards: { xpDifficulty: 5, xpMultiplier: 1, choices: [{ itemId: 2249, count: 1 }], reputation: [{ factionId: 72, tier: 5 }] } } };
  const wowheadRows = parseCsv("id,xp,money,items,choices,reputation\n11,840,0,,2249:1 2238:1,72:100\n12,905,500,5:2,,72:100\n");
  const { rows, counts, inNoSource } = mergeRewards([11, 12, 13], eglinkQuests, wowheadRows, questXPTable, factionRewardTable);
  assert.deepEqual(rows, [
    { id: 11, xp: 850, money: 0, items: "", choices: "2249:1", reputation: "72:100" },
    { id: 12, xp: 900, money: 500, items: "5:2", choices: "", reputation: "72:100" },
  ]);
  assert.deepEqual(counts.xp, { eglink: 1, wowhead: 1, none: 0 });
  assert.deepEqual(counts.money, { eglink: 0, wowhead: 1, none: 1 });
  assert.deepEqual(counts.choices, { eglink: 1, wowhead: 0, none: 1 });
  assert.deepEqual(inNoSource, [13]);
});

test("the check against Blizzard's API compares items by ID and lists what differs", () => {
  const ours = { xp: 850, money: 0, items: [[3681, 2]], choices: [[2249, 1], [287059, 1]], reputation: [[87, -250], [21, 50]] };
  const blizzard = { xp: 850, money: 0, items: [[3681, 1]], choices: [[2249, 1]], reputation: [[21, 50], [87, -250]] };
  assert.deepEqual(blizzardDifferences(ours, blizzard), [{ field: "choices", ours: [2249, 287059], blizzard: [2249] }]);
  const rows = parseCsv("id,xp,money,items,choices,reputation\n11,850,0,,,\n12,900,0,,,\n13,1,0,,,\n");
  const blizzardQuests = { 11: { xp: 850, money: 0, items: [], choices: [], reputation: [] }, 12: { xp: 725, money: 0, items: [], choices: [], reputation: [] }, 13: { missing: true } };
  assert.deepEqual(checkAgainstBlizzard(rows, blizzardQuests), { differences: [{ id: 12, field: "xp", ours: 900, blizzard: 725 }], unknown: [13] });
});

test("the saved lists: every series quest has a row, EG Link's values win", async () => {
  const read = async (name) => readFile(new URL(`../_Dev/${name}`, import.meta.url), "utf8");
  const rows = new Map(parseCsv(await read("forever-quest-rewards.csv")).map((row) => [row.id, row]));
  const wowhead = new Map(parseCsv(await read("wowhead-quest-rewards.csv")).map((row) => [row.id, row]));
  const eglink = JSON.parse(await read("eglink-quest-rewards.json"));
  assert.match(eglink.attribution, /Efficient Games.*CC BY 4\.0/);
  assert.equal(rows.size, wowhead.size);
  assert.deepEqual({ ...rows.get("11") }, { id: "11", xp: "850", money: "0", items: "", choices: "2249:1 2238:1 287059:1", reputation: "72:100" });
  assert.equal(rows.get("166").xp, "6200", "a dungeon quest's multiplied XP");
  assert.equal(wowhead.get("166").xp, "2600");
  assert.equal(rows.get("1367").reputation, "93:250 92:-1250", "a gain and a loss from overrides");
  assert.ok(!eglink.quests[5708] && rows.get("5708").xp === "700", "a quest EG Link lacks: Wowhead's XP, rounded");
});
