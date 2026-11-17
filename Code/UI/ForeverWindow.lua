local addonName, SM = ...
local L = SM.L

-- =============================================================================
-- WoW Forever window
--
-- On WoW Forever the Story Mode window is the Legacy window's challenge page:
-- Blizzard's PortraitFrameTemplate shell at the Legacy window's size, opened
-- where the talent window opens, with the Legacy background, divider, points
-- shield and bar, side tabs, and cards for quests. Every size and offset is
-- copied from Forever's own Blizzard_LegacySystem XML (1.60.1), and every
-- atlas is named by its element name, which is what SetAtlas resolves.
--
-- StoryMode.lua asks SM.ForeverWindow to build the shell and lays its story
-- list and detail sections where the layout it returns says. The window only
-- exists where the art does; every other client keeps the usual window.
-- =============================================================================

local ATLAS = {
    background = "Legacy-Challenge-BG",                 -- 813 x 510, gold line at row 57
    divider = "Legacy-Tree-Frame-divider-Vertical",
    barBackground = "Legacy-Progressbar-BG",
    barFill = "Legacy-Progressbar-Fill",
    barFrame = "Legacy-Progressbar-Frame",
    shield = "UI-Legacy-Points-icon-c60",
}

local function HasArt()
    if not (C_Texture and C_Texture.GetAtlasInfo) then return false end
    for _, name in pairs(ATLAS) do
        if not C_Texture.GetAtlasInfo(name) then return false end
    end
    return true
end

if not (SM.Client and SM.Client.isForever) or not HasArt() then return end

-- LegacySystemFrame and its LegacyChallengesPageTemplate. The story list and
-- the detail reach down to the frame's bottom border, and the list up to just
-- under the header's gold line, so their scroll views fill the columns;
-- Legacy stops them a few pixels short.
local WINDOW_W, WINDOW_H = 920, 575
local BACKGROUND_INSETS = { left = 1, top = 10, right = 2, bottom = 4 }
local LIST = { x = 6, top = 78, w = 330, bottom = 4 }          -- CategoryList (Legacy: top 80, bottom 8)
local DETAIL = { right = 24, bottom = 4, w = 560, h = 494 }      -- DetailPane (Legacy: bottom 8, h 490)
local DIVIDER = { x = 328, top = 72, w = 12, h = 503 }           -- VerticalDivider
local SUMMARY = { x = 280, top = 25, w = 520, h = 36 }           -- LegacyChallengePointSummary
local OVER_FRAME_LEVEL = 800                                     -- the divider and shield sit over the frame's border
local TOP_OFFSET = -116                                          -- Blizzard's UI panel TOP_OFFSET
local BOTTOM_CLAMP = 140                                         -- and its bottom clamp

local window = {}
SM.ForeverWindow = window

-- Sets an atlas by its element name. Returns whether this client has it.
function window.SetAtlas(tex, name, useAtlasSize)
    if not (name and C_Texture.GetAtlasInfo(name)) then return false end
    tex:SetAtlas(name, useAtlasSize)
    return true
end

-- Sets an atlas so it covers w x h without stretching: it scales evenly and
-- crops the overflow from the bottom, so the header band at the top of the
-- art stays where it is.
local function SetAtlasCover(tex, atlas, w, h)
    local info = C_Texture.GetAtlasInfo(atlas)
    local file = info and (info.file or info.filename)
    local atlasW, atlasH = info and info.width, info and info.height
    if not (file and atlasW and atlasH and atlasW > 0 and atlasH > 0) then
        tex:SetAtlas(atlas)
        return
    end
    tex:SetTexture(file)
    local left, right = info.leftTexCoord, info.rightTexCoord
    local top, bottom = info.topTexCoord, info.bottomTexCoord
    local scale = math.max(w / atlasW, h / atlasH)
    local keepW = (w / scale) / atlasW
    local keepH = (h / scale) / atlasH
    local cropX = (right - left) * (1 - keepW) / 2
    tex:SetTexCoord(left + cropX, right - cropX, top, top + (bottom - top) * keepH)
