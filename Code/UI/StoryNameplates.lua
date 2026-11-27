local _, SM = ...

-- A "!" in the story's colour above the nameplate of an NPC who offers a
-- story quest. The game draws its own "!" over NPCs and gives addons no way
-- to recolour it, so this is our own small badge on the game's nameplate.
-- Who offers what comes from StoryQuestsOnMap. Shows only where the game
-- shows friendly NPC nameplates (not in instances).

local Marks = SM.StoryQuestMarks
local OnMap = SM.StoryQuestsOnMap
local BADGE_SIZE = 20

local colorByGiverName = {}
local badgesByUnit = {}
local shownUnits = {}
local badgePool = CreateFramePool("Frame", UIParent, nil, function(_, badge)
    badge:Hide()
    badge:ClearAllPoints()
    badge:SetParent(UIParent)
end)

-- Story data and the game can spell an apostrophe differently.
local function NormalizedName(name)
    return (name:gsub("\226\128\153", "'"))
end

-- A giver with quests of both kinds shows the followed story's colour.
local function CollectGivers()
    wipe(colorByGiverName)
    for _, offer in ipairs(OnMap.offered) do
        local color = offer.npc and offer.npc ~= "" and Marks.ColorForQuest(offer.questID)
        if color then
            local name = NormalizedName(offer.npc)
            if colorByGiverName[name] ~= Marks.FOLLOWED_STORY_COLOR then
                colorByGiverName[name] = color
            end
        end
    end
end

local function GiverColor(unit)
    if UnitIsPlayer(unit) then return nil end
    local name = UnitName(unit)
    if not name or (issecretvalue and issecretvalue(name)) then return nil end
    return colorByGiverName[NormalizedName(name)]
end

local function ShowBadge(nameplate, color)
    local badge, isNew = badgePool:Acquire()
    if isNew then
        badge:SetSize(BADGE_SIZE, BADGE_SIZE)
        badge.icon = Marks.NewIcon(badge, Marks.GIVER_ATLAS, color)
        badge.icon:SetAllPoints()
    end
    Marks.Paint(badge.icon, color)
    badge:SetParent(nameplate)
    badge:SetPoint("BOTTOM", nameplate, "TOP", 0, 2)
    badge:Show()
    return badge
end

local function RemoveBadge(unit)
    local badge = badgesByUnit[unit]
    if badge then
        badgePool:Release(badge)
        badgesByUnit[unit] = nil
    end
end

local function UpdateUnit(unit)
    RemoveBadge(unit)
    local color = GiverColor(unit)
    if not color then return end
    local nameplate = C_NamePlate.GetNamePlateForUnit(unit)
    if nameplate and not nameplate:IsForbidden() then
        badgesByUnit[unit] = ShowBadge(nameplate, color)
    end
end

local function Refresh()
    CollectGivers()
    for unit in pairs(shownUnits) do UpdateUnit(unit) end
end

OnMap.OnChange(Refresh)
Marks.OnChange(Refresh)

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
eventFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
eventFrame:SetScript("OnEvent", function(_, event, unit)
    if event == "NAME_PLATE_UNIT_ADDED" then
        shownUnits[unit] = true
        UpdateUnit(unit)
    else
        shownUnits[unit] = nil
        RemoveBadge(unit)
    end
end)
