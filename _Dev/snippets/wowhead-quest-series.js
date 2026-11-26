function balanced(text, start) {
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

function listRows(page) {
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

async function readWowheadPage(url) {
  const response = await fetch(url);
  const page = await response.text();
  if (response.status === 404) return "missing";
  if (response.status !== 200 || response.headers.get("x-amzn-waf-action") || /Human Verification/i.test(page.slice(0, 3000))) return null;
  return page;
}

async function readQuestList(filter, delay) {
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

function downloadJson(fileName, data) {
  const file = new Blob([JSON.stringify(data)], { type: "application/json" });
  const link = document.createElement("a");
  link.href = URL.createObjectURL(file);
  link.download = fileName;
  link.click();
}

function seriesSteps(page, questID) {
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

readWowheadQuestSeries(5000);