end

-- The talent window opens centred, 116 below the top of the screen, and moves
-- up when its bottom would come within 140 of the screen's bottom.
local function PlaceLikeTalentWindow(frame)
    local yOffset = TOP_OFFSET
    if GetUIPanelLayoutAttribute then
        local ok, value = pcall(GetUIPanelLayoutAttribute, "TOP_OFFSET")
        if ok and type(value) == "number" then yOffset = value end
    end
    local top = UIParent:GetTop()
    if top then
        local bottom = top + yOffset - frame:GetHeight() * frame:GetScale()
        if bottom < BOTTOM_CLAMP then yOffset = yOffset + (BOTTOM_CLAMP - bottom) end
        if yOffset > -10 then yOffset = -10 end
    end
    frame:ClearAllPoints()
    frame:SetPoint("TOP", UIParent, "TOP", 0, yOffset / frame:GetScale())
end

-- ── Journal page ────────────────────────────────────────────────────────────
-- The Journal tab is a page from Forever's spellbook. The one-page
-- spellbook's parchment covers the detail side, from the vertical divider to
-- the frame's right border and from under the header's gold line to the
-- bottom border. It's cropped to fit, never stretched: its torn left, top and
-- bottom edges show, and its right edge runs on under the border. Each
-- chapter title gets the spellbook's divider, and the text the spellbook's ink.

local JOURNAL = {
    page = "spellbook-Page-Condensed-C60",          -- 813 x 682, the book's cover around the parchment
    crop = { left = 17, top = 65, bottom = 675 },   -- the parchment in it, without the cover and blue binding
    left = 338, top = 78,                           -- right of the vertical divider, under the gold line
    divider = "spellbook-divider",                  -- 657 x 11: a curl on the left, fading out on the right
    dividerJoin = 120,                              -- a shorter divider leaves out a piece of its solid line from here
    dividerIndent = 20,                             -- the curl starts this far left of the title
    ink = { 0.180, 0.106, 0.059 },                  -- SPELLBOOK_FONT_COLOR
}

local journal = { dividers = {} }

-- The page shows while a story is open on its Journal tab.
local function UpdateJournalPage()
    local shown = journal.tab == "journal" and journal.story == true
    if journal.page then journal.page:SetShown(shown) end
    if journal.layer then journal.layer:SetShown(shown) end
end

local function GetAtlasFile(atlas)
    local info = C_Texture.GetAtlasInfo(atlas)
    local file = info and (info.file or info.filename)
    if not (file and info.width and info.height and info.width > 0 and info.height > 0) then return nil end
    return info, file
end

-- Draws the parchment on frame, scaled to the page's height and cut off on
-- the right. Without the art the journal keeps its usual look.
local function BuildJournalPage(frame)
    local info, file = GetAtlasFile(JOURNAL.page)
    if not info then return end
    local crop = JOURNAL.crop
    local w = WINDOW_W - JOURNAL.left - BACKGROUND_INSETS.right
    local h = WINDOW_H - JOURNAL.top - BACKGROUND_INSETS.bottom
    local right = crop.left + w * (crop.bottom - crop.top) / h   -- the same scale across as down
    if right > info.width then return end
    local u = (info.rightTexCoord - info.leftTexCoord) / info.width
    local v = (info.bottomTexCoord - info.topTexCoord) / info.height

    local page = frame:CreateTexture(nil, "BACKGROUND", nil, 2)
    page:SetPoint("TOPLEFT", frame, "TOPLEFT", JOURNAL.left, -JOURNAL.top)
    page:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -BACKGROUND_INSETS.right, BACKGROUND_INSETS.bottom)
    page:SetTexture(file)
    page:SetTexCoord(info.leftTexCoord + crop.left * u, info.leftTexCoord + right * u,
        info.topTexCoord + crop.top * v, info.topTexCoord + crop.bottom * v)
    page:Hide()
    journal.page = page

    local color = SPELLBOOK_FONT_COLOR
    window.JournalInk = (color and color.GetRGB) and { color:GetRGB() } or JOURNAL.ink
