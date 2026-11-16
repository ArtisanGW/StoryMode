local _, SM = ...
local L = SM.L
local SMTooltip = SM.Tooltip
local C_BODY = SM.UIColors.body
local C_GOLD = SM.UIColors.gold
local C_DIM = SM.UIColors.dim

local QCARD_H = 44 + 8

function SM.ExecuteTrackButton(data, quest)
    if not data or not quest then return end
    local result = SM.SetWaypointForQuest(data, quest)
    SM.PrintTrackResult(result, quest, data)
    local storyFrame = SM.GetStoryModeFrame and SM.GetStoryModeFrame()
    if storyFrame then storyFrame:Hide() end
end

local activeQuestTooltipCard = nil
local questTooltipRefreshToken = 0

local function IsQuestTooltipDataCached(questID)
    if questID and C_QuestLog and C_QuestLog.IsQuestDataCached then
        local ok, cached = pcall(C_QuestLog.IsQuestDataCached, questID)
        if ok then return cached and true or false end
    end
    return nil
end

local function QuestCardHasQuestID(card, questID)
    if not (card and questID) then return false end
    if card.questID == questID then return true end
    if card.questEntry and SM.GetQuestIDs then
        for _, id in ipairs(SM.GetQuestIDs(card.questEntry)) do
            if id == questID then return true end
        end
    end
    return false
end

local function IsQuestTooltipCardActive(card)
    return card
        and activeQuestTooltipCard == card
        and card:IsShown()
        and card:IsMouseOver()
end

local function QueueQuestTooltipRefresh(card, delay)
    if not (C_Timer and C_Timer.After) then return end
    questTooltipRefreshToken = questTooltipRefreshToken + 1
    local token = questTooltipRefreshToken
    C_Timer.After(delay or 0, function()
        if token ~= questTooltipRefreshToken then return end
        if SM.RefreshQuestCardTooltip and IsQuestTooltipCardActive(card) then
            SM.RefreshQuestCardTooltip(card, false)
        end
    end)
end

local function EnsureQuestTooltipEvents()
    if SM.questTooltipEventFrame then return end

    SM.questTooltipEventFrame = CreateFrame("Frame")
    SM.questTooltipEventFrame:RegisterEvent("QUEST_LOG_UPDATE")
    if C_QuestLog and C_QuestLog.RequestLoadQuestByID then
        pcall(SM.questTooltipEventFrame.RegisterEvent, SM.questTooltipEventFrame, "QUEST_DATA_LOAD_RESULT")
    end

    SM.questTooltipEventFrame:SetScript("OnEvent", function(_, event, questID, success)
        local card = activeQuestTooltipCard
        if not IsQuestTooltipCardActive(card) then return end

        if event == "QUEST_DATA_LOAD_RESULT" then
            if not success or not QuestCardHasQuestID(card, questID) then return end
            QueueQuestTooltipRefresh(card, 0)
        elseif event == "QUEST_LOG_UPDATE" then
            QueueQuestTooltipRefresh(card, 0.05)
        end
    end)
end

local function RequestQuestTooltipData(card)
    local questID = card and card.questID
    if not (questID and C_QuestLog and C_QuestLog.RequestLoadQuestByID) then
        return false
    end

    EnsureQuestTooltipEvents()
    local ok = pcall(C_QuestLog.RequestLoadQuestByID, questID)
    if ok then
        QueueQuestTooltipRefresh(card, 0.35)
    end
    return ok
end

function SM.RefreshQuestCardTooltip(card, requestQuestData)
    if not (card and card.questID) then return end

    local questDataCached = IsQuestTooltipDataCached(card.questID)
    local requestedQuestData = requestQuestData and RequestQuestTooltipData(card) or false

    SMTooltip:SetOwner(card, "ANCHOR_RIGHT")
    SMTooltip:ClearLines()

    local qName = (QuestUtils_GetQuestName and QuestUtils_GetQuestName(card.questID)) or card.tooltipTitle or ""
    SMTooltip:AddLine(qName, 1, 1, 1)

    if card.tooltipNPC then
        SMTooltip:AddLine(card.tooltipNPC, C_BODY[1], C_BODY[2], C_BODY[3])
    end

    -- Objectives are only useful for active, incomplete quests. Completed
    -- quests no longer keep live counters, which makes old objective lines stale.
    local qComplete = SM.IsQuestFlaggedCompleted(card.questID)
    local hasObjectives = false
    if not qComplete then
        local objectives = SM.GetQuestObjectives(card.questID)
        if objectives and #objectives > 0 then
            SMTooltip:AddLine(" ")
            for _, obj in ipairs(objectives) do
                if obj.text and obj.text ~= "" then
                    hasObjectives = true
                    if obj.finished then
                        SMTooltip:AddLine(obj.text, 0.45, 0.90, 0.35, true)
                    else
                        SMTooltip:AddLine(obj.text, 0.9, 0.9, 0.9, true)
                    end
                end
            end
        end

        if requestedQuestData and questDataCached ~= true and not hasObjectives then
            SMTooltip:AddLine(" ")
            SMTooltip:AddLine(L["Quest Tooltip Loading"], C_DIM[1], C_DIM[2], C_DIM[3], true)
        end
    end

    if card.tooltipStatus then
        SMTooltip:AddLine(" ")
        SMTooltip:AddLine(card.tooltipStatus)
    end
    if card.tooltipRequirement then
        SMTooltip:AddLine(card.tooltipRequirement, 1.0, 0.82, 0.35, true)
    end

    SMTooltip:Show()
