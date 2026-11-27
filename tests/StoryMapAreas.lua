-- Story quests' areas on the maps: each map's quest area pin takes the
-- story's colour when every quest it drew shares it.
local Fakes = dofile("tests/StoryMarksFakes.lua")
local _, frames = Fakes.EventFrames()
Fakes.InstallGlobals()

function hooksecurefunc(target, key, hook)
    local original = target[key]
    target[key] = function(...)
        original(...)
        hook(...)
    end
end

local GAME_INSIDE = "Interface\\WorldMap\\UI-QuestBlob-Inside"
local GAME_OUTSIDE = "Interface\\WorldMap\\UI-QuestBlob-Outside"
-- The game's mixin: Refresh draws none, then each quest it shows.
QuestBlobPinMixin = {
    OnLoad = function() end,
    TryDrawQuest = function() end,
    Refresh = function(self)
        self:DrawNone()
        for _, questID in ipairs(self.questsToDraw) do self:DrawBlob(questID, true) end
    end,
}
-- A QuestBlobPinTemplate frame: the mixin copied in, as the template does.
local function NewPin()
    local pin = { fill = GAME_INSIDE, border = GAME_OUTSIDE, textureCalls = 0, questsToDraw = {} }
    for key, value in pairs(QuestBlobPinMixin) do pin[key] = value end
    function pin:DrawNone() end
    function pin:DrawBlob() end
    function pin:SetFillTexture(texture) self.fill = texture; self.textureCalls = self.textureCalls + 1 end
    function pin:SetBorderTexture(texture) self.border = texture end
    function pin:IsForbidden() return false end
    return pin
end

-- Made before Story Mode loads: the world map's pin, a scenario's area
-- frame, a forbidden pin.
local existingPin = NewPin()
local scenarioAreas = { IsForbidden = function() return false end }
local forbiddenPin = NewPin()
function forbiddenPin:IsForbidden() return true end
local allFrames = { scenarioAreas, existingPin, forbiddenPin }
function EnumerateFrames(frame)
    if not frame then return allFrames[1] end
    for index, eachFrame in ipairs(allFrames) do
        if eachFrame == frame then return allFrames[index + 1] end
    end
end

StoryModeDB = { markStoryQuests = true }
-- 201, 202: the followed story; 301: another story; 900: no story.
local SM = Fakes.NewStoryMode({ [201] = "hillsbrad", [202] = "hillsbrad", [301] = "other" }, "hillsbrad")
assert(loadfile("Code/UI/StoryQuestMarks.lua"))("StoryMode", SM)
assert(loadfile("Code/UI/StoryAreaArt.lua"))("StoryMode", SM)
assert(loadfile("Code/UI/StoryMapAreas.lua"))("StoryMode", SM)

local ART = "Interface\\AddOns\\StoryMode\\Art\\WorldMap\\"
local function Draw(pin, questIDs)
    pin.questsToDraw = questIDs
    pin:Refresh()
end
local function IsGame(pin) return pin.fill == GAME_INSIDE and pin.border == GAME_OUTSIDE end
local function IsStory(pin, story)
    return pin.fill == ART .. "QuestAreaInside" .. story .. ".tga" and pin.border == ART .. "QuestAreaOutside" .. story .. ".tga"
end

Draw(existingPin, { 201 })
assert(IsGame(existingPin) and existingPin.textureCalls == 0, "art not loaded: left alone")
Fakes.DrawFrame(frames, true)
assert(IsStory(existingPin, "Followed"), "art loaded, a pin made before Story Mode drew a followed story quest: green")

Draw(existingPin, { 301 })
assert(IsStory(existingPin, "Other"), "another story's quest: lime green")
Draw(existingPin, { 201, 301 })
assert(IsGame(existingPin), "two colours: the game's own")
Draw(existingPin, { 201, 900 })
assert(IsGame(existingPin), "a quest of no story: the game's own")
Draw(existingPin, {})
assert(IsGame(existingPin), "nothing drawn: the game's own")
Draw(existingPin, { 201, 202 })
assert(IsStory(existingPin, "Followed"), "two quests of the followed story: green")

local callsBefore = existingPin.textureCalls
Draw(existingPin, { 202 })
assert(existingPin.textureCalls == callsBefore, "same colour: the textures are left alone")

SM.SetStoryQuestMarks(false)
assert(IsGame(existingPin), "turned off: the game's own")
SM.SetStoryQuestMarks(true)
assert(IsStory(existingPin, "Followed"), "turned on: back right away")

local newPin = NewPin()
newPin:OnLoad()
Draw(newPin, { 301 })
assert(IsStory(newPin, "Other"), "a pin made after Story Mode loaded is coloured too")

Draw(forbiddenPin, { 201 })
assert(IsGame(forbiddenPin) and forbiddenPin.textureCalls == 0, "a forbidden pin is left alone")
assert(scenarioAreas.DrawNone == nil, "other area frames aren't hooked")

print("StoryMapAreas tests passed")