end

-- Puts divider number index under a chapter title, as wide as the title's
-- line plus the curl's indent (at most the art's own width): the curl and the
-- fading end keep their size and the solid line between them gets shorter.
-- Returns nil where there's no journal page.
function window.PlaceJournalDivider(index, title, width)
    if not journal.page then return nil end
    local divider = journal.dividers[index]
    if not divider then
        local info, file = GetAtlasFile(JOURNAL.divider)
        if not info then return nil end
        if not journal.layer then
            -- Dividers scroll with the text and hide with the page.
            local child = SM.GetDetailChild()
            journal.layer = CreateFrame("Frame", nil, child)
            journal.layer:SetAllPoints(child)
            UpdateJournalPage()
        end
        divider = CreateFrame("Frame", nil, journal.layer)
        divider:SetHeight(info.height)
        divider.info = info
        divider.head = divider:CreateTexture(nil, "ARTWORK")
        divider.head:SetPoint("TOPLEFT")
        divider.head:SetPoint("BOTTOMLEFT")
        divider.head:SetTexture(file)
        divider.tail = divider:CreateTexture(nil, "ARTWORK")
        divider.tail:SetPoint("TOPRIGHT")
        divider.tail:SetPoint("BOTTOMRIGHT")
        divider.tail:SetTexture(file)
        journal.dividers[index] = divider
    end

    local info = divider.info
    width = math.min(width + JOURNAL.dividerIndent, info.width)
    local join = math.min(JOURNAL.dividerJoin, width / 2)
    local u = (info.rightTexCoord - info.leftTexCoord) / info.width
    divider:SetWidth(width)
    divider.head:SetWidth(join)
    divider.head:SetTexCoord(info.leftTexCoord, info.leftTexCoord + join * u, info.topTexCoord, info.bottomTexCoord)
    divider.tail:SetWidth(width - join)
    divider.tail:SetTexCoord(info.rightTexCoord - (width - join) * u, info.rightTexCoord, info.topTexCoord, info.bottomTexCoord)
    divider:ClearAllPoints()
    divider:SetPoint("TOPLEFT", title, "BOTTOMLEFT", -JOURNAL.dividerIndent, -3)
    divider:Show()
    return divider
end

-- Hides the dividers from number first on.
function window.HideJournalDividers(first)
    for i = first, #journal.dividers do journal.dividers[i]:Hide() end
end

-- ── Guided or Explorer ──────────────────────────────────────────────────────
-- The start page ends with the choice of how quest cards show a story:
-- Guided shows every quest, Explorer only the ones the player has reached
-- (QuestCard.lua). Two buttons under the intro text, the chosen one lit;
-- each says what it does in its tooltip.

local MODE_CHOICE = { gap = 24, buttonW = 150, buttonH = 26, spacing = 12 }
local MODES = {
    { key = "guided", label = "Quest Mode Guided", text = "Quest Mode Guided Text" },
    { key = "explorer", label = "Quest Mode Explorer", text = "Quest Mode Explorer Text" },
}
local modeChoice = { shown = false, buttons = {} }

local function RefreshModeChoice()
    local current = SM.GetQuestCardMode()
    for _, mode in ipairs(MODES) do
        local button = modeChoice.buttons[mode.key]
        if mode.key == current then button:LockHighlight() else button:UnlockHighlight() end
    end
end

local function ShowModeTooltip(button)
    local tooltip = SM.Tooltip or GameTooltip
    local body = SM.UIColors.body
    -- Guided's opens to the left, Explorer's to the right: off the other button.
    tooltip:SetOwner(button, button.mode.key == "guided" and "ANCHOR_LEFT" or "ANCHOR_RIGHT")
    tooltip:ClearLines()
    tooltip:AddLine(L[button.mode.label], 1, 1, 1)
    tooltip:AddLine(L[button.mode.text], body[1], body[2], body[3], true)
    tooltip:Show()
end

