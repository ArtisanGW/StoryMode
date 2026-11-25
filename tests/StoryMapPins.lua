-- Story quests on the world map: the game's pins in the story's colour.
local Fakes = dofile("tests/StoryMarksFakes.lua")
local Fire = Fakes.EventFrames()
Fakes.InstallGlobals()

local function NewPin(fields)
    local pin = Fakes.NewRegion()
    for key, value in pairs(fields) do pin[key] = value end
    return pin
end

-- 101 and 102: the followed story; 103: another story; 900: not a story quest.
local SM = Fakes.NewStoryMode({ [101] = "hillsbrad", [102] = "hillsbrad", [103] = "other" }, "hillsbrad")
local completeQuestIDs = { [102] = true }

local giverFollowed = NewPin({ questID = 101, Texture = Fakes.NewRegion() })
local giverOther = NewPin({ questID = 103, Texture = Fakes.NewRegion() })
local giverNone = NewPin({ questID = 900, Texture = Fakes.NewRegion() })
local heightIndicatorCalls = 0
function giverFollowed:SetHeightIndicator()
    heightIndicatorCalls = heightIndicatorCalls + 1
    self.Texture:SetDesaturated(false)
end
local inProgress = NewPin({ Display = { Icon = Fakes.NewRegion() } })
function inProgress:GetQuestID() return 101 end
local turnIn = NewPin({ Display = { Icon = Fakes.NewRegion() } })
function turnIn:GetQuestID() return 102 end

local pinsByTemplate = {
    QuestOfferPinTemplate = { giverFollowed, giverOther, giverNone },
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
StoryModeDB = { markStoryQuests = true }

assert(loadfile("Code/UI/StoryQuestMarks.lua"))("StoryMode", SM)
assert(loadfile("Code/UI/StoryMapPins.lua"))("StoryMode", SM)
local Marks = SM.StoryQuestMarks
local FOLLOWED, OTHER = Marks.FOLLOWED_STORY_COLOR, Marks.OTHER_STORY_COLOR

Fire("PLAYER_LOGIN")
Fire("ADDON_LOADED", "Blizzard_WorldMap") -- hooks only once

offerProvider:RefreshAllData()
questProvider:RefreshAllData()

assert(Fakes.IsColor(giverFollowed.Texture, FOLLOWED), "followed story giver ! is green")
assert(Fakes.IsColor(giverOther.Texture, OTHER), "other story giver ! is lime green")
assert(Fakes.IsPlain(giverNone.Texture), "other quests keep the game's look")
assert(Fakes.IsColor(turnIn.Display.Icon, FOLLOWED), "story turn-in ? is painted")
assert(Fakes.IsColor(inProgress.Display.Icon, FOLLOWED), "in-progress pin is painted too")
assert(#inProgress.children == 0, "nothing is added to the game's pin")

-- A pooled pin reused for another quest gets the game's look back, and its
-- own floor greying from the game's SetHeightIndicator.
giverFollowed.questID = 900
offerProvider:RefreshAllData()
assert(Fakes.IsPlain(giverFollowed.Texture), "reused pin is plain again")
assert(heightIndicatorCalls == 1, "the pin's own floor look is put back")

-- Following another story swaps the colours.
giverFollowed.questID = 101
SM.followedStoryID = "other"
SM.RefreshStoryQuestMarks()
assert(Fakes.IsColor(giverFollowed.Texture, OTHER))
assert(Fakes.IsColor(giverOther.Texture, FOLLOWED))

-- Turned off: everything back.
SM.SetStoryQuestMarks(false)
assert(StoryModeDB.markStoryQuests == false)
assert(Fakes.IsPlain(giverFollowed.Texture) and Fakes.IsPlain(giverOther.Texture))
assert(Fakes.IsPlain(turnIn.Display.Icon) and Fakes.IsPlain(inProgress.Display.Icon))

SM.SetStoryQuestMarks(true)
assert(Fakes.IsColor(giverOther.Texture, FOLLOWED), "turned on again: painted right away")

print("StoryMapPins tests passed")
