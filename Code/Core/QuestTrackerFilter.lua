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

-- The story the player follows: the last story they opened. The start page
-- (the Introduction) clears selectedQuestlineID, so the tracker keeps its own
-- story and doesn't lose it whenever the player goes back to that page.
function SM.GetFollowedStoryID()
    if not StoryModeDB then return nil end
    local storyID = StoryModeDB.questTrackerStoryID or StoryModeDB.selectedQuestlineID
    return storyID and SM.GetQuestlineByID(storyID) and storyID or nil
end

local function FilteredStoryID()
    if not (StoryModeDB and StoryModeDB.hideUnrelatedQuestTrackerQuests) then return nil end
    return SM.GetFollowedStoryID()
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

-- A hidden quest missing from the log stays on the list: right after login the
-- log can still be empty, and forgetting them then lost every hidden quest. A
-- quest leaves the list when it's watched again or the game removes it from
-- the log (QUEST_REMOVED: turned in or abandoned).
local function AddHiddenWatches(hidden, watched, selectedStoryID)
    for questID in pairs(hidden) do
        if IsQuestInLog(questID) and IsInStory(questID, selectedStoryID) and not watched[questID] then
            SM.AddQuestWatch(questID)
        end
    end

    watched = WatchedQuestSet(ReadWatchedQuestIDs())
    for questID in pairs(hidden) do
        if IsInStory(questID, selectedStoryID) and watched[questID] then
            hidden[questID] = nil
        end
    end
end

local function Rewatch(questID)
    SM.RemoveQuestWatch(questID)
    SM.AddQuestWatch(questID)
end

-- The game puts each new watch first, and a full tracker leaves out the last
-- ones: once the hidden quests were back, the followed story's quests were
-- last and out of the tracker (measured with DevTrackerProbe). So the story
-- quests are watched again in front: the followed story's, then other
-- stories', each in the order they had.
local function PutStoryQuestsFirst(followedStoryID)
    local followedQuests, otherStoryQuests = {}, {}
    for _, questID in ipairs(ReadWatchedQuestIDs()) do
        local story = SM.FindQuestStory(questID)
        if story and story.id == followedStoryID then
            followedQuests[#followedQuests + 1] = questID
        elseif story then
            otherStoryQuests[#otherStoryQuests + 1] = questID
        end
    end
    -- Last to first, so the first ends up on top.
    for index = #otherStoryQuests, 1, -1 do Rewatch(otherStoryQuests[index]) end
    for index = #followedQuests, 1, -1 do Rewatch(followedQuests[index]) end
end

local function RestoreHiddenWatches(hidden, watched)
    local restored = false
    for questID in pairs(hidden) do
        if IsQuestInLog(questID) and not watched[questID] then
            SM.AddQuestWatch(questID)
            restored = true
        end
    end
    if restored then PutStoryQuestsFirst(SM.GetFollowedStoryID()) end

    watched = WatchedQuestSet(ReadWatchedQuestIDs())
    for questID in pairs(hidden) do
        if watched[questID] then
            hidden[questID] = nil
        end
    end
end

local function ForgetHiddenQuest(questID)
    local hidden = CharacterWatches()
    if hidden and questID then hidden[questID] = nil end
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
    if SM.RefreshStoryQuestMarks then SM.RefreshStoryQuestMarks() end
end

-- Only story quests is on (other addons may read it through _G.StoryMode).
function SM.IsQuestTrackerStoryFilterEnabled()
    return StoryModeDB ~= nil and StoryModeDB.hideUnrelatedQuestTrackerQuests == true
end

function SM.SetQuestTrackerStoryFilterEnabled(enabled)
    if not StoryModeDB then return end
    StoryModeDB.hideUnrelatedQuestTrackerQuests = enabled == true
    -- The focused quest's minimap border is always the game's blue (nothing
    -- can set it): turning the filter on drops the focus.
    local focusedQuestID = enabled and C_SuperTrack and C_SuperTrack.GetSuperTrackedQuestID()
    if focusedQuestID and focusedQuestID ~= 0 then C_SuperTrack.SetSuperTrackedQuestID(0) end
    SM.UpdateQuestTrackerStoryFilter()
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
eventFrame:RegisterEvent("QUEST_LOG_UPDATE")
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
eventFrame:RegisterEvent("QUEST_REMOVED")
eventFrame:SetScript("OnEvent", function(_, event, questID)
    if event == "QUEST_REMOVED" then
        ForgetHiddenQuest(questID)
        return
    end
    SM.UpdateQuestTrackerStoryFilter()
end)
