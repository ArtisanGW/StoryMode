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
-- The "..." of a quest in progress: the share of the icon its last dot takes.
local LAST_DOT_SHARE = 1 / 3

local paintedTextures = setmetatable({}, { __mode = "k" })
local progressDots = setmetatable({}, { __mode = "k" })
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

-- The last dot of a quest in progress, in the story's colour: a copy of the
-- pin's own icon, cropped to that dot and painted, laid over it. The pin
-- keeps the game's look, and nothing covers the dots.
local function LastDotMark(button, icon, color)
    local dot = progressDots[button]
    if not dot then
        dot = button:CreateTexture(nil, "OVERLAY", nil, 7)
        progressDots[button] = dot
    end
    local left, top, _, bottom, right = icon:GetTexCoord()
    dot:SetTexture(icon:GetTexture())
    dot:SetTexCoord(right - (right - left) * LAST_DOT_SHARE, right, top, bottom)
    dot:ClearAllPoints()
    dot:SetPoint("TOPRIGHT", icon, "TOPRIGHT")
    dot:SetPoint("BOTTOMLEFT", icon, "BOTTOMRIGHT", -icon:GetWidth() * LAST_DOT_SHARE, 0)
    Marks.Paint(dot, color)
    return dot
end

-- A quest's POI button (on the map, or in the map's quest list): a story
-- quest ready to turn in gets its "?" painted, one in progress the last dot
-- of its "...".
function Marks.UpdateQuestButton(button)
    if button:IsForbidden() then return end
    local icon = button.Display and button.Display.Icon
    local questID = button.GetQuestID and button:GetQuestID()
    local color = Marks.ColorForQuest(questID)
    local isReadyToTurnIn = color and C_QuestLog.IsComplete(questID)

    if icon then
        if isReadyToTurnIn then Marks.Paint(icon, color) else Marks.Restore(icon) end
    end

    if icon and color and not isReadyToTurnIn then
        LastDotMark(button, icon, color):Show()
    elseif progressDots[button] then
        progressDots[button]:Hide()
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
