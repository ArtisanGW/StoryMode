local _, SM = ...

-- Story quests' areas on the world map, and on any map built with the
-- game's QuestBlobPinTemplate, in the story's colour. Each map draws its
-- quest areas with one pin (a QuestPOIFrame), which has one fill and one
-- border texture for all the quests it draws: the focused quest, the one
-- picked in the map's quest list, the one under the cursor. So the pin takes
-- a story's colour when every quest it drew has that colour, and keeps the
-- game's blue otherwise. Post-hooks on each pin: DrawNone and DrawBlob tell
-- which quests it drew, Refresh ends a draw. Nothing changes before the art
-- is loaded (see StoryAreaArt).

local Marks = SM.StoryQuestMarks
local AreaArt = SM.StoryAreaArt

-- QuestBlobPinMixin:OnLoad sets these.
local GAME_INSIDE_TEXTURE = "Interface\\WorldMap\\UI-QuestBlob-Inside"
local GAME_OUTSIDE_TEXTURE = "Interface\\WorldMap\\UI-QuestBlob-Outside"

-- [pin] = the quests it drew last.
local drawnQuests = {}
-- [pin] = the story files on it; nil: the game's own.
local appliedFiles = {}

local function Recolor(pin)
    if pin:IsForbidden() then return end
    local files = AreaArt.ForColor(Marks.SharedColor(drawnQuests[pin]))
    if files == appliedFiles[pin] then return end
    appliedFiles[pin] = files
    pin:SetFillTexture(files and files.mapInside or GAME_INSIDE_TEXTURE)
    pin:SetBorderTexture(files and files.mapOutside or GAME_OUTSIDE_TEXTURE)
end

local function RecolorAll()
    for pin in pairs(drawnQuests) do Recolor(pin) end
end

local function HookPin(pin)
    if drawnQuests[pin] or pin:IsForbidden() then return end
    drawnQuests[pin] = {}
    hooksecurefunc(pin, "DrawNone", function(self) wipe(drawnQuests[self]) end)
    hooksecurefunc(pin, "DrawBlob", function(self, questID, draw)
        if draw then table.insert(drawnQuests[self], questID) end
    end)
    hooksecurefunc(pin, "Refresh", Recolor)
end

-- Pins made from now on run the hooked OnLoad; pins made before are found
-- among all frames by a function only the quest area pin has.
local function HookPins()
    hooksecurefunc(QuestBlobPinMixin, "OnLoad", HookPin)
    local frame = EnumerateFrames()
    while frame do
        if not frame:IsForbidden() and frame.TryDrawQuest == QuestBlobPinMixin.TryDrawQuest then
            HookPin(frame)
        end
        frame = EnumerateFrames(frame)
    end
end

Marks.OnChange(RecolorAll)
AreaArt.OnLoaded(RecolorAll)

if QuestBlobPinMixin then
    HookPins()
else
    local eventFrame = CreateFrame("Frame")
    eventFrame:RegisterEvent("ADDON_LOADED")
    eventFrame:SetScript("OnEvent", function(self, _, loadedAddonName)
        if loadedAddonName ~= "Blizzard_SharedMapDataProviders" then return end
        self:UnregisterEvent("ADDON_LOADED")
        HookPins()
    end)
end
