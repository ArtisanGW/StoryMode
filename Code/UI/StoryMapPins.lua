local _, SM = ...

-- Story quests on the world map: the game's own pins, in green.
-- • quest givers: their "!" turns green
-- • story quests ready to turn in: their "?" turns green
-- • story quests in progress: a small green "!" on their pin
-- Nothing of the game's is replaced: after the map's quest providers draw
-- their pins (a post-hook on RefreshAllData), the pins are tinted. Pins are
-- pooled, so each pass also puts back the colour of pins that no longer
-- show a story quest. The game never colours these textures itself, so
-- white is their own colour to go back to.

-- Times the yellow "!" and "?" (about 1, 0.82, 0) into a clear green.
local STORY_GREEN = { 0.25, 1, 0.25 }
local BADGE_ATLAS = "QuestNormal"
local BADGE_SIZE = 14

local tintedTextures = setmetatable({}, { __mode = "k" })
local progressBadges = setmetatable({}, { __mode = "k" })
local hookedProviders = {}

local function IsEnabled()
    return StoryModeDB ~= nil and StoryModeDB.greenStoryQuestsOnMap == true
end

local function IsStoryQuest(questID)
    return questID ~= nil and SM.FindQuestStory(questID) ~= nil
end

local function TintGreen(texture)
    texture:SetVertexColor(STORY_GREEN[1], STORY_GREEN[2], STORY_GREEN[3])
    tintedTextures[texture] = true
end

local function RestoreColor(texture)
    if not tintedTextures[texture] then return end
    texture:SetVertexColor(1, 1, 1)
    tintedTextures[texture] = nil
end

local function ProgressBadge(pin)
    local badge = progressBadges[pin]
    if not badge then
        badge = pin:CreateTexture(nil, "OVERLAY", nil, 7)
        badge:SetAtlas(BADGE_ATLAS)
        badge:SetSize(BADGE_SIZE, BADGE_SIZE)
        badge:SetPoint("CENTER", pin, "TOPRIGHT", -3, -3)
        badge:SetVertexColor(STORY_GREEN[1], STORY_GREEN[2], STORY_GREEN[3])
        progressBadges[pin] = badge
    end
    return badge
end

local function UpdateQuestOfferPin(pin)
    if not pin.Texture then return end
    if IsEnabled() and IsStoryQuest(pin.questID) then
        TintGreen(pin.Texture)
    else
        RestoreColor(pin.Texture)
    end
end

local function UpdateQuestPin(pin)
    local icon = pin.Display and pin.Display.Icon
    local questID = pin.GetQuestID and pin:GetQuestID()
    local isStoryQuest = IsEnabled() and IsStoryQuest(questID)
    local isReadyToTurnIn = isStoryQuest and C_QuestLog.IsComplete(questID)

    if icon then
        if isReadyToTurnIn then TintGreen(icon) else RestoreColor(icon) end
    end

    local showBadge = isStoryQuest and not isReadyToTurnIn
    if showBadge then
        ProgressBadge(pin):Show()
    elseif progressBadges[pin] then
        progressBadges[pin]:Hide()
    end
end

local PIN_UPDATERS = {
    QuestOfferPinTemplate = UpdateQuestOfferPin,
    QuestPinTemplate = UpdateQuestPin,
}

local function UpdatePins(map, pinTemplate)
    local updatePin = PIN_UPDATERS[pinTemplate]
    for pin in map:EnumeratePinsByTemplate(pinTemplate) do
        if not pin:IsForbidden() then updatePin(pin) end
    end
end

function SM.RefreshStoryMapPins()
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

function SM.SetGreenStoryQuestsOnMap(enabled)
    if not StoryModeDB then return end
    StoryModeDB.greenStoryQuestsOnMap = enabled == true
    SM.RefreshStoryMapPins()
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", function(_, event, loadedAddonName)
    if event == "PLAYER_LOGIN" or loadedAddonName == "Blizzard_WorldMap" then
        HookWorldMapProviders()
    end
end)