local function CreateModeChoice(parent)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetHeight(MODE_CHOICE.buttonH)
    for i, mode in ipairs(MODES) do
        local button = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
        button:SetSize(MODE_CHOICE.buttonW, MODE_CHOICE.buttonH)
        button:SetText(L[mode.label])
        button.mode = mode
        if i == 1 then
            button:SetPoint("TOPRIGHT", frame, "TOP", -MODE_CHOICE.spacing / 2, 0)
        else
            button:SetPoint("TOPLEFT", frame, "TOP", MODE_CHOICE.spacing / 2, 0)
        end
        button:SetScript("OnClick", function()
            if SM.GetQuestCardMode() == mode.key then return end
            PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
            SM.SetQuestCardMode(mode.key)
            RefreshModeChoice()
        end)
        button:SetScript("OnEnter", ShowModeTooltip)
        button:SetScript("OnLeave", function() (SM.Tooltip or GameTooltip):Hide() end)
        modeChoice.buttons[mode.key] = button
    end
    modeChoice.frame = frame
end

-- Puts the choice under anchor (the intro text) and returns the height it
-- adds to the page.
function window.PlaceQuestModeChoice(anchor)
    if not modeChoice.frame then CreateModeChoice(anchor:GetParent()) end
    local frame = modeChoice.frame
    frame:ClearAllPoints()
    frame:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -MODE_CHOICE.gap)
    frame:SetPoint("TOPRIGHT", anchor, "BOTTOMRIGHT", 0, -MODE_CHOICE.gap)
    RefreshModeChoice()
    frame:SetShown(modeChoice.shown)
    return MODE_CHOICE.gap + MODE_CHOICE.buttonH
end

-- Shows the choice with the start page and hides it with it.
function window.ShowQuestModeChoice(shown)
    modeChoice.shown = shown
    if modeChoice.frame then modeChoice.frame:SetShown(shown) end
end

local BuildProgressSummary  -- defined with the story progress below

-- Builds the shell on frame (created with PortraitFrameTemplate) and returns
-- where Story Mode's sections go, relative to layout.anchor (the window).
function window.Build(frame)
    frame:SetSize(WINDOW_W, WINDOW_H)
    frame:SetTitle(L["Addon Name"])
    frame:SetPortraitToAsset(SM.StoryModeAvatarTexture)
    if frame.CloseButton then
        frame.CloseButton:SetScript("OnClick", function() frame:Hide() end)
    end

    -- The art is drawn on the window itself, so the story sections (child
    -- frames) always sit on top of it. The sections anchor to the window,
    -- never to a texture: the Begin Story button has a secure overlay, and
    -- WoW refuses to anchor a protected frame through a texture.
    local background = frame:CreateTexture(nil, "BACKGROUND", nil, 1)
    background:SetPoint("TOPLEFT", frame, "TOPLEFT", BACKGROUND_INSETS.left, -BACKGROUND_INSETS.top)
    background:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -BACKGROUND_INSETS.right, BACKGROUND_INSETS.bottom)
    SetAtlasCover(background, ATLAS.background,
        WINDOW_W - BACKGROUND_INSETS.left - BACKGROUND_INSETS.right,
        WINDOW_H - BACKGROUND_INSETS.top - BACKGROUND_INSETS.bottom)

    local divider = CreateFrame("Frame", nil, frame)
    divider:SetSize(DIVIDER.w, DIVIDER.h)
    divider:SetPoint("TOPLEFT", frame, "TOPLEFT", DIVIDER.x, -DIVIDER.top)
    divider:SetFrameLevel(OVER_FRAME_LEVEL)
    local dividerArt = divider:CreateTexture(nil, "BACKGROUND")
    dividerArt:SetAllPoints()
    dividerArt:SetAtlas(ATLAS.divider)

    BuildProgressSummary(frame)
    BuildJournalPage(frame)

    local detailX = WINDOW_W - DETAIL.right - DETAIL.w
    local detailTop = WINDOW_H - DETAIL.bottom - DETAIL.h
    return {
        anchor = frame,
        listX = LIST.x,
        listTop = LIST.top,
        listW = DIVIDER.x - LIST.x,
        listH = WINDOW_H - LIST.top - LIST.bottom,
        detailX = detailX,
        detailTop = detailTop,
        detailW = DETAIL.w,
        detailH = DETAIL.h,
        headerH = 0,
    }
