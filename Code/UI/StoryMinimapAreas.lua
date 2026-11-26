local _, SM = ...

-- Story quests' areas on the minimap, in the story's colour. The minimap
-- draws an area for each quest on the objective tracker, all with the same
-- border and edge ring textures (Minimap:SetQuestBlobOutsideTexture,
-- SetQuestBlobRingTexture): no colour, nothing per quest. So the areas take
-- a story's colour only when every tracked quest on the player's map has
-- that colour (the tracker's selected-story filter does that), and stay the
-- game's blue otherwise. The focused quest's (C_SuperTrack) border uses a
-- "selected" texture this client has no setter for: it stays blue, so
-- turning that filter on drops the focus. The game has no getters either:
-- its own textures go back by file ID. Nothing changes before the art is
-- loaded (see StoryAreaArt).

local Marks = SM.StoryQuestMarks
local OnMap = SM.StoryQuestsOnMap
local AreaArt = SM.StoryAreaArt

local GAME_OUTSIDE_TEXTURE = 533895   -- Interface\Minimap\UI-QuestBlobMinimap-Outside
local GAME_RING_TEXTURE = 533893      -- Interface\Minimap\UI-QuestBlob-MinimapRing

-- nil: the game's own textures are on.
local appliedFiles

-- The tracked quests on the player's map: those the minimap draws areas for.
local function TrackedQuestsOnMap()
    local onMap = {}
    for _, questOnMap in ipairs(OnMap.mapID and C_QuestLog.GetQuestsOnMap(OnMap.mapID) or {}) do
        onMap[questOnMap.questID] = true
    end
    local questIDs = {}
    for index = 1, C_QuestLog.GetNumQuestWatches() do
        local questID = C_QuestLog.GetQuestIDForQuestWatchIndex(index)
        if onMap[questID] then questIDs[#questIDs + 1] = questID end
    end
    return questIDs
end

local function Refresh()
    if Minimap:IsForbidden() then return end
    local files = AreaArt.ForColor(Marks.SharedColor(TrackedQuestsOnMap()))
    if files == appliedFiles then return end
    appliedFiles = files
    Minimap:SetQuestBlobOutsideTexture(files and files.minimapOutside or GAME_OUTSIDE_TEXTURE)
    Minimap:SetQuestBlobRingTexture(files and files.minimapRing or GAME_RING_TEXTURE)
end

OnMap.OnChange(Refresh)
Marks.OnChange(Refresh)
AreaArt.OnLoaded(Refresh)

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
eventFrame:SetScript("OnEvent", Refresh)
