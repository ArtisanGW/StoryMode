-- Story quests in the quest list beside the world map: their pins are painted.
local Fakes = dofile("tests/StoryMarksFakes.lua")
local Fire = Fakes.EventFrames()
Fakes.InstallGlobals()

local function NewButton(questID)
    local button = Fakes.NewRegion()
    button.Display = { Icon = Fakes.NewRegion() }
    function button:GetQuestID() return questID end
    return button
end

local followedTurnIn = NewButton(102)
local otherStoryTurnIn = NewButton(103)
local otherQuest = NewButton(900)
local activeButtons = { followedTurnIn, otherStoryTurnIn, otherQuest }

QuestScrollFrame = { Contents = { buttonPool = {} } }
function QuestScrollFrame.Contents.buttonPool:EnumerateActive()
    local index = 0
    return function()
        index = index + 1
        return activeButtons[index]
    end
end

local listUpdates = 0
QuestLogQuests_Update = function() listUpdates = listUpdates + 1 end
function hooksecurefunc(name, hook)
    local original = _G[name]
    _G[name] = function(...)
        original(...)
        hook(...)
    end
end

C_QuestLog = { IsComplete = function(questID) return questID ~= 900 end }
StoryModeDB = { markStoryQuests = true }

local SM = Fakes.NewStoryMode({ [102] = "hillsbrad", [103] = "other" }, "hillsbrad")
assert(loadfile("Code/UI/StoryQuestMarks.lua"))("StoryMode", SM)
assert(loadfile("Code/UI/StoryQuestListPins.lua"))("StoryMode", SM)
local Marks = SM.StoryQuestMarks

Fire("PLAYER_LOGIN")
QuestLogQuests_Update()
assert(listUpdates == 1, "the game's list update still runs")
assert(Fakes.IsColor(followedTurnIn.Display.Icon, Marks.FOLLOWED_STORY_COLOR), "followed story ? is green")
assert(Fakes.IsColor(otherStoryTurnIn.Display.Icon, Marks.OTHER_STORY_COLOR), "other story ? is pink")
assert(Fakes.IsPlain(otherQuest.Display.Icon), "other quests keep their look")
assert(#otherQuest.children == 0, "other quests get no badge")

SM.SetStoryQuestMarks(false)
assert(Fakes.IsPlain(followedTurnIn.Display.Icon), "turned off: back to the game's look")

print("StoryQuestListPins tests passed")
