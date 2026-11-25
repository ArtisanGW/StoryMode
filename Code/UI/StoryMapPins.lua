local _, SM = ...

-- Story quests on the world map: the game's own pins, in the story's colour
-- (see StoryQuestMarks).
-- - quest givers: their "!" is painted
-- - story quests ready to turn in: their "?" is painted
-- - story quests in progress: a small painted "!" on their pin
-- Nothing of the game's is replaced: after the map's quest providers draw
-- their pins (a post-hook on RefreshAllData), the pins are tinted. Pins are
-- pooled, so each pass also puts back the colour of pins that no longer
-- show a story quest.

local Marks = SM.StoryQuestMarks
local hookedProviders = {}

-- An offer pin greys its "!" when the giver is on another floor: after a
-- restore, the pin's own SetHeightIndicator puts that back.
local function UpdateQuestOfferPin(pin)
    if pin:IsForbidden() or not pin.Texture then return end
    local color = Marks.ColorForQuest(pin.questID)
    if color then
        Marks.Paint(pin.Texture, color)
    elseif Marks.Restore(pin.Texture) and pin.SetHeightIndicator then
        pin:SetHeightIndicator(pin.floorLocation)
    end
end

local PIN_UPDATERS = {
    QuestOfferPinTemplate = UpdateQuestOfferPin,
    QuestPinTemplate = Marks.UpdateQuestButton,
}

local function UpdatePins(map, pinTemplate)
    local updatePin = PIN_UPDATERS[pinTemplate]
    for pin in map:EnumeratePinsByTemplate(pinTemplate) do
        updatePin(pin)
    end
end

local function RefreshMapPins()
    if not WorldMapFrame then return end
    for pinTemplate in pairs(PIN_UPDATERS) do
        UpdatePins(WorldMapFrame, pinTemplate)
    end
end

-- The world map builds one instance of each provider mixin, so the hook goes
-- on that instance: a hook on the mixin itself would come too late.
local PROVIDER_TEMPLATES = {
    { mixinName = "QuestOfferDataProviderMixin", pinTemplate = "QuestOfferPinTemplate" },
    { mixinName = "QuestDataProviderMixin", pinTemplate = "QuestPinTemplate" },
}

local function FindProviderTemplate(provider)
    for _, entry in ipairs(PROVIDER_TEMPLATES) do
        local mixin = _G[entry.mixinName]
        if mixin and provider.RefreshAllData == mixin.RefreshAllData then
            return entry.pinTemplate
        end
    end
end

local function HookWorldMapProviders()
    if not (WorldMapFrame and WorldMapFrame.dataProviders) then return end
    for provider in pairs(WorldMapFrame.dataProviders) do
        local pinTemplate = not hookedProviders[provider] and FindProviderTemplate(provider)
        if pinTemplate then
            hookedProviders[provider] = true
            hooksecurefunc(provider, "RefreshAllData", function(self)
                UpdatePins(self:GetMap(), pinTemplate)
            end)
        end
    end
end

Marks.OnChange(RefreshMapPins)

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", function(_, event, loadedAddonName)
    if event == "PLAYER_LOGIN" or loadedAddonName == "Blizzard_WorldMap" then
        HookWorldMapProviders()
    end
end)
