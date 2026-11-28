// Quest series from Wowhead's WoW Forever data, to pick new stories from.
//
//   node _Dev/tools/wowhead-quest-series.mjs snippet [root]
//     Writes _Dev/snippets/wowhead-quest-series.js, a script for the console
//     of any www.wowhead.com page in a browser (Wowhead refuses scripts
//     outside one). It reads Wowhead's
//     "first quest in series" list (split by level when Wowhead cuts it at
//     1000), then each first quest's page for its series, a page every few
//     seconds. It keeps its progress in the page's storage: if it stops at
//     Wowhead's check, reload the page and paste it again. At the end the
//     browser downloads wowhead-forever-quest-series.json.
//     _Dev/snippets/wowhead-quest-series-progress.js, pasted in the same
//     console while it runs, shows how many series it has read and the time left.
//
//   node _Dev/tools/wowhead-quest-series.mjs save <file.json> [root]
//     Writes _Dev/forever-quest-series.csv: every series of 2 or more steps,
//     with its status by length, faction, classes, level and quests.
//
//   node _Dev/tools/wowhead-quest-series.mjs list [root] [--faction horde] [--class mage] [--status epic]
//     Prints the series from the CSV that a character of that faction and
//     class can do.
//
//   node _Dev/tools/wowhead-quest-series.mjs rewards-snippet [root]
//     Writes _Dev/snippets/wowhead-quest-rewards.js, a script for the same
//     console: it reads Wowhead's whole Forever quest list (split by level
//     when Wowhead cuts it at 1000), a page every few seconds, and the browser
//     downloads wowhead-forever-quest-rewards.json: each quest's XP, money,
//     items, choices and reputation.
//
//   node _Dev/tools/wowhead-quest-series.mjs save-rewards <file.json> [root]
//     Writes _Dev/wowhead-quest-rewards.csv: Wowhead's rewards of every quest
//     of the series in the series CSV. quest-rewards.mjs then writes
//     _Dev/forever-quest-rewards.csv from EG Link's data, with these for what
//     EG Link doesn't have.
//
// The first quests are the list to read: a series' first quest is where a
// story begins, and its page shows the whole series.

import { mkdir, readFile, writeFile } from "node:fs/promises";
import path from "node:path";
import { pathToFileURL } from "node:url";

export const CSV_FILE = path.join("_Dev", "forever-quest-series.csv");
export const SNIPPET_FILE = path.join("_Dev", "snippets", "wowhead-quest-series.js");
export const REWARDS_CSV_FILE = path.join("_Dev", "forever-quest-rewards.csv");
export const WOWHEAD_REWARDS_CSV_FILE = path.join("_Dev", "wowhead-quest-rewards.csv");
export const REWARDS_SNIPPET_FILE = path.join("_Dev", "snippets", "wowhead-quest-rewards.js");
const COLUMNS = ["id", "name", "status", "quests", "faction", "classes", "level", "min_level", "zone_id", "quest_ids", "quest_names"];
export const REWARD_COLUMNS = ["id", "xp", "money", "items", "choices", "reputation"];

// Fewest steps for each status, longest first.
const STATUS_BY_LENGTH = [[15, "legendary"], [10, "epic"], [6, "immersive"], [3, "routine"], [2, "trivial"]];

// Wowhead's side and class IDs; classes as the game's class file names.
const FACTIONS = { 1: "Alliance", 2: "Horde" };
const CLASSES = {
  1: "WARRIOR", 2: "PALADIN", 3: "HUNTER", 4: "ROGUE", 5: "PRIEST", 6: "DEATHKNIGHT", 7: "SHAMAN",
  8: "MAGE", 9: "WARLOCK", 10: "MONK", 11: "DRUID", 12: "DEMONHUNTER", 13: "EVOKER",
};

// ---------------------------------------------------------------------------
// Browser snippet
// ---------------------------------------------------------------------------

/* global window, document, localStorage, DOMParser, Blob, URL */

// The bracketed value that starts at text[start] ("[" or "{"), strings skipped.
export function balanced(text, start) {
  let depth = 0;
  let quote = null;
  for (let index = start; index < text.length; index++) {
    const character = text[index];
    if (quote) {
      if (character === "\\") index++;
      else if (character === quote) quote = null;
    } else if (character === '"' || character === "'") {
      quote = character;
    } else if (character === "[" || character === "{") {
      depth++;
    } else if (character === "]" || character === "}") {
      depth--;
      if (depth === 0) return text.slice(start, index + 1);
    }
  }
  return null;
}

