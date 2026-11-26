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
-- Once an area texture is set while the game loads, the minimap draws every
-- custom one as "not found" (solid green) until the game restarts, /reload
-- included (measured: set at login it failed, and so did art set later; set
-- 6 s after PLAYER_ENTERING_WORLD it drew right). So the textures change only
-- after the player has been in the world for SETTLE_SECONDS, and not across
-- a loading screen.

local Marks = SM.StoryQuestMarks
local OnMap = SM.StoryQuestsOnMap

local GAME_OUTSIDE_TEXTURE = 533895   -- Interface\Minimap\UI-QuestBlobMinimap-Outside
local GAME_RING_TEXTURE = 533893      -- Interface\Minimap\UI-QuestBlob-MinimapRing
local ART = "Interface\\AddOns\\StoryMode\\Art\\Minimap\\"
-- The game's textures, recoloured: each pixel takes the story's colour at
-- the brightness of its strongest channel, alpha kept. Named with .tga: the
-- minimap drew an uncompressed .blp as "not found" (solid green), and
-- without an extension it looks for a .blp first.
local STORY_TEXTURES = {
    [Marks.FOLLOWED_STORY_COLOR] = { outside = ART .. "QuestAreaOutsideFollowed.tga", ring = ART .. "QuestAreaRingFollowed.tga" },
    [Marks.OTHER_STORY_COLOR] = { outside = ART .. "QuestAreaOutsideOther.tga", ring = ART .. "QuestAreaRingOther.tga" },
}

local SETTLE_SECONDS = 6

-- nil: the game's own textures are on.
local appliedColor
local settled = false
-- Counts loading screens, so a timer from before one doesn't settle.
local loadingScreens = 0

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
    if not settled or Minimap:IsForbidden() then return end
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
eventFrame:RegisterEvent("PLAYER_LEAVING_WORLD")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:SetScript("OnEvent", function(_, event)
    if event == "PLAYER_LEAVING_WORLD" then
        settled = false
        loadingScreens = loadingScreens + 1
    elseif event == "PLAYER_ENTERING_WORLD" then
        local loadingScreen = loadingScreens
        C_Timer.After(SETTLE_SECONDS, function()
            if loadingScreen ~= loadingScreens then return end
            settled = true
            Refresh()
        end)
    else
        Refresh()
    end
end)
