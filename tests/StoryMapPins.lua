-- Story quests on the world map: givers, turn-ins and quests in progress in green.
local events = {}
local eventHandler

local function NewTexture()
    local texture = { color = { 1, 1, 1 }, shown = true }
    function texture:SetVertexColor(red, green, blue) self.color = { red, green, blue } end
    function texture:SetAtlas(atlas) self.atlas = atlas end
    function texture:SetSize() end
    function texture:SetPoint() end
    function texture:Show() self.shown = true end
    function texture:Hide() self.shown = false end
    return texture
end

local function NewPin(fields)
    local pin = fields
    function pin:IsForbidden() return false end
    pin.createdTextures = {}
    function pin:CreateTexture()
        local texture = NewTexture()
        self.createdTextures[#self.createdTextures + 1] = texture
        return texture
    end
    return pin
end

local storyQuestIDs = { [101] = true, [102] = true }
local completeQuestIDs = { [102] = true }

local giverStory = NewPin({ questID = 101, Texture = NewTexture() })
local giverOther = NewPin({ questID = 900, Texture = NewTexture() })
local inProgress = NewPin({ Display = { Icon = NewTexture() } })
function inProgress:GetQuestID() return 101 end
local turnIn = NewPin({ Display = { Icon = NewTexture() } })
function turnIn:GetQuestID() return 102 end

local pinsByTemplate = {
    QuestOfferPinTemplate = { giverStory, giverOther },
    QuestPinTemplate = { inProgress, turnIn },
}

local map = {}
function map:EnumeratePinsByTemplate(template)
    local pins, index = pinsByTemplate[template] or {}, 0
    return function()
        index = index + 1
        return pins[index]
    end
end

QuestOfferDataProviderMixin = { RefreshAllData = function() end }
QuestDataProviderMixin = { RefreshAllData = function() end }
local offerProvider = { RefreshAllData = QuestOfferDataProviderMixin.RefreshAllData }
local questProvider = { RefreshAllData = QuestDataProviderMixin.RefreshAllData }
function offerProvider:GetMap() return map end
function questProvider:GetMap() return map end
map.dataProviders = { [offerProvider] = true, [questProvider] = true, [{}] = true }
WorldMapFrame = map

function hooksecurefunc(target, key, hook)
    local original = target[key]
    target[key] = function(...)
        original(...)
        hook(...)
    end
end

C_QuestLog = { IsComplete = function(questID) return completeQuestIDs[questID] == true end }
StoryModeDB = { greenStoryQuestsOnMap = true }

local eventFrame = {}
function eventFrame:RegisterEvent(event) events[event] = true end
function eventFrame:SetScript(_, handler) eventHandler = handler end
CreateFrame = function() return eventFrame end

local SM = {
    FindQuestStory = function(questID) return storyQuestIDs[questID] and { id = "story" } or nil end,
}
assert(loadfile("Code/UI/StoryMapPins.lua"))("StoryMode", SM)

local function IsGreen(texture) return texture.color[1] < 1 and texture.color[2] == 1 end
local function IsWhite(texture) return texture.color[1] == 1 and texture.color[2] == 1 and texture.color[3] == 1 end

assert(events.PLAYER_LOGIN)
eventHandler(nil, "PLAYER_LOGIN")
eventHandler(nil, "ADDON_LOADED", "Blizzard_WorldMap") -- hooks only once

offerProvider:RefreshAllData()
questProvider:RefreshAllData()

assert(IsGreen(giverStory.Texture), "story giver ! is green")
assert(IsWhite(giverOther.Texture), "other giver keeps its colour")
assert(IsGreen(turnIn.Display.Icon), "story turn-in ? is green")
assert(IsWhite(inProgress.Display.Icon), "in-progress icon keeps its colour")

-- The in-progress pin gets one badge, made once and reused.
offerProvider:RefreshAllData()
questProvider:RefreshAllData()
assert(IsGreen(giverStory.Texture), "a second refresh keeps the green")
assert(#inProgress.createdTextures == 1, "one badge per pin")
local badge = inProgress.createdTextures[1]
assert(badge.shown and IsGreen(badge) and badge.atlas == "QuestNormal", "in-progress badge is a green !")
assert(#turnIn.createdTextures == 0, "turn-in pins get no badge")

-- A pooled pin reused for another quest goes back to its own colour.
giverStory.questID = 900
offerProvider:RefreshAllData()
assert(IsWhite(giverStory.Texture), "reused pin is white again")

-- Turned off: everything back, badge hidden.
giverStory.questID = 101
SM.SetGreenStoryQuestsOnMap(false)
assert(StoryModeDB.greenStoryQuestsOnMap == false)
assert(IsWhite(giverStory.Texture))
assert(IsWhite(turnIn.Display.Icon))
assert(not badge.shown, "badge hidden when turned off")

SM.SetGreenStoryQuestsOnMap(true)
assert(IsGreen(giverStory.Texture), "turned on again: green right away")

print("StoryMapPins tests passed")
