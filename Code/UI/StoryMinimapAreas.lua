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
-- its own textures go back by file ID.
--
-- The minimap draws an addon's file only once the UI has loaded it. Given
-- it before, the minimap draws "not found" (solid green) for that file until
-- the game restarts, /reload included, and a texture on a hidden frame
-- doesn't load it (measured with devAddons/DevBlobProbe). So textures the
-- player can't see keep each file loaded, and the minimap gets the files
-- once IsObjectLoaded says they're in.

local Marks = SM.StoryQuestMarks
local OnMap = SM.StoryQuestsOnMap

local GAME_OUTSIDE_TEXTURE = 533895   -- Interface\Minimap\UI-QuestBlobMinimap-Outside
local GAME_RING_TEXTURE = 533893      -- Interface\Minimap\UI-QuestBlob-MinimapRing
local ART = "Interface\\AddOns\\StoryMode\\Art\\Minimap\\"
-- The game's textures, recoloured: each pixel takes the story's colour at
-- the brightness of its strongest channel, alpha kept. Named with .tga:
-- without an extension the game looks for a .blp first.
local STORY_TEXTURES = {
    [Marks.FOLLOWED_STORY_COLOR] = { outside = ART .. "QuestAreaOutsideFollowed.tga", ring = ART .. "QuestAreaRingFollowed.tga" },
    [Marks.OTHER_STORY_COLOR] = { outside = ART .. "QuestAreaOutsideOther.tga", ring = ART .. "QuestAreaRingOther.tga" },
}

-- nil: the game's own textures are on.
local appliedColor
local artLoaded = false

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

-- The colour all those quests share, or nil.
local function SharedColor()
    local sharedColor
    for _, questID in ipairs(TrackedQuestsOnMap()) do
        local color = Marks.ColorForQuest(questID)
        if not color or (sharedColor and color ~= sharedColor) then return nil end
        sharedColor = color
    end
    return sharedColor
end

local function Refresh()
    if not artLoaded or Minimap:IsForbidden() then return end
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
eventFrame:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
eventFrame:SetScript("OnEvent", Refresh)

-- One texture per file, at alpha 0. The frame has no parent, so hiding the
-- UI doesn't hide it: the files stay loaded.
local artFrame = CreateFrame("Frame")
artFrame:SetSize(64, 64)
artFrame:SetPoint("BOTTOMLEFT")
local artTextures = {}
for _, textures in pairs(STORY_TEXTURES) do
    for _, file in pairs(textures) do
        local texture = artFrame:CreateTexture()
        texture:SetAllPoints()
        texture:SetAlpha(0)
        texture:SetTexture(file)
        artTextures[#artTextures + 1] = texture
    end
end
artFrame:SetScript("OnUpdate", function(self)
    for _, texture in ipairs(artTextures) do
        if not texture:IsObjectLoaded() then return end
    end
    self:SetScript("OnUpdate", nil)
    artLoaded = true
    Refresh()
end)
