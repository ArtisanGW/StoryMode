-- The story quests on the player's map, offered and in the log, as the game reports them.
local Fakes = dofile("tests/StoryMarksFakes.lua")
local Fire = Fakes.EventFrames()
Fakes.InstallGlobals()

local requestedMapIDs = {}
C_Map = { GetBestMapForUnit = function() return 1412 end }
C_QuestLine = {
    RequestQuestLinesForMap = function(mapID) requestedMapIDs[#requestedMapIDs + 1] = mapID end,
    GetAvailableQuestLines = function() return { { questID = 201, x = 0.4, y = 0.5 }, { questID = 900, x = 0.1, y = 0.1 } } end,
    GetForceVisibleQuests = function() return { 202 } end,
    GetQuestLineInfo = function(questID) return { questID = questID, x = 0.6, y = 0.7 } end,
}
C_QuestLog = {
    GetQuestsOnMap = function() return { { questID = 301, x = 0.2, y = 0.3 }, { questID = 901, x = 0.9, y = 0.9 } } end,
}

local SM = Fakes.NewStoryMode({ [201] = "hillsbrad", [202] = "other", [301] = "hillsbrad" }, "hillsbrad",
    { [201] = "Devrak", [202] = "Kor'vas Bloodthorn" })
assert(loadfile("Code/Core/StoryQuestsOnMap.lua"))("StoryMode", SM)
local OnMap = SM.StoryQuestsOnMap
local changes = 0
OnMap.OnChange(function() changes = changes + 1 end)

Fire("PLAYER_ENTERING_WORLD")
assert(requestedMapIDs[1] == 1412, "asks the game which quests the map offers")
Fire("QUESTLINE_UPDATE", true)
assert(requestedMapIDs[2] == 1412, "asks again when the game says a request is needed")
local changesBefore = changes
Fire("QUESTLINE_UPDATE", false)
assert(changes == changesBefore + 1, "listeners run when the answer comes")

assert(OnMap.mapID == 1412)
assert(#OnMap.offered == 2, "only story quests are kept")
assert(OnMap.offered[1].questID == 201 and OnMap.offered[1].npc == "Devrak" and OnMap.offered[1].x == 0.4)
assert(OnMap.offered[2].questID == 202 and OnMap.offered[2].y == 0.7, "force-visible quests take the quest line's position")
assert(#OnMap.inLog == 1 and OnMap.inLog[1].questID == 301 and OnMap.inLog[1].x == 0.2)

print("StoryQuestsOnMap tests passed")
