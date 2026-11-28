// The rewards of the series' quests: EG Link's data first, Wowhead's for what
// EG Link doesn't have.
//
//   node _Dev/tools/quest-rewards.mjs eglink <eg-link-output-wowf folder> [root]
//     Reads data/wowf/<build>/quests.enUS.json of a clone of
//     https://github.com/JIVESCORP/eg-link-output-wowf and writes
//     _Dev/eglink-quest-rewards.json: the level and rewards of the series'
//     quests, each from the newest build that has the quest.
//
//   node _Dev/tools/quest-rewards.mjs merge [root]
//     Writes _Dev/forever-quest-rewards.csv from _Dev/eglink-quest-rewards.json,
//     _Dev/wowhead-quest-rewards.csv and the client tables in _Dev/client-tables
//     (QuestXP and QuestFactionReward, from wago.tools). Each field of a quest
//     (xp, money, items, choices, reputation) is EG Link's when EG Link has a
//     value for it, else Wowhead's. EG Link's XP is QuestXP's value for the
//     quest's level and XP difficulty, times its multiplier, rounded as the
//     server rounds it; its reputation tiers are QuestFactionReward's amounts.
//
//   node _Dev/tools/quest-rewards.mjs check <blizzard cache.json> [root]
//     Prints the quests whose merged rewards differ from Blizzard's Game Data
//     API (the cache blizzard-quest-rewards.py writes). A check only: nothing
//     of Blizzard's goes into the CSV.
//
// Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0
// (https://creativecommons.org/licenses/by/4.0/). Changed here: only the
// series' quests and their reward fields are kept, XP and reputation are
// worked out as amounts, and Wowhead's values fill what is missing.

import { readdir, readFile, writeFile } from "node:fs/promises";
import path from "node:path";
import { pathToFileURL } from "node:url";
import { CSV_FILE, REWARD_COLUMNS, REWARDS_CSV_FILE, WOWHEAD_REWARDS_CSV_FILE, parseCsv, seriesQuestIDs, toCsv } from "./wowhead-quest-series.mjs";

export const EGLINK_FILE = path.join("_Dev", "eglink-quest-rewards.json");
export const QUEST_XP_FILE = path.join("_Dev", "client-tables", "QuestXP.csv");
export const FACTION_REWARD_FILE = path.join("_Dev", "client-tables", "QuestFactionReward.csv");
export const EGLINK_CREDIT = "Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/).";
const EGLINK_CHANGES = "Changed: only the quests of Story Mode's series list, and of each only its level and rewards, from the newest build that has it.";

// The reward fields, in the CSV's order.
export const REWARD_FIELDS = ["xp", "money", "items", "choices", "reputation"];

// QuestFactionReward's rows: 1 holds the gains, 2 the losses.
const REPUTATION_GAIN_ROW = 1;
const REPUTATION_LOSS_ROW = 2;
// EG Link stores an explicit reputation amount times 100.
const REPUTATION_OVERRIDE_SCALE = 100;

// ---------------------------------------------------------------------------
// The client's tables
// ---------------------------------------------------------------------------

// A client table's CSV (ID, Difficulty_0 .. Difficulty_9) as rowID -> [value by difficulty].
export function difficultyTable(csvText) {
  const table = {};
  for (const row of parseCsv(csvText)) {
    table[Number(row.ID)] = Object.keys(row).filter((column) => column.startsWith("Difficulty_")).map((column) => Number(row[column]));
  }
  return table;
}

// The server rounds a quest's XP: to 5 up to 100, to 10 up to 500, to 25 up
// to 1000, to 50 above. Halves round up (840 -> 850, 6175 -> 6200).
export function roundQuestXP(xp) {
  const whole = Math.floor(xp);
  if (whole <= 100) return 5 * Math.floor((whole + 2) / 5);
  if (whole <= 500) return 10 * Math.floor((whole + 5) / 10);
  if (whole <= 1000) return 25 * Math.floor((whole + 12) / 25);
  return 50 * Math.floor((whole + 25) / 50);
}

