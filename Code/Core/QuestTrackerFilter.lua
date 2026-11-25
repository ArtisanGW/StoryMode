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
    local selectedStoryID = StoryModeDB.hideUnrelatedQuestTrackerQuests
        and StoryModeDB.selectedQuestlineID
    local selectedStory = selectedStoryID and SM.GetQuestlineByID(selectedStoryID)

    if selectedStory then
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
eventFrame:SetScript("OnEvent", function(_, event)
    if event == "PLAYER_REGEN_ENABLED"
        or event == "PLAYER_ENTERING_WORLD"
        or event == "QUEST_WATCH_LIST_CHANGED"
        or event == "QUEST_LOG_UPDATE" then
        SM.UpdateQuestTrackerStoryFilter()
    end
end)
