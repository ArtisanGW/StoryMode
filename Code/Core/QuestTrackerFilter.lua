local addonName, SM = ...

local updating = false

local function CharacterWatches()
    if not StoryModeDB then return nil end

    local characterGUID = UnitGUID and UnitGUID("player")
    if not characterGUID then return nil end

    StoryModeDB.hiddenQuestTrackerWatches = StoryModeDB.hiddenQuestTrackerWatches or {}
    local watches = StoryModeDB.hiddenQuestTrackerWatches[characterGUID]
    if not watches then
        watches = {}
        StoryModeDB.hiddenQuestTrackerWatches[characterGUID] = watches
    end
    return watches
end

local function ReadWatchedQuestIDs()
    local getCount = C_QuestLog and C_QuestLog.GetNumQuestWatches or GetNumQuestWatches
    local getQuestID = C_QuestLog and C_QuestLog.GetQuestIDForQuestWatchIndex or GetQuestIDForQuestWatchIndex
    if not getCount or not getQuestID then return nil end

    local questIDs = {}
    for index = 1, getCount() do
        local questID = getQuestID(index)
        if questID then questIDs[#questIDs + 1] = questID end
    end
    return questIDs
end

local function WatchedQuestSet(questIDs)
    local watched = {}
    for _, questID in ipairs(questIDs) do
        watched[questID] = true
    end
    return watched
end

local function IsInStory(questID, storyID)
    local story = SM.FindQuestStory(questID)
    return story and story.id == storyID or false
end

-- The story the tracker keeps: the last story the player opened. The start
-- page (the Introduction) clears selectedQuestlineID, so the filter keeps its
-- own story and doesn't turn off whenever the player goes back to it.
local function FilteredStoryID()
    if not (StoryModeDB and StoryModeDB.hideUnrelatedQuestTrackerQuests) then return nil end
    local storyID = StoryModeDB.questTrackerStoryID or StoryModeDB.selectedQuestlineID
    return storyID and SM.GetQuestlineByID(storyID) and storyID or nil
end

local function IsQuestInLog(questID)
    if C_QuestLog and C_QuestLog.GetLogIndexForQuestID then
        return C_QuestLog.GetLogIndexForQuestID(questID) ~= nil
    end
    if GetQuestLogIndexByID then
        local logIndex = GetQuestLogIndexByID(questID)
        return logIndex ~= nil and logIndex > 0
    end
    return SM.IsQuestInLog(questID)
end

local function AddHiddenWatches(hidden, watched, selectedStoryID)
    for questID in pairs(hidden) do
        if not IsQuestInLog(questID) then
            hidden[questID] = nil
        elseif IsInStory(questID, selectedStoryID) and not watched[questID] then
            SM.AddQuestWatch(questID)
        end
    end

    watched = WatchedQuestSet(ReadWatchedQuestIDs())
    for questID in pairs(hidden) do
        if not IsQuestInLog(questID)
            or (IsInStory(questID, selectedStoryID) and watched[questID]) then
            hidden[questID] = nil
        end
    end
end

local function RestoreHiddenWatches(hidden, watched)
    for questID in pairs(hidden) do
        if not IsQuestInLog(questID) then
            hidden[questID] = nil
        elseif not watched[questID] then
            SM.AddQuestWatch(questID)
        end
    end

    watched = WatchedQuestSet(ReadWatchedQuestIDs())
    for questID in pairs(hidden) do
        if not IsQuestInLog(questID) or watched[questID] then
            hidden[questID] = nil
        end
    end
end

function SM.UpdateQuestTrackerStoryFilter()
    if updating or not StoryModeDB then return end
    if InCombatLockdown and InCombatLockdown() then return end

    local hidden = CharacterWatches()
    local watchedQuestIDs = ReadWatchedQuestIDs()
    if not hidden or not watchedQuestIDs then return end

    updating = true
    local watched = WatchedQuestSet(watchedQuestIDs)
    local selectedStoryID = FilteredStoryID()

    if selectedStoryID then
        AddHiddenWatches(hidden, watched, selectedStoryID)
        for _, questID in ipairs(ReadWatchedQuestIDs()) do
            if not IsInStory(questID, selectedStoryID) then
                hidden[questID] = true
                SM.RemoveQuestWatch(questID)
            end
        end
    else
        RestoreHiddenWatches(hidden, watched)
    end
    updating = false
end

-- Called when the player opens a story. No story (the Introduction) keeps the
-- one the tracker already follows.
function SM.SetQuestTrackerStory(storyID)
    if not (StoryModeDB and storyID and SM.GetQuestlineByID(storyID)) then return end
    StoryModeDB.questTrackerStoryID = storyID
    SM.UpdateQuestTrackerStoryFilter()
end

function SM.SetQuestTrackerStoryFilterEnabled(enabled)
    if not StoryModeDB then return end
    StoryModeDB.hideUnrelatedQuestTrackerQuests = enabled == true
    SM.UpdateQuestTrackerStoryFilter()
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
eventFrame:RegisterEvent("QUEST_LOG_UPDATE")
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
eventFrame:SetScript("OnEvent", function()
    SM.UpdateQuestTrackerStoryFilter()
end)