// A quest's XP: QuestXP's value for the quest's level and XP difficulty, times
// the quest's multiplier, rounded as the server does. undefined when the
// table has no row for the level.
export function questXP(level, xpDifficulty, xpMultiplier, questXPTable) {
  const baseXP = questXPTable[level]?.[xpDifficulty];
  if (baseXP === undefined) return undefined;
  return roundQuestXP(baseXP * (xpMultiplier ?? 1));
}

// One of EG Link's reputation entries as an amount: its override when it has
// one, else QuestFactionReward's value for its tier (a tier below 0 is a loss).
export function reputationAmount(entry, factionRewardTable) {
  if (entry.override) return entry.override / REPUTATION_OVERRIDE_SCALE;
  const tier = entry.tier ?? 0;
  return tier < 0 ? factionRewardTable[REPUTATION_LOSS_ROW][-tier] : factionRewardTable[REPUTATION_GAIN_ROW][tier];
}

// ---------------------------------------------------------------------------
// EG Link
// ---------------------------------------------------------------------------

const buildNumber = (build) => Number(build.split(".").pop());

// questID -> { build, level, rewards } from EG Link's quest files, one per
// build ([{ build, quests }]): the newest build that has a quest wins.
export function newestQuests(buildFiles, questIDs) {
  const wanted = new Set(questIDs);
  const quests = {};
  for (const { build, quests: buildQuests } of [...buildFiles].sort((first, second) => buildNumber(first.build) - buildNumber(second.build))) {
    for (const [questID, quest] of Object.entries(buildQuests)) {
      if (wanted.has(Number(questID))) quests[questID] = { build, level: quest.level, rewards: quest.rewards || {} };
    }
  }
  return quests;
}

// One EG Link quest ({ level, rewards }) as reward fields: xp, money, items and
// choices ([itemID, count]), reputation ([factionID, amount]). xp is left out
// when QuestXP has no row for the quest's level; reputation of 0 is left out.
export function eglinkRewards(quest, questXPTable, factionRewardTable) {
  const rewards = quest.rewards;
  const itemPairs = (list) => (list || []).map((item) => [item.itemId, item.count]);
  return {
    xp: questXP(quest.level, rewards.xpDifficulty, rewards.xpMultiplier, questXPTable),
    money: rewards.money || 0,
    items: itemPairs(rewards.items),
    choices: itemPairs(rewards.choices),
    reputation: (rewards.reputation || []).map((entry) => [entry.factionId, reputationAmount(entry, factionRewardTable)]).filter(([, amount]) => amount),
  };
}

// ---------------------------------------------------------------------------
// The merge
// ---------------------------------------------------------------------------

const parsePairs = (text) => (text ? text.split(" ").map((pair) => pair.split(":").map(Number)) : []);
const formatPairs = (pairs) => pairs.map(([id, amount]) => `${id}:${amount}`).join(" ");

// A row of the rewards CSV as reward fields.
export function csvRewards(row) {
  return { xp: Number(row.xp) || 0, money: Number(row.money) || 0, items: parsePairs(row.items), choices: parsePairs(row.choices), reputation: parsePairs(row.reputation) };
}

// A row of Wowhead's rewards CSV as reward fields. Wowhead's XP is QuestXP's
// value before the server rounds it, so it is rounded here.
export function wowheadRewards(row) {
  const rewards = csvRewards(row);
  return { ...rewards, xp: roundQuestXP(rewards.xp) };
}

// Does a source have something for this field? 0 and an empty list are
// "nothing", so the next source is asked.
const hasValue = (value) => (Array.isArray(value) ? value.length > 0 : Boolean(value));

// One quest's rewards: each field from the first source (EG Link, then
// Wowhead) that has a value for it. sources says which one gave each field
// ("eglink", "wowhead", or "none" when neither has it). A source is the
// quest's reward fields, or undefined when it doesn't have the quest.
export function mergeQuest(eglink, wowhead) {
  const rewards = {};
  const sources = {};
  for (const field of REWARD_FIELDS) {
    const empty = field === "xp" || field === "money" ? 0 : [];
    if (hasValue(eglink?.[field])) {
      rewards[field] = eglink[field];
      sources[field] = "eglink";
    } else if (hasValue(wowhead?.[field])) {
      rewards[field] = wowhead[field];
      sources[field] = "wowhead";
    } else {
      rewards[field] = empty;
      sources[field] = "none";
    }
  }
  return { rewards, sources };
}

