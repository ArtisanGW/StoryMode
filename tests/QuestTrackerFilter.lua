local watchedQuestIDs = { 101, 202, 303 }
local questsInLog = { [101] = true, [202] = true }
local hiddenQuestEntries = { [303] = true }
local storiesByQuestID = { [101] = "hillsbrad", [202] = "other-story" }
storiesByQuestID[303] = "other-story"
local storyData = { hillsbrad = { id = "hillsbrad" }, ["other-story"] = { id = "other-story" } }
local inCombat = false
local eventHandler
local events = {}

StoryModeDB = {
    hideUnrelatedQuestTrackerQuests = true,
    selectedQuestlineID = "hillsbrad",
    hiddenQuestTrackerWatches = {},
}
UnitGUID = function() return "player-1" end
InCombatLockdown = function() return inCombat end
-- The game's tracker redraws itself on QUEST_WATCH_LIST_CHANGED; the filter
-- never calls into it.
ObjectiveTrackerManager = setmetatable({}, { __index = function() error("the filter called the tracker") end })

local eventFrame = {}
function eventFrame:RegisterEvent(event)
    events[event] = true
end
function eventFrame:SetScript(script, handler)
    assert(script == "OnEvent")
    eventHandler = handler
end
CreateFrame = function() return eventFrame end

local function FindWatchedIndex(questID)
    for index, watchedQuestID in ipairs(watchedQuestIDs) do
        if watchedQuestID == questID then return index end
    end
end

C_QuestLog = {
    GetNumQuestWatches = function() return #watchedQuestIDs end,
    GetQuestIDForQuestWatchIndex = function(index) return watchedQuestIDs[index] end,
    GetLogIndexForQuestID = function(questID)
        if questsInLog[questID] or hiddenQuestEntries[questID] then return questID end
    end,
    AddQuestWatch = function(questID)
        if not FindWatchedIndex(questID) then
            watchedQuestIDs[#watchedQuestIDs + 1] = questID
        end
    end,
    RemoveQuestWatch = function(questID)
        local index = FindWatchedIndex(questID)
        if index then table.remove(watchedQuestIDs, index) end
    end,
}

local SM = {
    FindQuestStory = function(questID)
        local storyID = storiesByQuestID[questID]
        return storyID and storyData[storyID]
    end,
    GetQuestlineByID = function(storyID) return storyData[storyID] end,
    IsQuestInLog = function(questID) return questsInLog[questID] == true end,
    AddQuestWatch = C_QuestLog.AddQuestWatch,
    RemoveQuestWatch = C_QuestLog.RemoveQuestWatch,
}

assert(loadfile("Code/Core/QuestTrackerFilter.lua"))("StoryMode", SM)

local function Contains(list, value)
    for _, item in ipairs(list) do
        if item == value then return true end
    end
    return false
end

local function Fire(event, ...)
    assert(events[event], "event not registered: " .. event)
    eventHandler(nil, event, ...)
end

SM.UpdateQuestTrackerStoryFilter()
local hidden = StoryModeDB.hiddenQuestTrackerWatches["player-1"]
assert(Contains(watchedQuestIDs, 101))
assert(not Contains(watchedQuestIDs, 202))
assert(not Contains(watchedQuestIDs, 303))
assert(hidden[202] == true)
assert(hidden[303] == true)


SM.SetQuestTrackerStory("other-story")
assert(StoryModeDB.questTrackerStoryID == "other-story")
assert(not Contains(watchedQuestIDs, 101))
assert(Contains(watchedQuestIDs, 202))
assert(hidden[101] == true)
assert(hidden[202] == nil)

SM.SetQuestTrackerStoryFilterEnabled(false)
assert(Contains(watchedQuestIDs, 101))
assert(Contains(watchedQuestIDs, 202))
assert(Contains(watchedQuestIDs, 303))
assert(next(hidden) == nil)

SM.SetQuestTrackerStory("hillsbrad")
-- Turned on from the start page: the Introduction has no story selected.
StoryModeDB.selectedQuestlineID = nil
SM.SetQuestTrackerStoryFilterEnabled(true)
assert(Contains(watchedQuestIDs, 101))
assert(not Contains(watchedQuestIDs, 202))
C_QuestLog.AddQuestWatch(202)
Fire("QUEST_WATCH_LIST_CHANGED")
assert(not Contains(watchedQuestIDs, 202))
assert(hidden[202] == true)

questsInLog[202] = nil
Fire("QUEST_LOG_UPDATE")
assert(hidden[202] == nil)

inCombat = true
questsInLog[202] = true
C_QuestLog.AddQuestWatch(202)
SM.UpdateQuestTrackerStoryFilter()
assert(Contains(watchedQuestIDs, 202))
inCombat = false
Fire("PLAYER_REGEN_ENABLED")
assert(not Contains(watchedQuestIDs, 202))

-- Back on the start page: the tracker keeps the last story.
StoryModeDB.selectedQuestlineID = nil
SM.SetQuestTrackerStory(nil)
SM.UpdateQuestTrackerStoryFilter()
assert(StoryModeDB.questTrackerStoryID == "hillsbrad")
assert(not Contains(watchedQuestIDs, 202))

-- A story that no longer exists shows every quest again.
StoryModeDB.questTrackerStoryID = "removed-story"
SM.UpdateQuestTrackerStoryFilter()
assert(Contains(watchedQuestIDs, 202))
assert(hidden[202] == nil)

print("QuestTrackerFilter tests passed")
