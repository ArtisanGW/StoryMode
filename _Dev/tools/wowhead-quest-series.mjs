// Quest series from Wowhead's WoW Forever data, to pick new stories from.
//
//   node _Dev/tools/wowhead-quest-series.mjs snippet
//     Prints a script for the console of any www.wowhead.com page in a
//     browser (Wowhead refuses scripts outside one). It reads Wowhead's
//     "first quest in series" list (split by level when Wowhead cuts it at
//     1000), then each first quest's page for its series, a page every few
//     seconds. It keeps its progress in the page's storage: if it stops at
//     Wowhead's check, reload the page and paste it again. At the end the
//     browser downloads wowhead-forever-quest-series.json.
//
//   node _Dev/tools/wowhead-quest-series.mjs save <file.json> [root]
//     Writes _Dev/forever-quest-series.csv: every series of 3 or more steps,
//     with its status by length, faction, classes, level and quests.
//
//   node _Dev/tools/wowhead-quest-series.mjs list [root] [--faction horde] [--class mage] [--status epic]
//     Prints the series from the CSV that a character of that faction and
//     class can do.
//
// The first quests are the list to read: a series' first quest is where a
// story begins, and its page shows the whole series.

import { readFile, writeFile } from "node:fs/promises";
import path from "node:path";
import { pathToFileURL } from "node:url";

export const CSV_FILE = path.join("_Dev", "forever-quest-series.csv");
const COLUMNS = ["id", "name", "status", "quests", "faction", "classes", "level", "min_level", "zone_id", "quest_ids", "quest_names"];

// Fewest steps for each status, longest first.
const STATUS_BY_LENGTH = [[15, "legendary"], [10, "epic"], [6, "immersive"], [3, "routine"]];

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

async function readWowheadQuestSeries(delay) {
  const STORE = "storyModeQuestSeries";
  const LIST_LIMIT = 1000;
  const FILTER = "?filter=7;1;0";
  const sleep = (milliseconds) => new Promise((resolve) => setTimeout(resolve, milliseconds));
  const saved = JSON.parse(localStorage.getItem(STORE) || "{}");
  saved.series = saved.series || {};
  const store = () => localStorage.setItem(STORE, JSON.stringify(saved));
  const stop = (reason) => console.log(`Stopped: ${reason}. Reload this page (it passes Wowhead's check), then paste the script again; it carries on.`);

  // A page's text, "missing" for a 404, or null when Wowhead holds the request back.
  async function readPage(url) {
    const response = await fetch(url);
    const page = await response.text();
    if (response.status === 404) return "missing";
    if (response.status !== 200 || response.headers.get("x-amzn-waf-action") || /Human Verification/i.test(page.slice(0, 3000))) return null;
    return page;
  }

  // The first quests with levels low to high, halving the range while Wowhead cuts the list.
  async function readList(low, high) {
    const page = await readPage(`/forever/quests/min-level:${low}/max-level:${high}${FILTER}`);
    if (page === null || page === "missing") throw new Error(`Wowhead refused the list for levels ${low}-${high}`);
    const rows = listRows(page);
    if (!rows) throw new Error(`no quest list on the page for levels ${low}-${high}`);
    if (rows.some((row) => row.level < low || row.level > high)) throw new Error("Wowhead ignored the level filter");
    console.log(`Levels ${low}-${high}: ${rows.length} first quests.`);
    if (rows.length < LIST_LIMIT || low === high) return rows;
    const middle = Math.floor((low + high) / 2);
    await sleep(delay);
    const lower = await readList(low, middle);
    await sleep(delay);
    return lower.concat(await readList(middle + 1, high));
  }

  if (!saved.starts) {
    try {
      const page = await readPage(`/forever/quests${FILTER}`);
      if (page === null || page === "missing") return stop("Wowhead refused the first quest list");
      let rows = listRows(page);
      if (!rows) {
        console.log(page.slice(0, 500));
        return stop("no quest list on the page (its start is above)");
      }
      console.log(`${rows.length} first quests.`);
      if (rows.length >= LIST_LIMIT) {
        const byLevel = await readList(1, 80);
        const levelIDs = new Set(byLevel.map((row) => row.id));
        const outside = rows.filter((row) => !levelIDs.has(row.id));
        if (outside.length) console.log(`${outside.length} first quests outside levels 1-80 kept from the cut list; others may be missing.`);
        rows = byLevel.concat(outside);
      }
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
    const page = await readPage(`/forever/quest=${id}`);
    if (page === null) return stop(`Wowhead refused quest ${id}`);
    saved.series[id] = { steps: page === "missing" ? [] : seriesSteps(page, Number(id)) };
    store();
    if (index < 3) console.log(`Quest ${id}: ${saved.series[id].steps.length} steps.`);
    else if ((index + 1) % 10 === 0) console.log(`${total - ids.length + index + 1} of ${total} series read.`);
    await sleep(delay);
  }

  const file = new Blob([JSON.stringify({ read: new Date().toISOString(), filter: FILTER, starts: saved.starts, series: saved.series })], { type: "application/json" });
  const link = document.createElement("a");
  link.href = URL.createObjectURL(file);
  link.download = "wowhead-forever-quest-series.json";
  link.click();
  console.log(`Read all ${total} series; downloaded wowhead-forever-quest-series.json. To read again from scratch: localStorage.removeItem("${STORE}")`);
}

export const snippet = (delay = 5000) =>
  [balanced, listRows, seriesSteps, readWowheadQuestSeries].map((part) => part.toString()).join("\n\n") + `\n\nreadWowheadQuestSeries(${delay});`;

// ---------------------------------------------------------------------------
// The series table
// ---------------------------------------------------------------------------

export function seriesStatus(steps) {
  return STATUS_BY_LENGTH.find(([fewest]) => steps >= fewest)?.[1] || null;
}

const classNames = (mask) => Object.entries(CLASSES).filter(([id]) => mask & (1 << (id - 1))).map(([, name]) => name);

// One row per series of 3 or more steps, longest first; a series that two
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

export const toCsv = (rows) => [COLUMNS, ...rows.map((row) => COLUMNS.map((column) => row[column]))].map((values) => values.map(csvField).join(",")).join("\n") + "\n";

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
    process.stdout.write(snippet(Number(option("delay")) || 5000) + "\n");
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
  } else if (command === "list") {
    const csvFile = path.join(path.resolve(positional[0] || process.cwd()), CSV_FILE);
    const rows = filterSeries(parseCsv(await readFile(csvFile, "utf8")), { faction: option("faction"), className: option("class"), status: option("status") });
    for (const row of rows) {
      console.log([row.status.padEnd(9), String(row.quests).padStart(2), row.faction.padEnd(8), `${row.min_level}-${row.level}`.padEnd(5), row.name, `(${row.id})`, row.classes].join("  ").trimEnd());
    }
    console.log(`${rows.length} series.`);
  } else {
    console.log("Commands: snippet, save <file.json> [root], list [root] [--faction] [--class] [--status]");
    process.exitCode = 1;
  }
}

if (import.meta.url === pathToFileURL(process.argv[1]).href) {
  main().catch((error) => {
    console.error(error.message);
    process.exitCode = 1;
  });
}
