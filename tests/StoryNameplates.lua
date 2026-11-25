-- A "!" in the story's colour above the nameplate of an NPC who offers a story quest.
local Fakes = dofile("tests/StoryMarksFakes.lua")
local Fire = Fakes.EventFrames()
Fakes.InstallGlobals()

local units = {
    nameplate1 = { name = "Devrak" },
    nameplate2 = { name = "Some Guard" },
    nameplate3 = { name = "Kor\226\128\153vas Bloodthorn" },
    nameplate4 = { name = "Devrak", player = true },
}
for _, unit in pairs(units) do unit.nameplate = Fakes.NewRegion() end

UnitName = function(unit) return units[unit].name end
UnitIsPlayer = function(unit) return units[unit].player == true end
C_NamePlate = { GetNamePlateForUnit = function(unit) return units[unit].nameplate end }
StoryModeDB = { markStoryQuests = true }

local SM = Fakes.NewStoryMode({ [201] = "hillsbrad", [202] = "other" }, "hillsbrad")
SM.StoryQuestsOnMap = { offered = {} }
local listeners = {}
function SM.StoryQuestsOnMap.OnChange(listener) listeners[#listeners + 1] = listener end
local function OfferedChanged(offered)
    SM.StoryQuestsOnMap.offered = offered
    for _, listener in ipairs(listeners) do listener() end
end

assert(loadfile("Code/UI/StoryQuestMarks.lua"))("StoryMode", SM)
assert(loadfile("Code/UI/StoryNameplates.lua"))("StoryMode", SM)
local Marks = SM.StoryQuestMarks

local function Badge(unit)
    local badge = units[unit].nameplate.badge
    return badge and badge.shown and badge or nil
end

OfferedChanged({
    { questID = 201, npc = "Devrak" },
    { questID = 202, npc = "Kor'vas Bloodthorn" },
})
for unit in pairs(units) do Fire("NAME_PLATE_UNIT_ADDED", unit) end
assert(Badge("nameplate1"), "followed story giver gets a badge")
assert(Badge("nameplate1").icon.atlas == "QuestNormal", "the badge is a !")
assert(Fakes.IsColor(Badge("nameplate1").icon, Marks.FOLLOWED_STORY_COLOR), "in green")
assert(Badge("nameplate3"), "names match across apostrophe spellings")
assert(Fakes.IsColor(Badge("nameplate3").icon, Marks.OTHER_STORY_COLOR), "other story giver in pink")
assert(not Badge("nameplate2"), "other NPCs get none")
assert(not Badge("nameplate4"), "players get none")

-- A nameplate going away gives its badge back to the pool.
local badge = Badge("nameplate1")
Fire("NAME_PLATE_UNIT_REMOVED", "nameplate1")
assert(not Badge("nameplate1"), "badge gone with the nameplate")
assert(not badge.shown and badge.parent == UIParent)

-- The game stops offering the quest: the badge goes.
OfferedChanged({ { questID = 201, npc = "Devrak" } })
assert(not Badge("nameplate3"), "no badge once the quest isn't offered")

-- Turned off, then on again.
Fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
assert(Badge("nameplate1"))
SM.SetStoryQuestMarks(false)
assert(not Badge("nameplate1"), "turned off: no badges")
SM.SetStoryQuestMarks(true)
assert(Badge("nameplate1"), "turned on: badges right away")

print("StoryNameplates tests passed")
