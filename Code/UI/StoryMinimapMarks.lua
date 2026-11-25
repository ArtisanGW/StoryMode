local _, SM = ...

-- Story quests on the minimap, in the story's colour: a "!" for a giver, a
-- "?" for a quest ready to turn in, a small "!" for one in progress. The
-- game draws its own minimap icons and gives addons no way to recolour
-- them, so these are our own markers on top. One too far away for the
-- minimap waits on its edge, in its direction. Positions come from
-- StoryQuestsOnMap; the minimap's scale and turn come from the game
-- (C_Minimap.GetViewRadius, the rotateMinimap setting, GetPlayerFacing).
-- Hidden where the game gives no player position (instances).

local Marks = SM.StoryQuestMarks
local OnMap = SM.StoryQuestsOnMap

local MARKER_SIZE = 16
local PROGRESS_MARKER_SIZE = 11
local EDGE_INSET = 6
local UPDATE_SECONDS = 0.05

local markers = {}
local markerPool = CreateFramePool("Frame", Minimap, nil, function(_, marker)
    marker:Hide()
    marker:ClearAllPoints()
end)

local function AddMarker(quest, atlas, size, color)
    local marker, isNew = markerPool:Acquire()
    if isNew then
        marker:SetFrameLevel(Minimap:GetFrameLevel() + 5)
        marker.icon = Marks.NewIcon(marker, atlas, color)
        marker.icon:SetAllPoints()
    end
    marker.icon:SetAtlas(atlas)
    Marks.Paint(marker.icon, color)
    marker:SetSize(size, size)
    marker.x, marker.y = quest.x, quest.y
    markers[#markers + 1] = marker
end

local function RebuildMarkers()
    markerPool:ReleaseAll()
    wipe(markers)
    for _, offer in ipairs(OnMap.offered) do
        local color = Marks.ColorForQuest(offer.questID)
        if color then AddMarker(offer, Marks.GIVER_ATLAS, MARKER_SIZE, color) end
    end
    for _, quest in ipairs(OnMap.inLog) do
        local color = Marks.ColorForQuest(quest.questID)
        if color and C_QuestLog.IsComplete(quest.questID) then
            AddMarker(quest, Marks.TURN_IN_ATLAS, MARKER_SIZE, color)
        elseif color then
            AddMarker(quest, Marks.GIVER_ATLAS, PROGRESS_MARKER_SIZE, color)
        end
    end
end

-- Map positions to minimap pixels from the player: x grows east, y south;
-- the minimap's up is north, or the player's facing when it turns.
local function MinimapOffset(marker, player, yardsWide, yardsHigh, pixelsPerYard, facing)
    local east = (marker.x - player.x) * yardsWide * pixelsPerYard
    local north = (player.y - marker.y) * yardsHigh * pixelsPerYard
    local cosine, sine = math.cos(facing), math.sin(facing)
    return east * cosine + north * sine, north * cosine - east * sine
end

local function PlaceMarkers()
    local player = OnMap.mapID and C_Map.GetPlayerMapPosition(OnMap.mapID, "player")
    local yardsWide, yardsHigh = 0, 0
    if player then yardsWide, yardsHigh = C_Map.GetMapWorldSize(OnMap.mapID) end
    if not player or yardsWide == 0 then
        for _, marker in ipairs(markers) do marker:Hide() end
        return
    end

    local radius = Minimap:GetWidth() / 2
    local pixelsPerYard = radius / C_Minimap.GetViewRadius()
    local facing = GetCVarBool("rotateMinimap") and GetPlayerFacing() or 0
    local edge = radius - EDGE_INSET
    for _, marker in ipairs(markers) do
        local offsetX, offsetY = MinimapOffset(marker, player, yardsWide, yardsHigh, pixelsPerYard, facing)
        local distance = math.sqrt(offsetX * offsetX + offsetY * offsetY)
        if distance > edge then
            offsetX, offsetY = offsetX * edge / distance, offsetY * edge / distance
        end
        marker:ClearAllPoints()
        marker:SetPoint("CENTER", Minimap, "CENTER", offsetX, offsetY)
        marker:Show()
    end
end

local function Refresh()
    RebuildMarkers()
    PlaceMarkers()
end

OnMap.OnChange(Refresh)
Marks.OnChange(Refresh)

local updateFrame = CreateFrame("Frame")
local elapsedSinceUpdate = 0
updateFrame:SetScript("OnUpdate", function(_, elapsed)
    if #markers == 0 then return end
    elapsedSinceUpdate = elapsedSinceUpdate + elapsed
    if elapsedSinceUpdate < UPDATE_SECONDS then return end
    elapsedSinceUpdate = 0
    PlaceMarkers()
end)
