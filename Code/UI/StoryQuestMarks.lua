local _, SM = ...

-- Story quest marks: the colours, the setting, and the parts shared by the
-- places that show them (world map pins, the map's quest list, nameplates,
-- the minimap). Quests of the story the player follows are green; quests of
-- the other stories are lime green. Other quests stay as the game draws them.
-- Each place registers a refresh, run when the setting or the followed
-- story changes.

local Marks = {}
SM.StoryQuestMarks = Marks

Marks.FOLLOWED_STORY_COLOR = { 0.3, 1, 0.3 }
Marks.OTHER_STORY_COLOR = { 0.75, 1, 0.1 }
Marks.GIVER_ATLAS = "QuestNormal"
Marks.TURN_IN_ATLAS = "UI-QuestIcon-TurnIn-Normal"
local BADGE_SIZE = 20
-- Where the "!" of a quest in progress sits, from the pin's centre. The
-- game's "..." has its dots 5 apart, the last one centred 5 right of the
-- pin's centre and 1 above it. The "!" (20 wide) has its point centred 10
-- from its left and 4.5 above its bottom (measured on the map), so the point
-- reads as a fourth dot.
local PROGRESS_BADGE_X = 0
local PROGRESS_BADGE_Y = -3.5

local paintedTextures = setmetatable({}, { __mode = "k" })
local progressBadges = setmetatable({}, { __mode = "k" })
local refreshes = {}

function Marks.IsEnabled()
    return StoryModeDB ~= nil and StoryModeDB.markStoryQuests == true
end

-- The colour of a quest's mark, or nil when it gets none (marks off, or not
-- a story quest).
function Marks.ColorForQuest(questID)
    if not (questID and Marks.IsEnabled()) then return nil end
    local story = SM.FindQuestStory(questID)
    if not story then return nil end
    if story.id == SM.GetFollowedStoryID() then return Marks.FOLLOWED_STORY_COLOR end
    return Marks.OTHER_STORY_COLOR
end

-- The game's icons are yellow: grey first, so any colour shows true. The game
-- never colours or greys the POI buttons' icons itself, so plain is their own
-- look to go back to. (Quest offer pins grey themselves for another floor:
-- they put that back on their own, see StoryMapPins.)
function Marks.Paint(texture, color)
    texture:SetDesaturated(true)
    texture:SetVertexColor(color[1], color[2], color[3])
    paintedTextures[texture] = true
end

function Marks.Restore(texture)
    if not paintedTextures[texture] then return false end
    texture:SetDesaturated(false)
    texture:SetVertexColor(1, 1, 1)
    paintedTextures[texture] = nil
    return true
end

-- A texture showing a mark: an atlas of the game's, painted.
function Marks.NewIcon(parent, atlas, color, layer)
    local icon = parent:CreateTexture(nil, layer or "OVERLAY", nil, 7)
    icon:SetAtlas(atlas)
    Marks.Paint(icon, color)
    return icon
end

-- The "!" rises from beside the last dot of the pin's "...", covering none
-- of them.
local function ProgressBadge(button, color)
    local badge = progressBadges[button]
    if not badge then
        badge = Marks.NewIcon(button, Marks.GIVER_ATLAS, color)
        badge:SetSize(BADGE_SIZE, BADGE_SIZE)
        progressBadges[button] = badge
    end
    badge:ClearAllPoints()
    badge:SetPoint("BOTTOMLEFT", button, "CENTER", PROGRESS_BADGE_X, PROGRESS_BADGE_Y)
    Marks.Paint(badge, color)
    return badge
end

-- A quest's POI button (on the map, or in the map's quest list): a story
-- quest ready to turn in gets its "?" painted, one in progress a "!" beside
-- the last dot of its "...".
function Marks.UpdateQuestButton(button)
    if button:IsForbidden() then return end
    local icon = button.Display and button.Display.Icon
    local questID = button.GetQuestID and button:GetQuestID()
    local color = Marks.ColorForQuest(questID)
    local isReadyToTurnIn = color and C_QuestLog.IsComplete(questID)

    if icon then
        if isReadyToTurnIn then Marks.Paint(icon, color) else Marks.Restore(icon) end
    end

    if color and not isReadyToTurnIn then
        ProgressBadge(button, color):Show()
    elseif progressBadges[button] then
        progressBadges[button]:Hide()
    end
end

function Marks.OnChange(refresh)
    refreshes[#refreshes + 1] = refresh
end

function SM.RefreshStoryQuestMarks()
    for _, refresh in ipairs(refreshes) do refresh() end
end

function SM.SetStoryQuestMarks(enabled)
    if not StoryModeDB then return end
    StoryModeDB.markStoryQuests = enabled == true
    SM.RefreshStoryQuestMarks()
end