end

-- ── Detail tabs ─────────────────────────────────────────────────────────────
-- Adventure, Progress and Journal are side tabs on the window's right edge,
-- like the Legacy window's tabs (LegacySystemTabTemplate), with the character
-- window's own tab icons: its PvP tab for Adventure (by faction, as the
-- character window does), Reputation for Progress and Statistics for Journal.

local function AdventureIcon()
    return UnitFactionGroup("player") == "Alliance"
        and "Interface/ICONS/INV_SideTab_Honor_Alliance_c60"
        or "Interface/ICONS/INV_SideTab_Honor_Horde_c60"
end

local DETAIL_TABS = {
    { key = "story", label = "Tab Adventure", icon = AdventureIcon },
    { key = "progress", label = "Tab Progress", icon = "Interface/ICONS/INV_SideTab_Reputation2_c60" },
    { key = "journal", label = "Tab Journal", icon = "Interface/ICONS/INV_SideTab_Stats_c60" },
    { key = "scarlet", label = "Tab Scarlet Crusader", icon = "Interface\\Icons\\Spell_Holy_SealOfWrath" },
}

local function SetTabIcon(tab, icon)
    tab.Icon:SetTexture(type(icon) == "function" and icon() or icon)
end
local detailTabs = {}

function window.AddDetailTabs(frame, onSelect)
    local previous
    for _, info in ipairs(DETAIL_TABS) do
        local tab = CreateFrame("Frame", nil, frame, "LargeSideTabButtonTemplate")
        tab:EnableMouse(true)
        tab.tooltipText = L[info.label]
        tab.iconSource = info.icon
        SetTabIcon(tab, info.icon)
        tab:SetFillToInterior(true)
        tab:SetCustomOnMouseUpHandler(function(_, button, upInside)
            if button == "LeftButton" and upInside then onSelect(info.key) end
        end)
        if previous then
            tab:SetPoint("TOPLEFT", previous, "BOTTOMLEFT", 0, -2)
        else
            tab:SetPoint("TOPLEFT", frame, "TOPRIGHT", 0, -60)
        end
        tab:SetChecked(false)
        tab:Hide()
        detailTabs[info.key] = tab
        previous = tab
    end
end

function window.SetDetailTab(key)
    for tabKey, tab in pairs(detailTabs) do
        tab:SetChecked(tabKey == key)
    end
    journal.tab = key
    UpdateJournalPage()
end

-- ── Chapter track ───────────────────────────────────────────────────────────
-- Chapters are square portraits in the Legacy icon frame instead of circles:
-- green when the chapter is done, brown while it's under way, grey before.
-- The selected chapter is always in full colour, with no arrow under it.
-- Between chapters sits the Legacy tree's arrow, so the track spaces its
-- chapters wider than usual to fit it.

window.ChapterArrowGap = 40

local CHAPTER_FRAME = {
    done = "Legacy-Tree-Frame-icon-frame-Green",
    open = "Legacy-Tree-Frame-icon-frame",
    later = "Legacy-Tree-Frame-icon-frame-disable",
}
local ICON_MASK = "UI-Frame-IconMask"

function window.DecorateChapterNode(node)
    node.isLegacyNode = true
    -- The frame is drawn 60 around a 50 icon in Legacy; keep that ratio.
    local inset = math.floor((node.portrait:GetWidth() * 60 / 50 - node.portrait:GetWidth()) / 2 + 0.5)
    node.legacyFrame = node:CreateTexture(nil, "OVERLAY", nil, 4)
    node.legacyFrame:SetPoint("TOPLEFT", node.portrait, "TOPLEFT", -inset, inset)
    node.legacyFrame:SetPoint("BOTTOMRIGHT", node.portrait, "BOTTOMRIGHT", inset, -inset)
end