end

-- WoW Forever: quest cards are the Legacy window's challenge cards
-- (LegacyChallengeTemplate), at its size and with its state art: a finished
-- quest is a brown card with a brown ribbon, any other a dark card with a dark
-- ribbon, and the quest to do now gets the gold outline. Field names match the
-- usual card, so the click and tooltip code below works for both.
SM.LegacyQuestCardWidth, SM.LegacyQuestCardHeight = 516, 122
SM.LegacyQuestCardGap = 5

local LEGACY = {
    card = "Legacy-Challenge-Cards",
    cardOpen = "Legacy-Challenge-Cards-Disable",
    selected = "Legacy-Challenge-Cards-selected",
    ribbon = "Legacy-Challenge-Cards-Ribbon-Brown",
    ribbonOpen = "Legacy-Challenge-Cards-Ribbon-Brown-disable",
    iconFrame = "Legacy-Tree-Frame-icon-frame",
    iconMask = "UI-Frame-IconMask",
    statusBackground = "Legacy-Challenge-Cards-Date-BG",
    check = "worldquest-tracker-checkmark",
    shield = "Legacy-Tree-Frame-Points-icon",
}
local WHITE = { 1, 1, 1 }
local GRAY = { 0.5, 0.5, 0.5 }

-- The objective line from the quest cache (Data/Forever/ForeverQuestText.lua,
-- English), with the game's $ tokens filled in.
local function GetQuestCardText(questID)
    local text = SM.ForeverQuestText and questID and SM.ForeverQuestText[questID]
    if not text or GetLocale() ~= "enUS" then return nil end
    text = text:gsub("%$[Gg]([^:;]*):([^;]*);", function(male, female)
        return (UnitSex and UnitSex("player") == 3) and female or male
    end)
    text = text:gsub("%$%d+o[a-z]%s*", "")
    text = text:gsub("%$[Nn]", UnitName and UnitName("player") or "")
    text = text:gsub("%$[Cc]", UnitClass and (UnitClass("player")) or "")
    text = text:gsub("%$[Rr]", UnitRace and (UnitRace("player")) or "")
    text = text:gsub("%$[Bb]", " "):gsub("%s+", " ")
    return text
end

