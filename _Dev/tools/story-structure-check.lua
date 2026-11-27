-- Loads every story data file a .toc lists, with real Lua, and checks each
-- quest entry's shape: what the text-based tools can't see, such as a quest
-- line written inside another quest's table (Lua then reads it as part of
-- that quest, and the story never shows it).
--
--   lua _Dev/tools/story-structure-check.lua StoryMode_Camelot.toc
--
-- Reports: files that don't load; chapters without quests; quests without an
-- id (item steps excepted) or name; a quest table holding a nested entry; the
-- same quest twice for the same faction in one story. Prints the other quest
-- keys it saw, for a glance at typos.

local toc = arg[1] or "StoryMode.toc"
local files = {}
for line in io.lines(toc) do
    local file = line:gsub("\\", "/"):match("^%s*(Data/.-%.lua)%s*$")
    if file and (file:match("^Data/Storylines/") or file:match("^Data/ClassQuests/") or file:match("^Data/Professions/")
        or file:match("^Data/Forever/%w+Data%.lua$") or file:match("^Data/Campaigns/")) then
        files[#files + 1] = file
    end
end

local KNOWN_KEYS = {}
for key in ([[id name npc faction gameVersions optional parallel recap recapAlliance recapHorde race class
    excludeRace ids altIds foreverId foreverOptional classicId guidanceQuest guidanceQuests location mapID x y item objective
    breadcrumbFor afterQuest attunement displayName hideIf showIf instance recapAfter trackingHint trackingHintFormat
    trackingHintQuestID trackingHintQuestName trackingHintPlace trackingHintNPC trackingHintDestination]]):gmatch("%S+") do
    KNOWN_KEYS[key] = true
end

local problems, quests, stories = 0, 0, 0
local otherKeys = {}
local function report(file, message)
    problems = problems + 1
    print(file .. ": " .. message)
end

for _, file in ipairs(files) do
    local SM = {}
    local chunk, loadError = loadfile(file)
    if not chunk then
        report(file, "does not load: " .. loadError)
    else
        local ok, runError = pcall(chunk, "StoryMode", SM)
        if not ok then report(file, "error: " .. tostring(runError)) end
        for key, data in pairs(SM) do
            if type(data) == "table" and data.chapters then
                stories = stories + 1
                local seen = {}
                for chapterIndex, chapter in ipairs(data.chapters) do
                    local chapterName = tostring(chapter.chapter or chapterIndex)
                    if type(chapter.quests) ~= "table" then
                        report(file, ("%s: chapter %q has no quests"):format(key, chapterName))
                    else
                        local count = 0
                        for _ in pairs(chapter.quests) do count = count + 1 end
                        if count ~= #chapter.quests then
                            report(file, ("%s: chapter %q has %d quest entries but a list of %d"):format(key, chapterName, count, #chapter.quests))
                        end
                        for index, quest in ipairs(chapter.quests) do
                            quests = quests + 1
                            if type(quest) ~= "table" then
                                report(file, ("%s %q #%d is not a table"):format(key, chapterName, index))
                            else
                                if type(quest.id) ~= "number" and not quest.ids and not quest.item then
                                    report(file, ("%s %q #%d %s has no id"):format(key, chapterName, index, tostring(quest.name)))
                                end
                                if type(quest.name) ~= "string" then
                                    report(file, ("%s %q #%d (id %s) has no name"):format(key, chapterName, index, tostring(quest.id)))
                                end
                                for field, value in pairs(quest) do
                                    if type(field) == "number" then
                                        report(file, ("%s %q: quest %s %q holds a nested entry (id %s %q): a quest line is inside another quest's table")
                                            :format(key, chapterName, tostring(quest.id), tostring(quest.name),
                                                tostring(type(value) == "table" and value.id), tostring(type(value) == "table" and value.name)))
                                    elseif not KNOWN_KEYS[field] then
                                        otherKeys[field] = (otherKeys[field] or 0) + 1
                                    end
                                end
                                -- afterQuest names quests (an ID or a list) in the same chapter, each for a side the quest is for.
                                if quest.afterQuest ~= nil then
                                    local list = type(quest.afterQuest) == "table" and quest.afterQuest or { quest.afterQuest }
                                    for _, afterID in ipairs(list) do
                                        local found = false
                                        for _, other in ipairs(chapter.quests) do
                                            if type(other) == "table" and other.id == afterID and other ~= quest
                                                and (other.faction == nil or quest.faction == nil or other.faction == quest.faction) then
                                                found = true
                                            end
                                        end
                                        if not found then
                                            report(file, ("%s %q: quest %s %q has afterQuest %s, which isn't in the chapter for its side")
                                                :format(key, chapterName, tostring(quest.id), tostring(quest.name), tostring(afterID)))
                                        end
                                    end
                                end
                                if quest.id then
                                    local signature = table.concat({ quest.id, tostring(quest.faction or chapter.faction), tostring(quest.class), tostring(quest.race) }, "/")
                                    if seen[signature] then
                                        report(file, ("%s: quest %d %q appears twice (chapters %q and %q)"):format(key, quest.id, tostring(quest.name), seen[signature], chapterName))
                                    end
                                    seen[signature] = chapterName
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

print(("%d stories, %d quests, %d problems"):format(stories, quests, problems))
local keys = {}
for field, count in pairs(otherKeys) do keys[#keys + 1] = field .. " x" .. count end
table.sort(keys)
if #keys > 0 then print("other quest keys: " .. table.concat(keys, ", ")) end
os.exit(problems == 0 and 0 or 1)
