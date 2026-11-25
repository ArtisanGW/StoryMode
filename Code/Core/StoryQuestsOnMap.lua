local _, SM = ...

-- The story quests on the player's map, as the game reports them:
-- - offered: quests a giver there has for the player (the same quest lines
--   the world map shows as "!"), with the giver's name from the story data
-- - in the log: quests the game places on that map
-- Each with its map position. Listeners run whenever the list is rebuilt.

local OnMap = { mapID = nil, offered = {}, inLog = {} }
SM.StoryQuestsOnMap = OnMap

local listeners = {}

function OnMap.OnChange(listener)
    listeners[#listeners + 1] = listener
end

local function AddOffered(questID, x, y)
    local _, quest = SM.FindQuestStory(questID)
    if quest then
        OnMap.offered[#OnMap.offered + 1] = { questID = questID, x = x, y = y, npc = quest.npc }
    end
end

local function CollectOffered(mapID)
    for _, questLineInfo in ipairs(C_QuestLine.GetAvailableQuestLines(mapID) or {}) do
        AddOffered(questLineInfo.questID, questLineInfo.x, questLineInfo.y)
    end
    for _, questID in ipairs(C_QuestLine.GetForceVisibleQuests(mapID) or {}) do
        local questLineInfo = C_QuestLine.GetQuestLineInfo(questID, mapID)
        if questLineInfo then AddOffered(questID, questLineInfo.x, questLineInfo.y) end
    end
end

local function CollectInLog(mapID)
    for _, questOnMap in ipairs(C_QuestLog.GetQuestsOnMap(mapID) or {}) do
        if SM.FindQuestStory(questOnMap.questID) then
            OnMap.inLog[#OnMap.inLog + 1] = { questID = questOnMap.questID, x = questOnMap.x, y = questOnMap.y }
        end
    end
end

function OnMap.Rebuild()
    OnMap.mapID = C_Map.GetBestMapForUnit("player")
    wipe(OnMap.offered)
    wipe(OnMap.inLog)
    if OnMap.mapID then
        CollectOffered(OnMap.mapID)
        CollectInLog(OnMap.mapID)
    end
    for _, listener in ipairs(listeners) do listener() end
end

-- The game answers with QUESTLINE_UPDATE.
local function RequestOffered()
    local mapID = C_Map.GetBestMapForUnit("player")
    if mapID then C_QuestLine.RequestQuestLinesForMap(mapID) end
end

local eventFrame = CreateFrame("Frame")
for _, event in ipairs({
    "PLAYER_ENTERING_WORLD", "ZONE_CHANGED_NEW_AREA", "ZONE_CHANGED", "ZONE_CHANGED_INDOORS",
    "QUEST_ACCEPTED", "QUEST_TURNED_IN", "QUEST_REMOVED", "QUESTLINE_UPDATE", "QUEST_LOG_UPDATE",
}) do
    eventFrame:RegisterEvent(event)
end
eventFrame:SetScript("OnEvent", function(_, event, requestRequired)
    if event == "QUESTLINE_UPDATE" and requestRequired then
        RequestOffered()
    elseif event == "QUESTLINE_UPDATE" or event == "QUEST_LOG_UPDATE" then
        OnMap.Rebuild()
    else
        RequestOffered()
        OnMap.Rebuild()
    end
end)
