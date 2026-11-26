-- Story quests' areas on the minimap: the borders take the story's colour
-- when every tracked quest on the map (but the super-tracked one) shares it.
local Fakes = dofile("tests/StoryMarksFakes.lua")
local Fire = Fakes.EventFrames()
Fakes.InstallGlobals()

local outsideTexture, ringTexture, textureCalls = 533895, 533893, 0
Minimap = Fakes.NewRegion()
function Minimap:SetQuestBlobOutsideTexture(texture) outsideTexture = texture; textureCalls = textureCalls + 1 end
function Minimap:SetQuestBlobRingTexture(texture) ringTexture = texture end

local watched, onMap, superTracked = {}, {}, 0
C_QuestLog = {
    GetNumQuestWatches = function() return #watched end,
    GetQuestIDForQuestWatchIndex = function(index) return watched[index] end,
    GetQuestsOnMap = function()
        local quests = {}
        for _, questID in ipairs(onMap) do quests[#quests + 1] = { questID = questID } end
        return quests
    end,
}
C_SuperTrack = { GetSuperTrackedQuestID = function() return superTracked end }
StoryModeDB = { markStoryQuests = true }

-- 201, 202: the followed story; 301: another story; 900: no story.
local SM = Fakes.NewStoryMode({ [201] = "hillsbrad", [202] = "hillsbrad", [301] = "other" }, "hillsbrad")
SM.StoryQuestsOnMap = { mapID = 1424 }
local listeners = {}
function SM.StoryQuestsOnMap.OnChange(listener) listeners[#listeners + 1] = listener end
local function OnMapChanged()
    for _, listener in ipairs(listeners) do listener() end
end

assert(loadfile("Code/UI/StoryQuestMarks.lua"))("StoryMode", SM)
assert(loadfile("Code/UI/StoryMinimapAreas.lua"))("StoryMode", SM)

local ART = "Interface\\AddOns\\StoryMode\\Art\\Minimap\\"
local function IsGame() return outsideTexture == 533895 and ringTexture == 533893 end
local function IsFollowed() return outsideTexture == ART .. "QuestAreaOutsideFollowed" and ringTexture == ART .. "QuestAreaRingFollowed" end
local function IsOther() return outsideTexture == ART .. "QuestAreaOutsideOther" and ringTexture == ART .. "QuestAreaRingOther" end

watched, onMap = { 201, 202 }, { 201, 202, 301, 900 }
OnMapChanged()
assert(IsFollowed(), "every tracked quest of the followed story: green")

watched = { 301 }
Fire("QUEST_WATCH_LIST_CHANGED")
assert(IsOther(), "another story's quest: lime green")

watched = { 201, 301 }
Fire("QUEST_WATCH_LIST_CHANGED")
assert(IsGame(), "two colours: the game's own")

watched = { 201, 900 }
Fire("QUEST_WATCH_LIST_CHANGED")
assert(IsGame(), "a quest of no story: the game's own")

superTracked = 900
Fire("SUPER_TRACKING_CHANGED")
assert(IsFollowed(), "the super-tracked quest keeps the game's own border, so it doesn't count")

watched, onMap, superTracked = { 201, 900 }, { 201 }, 0
Fire("QUEST_WATCH_LIST_CHANGED")
assert(IsFollowed(), "a tracked quest of no story off this map doesn't count")

local callsBefore = textureCalls
OnMapChanged()
assert(textureCalls == callsBefore, "same colour: the textures are left alone")

SM.SetStoryQuestMarks(false)
assert(IsGame(), "turned off: the game's own")
SM.SetStoryQuestMarks(true)
assert(IsFollowed(), "turned on: back right away")

watched = {}
Fire("QUEST_WATCH_LIST_CHANGED")
assert(IsGame(), "nothing tracked: the game's own")

print("StoryMinimapAreas tests passed")
