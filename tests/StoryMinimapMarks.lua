-- Story quests on the minimap: our own markers, in the story's colour.
local Fakes = dofile("tests/StoryMarksFakes.lua")
Fakes.EventFrames()
Fakes.InstallGlobals()

-- Keep the marker pool the module makes, to look at its markers.
local markerPool
CreateFramePool = function(...)
    markerPool = Fakes.CreateFramePool(...)
    return markerPool
end

Minimap = Fakes.NewRegion()
function Minimap:GetWidth() return 140 end

local player = { x = 0.5, y = 0.5 }
local rotateMinimap = false
local facing = 0
C_Map = {
    GetPlayerMapPosition = function() return player end,
    GetMapWorldSize = function() return 1000, 1000 end,
}
C_Minimap = { GetViewRadius = function() return 100 end }
GetCVarBool = function(name) return name == "rotateMinimap" and rotateMinimap end
GetPlayerFacing = function() return facing end
C_QuestLog = { IsComplete = function(questID) return questID == 302 end }
StoryModeDB = { markStoryQuests = true }

local SM = Fakes.NewStoryMode({ [201] = "hillsbrad", [301] = "other", [302] = "hillsbrad" }, "hillsbrad")
SM.StoryQuestsOnMap = { mapID = 1412, offered = {}, inLog = {} }
local listeners = {}
function SM.StoryQuestsOnMap.OnChange(listener) listeners[#listeners + 1] = listener end
local function OnMapChanged()
    for _, listener in ipairs(listeners) do listener() end
end

assert(loadfile("Code/UI/StoryQuestMarks.lua"))("StoryMode", SM)
assert(loadfile("Code/UI/StoryMinimapMarks.lua"))("StoryMode", SM)
local Marks = SM.StoryQuestMarks

local function MarkerFor(x, y)
    for marker in pairs(markerPool.active) do
        if marker.x == x and marker.y == y then return marker end
    end
end

local function Near(value, expected) return math.abs(value - expected) < 0.01 end

local function IsAt(marker, offsetX, offsetY)
    return marker.shown and marker.anchor == Minimap and Near(marker.offsetX, offsetX) and Near(marker.offsetY, offsetY)
end

-- The minimap shows 100 yards over its 70 px radius: 0.7 px a yard.
SM.StoryQuestsOnMap.offered = { { questID = 201, x = 0.51, y = 0.48 } }
SM.StoryQuestsOnMap.inLog = { { questID = 301, x = 0.5, y = 0.6 }, { questID = 302, x = 0.9, y = 0.5 } }
OnMapChanged()

local giver = MarkerFor(0.51, 0.48)
assert(giver and giver.icon.atlas == Marks.GIVER_ATLAS and giver.size == 16, "a giver gets a !")
assert(Fakes.IsColor(giver.icon, Marks.FOLLOWED_STORY_COLOR), "followed story: green")
assert(IsAt(giver, 7, 14), "10 yards east and 20 north of the player")

local inProgress = MarkerFor(0.5, 0.6)
assert(inProgress and inProgress.icon.atlas == Marks.GIVER_ATLAS and inProgress.size == 11, "in progress: a small !")
assert(Fakes.IsColor(inProgress.icon, Marks.OTHER_STORY_COLOR), "other story: pink")
assert(IsAt(inProgress, 0, -64), "too far: waits on the edge, in its direction")

local turnIn = MarkerFor(0.9, 0.5)
assert(turnIn and turnIn.icon.atlas == Marks.TURN_IN_ATLAS, "ready to turn in: a ?")
assert(IsAt(turnIn, 64, 0))

-- A turning minimap: facing west, north is to the right.
rotateMinimap, facing = true, math.pi / 2
OnMapChanged()
assert(IsAt(MarkerFor(0.51, 0.48), 14, -7), "turns with the player")

-- No player position (an instance): markers hidden.
player = nil
OnMapChanged()
for marker in pairs(markerPool.active) do assert(not marker.shown, "hidden without a player position") end
player = { x = 0.5, y = 0.5 }

-- Turned off: no markers.
SM.SetStoryQuestMarks(false)
assert(next(markerPool.active) == nil, "turned off: none")
SM.SetStoryQuestMarks(true)
assert(MarkerFor(0.51, 0.48), "turned on: back right away")

print("StoryMinimapMarks tests passed")