function window.StyleChapterNode(node, complete, active, selected)
    node.ring:Hide()
    node.squareBorder:Hide()
    SM.SetSimpleBorder(node.portraitBorder, 0, 0, 0, 0)
    node.checkmark:Hide()
    for _, mask in ipairs({ node.portraitMask, node.glowMask, node.hoverGlowMask }) do
        if mask then mask:SetAtlas(ICON_MASK) end
    end

    local frameKey = complete and "done" or ((active or selected) and "open") or "later"
    node.legacyFrame:SetAtlas(CHAPTER_FRAME[frameKey])
    local colored = complete or active or selected
    node.isDimmed = not colored
    node.portrait:SetDesaturation(colored and 0 or 0.8)
    local shade = colored and 1 or 0.7
    node.portrait:SetVertexColor(shade, shade, shade)
    if node.downArrow then node.downArrow:Hide() end
end

-- The Legacy tree's arrow (LegacyTreeTraitEdgeArrowTemplate: the talent
-- tree's edge at 1.25 scale): a line from one chapter to the next and a head
-- pointing at it, yellow once the chapter before is done and grey before.
-- The head's art points down, so it turns a quarter to point right, and it
-- sits just outside the next chapter's frame, as on the tree.
local ARROW = {
    line = { done = "talents-arrow-line-yellow", open = "talents-arrow-line-gray" },
    head = { done = "talents-arrow-head-yellow", open = "talents-arrow-head-gray" },
    scale = 1.25,
    thickness = 6,
    headW = 28, headH = 24,
    tip = 5.5,   -- the head's point, from the art's centre
}

function window.CreateChapterArrow(parent)
    local arrow = CreateFrame("Frame", nil, parent)
    arrow:SetAllPoints(parent)
    -- Under the chapters, so the line starts beneath the first one.
    arrow:SetFrameLevel(parent:GetFrameLevel())
    arrow.isLegacyArrow = true
    arrow.line = arrow:CreateLine(nil, "OVERLAY", nil, -2)
    arrow.line:SetThickness(ARROW.thickness * ARROW.scale)
    arrow.head = arrow:CreateTexture(nil, "OVERLAY", nil, 1)
    arrow.head:SetSize(ARROW.headW * ARROW.scale, ARROW.headH * ARROW.scale)
    arrow.head:SetRotation(math.pi / 2)
    return arrow
end

function window.PlaceChapterArrow(arrow, fromNode, toNode, done)
    local key = done and "done" or "open"
    window.SetAtlas(arrow.line, ARROW.line[key])
    window.SetAtlas(arrow.head, ARROW.head[key])
    local frameHalf = toNode.portrait:GetWidth() * 60 / 50 / 2
    local headX = -(frameHalf + ARROW.tip * ARROW.scale + 1)
    arrow.line:SetStartPoint("CENTER", fromNode.portrait)
    arrow.line:SetEndPoint("CENTER", toNode.portrait, headX, 0)
    arrow.head:ClearAllPoints()
    arrow.head:SetPoint("CENTER", toNode.portrait, "CENTER", headX, 0)
    arrow:Show()
end

-- ── Story progress ──────────────────────────────────────────────────────────
-- The header shows the selected story's progress the way the Legacy challenge
-- page shows its points: the shield counts finished chapters, the bar fills
-- with finished quests.

local progress

