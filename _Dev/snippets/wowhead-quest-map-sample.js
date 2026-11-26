// Wowhead quest pages' map data (where the quest givers stand), for
// wowhead-quest-series.mjs to read them right: paste in the console of any
// www.wowhead.com page; the browser downloads wowhead-quest-map-sample.json.
// Quests: 7 Kobold Camp Cleanup, 95 Sven's Revenge, 788 Cutting Teeth (Horde),
// 2 Sharptalon's Claw (started by an item).
(async () => {
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
  const QUESTS = [7, 95, 788, 2];
  const WORDS = ["Mapper(", "mapperData", "\"coords\"", "coords:", "\"coord\"", "uiMapId"];
  const samples = {};
  for (const id of QUESTS) {
    const response = await fetch(`/forever/quest=${id}`);
    const page = await response.text();
    const found = [];
    for (const word of WORDS) {
      let from = 0;
      for (let count = 0; count < 6; count++) {
        const at = page.indexOf(word, from);
        if (at < 0) break;
        from = at + 1;
        const open = page.slice(at, at + 300).search(/[{[]/);
        const value = open >= 0 ? balanced(page, at + open) : null;
        found.push({ word, before: page.slice(Math.max(0, at - 300), at), value: (value || page.slice(at, at + 3000)).slice(0, 30000) });
      }
    }
    samples[id] = { status: response.status, waf: response.headers.get("x-amzn-waf-action"), found };
    console.log(`Quest ${id}: ${found.length} map parts.`);
    await new Promise((resolve) => setTimeout(resolve, 3000));
  }
  const link = document.createElement("a");
  link.href = URL.createObjectURL(new Blob([JSON.stringify(samples, null, 1)], { type: "application/json" }));
  link.download = "wowhead-quest-map-sample.json";
  link.click();
  console.log("downloaded wowhead-quest-map-sample.json");
})();