local function CreateLegacyQuestCard(parent)
    local SetAtlas = SM.ForeverWindow.SetAtlas
    local card = CreateFrame("Button", nil, parent)
    card:EnableMouse(true)
    card:SetSize(SM.LegacyQuestCardWidth, SM.LegacyQuestCardHeight)
    card.isLegacyCard = true

    card.bg = card:CreateTexture(nil, "BACKGROUND")
    card.bg:SetAllPoints()

    card.selected = card:CreateTexture(nil, "BORDER")
    card.selected:SetAllPoints()
    SetAtlas(card.selected, LEGACY.selected)
    card.selected:Hide()

    local highlight = card:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetAllPoints()
    SetAtlas(highlight, LEGACY.selected)
    highlight:SetAlpha(0.35)

    card.ribbon = card:CreateTexture(nil, "ARTWORK")
    card.ribbon:SetPoint("TOPLEFT", card, "TOPLEFT", 5, -4)
    card.ribbon:SetPoint("TOPRIGHT", card, "TOPRIGHT", -80, -4)
    card.ribbon:SetHeight(46)

    -- Quest giver portrait in the Legacy icon frame (LegacyChallengeIconFrameTemplate).
    local iconHolder = CreateFrame("Frame", nil, card)
    iconHolder:SetSize(60, 60)
    iconHolder:SetPoint("TOPLEFT", card, "TOPLEFT", 12, -18)
    card.portrait = iconHolder:CreateTexture(nil, "ARTWORK")
    card.portrait:SetSize(50, 50)
    card.portrait:SetPoint("CENTER")
    local mask = iconHolder:CreateMaskTexture()
    mask:SetAllPoints(card.portrait)
    if SetAtlas(mask, LEGACY.iconMask) then card.portrait:AddMaskTexture(mask) end
    local iconFrame = iconHolder:CreateTexture(nil, "OVERLAY")
    SetAtlas(iconFrame, LEGACY.iconFrame, true)
    iconFrame:SetPoint("CENTER")

    card.title = card:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    card.title:SetPoint("TOPLEFT", card.ribbon, "TOPLEFT", 70, -18)
    card.title:SetPoint("RIGHT", card, "RIGHT", -80, 0)
    card.title:SetJustifyH("LEFT")
    card.title:SetWordWrap(false)

    card.npcLabel = card:CreateFontString(nil, "OVERLAY", "SystemFont_Shadow_Med1")
    card.npcLabel:SetPoint("TOPLEFT", card.ribbon, "BOTTOMLEFT", 72, -2)
    card.npcLabel:SetPoint("RIGHT", card, "RIGHT", -80, 0)
    card.npcLabel:SetJustifyH("LEFT")
    card.npcLabel:SetJustifyV("TOP")
    card.npcLabel:SetMaxLines(4)

    -- Top-right corner, where Legacy shows the date a challenge was done.
    card.statusBackground = card:CreateTexture(nil, "OVERLAY")
    SetAtlas(card.statusBackground, LEGACY.statusBackground, true)
    card.statusBackground:SetPoint("TOPRIGHT", card, "TOPRIGHT", -6, -3)
    card.check = card:CreateTexture(nil, "OVERLAY", nil, 1)
    SetAtlas(card.check, LEGACY.check, true)
    card.check:SetScale(0.5)
    card.check:SetPoint("TOPRIGHT", card, "TOPRIGHT", -20, -8)  -- in the check's half scale
    card.status = card:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    card.status:SetJustifyH("RIGHT")

    -- The step's place in the chapter, on the Legacy points shield.
    card.shield = card:CreateTexture(nil, "ARTWORK")
    SetAtlas(card.shield, LEGACY.shield)
    card.shield:SetSize(35, 51)
    card.shield:SetPoint("TOPRIGHT", card, "TOPRIGHT", -14, -26)
    card.step = card:CreateFontString(nil, "OVERLAY", "GameFontNormalMed3")
    card.step:SetPoint("CENTER", card.shield, "CENTER", -1, -4)

    -- Kept so shared code that touches card.icon still works.
    card.icon = card:CreateTexture(nil, "OVERLAY")
    card.icon:Hide()

    -- state: "done", "active" (in the quest log), "next", "optional",
    -- "locked" (has a requirement) or "later".
    function card:SetLegacyState(state, stepNumber, data, chapter, quest)
        local done = state == "done"
        local current = state == "active" or state == "next"
        SetAtlas(self.bg, done and LEGACY.card or LEGACY.cardOpen)
        SetAtlas(self.ribbon, done and LEGACY.ribbon or LEGACY.ribbonOpen)
        self.selected:SetShown(current)

        local displayID = data and data.npcDisplayIDs and quest and data.npcDisplayIDs[quest.npc]
        local iconPath = data and ((data.chapterIcons and chapter and data.chapterIcons[chapter.chapter]) or data.icon)
        SM.SetChapterPortrait(self.portrait, displayID, iconPath, quest and quest.id)
        self.portrait:SetDesaturated(not done and not current)

        -- The quest's own objective; without one, who gives it and where.
        local text = GetQuestCardText(quest and quest.id)
        if not text then
            local npc = quest and quest.npc or ""
            local location = quest and (quest.location
                or (data and data.npcLocations and data.npcLocations[quest.npc] and data.npcLocations[quest.npc].location))
            text = (location and location ~= "") and (npc .. ", " .. location) or npc
        end
        self.npcLabel:SetText(text)

        local statusText = (done and L["Quest Status Completed"])
            or (state == "active" and L["Quest Status In Progress"])
            or (state == "optional" and L["Quest Status Optional"]) or nil
        self.status:SetText(statusText or "")
        self.status:ClearAllPoints()
        self.status:SetPoint("RIGHT", self.statusBackground, "RIGHT", done and -24 or -8, 0)
        self.status:SetTextColor(done and 0.45 or 1, done and 0.9 or 0.82, done and 0.35 or 0)
        self.statusBackground:SetShown(statusText ~= nil)
        self.check:SetShown(done)

        self.step:SetText(stepNumber and tostring(stepNumber) or "")
        self.shield:SetShown(stepNumber ~= nil)
        self.step:SetShown(stepNumber ~= nil)

        local color = (done or current) and WHITE or GRAY
        self.title:SetTextColor(color[1], color[2], color[3])
        self.npcLabel:SetTextColor(color[1], color[2], color[3])
    end

    return card
end