// The rewards CSV's rows for the series' quests, and per field how many
// quests each source gave: counts[field][source].
export function mergeRewards(questIDs, eglinkQuests, wowheadRows, questXPTable, factionRewardTable) {
  const wowheadByID = new Map(wowheadRows.map((row) => [Number(row.id), wowheadRewards(row)]));
  const counts = Object.fromEntries(REWARD_FIELDS.map((field) => [field, { eglink: 0, wowhead: 0, none: 0 }]));
  const rows = [];
  const inNoSource = [];
  for (const questID of questIDs) {
    const eglinkQuest = eglinkQuests[questID];
    const eglink = eglinkQuest && eglinkRewards(eglinkQuest, questXPTable, factionRewardTable);
    const wowhead = wowheadByID.get(questID);
    if (!eglink && !wowhead) {
      inNoSource.push(questID);
      continue;
    }
    const { rewards, sources } = mergeQuest(eglink, wowhead);
    for (const field of REWARD_FIELDS) counts[field][sources[field]]++;
    rows.push({ id: questID, xp: rewards.xp, money: rewards.money, items: formatPairs(rewards.items), choices: formatPairs(rewards.choices), reputation: formatPairs(rewards.reputation) });
  }
  return { rows, counts, inNoSource };
}

// ---------------------------------------------------------------------------
// The check against Blizzard's API
// ---------------------------------------------------------------------------

const sortedPairs = (pairs) => [...pairs].sort((first, second) => first[0] - second[0] || first[1] - second[1]);
const sameList = (first, second) => JSON.stringify(first) === JSON.stringify(second);
const itemIDs = (pairs) => pairs.map(([itemID]) => itemID).sort((first, second) => first - second);

// The fields of one quest that differ from Blizzard's API: [{ field, ours, blizzard }].
// The API gives no item counts, so items and choices are compared by item ID.
export function blizzardDifferences(ours, blizzard) {
  const differences = [];
  const compare = (field, ourValue, blizzardValue) => {
    if (!sameList(ourValue, blizzardValue)) differences.push({ field, ours: ourValue, blizzard: blizzardValue });
  };
  compare("xp", ours.xp, blizzard.xp);
  compare("money", ours.money, blizzard.money);
  compare("items", itemIDs(ours.items), itemIDs(blizzard.items));
  compare("choices", itemIDs(ours.choices), itemIDs(blizzard.choices));
  compare("reputation", sortedPairs(ours.reputation), sortedPairs(blizzard.reputation));
  return differences;
}

// Every difference between the rewards CSV's rows and the Blizzard cache's
// quests: [{ id, field, ours, blizzard }]; unknown lists the quests the API
// doesn't have.
export function checkAgainstBlizzard(rewardRows, blizzardQuests) {
  const differences = [];
  const unknown = [];
  for (const row of rewardRows) {
    const blizzard = blizzardQuests[row.id];
    if (!blizzard || blizzard.missing) {
      unknown.push(Number(row.id));
      continue;
    }
    for (const difference of blizzardDifferences(csvRewards(row), blizzard)) differences.push({ id: Number(row.id), ...difference });
  }
  return { differences, unknown };
}

// ---------------------------------------------------------------------------
// Commands
// ---------------------------------------------------------------------------

const readJson = async (file) => JSON.parse(await readFile(file, "utf8"));

async function readSeriesQuestIDs(root) {
  return seriesQuestIDs(parseCsv(await readFile(path.join(root, CSV_FILE), "utf8")));
}

