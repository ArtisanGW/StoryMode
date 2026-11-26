local _, SM = ...

-- Story quests' areas on the minimap, in the story's colour. The minimap
-- draws an area for each quest on the objective tracker, all with the same
-- border texture and edge ring (Minimap:SetQuestBlobOutsideTexture,
-- SetQuestBlobRingTexture): no colour, nothing per quest. So the borders take
-- a story's colour only when every tracked quest on the player's map has that
-- colour (the tracker's selected-story filter does that), and stay the game's
-- blue otherwise. The super-tracked quest is left out: its border uses a
-- "selected" texture this client has no setter for, so it stays blue. The
-- game has no getters either: its own textures go back by file ID.

local Marks = SM.StoryQuestMarks
local OnMap = SM.StoryQuestsOnMap

local GAME_OUTSIDE_TEXTURE = 533895   -- Interface\Minimap\UI-QuestBlobMinimap-Outside
local GAME_RING_TEXTURE = 533893      -- Interface\Minimap\UI-QuestBlob-MinimapRing
local ART = "Interface\\AddOns\\StoryMode\\Art\\Minimap\\"
-- The game's textures, recoloured: each pixel takes the story's colour at
-- the brightness of its strongest channel, alpha kept.
local STORY_TEXTURES = {
    [Marks.FOLLOWED_STORY_COLOR] = { outside = ART .. "QuestAreaOutsideFollowed", ring = ART .. "QuestAreaRingFollowed" },
    [Marks.OTHER_STORY_COLOR] = { outside = ART .. "QuestAreaOutsideOther", ring = ART .. "QuestAreaRingOther" },
}

-- nil: the game's own textures are on.
local appliedColor

-- The tracked quests whose areas take the border texture: on the player's
-- map, and not super-tracked.
local function TrackedQuestsWithBorder()
    local onMap = {}
    for _, questOnMap in ipairs(OnMap.mapID and C_QuestLog.GetQuestsOnMap(OnMap.mapID) or {}) do
        onMap[questOnMap.questID] = true
    end
    local superTrackedQuestID = C_SuperTrack.GetSuperTrackedQuestID()
    local questIDs = {}
    for index = 1, C_QuestLog.GetNumQuestWatches() do
        local questID = C_QuestLog.GetQuestIDForQuestWatchIndex(index)
        if onMap[questID] and questID ~= superTrackedQuestID then questIDs[#questIDs + 1] = questID end
    end
    return questIDs
end

-- The colour all those quests share, or nil.
local function SharedColor()
    local sharedColor
    for _, questID in ipairs(TrackedQuestsWithBorder()) do
        local color = Marks.ColorForQuest(questID)
        if not color or (sharedColor and color ~= sharedColor) then return nil end
        sharedColor = color
    end
    return sharedColor
end

local function Refresh()
    if Minimap:IsForbidden() then return end
    local color = SharedColor()
    if color == appliedColor then return end
    appliedColor = color
    local textures = STORY_TEXTURES[color]
    Minimap:SetQuestBlobOutsideTexture(textures and textures.outside or GAME_OUTSIDE_TEXTURE)
    Minimap:SetQuestBlobRingTexture(textures and textures.ring or GAME_RING_TEXTURE)
end

OnMap.OnChange(Refresh)
Marks.OnChange(Refresh)

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("SUPER_TRACKING_CHANGED")
eventFrame:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
eventFrame:SetScript("OnEvent", Refresh)
