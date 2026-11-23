#!/usr/bin/env node
// Writes CHANGELOG.md sections into Locales/enUS.lua as L["Release Notes
// <version>"], the text the start page's hidden page shows behind the wax
// seal, newest first (it lists every such key it finds). Headings become
// inked lines, items bullets; bold and code marks are dropped, and so is
// Maintenance, which isn't for players.
//   node _Dev/tools/release-notes.mjs <version> [<version> ...]
//   node _Dev/tools/release-notes.mjs --from <oldest version>   (it and every newer one)
// Translate the new strings into the other locales afterwards, as any other.

import fs from "node:fs";
import path from "node:path";

const root = process.cwd();
const changelog = fs.readFileSync(path.join(root, "CHANGELOG.md"), "utf8");
const all = [...changelog.matchAll(/^## (\d+\.\d+\.\d+)\s*$/gm)].map((m) => m[1]);
let versions = process.argv.slice(2);
if (versions[0] === "--from") {
  const oldest = all.indexOf(versions[1]);
  if (oldest < 0) { console.error(`No changelog section for ${versions[1]}.`); process.exit(1); }
  versions = all.slice(0, oldest + 1);
}
if (!versions.length) {
  console.error("Usage: node _Dev/tools/release-notes.mjs <version> [...] | --from <version>");
  process.exit(1);
}

const HEADING_INK = "521902"; // the spellbook divider's ink
const SKIP = new Set(["Maintenance"]);
function notes(version) {
  const start = changelog.indexOf(`## ${version}\n`);
  if (start < 0) { console.error(`No changelog section for ${version}.`); process.exit(1); }
  const next = changelog.indexOf("\n## ", start + 4);
  const sections = [];
  let current = null;
  for (const raw of changelog.slice(start, next >= 0 ? next : changelog.length).split("\n").slice(1)) {
    const line = raw.trimEnd();
    const heading = line.match(/^###\s+(.*)$/);
    if (heading) {
      current = SKIP.has(heading[1].trim()) ? null : { title: heading[1].trim(), items: [] };
      if (current) sections.push(current);
      continue;
    }
    const item = line.match(/^-\s+(.*)$/);
    if (item && current) current.items.push(item[1].replace(/\*\*/g, "").replace(/`/g, ""));
  }
  return sections
    .filter((s) => s.items.length)
    .map((s) => `|cff${HEADING_INK}${s.title}|r\n` + s.items.map((i) => `• ${i}`).join("\n"))
    .join("\n\n");
}

const enPath = path.join(root, "Locales", "enUS.lua");
let en = fs.readFileSync(enPath, "utf8");
const report = [];
for (const version of versions) {
  const text = notes(version);
  const lua = text.replace(/\\/g, "\\\\").replace(/"/g, '\\"').replace(/\n/g, "\\n");
  const key = `Release Notes ${version}`;
  const entry = `L["${key}"] = "${lua}"`;
  const existing = new RegExp(`^L\\["${key.replace(/\./g, "\\.")}"\\] = ".*"$`, "m");
  if (existing.test(en)) {
    en = en.replace(existing, () => entry);
  } else {
    // After the newer version given with it, or else first, under the notes page title.
    const anchor = /^L\["Release Notes \d+\.\d+\.\d+"\] = ".*"$/m.exec(en) && versions.indexOf(version) > 0
      ? new RegExp(`^L\\["Release Notes ${versions[versions.indexOf(version) - 1].replace(/\./g, "\\.")}"\\] = ".*"$`, "m")
      : /^L\["Release Notes Version"\] = ".*"$/m;
    const m = en.match(anchor);
    if (!m) { console.error(`No anchor for ${key} in enUS.lua.`); process.exit(1); }
    en = en.replace(anchor, () => `${m[0]}\n${entry}`);
  }
  report.push({ version, characters: text.length, lines: text.split("\n").length });
}
fs.writeFileSync(enPath, en);
console.log(JSON.stringify(report, null, 2));