function SM.CreateQuestCard(parent)
    if SM.ForeverWindow then
        local card = CreateLegacyQuestCard(parent)
        SM.AttachQuestCardScripts(card)
        return card
    end
    local card = CreateFrame("Button", nil, parent, (SM.IsMainlineClient()) and nil or "BackdropTemplate")
    card:EnableMouse(true)
    card:SetHeight(QCARD_H)
    if SM.IsClassicClient() then
        SM.ApplyClassicCardBackdrop(card, 0.18, 0.50)
    end

    -- Housing endeavor-style card background
    local bg = card:CreateTexture(nil, "BACKGROUND")
    if SM.IsMainlineClient() then
        bg:SetAtlas("housing-dashboard-initiatives-tasks-listitem-bg", false)
    else
        SM.ClearCardFillTexture(bg)
    end
    bg:SetAllPoints()
    card.bg = bg
    if SM.IsClassicClient() then
        card.shade = SM.CreateInsetCardShade(card, 0.38)
    end

    local cardMask = card:CreateMaskTexture()
    cardMask:SetTexture("Interface/Buttons/WHITE8x8")
    cardMask:SetPoint("TOPLEFT", card, "TOPLEFT", 2, -2)
    cardMask:SetPoint("BOTTOMRIGHT", card, "BOTTOMRIGHT", -2, 2)
    bg:AddMaskTexture(cardMask)
    card.bgMask = cardMask

    -- Hover highlight
    if SM.IsMainlineClient() then
        card:SetHighlightAtlas("housing-dashboard-initiatives-tasks-listitem-bg")
        card:GetHighlightTexture():SetAllPoints()
        card:GetHighlightTexture():SetAlpha(0.3)
    else
        SM.SetSubtleCardHover(card)
    end
    if card:GetHighlightTexture() then
        card:GetHighlightTexture():AddMaskTexture(cardMask)
    end

    -- Status icon (always 14x14 for consistent text alignment)
    local ICON_LEFT = 10
    local TEXT_LEFT = ICON_LEFT + 14 + 8  -- icon width + gap
    local icon = card:CreateTexture(nil, "ARTWORK")
    icon:SetSize(14, 14)
    icon:SetPoint("LEFT", card, "LEFT", ICON_LEFT, 0)
    card.icon = icon

    -- Quest name (top line)
    local title = SM.NoShadow(card:CreateFontString(nil, "ARTWORK", "GameFontNormal"))
    title:SetPoint("LEFT", card, "LEFT", TEXT_LEFT, 0)
    title:SetPoint("RIGHT", card, "RIGHT", -10, 0)
    title:SetPoint("BOTTOM", card, "CENTER", 0, 1)
    title:SetJustifyH("LEFT")
    title:SetJustifyV("BOTTOM")
    title:SetWordWrap(false)
    card.title = title

    -- NPC name (bottom line, same left edge as title)
    local npcLabel = SM.NoShadow(card:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall"))
    npcLabel:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -2)
    npcLabel:SetPoint("RIGHT", card, "RIGHT", -10, 0)
    npcLabel:SetJustifyH("LEFT")
    npcLabel:SetWordWrap(false)
    card.npcLabel = npcLabel

    SM.AttachQuestCardScripts(card)
    return card
end

-- Tooltip, chat link and tracking clicks, shared by both card styles.
function SM.AttachQuestCardScripts(card)
    -- Tooltip — refreshes in place when Blizzard finishes loading quest data.
    card:SetScript("OnEnter", function(self)
        if not self.questID then return end
        activeQuestTooltipCard = self
        EnsureQuestTooltipEvents()
        SM.RefreshQuestCardTooltip(self, true)
    end)
    card:SetScript("OnLeave", function(self)
        if activeQuestTooltipCard == self then
            activeQuestTooltipCard = nil
            questTooltipRefreshToken = questTooltipRefreshToken + 1
        end
        SMTooltip:Hide()
    end)
    card:SetScript("OnClick", function(self, button)
        if not self.questEntry then return end

        local questName = self.tooltipTitle or self.questEntry.name or L["Quest"]
        if button == "LeftButton" and IsShiftKeyDown() and SM.InsertQuestChatLink(self.questEntry, self.questID, questName) then
            return
        end

        local questText = SM.GetQuestChatLink(self.questEntry, questName)
        if self.questCompleteForClick or SM.IsQuestEntryComplete(self.questEntry) then
            local storyFrame = SM.GetStoryModeFrame and SM.GetStoryModeFrame()
            if storyFrame then storyFrame:Hide() end
            print(L["Addon Prefix"] .. string.format(L["Quest Click Complete Format"], questText))
            return
        end

        if self.tooltipRequirement then
            local storyFrame = SM.GetStoryModeFrame and SM.GetStoryModeFrame()
            if storyFrame then storyFrame:Hide() end
            print(L["Addon Prefix"] .. self.tooltipRequirement)
            return
        end

        SM.ExecuteTrackButton(self.storyData, self.questEntry)
    end)
end