function BuildProgressSummary(frame)
    local summary = CreateFrame("Frame", nil, frame)
    summary:SetSize(SUMMARY.w, SUMMARY.h)
    summary:SetPoint("TOPLEFT", frame, "TOPLEFT", SUMMARY.x, -SUMMARY.top)

    local barBackground = summary:CreateTexture(nil, "ARTWORK")
    barBackground:SetAtlas(ATLAS.barBackground)
    barBackground:SetHeight(16)
    barBackground:SetPoint("LEFT", summary, "LEFT", -6, -3)
    barBackground:SetPoint("RIGHT", summary, "RIGHT", 0, -3)

    local bar = CreateFrame("StatusBar", nil, summary)
    bar:SetPoint("TOPLEFT", barBackground, "TOPLEFT", 0, 0)
    bar:SetPoint("BOTTOMRIGHT", barBackground, "BOTTOMRIGHT", 0, 3)
    local fill = bar:CreateTexture(nil, "ARTWORK")
    fill:SetAtlas(ATLAS.barFill)
    bar:SetStatusBarTexture(fill)
    bar:SetMinMaxValues(0, 1)
    local barFrame = bar:CreateTexture(nil, "OVERLAY")
    barFrame:SetAtlas(ATLAS.barFrame)
    barFrame:SetPoint("TOPLEFT", bar, "TOPLEFT", -8, 7)
    barFrame:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", 8, -10)
    local text = bar:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
    text:SetPoint("CENTER")

    -- Over the title bar's border, as in Legacy (LegacyPointShield, level 800).
    local shield = CreateFrame("Frame", nil, summary)
    shield:SetSize(46, 64)
    shield:SetFrameLevel(OVER_FRAME_LEVEL)
    shield:SetPoint("RIGHT", summary, "LEFT", 14, 4)
    local shieldIcon = shield:CreateTexture(nil, "BACKGROUND")
    shieldIcon:SetAtlas(ATLAS.shield)
    shieldIcon:SetSize(46, 66)
    shieldIcon:SetPoint("TOPRIGHT")
    local points = shield:CreateFontString(nil, "OVERLAY", "GameFontNormalMed3")
    points:SetSize(42, 16)
    points:SetPoint("TOPRIGHT", shield, "TOPRIGHT", -2, -31)
    points:SetTextColor(1, 1, 1)

    summary:Hide()
    progress = { frame = summary, bar = bar, text = text, points = points }
end

local function ShowProgress(data)
    if not progress then return end
    if not data then
        progress.frame:Hide()
        return
    end
    local chapters = SM.GetAllChapters(data)
    local chaptersDone = 0
    for _, chapter in ipairs(chapters) do
        local done, total = SM.GetChapterProgress(chapter)
        if total > 0 and done == total then chaptersDone = chaptersDone + 1 end
    end
    local questsDone, questsTotal = SM.GetCampaignProgress(data)
    progress.points:SetText(chaptersDone)
    progress.bar:SetValue(questsTotal > 0 and questsDone / questsTotal or 0)
    progress.text:SetText(string.format(L["Progress Summary Format"], chaptersDone, #chapters, questsDone, questsTotal))
    progress.frame:Show()
end

-- Shows the tabs and progress for a story, or hides them on the start page.
function window.ShowStory(data, showScarletTab)
    for key, tab in pairs(detailTabs) do
        tab:SetShown(data ~= nil and (key ~= "scarlet" or showScarletTab == true))
        -- The faction icon is only known once the character is in the world.
        if data and type(tab.iconSource) == "function" then SetTabIcon(tab, tab.iconSource) end
    end
    ShowProgress(data)
    journal.story = data ~= nil
    UpdateJournalPage()
end

-- Opens the window where the talent window opens, until it's dragged
-- somewhere else. Called once StoryMode.lua has set the window's scripts,
-- since SetScript drops earlier hooks.
function window.Attach(frame)
    local moved = false
    frame:HookScript("OnDragStop", function() moved = true end)
    frame:HookScript("OnShow", function(self)
        if not moved then PlaceLikeTalentWindow(self) end
    end)
    PlaceLikeTalentWindow(frame)
end

-- Creates the window. If anything in it fails, the Forever window turns
-- itself off, Story Mode builds its usual window instead, and the error goes
-- to chat so it can be fixed.
function window.Create(name)
    local created, frame = pcall(CreateFrame, "Frame", name, UIParent, "PortraitFrameTemplate")
    local built, layout = false, frame
    if created then
        built, layout = pcall(window.Build, frame)
        if not built then frame:Hide() end
    end
    if created and built then return frame, layout end

    SM.ForeverWindow = nil
    C_Timer.After(3, function()
        print("|cffffd200Story Mode:|r the WoW Forever window failed, using the usual one. " .. tostring(layout))
    end)
    return nil
end
