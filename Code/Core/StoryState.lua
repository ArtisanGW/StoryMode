local _, SM = ...

local storyStateCache = setmetatable({}, { __mode = "k" })

function SM.ResolveAchievementID(data)
    if not data then return end
    local faction = UnitFactionGroup("player")
    if data.achievementIDByFaction then
        data.achievementID = data.achievementIDByFaction[faction] or data.achievementID
    end
    if data.achievementsByFaction then
        data.achievements = data.achievementsByFaction[faction] or data.achievements
    end

    if data.achievementID then
        local _, name = GetAchievementInfo(data.achievementID)
        if name then return end
    end
    if data.achievementName then
        for id = 1, 50000 do
            local _, name = GetAchievementInfo(id)
            if name == data.achievementName then
                data.achievementID = id
                return
            end
        end
    end
end

-- WoW Forever's Legacy challenges are achievements, and a challenge can have
-- several IDs (Lord Valthalak Laid to Rest is 62054 and 64014). The one
-- the game lists in the challenge's category is the one the Legacy window
-- shows. Returns it, or nil off Forever or before the list is ready.
local legacyChallengeIDs = {}

function SM.GetLegacyChallengeID(ids)
    if not ids or not (SM.Client and SM.Client.isForever) then return nil end
    if not (GetAchievementCategory and GetCategoryNumAchievements and GetAchievementInfo) then return nil end
    if legacyChallengeIDs[ids] then return legacyChallengeIDs[ids] end
    for _, id in ipairs(type(ids) == "table" and ids or { ids }) do
        local category = GetAchievementCategory(id)
        local count = category and GetCategoryNumAchievements(category) or 0
        for index = 1, count do
            if GetAchievementInfo(category, index) == id then
                legacyChallengeIDs[ids] = id
                return id
            end
        end
    end
    return nil
end

-- Opens the Legacy window at a challenge (Blizzard_LegacySystem's own
-- ShowLegacyChallenge, loading it first if its bootstrap isn't there).
function SM.OpenLegacyChallenge(id)
    if not id then return end
    if ShowLegacyChallenge then
        ShowLegacyChallenge(id)
        return
    end
    if not LegacySystemFrame then SM.LoadAddOn("Blizzard_LegacySystem") end
    if LegacySystemFrame and LegacySystemFrame.OpenToChallenge then
        LegacySystemFrame:OpenToChallenge(id)
    end
end

function SM.InvalidateStoryStateCache()
    storyStateCache = setmetatable({}, { __mode = "k" })
end

function SM.IsStoryFinished(data)
    if not data then return false end

    local previousStoryData = SM.GetCurrentStoryData and SM.GetCurrentStoryData() or nil
    if SM.SetCurrentStoryData then SM.SetCurrentStoryData(data) end
    local isFinished = SM.FindNextQuest(data) == nil
    if SM.SetCurrentStoryData then SM.SetCurrentStoryData(previousStoryData) end

    return isFinished
end

function SM.GetStoryState(data)
    if not data then return nil end

    local cached = storyStateCache[data]
    if cached then return cached end

    local gateReason = SM.GetQuestlineGateReason(data)
    local nextQuest, nextChapter = SM.FindNextQuest(data)
    local state = {
        data = data,
        gateReason = gateReason,
        isAvailable = not gateReason,
        isFinished = not gateReason and nextQuest == nil,
        nextQuest = nextQuest,
        nextChapter = nextChapter,
        levelText = SM.GetRecommendedLevelText and SM.GetRecommendedLevelText(data) or nil,
        levelMinimum = SM.GetRecommendedLevelMinimum and SM.GetRecommendedLevelMinimum(data) or nil,
        zoneText = SM.GetQuestlineZoneText and SM.GetQuestlineZoneText(data) or data.zone or "",
    }

    storyStateCache[data] = state
    return state
end