async function saveEglink(eglinkFolder, root) {
  const productFolder = path.join(eglinkFolder, "data", "wowf");
  const buildFiles = [];
  for (const build of await readdir(productFolder)) {
    const questFile = path.join(productFolder, build, "quests.enUS.json");
    try {
      buildFiles.push({ build, quests: (await readJson(questFile)).quests });
    } catch (error) {
      if (error.code !== "ENOENT") throw error;  // a build without a quest file
    }
  }
  const questIDs = await readSeriesQuestIDs(root);
  const quests = newestQuests(buildFiles, questIDs);
  const builds = buildFiles.map((file) => file.build).sort((first, second) => buildNumber(first) - buildNumber(second));
  const eglinkFile = path.join(root, EGLINK_FILE);
  await writeFile(eglinkFile, JSON.stringify({ attribution: EGLINK_CREDIT, changes: EGLINK_CHANGES, source: "https://github.com/JIVESCORP/eg-link-output-wowf", product: "wowf", builds, quests }, null, 1) + "\n");
  console.log(`Wrote ${Object.keys(quests).length} of the series' ${questIDs.length} quests to ${eglinkFile}, from ${builds.length} builds (${builds[0]} to ${builds.at(-1)}).`);
}

async function merge(root) {
  const questIDs = await readSeriesQuestIDs(root);
  const eglink = await readJson(path.join(root, EGLINK_FILE));
  const wowheadRows = parseCsv(await readFile(path.join(root, WOWHEAD_REWARDS_CSV_FILE), "utf8"));
  const questXPTable = difficultyTable(await readFile(path.join(root, QUEST_XP_FILE), "utf8"));
  const factionRewardTable = difficultyTable(await readFile(path.join(root, FACTION_REWARD_FILE), "utf8"));
  const { rows, counts, inNoSource } = mergeRewards(questIDs, eglink.quests, wowheadRows, questXPTable, factionRewardTable);
  const csvFile = path.join(root, REWARDS_CSV_FILE);
  await writeFile(csvFile, toCsv(rows, REWARD_COLUMNS));
  console.log(`Wrote the rewards of ${rows.length} of the series' ${questIDs.length} quests to ${csvFile}.`);
  for (const field of REWARD_FIELDS) {
    console.log(`  ${field.padEnd(10)} EG Link ${counts[field].eglink}, Wowhead ${counts[field].wowhead}, none ${counts[field].none}`);
  }
  if (inNoSource.length) console.log(`In no source: ${inNoSource.join(" ")}`);
}

async function check(blizzardCacheFile, root) {
  const rewardRows = parseCsv(await readFile(path.join(root, REWARDS_CSV_FILE), "utf8"));
  const { differences, unknown } = checkAgainstBlizzard(rewardRows, (await readJson(blizzardCacheFile)).quests);
  for (const difference of differences) {
    console.log(`${difference.id}\t${difference.field}\tours ${JSON.stringify(difference.ours)}\tBlizzard ${JSON.stringify(difference.blizzard)}`);
  }
  const quests = new Set(differences.map((difference) => difference.id)).size;
  const byField = REWARD_FIELDS.map((field) => `${field} ${differences.filter((difference) => difference.field === field).length}`).join(", ");
  console.log(`${quests} of ${rewardRows.length} quests differ from Blizzard's API: ${byField}. ${unknown.length} quests the API doesn't have: ${unknown.join(" ")}`);
}

async function main() {
  const [command, ...rest] = process.argv.slice(2);
  if (command === "eglink" && rest[0]) {
    await saveEglink(path.resolve(rest[0]), path.resolve(rest[1] || process.cwd()));
  } else if (command === "merge") {
    await merge(path.resolve(rest[0] || process.cwd()));
  } else if (command === "check" && rest[0]) {
    await check(path.resolve(rest[0]), path.resolve(rest[1] || process.cwd()));
  } else {
    console.log("Commands: eglink <eg-link-output-wowf folder> [root], merge [root], check <blizzard cache.json> [root]");
    process.exitCode = 1;
  }
}

if (import.meta.url === pathToFileURL(process.argv[1]).href) {
  main().catch((error) => {
    console.error(error.message);
    process.exitCode = 1;
  });
}