// The rows of a Wowhead list page's quest Listview, or null when the page has none.
export function listRows(page) {
  const parse = (text) => {
    try {
      return JSON.parse(text);
    } catch {
      return Function(`return (${text});`)();
    }
  };
  let searchFrom = 0;
  while (true) {
    const listviewAt = page.indexOf("new Listview(", searchFrom);
    if (listviewAt < 0) return null;
    searchFrom = listviewAt + 1;
    const optionsAt = page.indexOf("{", listviewAt);
    const options = balanced(page, optionsAt);
    if (!options || !/["']?template["']?\s*:\s*["']quest["']/.test(options)) continue;
    const data = options.match(/["']?data["']?\s*:\s*(\[|[A-Za-z_$][\w$]*)/);
    if (!data) continue;
    if (data[1] === "[") return parse(balanced(options, data.index + data[0].length - 1));
    const variable = page.match(new RegExp(`${data[1].replace(/\$/g, "\\$")}\\s*=\\s*\\[`));
    if (variable) return parse(balanced(page, variable.index + variable[0].length - 1));
  }
}

// A quest page's series: one list of { id, name } per step (more than one
// when the step has alternatives). The page's own quest is bold, not a link.
export function seriesSteps(page, questID) {
  const pageDocument = new DOMParser().parseFromString(page, "text/html");
  for (const table of pageDocument.querySelectorAll("table")) {
    const steps = [];
    let holdsQuest = false;
    for (const row of table.rows) {
      if (!row.cells[0] || !/^\d+\.$/.test(row.cells[0].textContent.trim())) continue;
      const quests = [];
      for (const cell of [...row.cells].slice(1)) {
        for (const element of cell.querySelectorAll("a[href*='quest='], b")) {
          if (element.tagName === "B") {
            if (element.closest("a")) continue;
            holdsQuest = true;
            quests.push({ id: questID, name: element.textContent.trim() });
          } else {
            quests.push({ id: Number(element.getAttribute("href").match(/quest=(\d+)/)[1]), name: element.textContent.trim() });
          }
        }
      }
      if (quests.length) steps.push(quests);
    }
    if (holdsQuest && steps.length) return steps;
  }
  return [];
}

// A page's text, "missing" for a 404, or null when Wowhead holds the request back.
export async function readWowheadPage(url) {
  const response = await fetch(url);
  const page = await response.text();
  if (response.status === 404) return "missing";
  if (response.status !== 200 || response.headers.get("x-amzn-waf-action") || /Human Verification/i.test(page.slice(0, 3000))) return null;
  return page;
}

// The rows of Wowhead's Forever quest list (filter: "" or "?filter=..."). When
// Wowhead cuts it at 1000 rows: by level, halving the range while it's cut
// (a level still cut: by required level), plus the cut list's rows outside
// levels 1-80.
export async function readQuestList(filter, delay) {
  const LIST_LIMIT = 1000;
  const sleep = (milliseconds) => new Promise((resolve) => setTimeout(resolve, milliseconds));
  // One level's quests, required levels low to high, halving while it's cut.
  async function readRequiredLevels(level, low, high) {
    const page = await readWowheadPage(`/forever/quests/min-level:${level}/max-level:${level}/min-req-level:${low}/max-req-level:${high}${filter}`);
    if (page === null || page === "missing") throw new Error(`Wowhead refused the list for level ${level}, required levels ${low}-${high}`);
    const rows = listRows(page) || [];
    if (rows.some((row) => row.reqlevel < low || row.reqlevel > high)) throw new Error("Wowhead ignored the required level filter");
    console.log(`Level ${level}, required levels ${low}-${high}: ${rows.length} quests.`);
    if (rows.length < LIST_LIMIT) return rows;
    if (low === high) {
      console.log(`Level ${level}, required level ${low}: Wowhead cut the list at ${LIST_LIMIT}; some quests are missing.`);
      return rows;
    }
    const middle = Math.floor((low + high) / 2);
    await sleep(delay);
    const lower = await readRequiredLevels(level, low, middle);
    await sleep(delay);
    return lower.concat(await readRequiredLevels(level, middle + 1, high));
  }
  async function readLevels(low, high) {
    const page = await readWowheadPage(`/forever/quests/min-level:${low}/max-level:${high}${filter}`);
    if (page === null || page === "missing") throw new Error(`Wowhead refused the list for levels ${low}-${high}`);
    const rows = listRows(page);
    if (!rows) throw new Error(`no quest list on the page for levels ${low}-${high}`);
    if (rows.some((row) => row.level < low || row.level > high)) throw new Error("Wowhead ignored the level filter");
    console.log(`Levels ${low}-${high}: ${rows.length} quests.`);
    if (rows.length < LIST_LIMIT) return rows;
    if (low === high) {
      let split = [];
      try {
        await sleep(delay);
        split = await readRequiredLevels(low, 0, low);
      } catch (error) {
        console.log(`Level ${low}: Wowhead cut the list at ${LIST_LIMIT} and ${error.message}; some quests of that level are missing.`);
      }
      const splitIDs = new Set(split.map((row) => row.id));
      return split.concat(rows.filter((row) => !splitIDs.has(row.id)));
    }
    const middle = Math.floor((low + high) / 2);
    await sleep(delay);
    const lower = await readLevels(low, middle);
    await sleep(delay);
    return lower.concat(await readLevels(middle + 1, high));
  }

  const page = await readWowheadPage(`/forever/quests${filter}`);
  if (page === null || page === "missing") throw new Error("Wowhead refused the quest list");
  const rows = listRows(page);
  if (!rows) {
    console.log(page.slice(0, 500));
    throw new Error("no quest list on the page (its start is above)");
  }
  console.log(`${rows.length} quests.`);
  if (rows.length < LIST_LIMIT) return rows;
  await sleep(delay);
  const byLevel = await readLevels(1, 80);
  const levelIDs = new Set(byLevel.map((row) => row.id));
  const outside = rows.filter((row) => !levelIDs.has(row.id));
  if (outside.length) console.log(`${outside.length} quests outside levels 1-80 kept from the cut list; others may be missing.`);
  return byLevel.concat(outside);
}

// The browser saves data as fileName.
function downloadJson(fileName, data) {
  const file = new Blob([JSON.stringify(data)], { type: "application/json" });
  const link = document.createElement("a");
  link.href = URL.createObjectURL(file);
  link.download = fileName;
  link.click();
}

async function readWowheadQuestSeries(delay) {
  const STORE = "storyModeQuestSeries";
  const FILTER = "?filter=7;1;0";
  const sleep = (milliseconds) => new Promise((resolve) => setTimeout(resolve, milliseconds));
  const saved = JSON.parse(localStorage.getItem(STORE) || "{}");
  saved.series = saved.series || {};
  const store = () => localStorage.setItem(STORE, JSON.stringify(saved));
  const stop = (reason) => console.log(`Stopped: ${reason}. Reload this page (it passes Wowhead's check), then paste the script again; it carries on.`);

  if (!saved.starts) {
    try {
      const rows = await readQuestList(FILTER, delay);
      saved.starts = {};
      for (const row of rows) saved.starts[row.id] = row;
      store();
    } catch (error) {
      return stop(error.message);
    }
  }

  const ids = Object.keys(saved.starts).filter((id) => !saved.series[id]);
  const total = Object.keys(saved.starts).length;
  console.log(`${total - ids.length} of ${total} series read; about ${Math.ceil((ids.length * delay) / 60000)} min left.`);
  for (const [index, id] of ids.entries()) {
    const page = await readWowheadPage(`/forever/quest=${id}`);
    if (page === null) return stop(`Wowhead refused quest ${id}`);
    saved.series[id] = { steps: page === "missing" ? [] : seriesSteps(page, Number(id)) };
    store();
    if (index < 3) console.log(`Quest ${id}: ${saved.series[id].steps.length} steps.`);
    else if ((index + 1) % 10 === 0) console.log(`${total - ids.length + index + 1} of ${total} series read.`);
    await sleep(delay);
  }

  downloadJson("wowhead-forever-quest-series.json", { read: new Date().toISOString(), filter: FILTER, starts: saved.starts, series: saved.series });
  console.log(`Read all ${total} series; downloaded wowhead-forever-quest-series.json. To read again from scratch: localStorage.removeItem("${STORE}")`);
}

// Each quest's rewards from Wowhead's whole Forever quest list: a few pages.
async function readWowheadQuestRewards(delay) {
  let rows;
  try {
    rows = await readQuestList("", delay);
  } catch (error) {
    return console.log(`Stopped: ${error.message}. Reload this page (it passes Wowhead's check), then paste the script again.`);
  }
  const quests = {};
  for (const row of rows) {
    quests[row.id] = { xp: row.xp || 0, money: row.money || 0, items: row.itemrewards || [], choices: row.itemchoices || [], reputation: row.reprewards || [] };
  }
  downloadJson("wowhead-forever-quest-rewards.json", { read: new Date().toISOString(), quests });
  console.log(`Read ${rows.length} quests; downloaded wowhead-forever-quest-rewards.json.`);
}

const SHARED_PARTS = [balanced, listRows, readWowheadPage, readQuestList, downloadJson];
const snippetOf = (parts, call) => parts.map((part) => part.toString()).join("\n\n") + `\n\n${call};`;

export const snippet = (delay = 5000) => snippetOf([...SHARED_PARTS, seriesSteps, readWowheadQuestSeries], `readWowheadQuestSeries(${delay})`);
export const rewardsSnippet = (delay = 5000) => snippetOf([...SHARED_PARTS, readWowheadQuestRewards], `readWowheadQuestRewards(${delay})`);

// ---------------------------------------------------------------------------
// The series table
// ---------------------------------------------------------------------------

export function seriesStatus(steps) {
  return STATUS_BY_LENGTH.find(([fewest]) => steps >= fewest)?.[1] || null;
}

const classNames = (mask) => Object.entries(CLASSES).filter(([id]) => mask & (1 << (id - 1))).map(([, name]) => name);

// One row per series of 2 or more steps, longest first; a series that two
// first quests share is kept once.
export function seriesRows(scan) {
  const starts = Object.values(scan.starts);
  if (!starts.some((start) => start.side !== undefined)) throw new Error("Wowhead's list rows have no side: its list format changed");
  const rows = [];
  const seen = new Set();
  for (const start of starts) {
    const steps = scan.series[start.id]?.steps || [];
    const status = seriesStatus(steps.length);
    if (!status) continue;
    const questIDs = steps.map((step) => step.map((quest) => quest.id).join("/")).join(" ");
    if (seen.has(questIDs)) continue;
    seen.add(questIDs);
    rows.push({
      id: start.id,
      name: steps[0][0].name,
      status,
      quests: steps.length,
      faction: FACTIONS[start.side] || "Both",
      classes: classNames(start.reqclass || 0).join(" "),
      level: start.level ?? "",
      min_level: start.reqlevel ?? "",
      zone_id: start.category ?? "",
      quest_ids: questIDs,
      quest_names: steps.map((step) => step.map((quest) => quest.name).join(" / ")).join(" | "),
    });
  }
  return rows.sort((first, second) => second.quests - first.quests || first.id - second.id);
}

const csvField = (value) => (/[",\r\n]/.test(String(value)) ? `"${String(value).replace(/"/g, '""')}"` : String(value));

export const toCsv = (rows, columns = COLUMNS) => [columns, ...rows.map((row) => columns.map((column) => row[column]))].map((values) => values.map(csvField).join(",")).join("\n") + "\n";

const questIDsOf = (seriesRows) => new Set(seriesRows.flatMap((row) => row.quest_ids.split(/[ /]/).map(Number)));

// One row per quest of the series (rows of the series CSV) that Wowhead's
// list has, by quest ID: items and choices as "itemID:count", reputation as
// "factionID:amount", space separated.
export function rewardRows(rewardsScan, seriesRows) {
  const pairs = (list) => list.map(([id, amount]) => `${id}:${amount}`).join(" ");
  return [...questIDsOf(seriesRows)].filter((id) => rewardsScan.quests[id]).sort((first, second) => first - second).map((id) => {
    const quest = rewardsScan.quests[id];
    return { id, xp: quest.xp, money: quest.money, items: pairs(quest.items), choices: pairs(quest.choices), reputation: pairs(quest.reputation) };
  });
}

// The series' quests, in ID order.
export const seriesQuestIDs = (seriesRows) => [...questIDsOf(seriesRows)].sort((first, second) => first - second);

export function parseCsv(text) {
  const records = [];
  let record = [];
  let field = "";
  let quoted = false;
  for (let index = 0; index < text.length; index++) {
    const character = text[index];
    if (quoted) {
      if (character === '"' && text[index + 1] === '"') {
        field += '"';
        index++;
      } else if (character === '"') {
        quoted = false;
      } else {
        field += character;
      }
    } else if (character === '"') {
      quoted = true;
    } else if (character === ",") {
      record.push(field);
      field = "";
    } else if (character === "\n") {
      record.push(field);
      records.push(record);
      record = [];
      field = "";
    } else if (character !== "\r") {
      field += character;
    }
  }
  if (field || record.length) records.push([...record, field]);
  const [header, ...values] = records;
  return values.map((row) => Object.fromEntries(header.map((column, index) => [column, row[index] ?? ""])));
}

// The series a character of that faction and class can do (a filter left
// out matches every series).
export function filterSeries(rows, { faction, className, status } = {}) {
  const classFile = className?.toUpperCase().replace(/\s+/g, "");
  return rows.filter((row) =>
    (!faction || row.faction === "Both" || row.faction.toLowerCase() === faction.toLowerCase()) &&
    (!classFile || !row.classes || row.classes.split(" ").includes(classFile)) &&
    (!status || row.status === status.toLowerCase()));
}

// ---------------------------------------------------------------------------
// Commands
// ---------------------------------------------------------------------------

async function main() {
  const args = process.argv.slice(2);
  const command = args[0];
  const VALUE_OPTIONS = new Set(["--faction", "--class", "--status", "--delay"]);
  const positional = args.slice(1).filter((arg, index, list) => !arg.startsWith("--") && !VALUE_OPTIONS.has(list[index - 1]));
  const option = (name) => {
    const index = args.indexOf(`--${name}`);
    return index >= 0 ? args[index + 1] : undefined;
  };

  if (command === "snippet") {
    const snippetFile = path.join(path.resolve(positional[0] || process.cwd()), SNIPPET_FILE);
    await mkdir(path.dirname(snippetFile), { recursive: true });
    await writeFile(snippetFile, snippet(Number(option("delay")) || 5000) + "\n");
    console.log(`Wrote ${snippetFile}.`);
  } else if (command === "save") {
    if (!positional[0]) throw new Error("save needs the downloaded wowhead-forever-quest-series.json");
    const scan = JSON.parse(await readFile(positional[0], "utf8"));
    const rows = seriesRows(scan);
    const csvFile = path.join(path.resolve(positional[1] || process.cwd()), CSV_FILE);
    await writeFile(csvFile, toCsv(rows));
    const noSeries = Object.keys(scan.starts).filter((id) => !scan.series[id]?.steps.length).length;
    const byStatus = STATUS_BY_LENGTH.map(([, status]) => `${rows.filter((row) => row.status === status).length} ${status}`).join(", ");
    console.log(`Wrote ${rows.length} series to ${csvFile}: ${byStatus}.`);
    if (noSeries) console.log(`${noSeries} first quests had no series on their page.`);
  } else if (command === "rewards-snippet") {
    const snippetFile = path.join(path.resolve(positional[0] || process.cwd()), REWARDS_SNIPPET_FILE);
    await mkdir(path.dirname(snippetFile), { recursive: true });
    await writeFile(snippetFile, rewardsSnippet(Number(option("delay")) || 5000) + "\n");
    console.log(`Wrote ${snippetFile}.`);
  } else if (command === "save-rewards") {
    if (!positional[0]) throw new Error("save-rewards needs the downloaded wowhead-forever-quest-rewards.json");
    const root = path.resolve(positional[1] || process.cwd());
    const scan = JSON.parse(await readFile(positional[0], "utf8"));
    const series = parseCsv(await readFile(path.join(root, CSV_FILE), "utf8"));
    const rows = rewardRows(scan, series);
    const csvFile = path.join(root, WOWHEAD_REWARDS_CSV_FILE);
    await writeFile(csvFile, toCsv(rows, REWARD_COLUMNS));
    console.log(`Wrote the rewards of ${rows.length} of the series' ${questIDsOf(series).size} quests to ${csvFile}.`);
  } else if (command === "list") {
    const csvFile = path.join(path.resolve(positional[0] || process.cwd()), CSV_FILE);
    const rows = filterSeries(parseCsv(await readFile(csvFile, "utf8")), { faction: option("faction"), className: option("class"), status: option("status") });
    for (const row of rows) {
      console.log([row.status.padEnd(9), String(row.quests).padStart(2), row.faction.padEnd(8), `${row.min_level}-${row.level}`.padEnd(5), row.name, `(${row.id})`, row.classes].join("  ").trimEnd());
    }
    console.log(`${rows.length} series.`);
  } else {
    console.log("Commands: snippet [root], save <file.json> [root], list [root] [--faction] [--class] [--status], rewards-snippet [root], save-rewards <file.json> [root]");
    process.exitCode = 1;
  }
}

if (import.meta.url === pathToFileURL(process.argv[1]).href) {
  main().catch((error) => {
    console.error(error.message);
    process.exitCode = 1;
  });
}
