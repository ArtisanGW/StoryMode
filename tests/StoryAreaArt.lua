-- The story colours' quest area art: loaded by textures the player can't
-- see before anything gives it to the game.
local Fakes = dofile("tests/StoryMarksFakes.lua")
local _, frames = Fakes.EventFrames()
Fakes.InstallGlobals()

local SM = Fakes.NewStoryMode({}, "hillsbrad")
assert(loadfile("Code/UI/StoryQuestMarks.lua"))("StoryMode", SM)
assert(loadfile("Code/UI/StoryAreaArt.lua"))("StoryMode", SM)
local Marks, AreaArt = SM.StoryQuestMarks, SM.StoryAreaArt

local ART = "Interface\\AddOns\\StoryMode\\Art\\"
local artFiles = {}
for _, frame in ipairs(frames) do
    for _, texture in ipairs(frame.children) do
        assert(texture.alpha == 0, "the art textures can't be seen")
        artFiles[#artFiles + 1] = texture.texture
    end
end
table.sort(artFiles)
local expected = {}
for _, story in ipairs({ "Followed", "Other" }) do
    for _, name in ipairs({ "Minimap\\QuestAreaOutside", "Minimap\\QuestAreaRing", "WorldMap\\QuestAreaInside", "WorldMap\\QuestAreaOutside" }) do
        expected[#expected + 1] = ART .. name .. story .. ".tga"
    end
end
table.sort(expected)
assert(table.concat(artFiles, " ") == table.concat(expected, " "), "every file is loaded by a texture")

local loadedCalls = 0
AreaArt.OnLoaded(function() loadedCalls = loadedCalls + 1 end)
Fakes.DrawFrame(frames, false)
assert(AreaArt.ForColor(Marks.FOLLOWED_STORY_COLOR) == nil, "not loaded: no files (given now, they stay 'not found' until a restart)")
assert(loadedCalls == 0)

Fakes.DrawFrame(frames, true)
assert(loadedCalls == 1, "loaded: the listeners run")
local followed = AreaArt.ForColor(Marks.FOLLOWED_STORY_COLOR)
assert(followed.minimapOutside == ART .. "Minimap\\QuestAreaOutsideFollowed.tga")
assert(followed.mapInside == ART .. "WorldMap\\QuestAreaInsideFollowed.tga")
assert(AreaArt.ForColor(Marks.OTHER_STORY_COLOR).mapOutside == ART .. "WorldMap\\QuestAreaOutsideOther.tga")
assert(AreaArt.ForColor(nil) == nil, "no colour: no files")

Fakes.DrawFrame(frames, true)
assert(loadedCalls == 1, "the listeners run once")

print("StoryAreaArt tests passed")
