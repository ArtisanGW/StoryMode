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

-- LegacySystemFrame and its LegacyChallengesPageTemplate.
local WINDOW_W, WINDOW_H = 920, 575
local BACKGROUND_INSETS = { left = 1, top = 10, right = 2, bottom = 4 }
local LIST = { x = 6, top = 80, w = 330, bottom = 8 }          -- CategoryList
local DETAIL = { right = 24, bottom = 8, w = 560, h = 490 }      -- DetailPane
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
end

-- ── Chapter track ───────────────────────────────────────────────────────────
-- Chapters are square portraits in the Legacy icon frame instead of circles:
-- green when the chapter is done, brown while it's under way, grey before.
-- The selected chapter is always in full colour.

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
