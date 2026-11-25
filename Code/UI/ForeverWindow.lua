local addonName, SM = ...
local L = SM.L

-- =============================================================================
-- WoW Forever window
--
-- On WoW Forever the Story Mode window is the Legacy window's challenge page:
-- Blizzard's PortraitFrameTemplate shell at the Legacy window's size, opened
-- where the Legacy window opens, with the Legacy background, divider and
-- progress bar, side tabs, and cards for quests. Every size and offset is
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
local SUMMARY = { top = 25, w = 520, h = 36 }                    -- LegacyChallengePointSummary
-- Legacy puts its summary at x 280, with its points shield left of the bar.
-- Ours has no shield and centres the bar under the window title, which sits
-- between the portrait and the close button (PortraitFrameTemplate's title
-- runs from 58 to 24 short of the edges); the bar starts 6 left of the summary.
SUMMARY.x = math.floor(WINDOW_W / 2 + (58 - 24) / 2 - (SUMMARY.w - 6) / 2 + 0.5)
local OVER_FRAME_LEVEL = 800                                     -- the divider sits over the frame's border
local TOP_OFFSET = -116                                          -- Blizzard's UI panel TOP_OFFSET
local LEFT_OFFSET = 16                                           -- its LEFT_OFFSET
local BOTTOM_CLAMP = 140                                         -- and its bottom clamp
local LEGACY_XOFFSET = 35                                        -- Blizzard_LegacySystemRegistration.lua

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

local function PanelLayoutAttribute(name, fallback)
    if GetUIPanelLayoutAttribute then
        local ok, value = pcall(GetUIPanelLayoutAttribute, name)
        if ok and type(value) == "number" then return value end
    end
    return fallback
end

-- The Legacy window opens as a left-side UI panel 35 right of the panel
-- area's left edge, 116 below the top of the screen, and moves up when its
-- bottom would come within 140 of the screen's bottom.
local function PlaceLikeLegacyWindow(frame)
    local yOffset = PanelLayoutAttribute("TOP_OFFSET", TOP_OFFSET)
    local xOffset = PanelLayoutAttribute("LEFT_OFFSET", LEFT_OFFSET) + LEGACY_XOFFSET
    local top = UIParent:GetTop()
    if top then
        local bottom = top + yOffset - frame:GetHeight() * frame:GetScale()
        if bottom < BOTTOM_CLAMP then yOffset = yOffset + (BOTTOM_CLAMP - bottom) end
        if yOffset > -10 then yOffset = -10 end
    end
    frame:ClearAllPoints()
    frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", xOffset / frame:GetScale(), yOffset / frame:GetScale())
end

-- ── Journal page ────────────────────────────────────────────────────────────
-- The Journal tab is the right-hand page of Forever's open spellbook. It
-- covers the detail side, from the vertical divider to the frame's right
-- border and from under the header's gold line to the bottom border, scaled
-- to fit its whole height, never stretched. A sliver of the book's dark cover
-- shows above, below and right of it, so its top, bottom and right edges read
-- as they do in the spellbook. On the left is the book's binding: the page's
-- own inner edge with its gutter shadow. The page is wider than the space, so
-- the rest of it starts further in, and the gutter's last stretch fades into
-- it so no step shows.
-- Each chapter title gets the spellbook's divider, and the text the
-- spellbook's ink. The journal turns its pages with the spellbook's paging
-- control (JournalTab.lua).

local JOURNAL = {
    page = "spellbook-Page-Right-C60",              -- 810 x 682, the book's cover around the parchment
    crop = { right = 810, top = 54, bottom = 682 }, -- the parchment and its edges (top 61, bottom 668, right 790), with a sliver of cover
    binding = { gutter = 40, fade = 40 },           -- in the art: the page's inner edge, and its fade into the rest of the page
    pager = { right = 40, bottom = 12 },            -- the paging control, from the page's bottom right
    left = 338, top = 78,                           -- right of the vertical divider, under the gold line
    divider = "spellbook-divider",                  -- 657 x 11: a curl on the left, fading out on the right
    dividerJoin = 120,                              -- a shorter divider leaves out a piece of its solid line from here
    dividerIndent = 20,                             -- the curl starts this far left of the title
    ink = { 0.180, 0.106, 0.059 },                  -- SPELLBOOK_FONT_COLOR
}

local journal = { dividers = {}, pieces = {} }

-- The page shows while a story is open on its Journal tab.
-- The start page is drawn on it too (window.ShowStartPage), without the
-- paging control.
local function UpdateJournalPage()
    local onJournal = journal.tab == "journal" and journal.story == true
    local shown = onJournal or journal.start == true
    if journal.page then journal.page:SetShown(shown) end
    for _, piece in ipairs(journal.pieces) do piece:SetShown(shown) end
    if journal.layer then journal.layer:SetShown(shown) end
    if journal.pager then journal.pager:SetShown(onJournal) end
end

local function GetAtlasFile(atlas)
    local info = C_Texture.GetAtlasInfo(atlas)
    local file = info and (info.file or info.filename)
    if not (file and info.width and info.height and info.width > 0 and info.height > 0) then return nil end
    return info, file
end

-- A texture on frame showing columns from x1 to x2 of the atlas (in its own
-- pixels, rows crop.top to crop.bottom), x pixels right of the page's left
-- edge and w wide; w nil runs it to the frame's right border.
local function JournalPiece(frame, sublevel, info, file, x1, x2, x, w)
    local crop = JOURNAL.crop
    local u = (info.rightTexCoord - info.leftTexCoord) / info.width
    local v = (info.bottomTexCoord - info.topTexCoord) / info.height
    local piece = frame:CreateTexture(nil, "BACKGROUND", nil, sublevel)
    piece:SetPoint("TOPLEFT", frame, "TOPLEFT", JOURNAL.left + x, -JOURNAL.top)
    if w then
        piece:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", JOURNAL.left + x, BACKGROUND_INSETS.bottom)
        piece:SetWidth(w)
    else
        piece:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -BACKGROUND_INSETS.right, BACKGROUND_INSETS.bottom)
    end
    piece:SetTexture(file)
    piece:SetTexCoord(info.leftTexCoord + x1 * u, info.leftTexCoord + x2 * u,
        info.topTexCoord + crop.top * v, info.topTexCoord + crop.bottom * v)
    piece:Hide()
    return piece
end

-- Draws the page on frame. Without the art the journal keeps its usual look.
local function BuildJournalPage(frame)
    local info, file = GetAtlasFile(JOURNAL.page)
    if not info then return end
    local crop, binding = JOURNAL.crop, JOURNAL.binding
    local w = WINDOW_W - JOURNAL.left - BACKGROUND_INSETS.right
    local h = WINDOW_H - JOURNAL.top - BACKGROUND_INSETS.bottom
    local scale = h / (crop.bottom - crop.top)     -- screen pixels to one of the art's
    local right = math.min(crop.right, info.width)

    local gutterW = math.floor(binding.gutter * scale + 0.5)
    local fadeW = math.floor(binding.fade * scale + 0.5)
    local x = gutterW                              -- where the rest of the page starts
    local restLeft = right - (w - x) / scale
    if restLeft < binding.gutter + binding.fade then return end

    -- The rest of the page, to its right edge. The paging control anchors to it.
    journal.page = JournalPiece(frame, 2, info, file, restLeft, right, x)
    table.insert(journal.pieces, JournalPiece(frame, 2, info, file, 0, binding.gutter, 0, gutterW))
    -- The gutter's last stretch over the page's start, fading out.
    if CreateColor then
        local fade = JournalPiece(frame, 3, info, file, binding.gutter, binding.gutter + binding.fade, x, fadeW)
        fade:SetGradient("HORIZONTAL", CreateColor(1, 1, 1, 1), CreateColor(1, 1, 1, 0))
        table.insert(journal.pieces, fade)
    end

    local color = SPELLBOOK_FONT_COLOR
    window.JournalInk = (color and color.GetRGB) and { color:GetRGB() } or JOURNAL.ink
end

-- The frame over the journal's text that shows and hides with the page: the
-- dividers and the text of a chapter that runs on to the next page live on
-- it. nil where there's no journal page.
function window.GetJournalLayer()
    if not journal.page then return nil end
    if not journal.layer then
        local child = SM.GetDetailChild()
        journal.layer = CreateFrame("Frame", nil, child)
        journal.layer:SetAllPoints(child)
        UpdateJournalPage()
    end
    return journal.layer
end

-- The spellbook's paging control ("Page 1/2" and its arrows) at the page's
-- bottom right, made once on parent; host:OnPageChanged() runs when it
-- turns. nil where there's no journal page or no paging control.
function window.GetJournalPager(parent, host)
    if not journal.page then return nil end
    if journal.pager then return journal.pager end
    if not (C_XMLUtil and C_XMLUtil.GetTemplateInfo and C_XMLUtil.GetTemplateInfo("PagingControlsHorizontalTemplate")) then
        return nil
    end
    local pager = CreateFrame("Frame", nil, parent, "PagingControlsHorizontalTemplate")
    pager:SetPoint("BOTTOMRIGHT", journal.page, "BOTTOMRIGHT", -JOURNAL.pager.right, JOURNAL.pager.bottom)
    pager:SetFrameLevel(parent:GetFrameLevel() + 20)
    -- As the spellbook sets it up (Blizzard_SpellBookFrame.xml).
    pager.spacing = 8
    pager.hideWhenSinglePage = true
    if SOUNDKIT then
        pager.prevPageSound = SOUNDKIT.IG_ABILITY_PAGE_TURN
        pager.nextPageSound = SOUNDKIT.IG_ABILITY_PAGE_TURN
    end
    pager.PageText:SetFontObject(SystemFont_Med3 or GameFontHighlight)
    local ink = window.JournalInk or JOURNAL.ink
    pager.PageText:SetTextColor(ink[1], ink[2], ink[3])
    pager:SetOverridePagedContentFrame(host)
    pager:UpdateControls()
    journal.pager = pager
    UpdateJournalPage()
    return pager
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
        -- Dividers move with the text and hide with the page.
        divider = CreateFrame("Frame", nil, window.GetJournalLayer())
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

-- ── Red buttons ─────────────────────────────────────────────────────────────
-- Buttons look like the Friends window's Add New Friend button: Forever draws
-- that with the red three-slice button art (128-RedButton, its c60 brass
-- frame), which SharedButtonSmallTemplate uses, at the size it shows.
local RED_BUTTON = { template = "SharedButtonSmallTemplate", fallback = "UIPanelButtonTemplate", height = 26 }

function window.CreateRedButton(parent, width)
    local template = C_XMLUtil and C_XMLUtil.GetTemplateInfo and C_XMLUtil.GetTemplateInfo(RED_BUTTON.template)
        and RED_BUTTON.template or RED_BUTTON.fallback
    local button = CreateFrame("Button", nil, parent, template)
    button:SetSize(width, RED_BUTTON.height)
    return button
end
window.RedButtonHeight = RED_BUTTON.height

-- ── Start page ──────────────────────────────────────────────────────────────
-- The start page is two pages of the journal: the spellbook page the Journal
-- tab uses, turned with the same paging control (or the mouse wheel).
-- Page 1 is a letter from Story Mode's author, laid out like a journal page:
-- a header and subline, the greeting over the spellbook's divider like a
-- chapter's title, the letter ending in its closing, and a red wax seal with
-- the Story Mode rune pressed into the page's bottom left corner, across from
-- the page number and not quite straight, all in the spellbook's ink. The
-- seal warms under the mouse, and a click on it opens hidden pages turned by
-- the same paging control: the credits, centred like a film's, then each
-- version's release notes, newest first, a page each (more where they run
-- long; each L["Release Notes <version>"], made from CHANGELOG.md by
-- _Dev/tools/release-notes.mjs). Back from the credits is the letter.
-- Page 2 has the settings, laid out like DialogueUI's: under a Settings
-- heading with the spellbook's divider, a list on the left two thirds and,
-- right of a rule (the divider's line turned upright, fading out at both
-- ends) what the setting under the mouse does, and in the bottom right
-- corner the Ruins of Lordaeron's graveyard gate engraved in brown ink, as
-- DialogueUI's settings have Dalaran. Each row sits on the spellbook item's
-- backplate, faint until the mouse is on it (the spellbook's own hover), and
-- the last row hovered keeps it and its explanation. A switch is
-- DialogueUI's: the value between two arrows, and under it a bar with a part
-- for each choice, each a thin inked rectangle, the chosen one in the
-- dropdown's brown. A list of choices is a dropdown: the same backplate,
-- darkened, with the value and a brushed chevron. A yes or no is a box
-- inked by hand like DialogueUI's: an empty frame when off, dark brown with
-- a tan check when on (Art/Decor/settings_controls, drawn by
-- _Dev/art/settings-controls.py).

local START = {
    -- The Journal tab's page spacing (PAGE in JournalTab.lua): the header 30
    -- from the top, the subline 4 under it, and the text 22 under a line with
    -- a divider (the divider 3 under the line, the text 8 under the divider).
    titleTop = 30, subtitleGap = 4, headerGap = 18, textGap = 22, textSpacing = 4,
    -- The seal: its middle this far right of the letter's left edge and this
    -- far up from the page's bottom, turned a little. (Without the paging
    -- control it sits by the closing instead: byX, byY from the letter's end.)
    sealGlow = { color = { 1, 0.72, 0.48 }, alpha = 0.35, speed = 3 }, -- warm light under the mouse, faded in at speed a second
    -- The credits: under the title and subline, a role in faint ink, its
    -- names in a larger hand, and space before the next role.
    creditsTop = 26, roleGap = 4, nameGap = 2, creditGap = 18, roleAlpha = 0.7, contactH = 18,
    -- The release notes: their line spacing, the room kept above the page's
    -- bottom for the paging control, and the page's height before layout.
    notesSpacing = 3, notesBottom = 44, pageFallback = 490,
    -- A bullet's text hangs in a column this far in, so its wrapped lines
    -- line up under its first; a little space between bullets and more
    -- between sections.
    bulletIndent = 14, bulletGap = 4, sectionGap = 14,
    seal = { file = "Interface\\AddOns\\StoryMode\\Art\\Decor\\wax_seal", size = 84, x = 64, y = 72, byX = 56, byY = -4, turn = -0.14 }, -- _Dev/art/wax-seal.py
    headingTop = 30, splitGap = 16, listShare = 2 / 3, columnGap = 20, splitH = 280,
    rowH = 38, rowInset = 10,
    backplate = "spellbook-item-backplate", backplateIdle = 0.25, backplateHover = 1, -- SpellBookItem's
    switchW = 120, arrowSize = 16, segmentGap = 4, segmentH = 3, segmentDim = 0.22, arrowOff = 0.25,
    -- The dropdown: the backplate darkened, in layers (it's a faint wash
    -- alone), warmer under the mouse; its value in a parchment light.
    dropdownW = 120, dropdownH = 26, dropdownLayers = 5,
    dropdownTint = { 0.30, 0.18, 0.12 }, dropdownHover = { 0.36, 0.22, 0.14 },
    backplateColor = { 1, 0.918, 0.698 },              -- the backplate's own colour, which the tint darkens
    light = { 0.96, 0.89, 0.76 },
    -- The inked controls: cells of a 128 x 256 texture, a box's shown at
    -- cellSize (the box inside it is 22 across at that size), the check
    -- smaller so it sits inside the box, and the inked rectangle for the switch.
    controls = "Interface\\AddOns\\StoryMode\\Art\\Decor\\settings_controls", cellSize = 32, checkSize = 22, chevronSize = 22,
    cells = {
        boxOff = { 0, 0.5, 0, 0.25 }, boxOn = { 0.5, 1, 0, 0.25 },
        check = { 0, 0.5, 0.25, 0.5 }, chevron = { 0.5, 1, 0.25, 0.5 },
        line = { 0, 1, 0.5, 0.625 },
    },
    ruleW = 2, ruleAlpha = 0.5, ruleFade = 60,          -- the ink rule, where the divider's art is missing
    ruleSlice = { 140, 300 },                           -- columns of the divider's art where its line runs solid
    ruleCore = 2,                                       -- the line's middle, from the art's top (its shadow is below)
    -- White ink (made by _Dev/art/engrave-lordaeron.py), tinted brown: darker
    -- than DialogueUI's (173, 114, 65), which is the spellbook page's own colour.
    decor = { file = "Interface\\AddOns\\StoryMode\\Art\\Decor\\lordaeron", size = 240, right = 10, bottom = 26,
        color = { 112 / 255, 64 / 255, 30 / 255 }, alpha = 0.8 },
    arrows = { left = "uitools-icon-chevron-left", right = "uitools-icon-chevron-right" },
}

-- The credits, in order: a role (a locale key) and its names, which stay as
-- they are; contact puts an address to copy under the names.
local CREDITS = {
    { role = "Credits Author", names = { "Rafael Polutta" } },
    { role = "Credits Data", names = { "Wowhead", "wago.tools" } },
    { role = "Credits Inspiration", names = { "Peterodox" } },   -- DialogueUI's author
    { role = "Credits Art", names = { "Blizzard Entertainment" } },
    { role = "Credits Shoutout", names = { "Carpenter" } },     -- the author's other addon
    { role = "Credits Feedback", names = {}, contact = "contact@hejrafa.com" },
}

local function QuestModeExplanation()
    return L["Quest Mode Guided"] .. "\n" .. L["Quest Mode Guided Text"] .. "\n\n"
        .. L["Quest Mode Explorer"] .. "\n" .. L["Quest Mode Explorer Text"]
end

local SETTINGS = {
    {
        label = "Setting Quest Cards", kind = "switch",
        choices = function()
            return { { value = "guided", text = L["Quest Mode Guided"] }, { value = "explorer", text = L["Quest Mode Explorer"] } }
        end,
        get = function() return SM.GetQuestCardMode() end,
        set = function(value) SM.SetQuestCardMode(value) end,
        explain = QuestModeExplanation,
    },
    {
        label = "Journal Voice Menu Title", kind = "dropdown",
        available = function() return SM.CanReadJournalAloud and SM.CanReadJournalAloud() and SM.GetJournalVoiceChoices ~= nil end,
        choices = function() return SM.GetJournalVoiceChoices() end,
        get = function() return SM.GetJournalVoice() end,
        set = function(value) SM.SetJournalVoice(value) end,
        explain = function() return L["Setting Journal Voice Text"] end,
    },
    {
        label = "Setting Minimap Button", kind = "check",
        available = function() return SM.SetMinimapButtonShown ~= nil end,
        get = function() return not (StoryModeDB and StoryModeDB.minimapButtonHidden) end,
        set = function(value) SM.SetMinimapButtonShown(value) end,
        explain = function() return L["Setting Minimap Button Text"] end,
    },
    {
        label = "Setting Story Quest Filter", kind = "check",
        available = function() return SM.SetQuestTrackerStoryFilterEnabled ~= nil end,
        get = function() return StoryModeDB and StoryModeDB.hideUnrelatedQuestTrackerQuests == true end,
        set = function(value) SM.SetQuestTrackerStoryFilterEnabled(value) end,
        explain = function() return L["Setting Story Quest Filter Text"] end,
    },
    {
        label = "Setting Green Story Quests", kind = "check",
        available = function() return SM.SetGreenStoryQuestsOnMap ~= nil end,
        get = function() return StoryModeDB and StoryModeDB.greenStoryQuestsOnMap == true end,
        set = function(value) SM.SetGreenStoryQuestsOnMap(value) end,
        explain = function() return L["Setting Green Story Quests Text"] end,
    },
}

local startPage = { shown = false, rows = {}, page = 1 }

local function Ink(alpha)
    local ink = window.JournalInk or JOURNAL.ink
    return ink[1], ink[2], ink[3], alpha or 1
end

-- The dropdown's brown: the backplate's colour under its tint.
local function DropdownInk()
    local c, t = START.backplateColor, START.dropdownTint
    return c[1] * t[1], c[2] * t[2], c[3] * t[3], 1
end

local function InkedText(parent, font)
    local text = SM.NoShadow(parent:CreateFontString(nil, "ARTWORK", font))
    text:SetTextColor(Ink())
    return text
end

local function InkedAtlas(parent, atlas, size, layer)
    local texture = parent:CreateTexture(nil, layer or "ARTWORK")
    texture:SetAtlas(atlas)
    texture:SetSize(size, size)
    texture:SetVertexColor(Ink())
    return texture
end

-- An address to copy, in the credits: it reads like the names, and a
-- click selects it all for the player to copy (WoW's text can't be
-- selected otherwise, and only Blizzard's own code may write to the
-- clipboard: CopyToClipboard is protected). Typing doesn't change it, and it lets go of the
-- keyboard once copied, or on Escape or Enter.
local function ContactBox(parent, address)
    local box = CreateFrame("EditBox", nil, parent)
    box:SetAutoFocus(false)
    box:SetFontObject(QuestFont_Large)
    SM.NoShadow(box)
    box:SetTextColor(Ink())
    box:SetJustifyH("CENTER")
    -- As tall as a name's line, so it sits the same under its role.
    local size = QuestFont_Large and select(2, QuestFont_Large:GetFont())
    box:SetHeight(size and math.ceil(size) + 2 or START.contactH)
    box:SetText(address)
    box:SetCursorPosition(0)
    local function Select(self)
        self:SetFocus()
        self:HighlightText()
    end
    box:SetScript("OnMouseUp", Select)
    box:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
    box:SetScript("OnEditFocusLost", function(self)
        self:HighlightText(0, 0)
        self:SetCursorPosition(0)
    end)
    box:SetScript("OnTextChanged", function(self, typed)
        if typed then
            self:SetText(address)
            self:HighlightText()
        end
    end)
    box:SetScript("OnKeyUp", function(self, key)
        if key == "C" and ((IsControlKeyDown and IsControlKeyDown()) or (IsMetaKeyDown and IsMetaKeyDown())) then
            self:ClearFocus()
        end
    end)
    box:SetScript("OnEscapePressed", box.ClearFocus)
    box:SetScript("OnEnterPressed", box.ClearFocus)
    box:SetScript("OnHide", box.ClearFocus)
    box:SetScript("OnEnter", function(self)
        if GameTooltip then
            GameTooltip:SetOwner(self, "ANCHOR_TOP")
            GameTooltip:SetText(L["Credits Copy Hint"]:format(IsMacClient and IsMacClient() and "Cmd+C" or "Ctrl+C"), 1, 1, 1, 1, true)
            GameTooltip:Show()
        end
    end)
    box:SetScript("OnLeave", function()
        if GameTooltip then GameTooltip:Hide() end
    end)
    return box
end

-- A texture showing one cell of the inked controls.
local function ControlCell(parent, cell, size, layer)
    local texture = parent:CreateTexture(nil, layer or "ARTWORK")
    texture:SetTexture(START.controls)
    texture:SetTexCoord(unpack(START.cells[cell]))
    texture:SetSize(size, size)
    return texture
end

-- A dropdown shows only its choice's first word ("Ava", not "Ava (Enhanced)
-- [en-US]"); its menu shows the whole name. Text with no spaces stops at a
-- bracket, as in "自动（匹配你的角色）".
local function FirstWord(text)
    text = text or ""
    local word = text:match("^%s*([^%s%(%[]+)") or text
    local cut = word:find("（", 1, true)
    if cut and cut > 1 then word = word:sub(1, cut - 1) end
    return word
end

local function ChoiceIndex(def)
    local choices, value = def.choices(), def.get()
    for i, choice in ipairs(choices) do
        if choice.value == value then return i, choices end
    end
    return 1, choices
end

-- The focused row's explanation, on the right third.
local function ShowExplanation()
    local row = startPage.focus
    if not (row and startPage.panelText) then return end
    local def = row.def
    startPage.panelText:SetText(def.explain(def.get(), row.valueText and row.valueText:GetText() or nil))
end

local function SetFocus(row)
    local old = startPage.focus
    if old and old ~= row then old.backplate:SetAlpha(START.backplateIdle) end
    startPage.focus = row
    row.backplate:SetAlpha(START.backplateHover)
    ShowExplanation()
end

local function RefreshRow(row)
    local def = row.def
    if def.kind == "check" then
        local on = def.get() == true
        row.checkmark:SetShown(on)
        row.boxArt:SetTexCoord(unpack(START.cells[on and "boxOn" or "boxOff"]))
    else
        local index, choices = ChoiceIndex(def)
        local text = choices[index] and choices[index].text or ""
        row.valueText:SetText(def.kind == "dropdown" and FirstWord(text) or text)
        if def.kind == "switch" then
            for i, segment in ipairs(row.segments) do
                if i == index then
                    segment:SetVertexColor(DropdownInk())
                else
                    segment:SetVertexColor(Ink(START.segmentDim))
                end
            end
            row.left:SetEnabled(index > 1)
            row.right:SetEnabled(index < #choices)
            row.left.icon:SetAlpha(index > 1 and 1 or START.arrowOff)
            row.right.icon:SetAlpha(index < #choices and 1 or START.arrowOff)
        end
    end
    if startPage.focus == row then ShowExplanation() end
end

local function Choose(row, value)
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
    row.def.set(value)
    RefreshRow(row)
end

-- A switch steps by delta (1 or -1); its arrows stop at the ends, a click
-- on the row goes round.
local function StepRow(row, delta, wrap)
    local index, choices = ChoiceIndex(row.def)
    local target = index + delta
    if wrap then target = (target - 1) % #choices + 1 end
    if target < 1 or target > #choices or target == index then return end
    Choose(row, choices[target].value)
end

local function CreateArrow(row, atlas, delta)
    local arrow = CreateFrame("Button", nil, row)
    arrow:SetSize(START.arrowSize + 10, START.rowH)
    arrow.icon = InkedAtlas(arrow, atlas, START.arrowSize)
    arrow.icon:SetPoint("CENTER")
    arrow:SetScript("OnEnter", function() SetFocus(row) end)
    arrow:SetScript("OnClick", function() StepRow(row, delta) end)
    return arrow
end

-- DialogueUI's switch: < value > and a bar of a part per choice.
local function BuildSwitch(row)
    row.right = CreateArrow(row, START.arrows.right, 1)
    row.right:SetPoint("RIGHT", row, "RIGHT", -2, 0)
    row.valueText = InkedText(row, "SystemFont_Med3")
    row.valueText:SetWidth(START.switchW)
    row.valueText:SetWordWrap(false)
    row.valueText:SetJustifyH("CENTER")
    row.valueText:SetPoint("RIGHT", row.right, "LEFT", 0, 2)
    row.left = CreateArrow(row, START.arrows.left, -1)
    row.left:SetPoint("RIGHT", row.valueText, "LEFT", 0, -2)
    row.segments = {}
    local count = #row.def.choices()
    local barW = START.switchW - 16
    local partW = (barW - START.segmentGap * (count - 1)) / count
    for i = 1, count do
        -- The inked rectangle, tinted in RefreshRow.
        local segment = row:CreateTexture(nil, "ARTWORK")
        segment:SetTexture(START.controls)
        segment:SetTexCoord(unpack(START.cells.line))
        segment:SetSize(partW, START.segmentH)
        segment:SetPoint("TOPLEFT", row.valueText, "BOTTOMLEFT", 8 + (i - 1) * (partW + START.segmentGap), -4)
        row.segments[i] = segment
    end
    row:SetScript("OnClick", function() StepRow(row, 1, true) end)
end

-- The dropdown: the row's backplate darkened, with the value and a brushed
-- chevron, opening the game's menu of the choices.
local function BuildDropdown(row)
    local box = CreateFrame("Button", nil, row)
    box:SetSize(START.dropdownW, START.dropdownH)
    box:SetPoint("RIGHT", row, "RIGHT", -2, 0)
    local layers = {}
    local function Tint(color)
        for _, layer in ipairs(layers) do layer:SetVertexColor(color[1], color[2], color[3]) end
    end
    for i = 1, START.dropdownLayers do
        local layer = box:CreateTexture(nil, "BACKGROUND", nil, i - 1)
        layer:SetAtlas(START.backplate)
        layer:SetAllPoints()
        layers[i] = layer
    end
    Tint(START.dropdownTint)
    local chevron = ControlCell(box, "chevron", START.chevronSize)
    chevron:SetPoint("RIGHT", box, "RIGHT", -4, 0)
    row.valueText = SM.NoShadow(box:CreateFontString(nil, "ARTWORK", "SystemFont_Med1"))
    row.valueText:SetTextColor(START.light[1], START.light[2], START.light[3])
    row.valueText:SetJustifyH("LEFT")
    row.valueText:SetWordWrap(false)
    row.valueText:SetPoint("LEFT", box, "LEFT", 12, 0)
    row.valueText:SetPoint("RIGHT", chevron, "LEFT", 2, 0)
    local function Open()
        if not (MenuUtil and MenuUtil.CreateContextMenu) then
            StepRow(row, 1, true)
            return
        end
        local def = row.def
        MenuUtil.CreateContextMenu(box, function(_, root)
            for _, choice in ipairs(def.choices()) do
                root:CreateRadio(choice.text,
                    function() return def.get() == choice.value end,
                    function() Choose(row, choice.value) end)
            end
            if root.SetScrollMode then root:SetScrollMode(300) end
        end)
    end
    box:SetScript("OnEnter", function()
        Tint(START.dropdownHover)
        SetFocus(row)
    end)
    box:SetScript("OnLeave", function() Tint(START.dropdownTint) end)
    box:SetScript("OnClick", Open)
    row:SetScript("OnClick", Open)
end

-- The inked box: an empty frame when off, dark brown with the check when on
-- (RefreshRow).
local function BuildCheck(row)
    local box = CreateFrame("Frame", nil, row)
    box:SetSize(START.cellSize, START.cellSize)
    box:SetPoint("RIGHT", row, "RIGHT", -5, 0)
    row.boxArt = ControlCell(box, "boxOff", START.cellSize)
    row.boxArt:SetPoint("CENTER")
    row.checkmark = ControlCell(box, "check", START.checkSize, "OVERLAY")
    row.checkmark:SetPoint("CENTER", box, "CENTER", 1, 1)
    row:SetScript("OnClick", function() Choose(row, not row.def.get()) end)
end

local function CreateRow(parent, def)
    local row = CreateFrame("Button", nil, parent)
    row:SetHeight(START.rowH)
    row.def = def
    row.backplate = row:CreateTexture(nil, "BACKGROUND")
    row.backplate:SetAtlas(START.backplate)
    row.backplate:SetPoint("TOPLEFT", row, "TOPLEFT", -8, 4)
    row.backplate:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", 8, -4)
    row.backplate:SetAlpha(START.backplateIdle)
    row.label = InkedText(row, "SystemFont_Med3")
    row.label:SetPoint("LEFT", row, "LEFT", START.rowInset, 0)
    row.label:SetText(L[def.label])
    if def.kind == "switch" then BuildSwitch(row)
    elseif def.kind == "dropdown" then BuildDropdown(row)
    else BuildCheck(row) end
    row:SetScript("OnEnter", SetFocus)
    return row
end

-- A vertical rule that fades in from the top and out to the bottom.
local function CreateRule(parent)
    local rule = CreateFrame("Frame", nil, parent)
    local info, file = GetAtlasFile(JOURNAL.divider)
    -- The divider's line turned upright: down the rule runs along the line,
    -- across it the line's thickness, so it has the divider's ink and grain.
    local function LinePart(c0, c1, fromAlpha, toAlpha)
        local u = (info.rightTexCoord - info.leftTexCoord) / info.width
        local u0, u1 = info.leftTexCoord + c0 * u, info.leftTexCoord + c1 * u
        local v0, v1 = info.topTexCoord, info.bottomTexCoord
        local part = rule:CreateTexture(nil, "ARTWORK")
        part:SetTexture(file)
        part:SetTexCoord(u0, v0, u1, v0, u0, v1, u1, v1)
        if fromAlpha ~= toAlpha and part.SetGradient and CreateColor then
            -- Vertical gradients run bottom to top.
            part:SetGradient("VERTICAL", CreateColor(1, 1, 1, fromAlpha), CreateColor(1, 1, 1, toAlpha))
        end
        return part
    end
    -- Without the art, a line in the journal's ink.
    local function InkPart(_, _, fromAlpha, toAlpha)
        local r, g, b = Ink()
        local part = rule:CreateTexture(nil, "ARTWORK")
        part:SetColorTexture(1, 1, 1, 1)
        if part.SetGradient and CreateColor then
            part:SetGradient("VERTICAL", CreateColor(r, g, b, fromAlpha * START.ruleAlpha), CreateColor(r, g, b, toAlpha * START.ruleAlpha))
        else
            part:SetColorTexture(r, g, b, math.max(fromAlpha, toAlpha) * START.ruleAlpha)
        end
        return part
    end
    local Part = info and LinePart or InkPart
    rule:SetWidth(info and info.height or START.ruleW)
    rule.core = info and START.ruleCore or START.ruleW / 2
    local c0, c1 = START.ruleSlice[1], START.ruleSlice[2]
    local fade = math.floor((c1 - c0) / 5)
    local top = Part(c0, c0 + fade, 1, 0)
    top:SetPoint("TOPLEFT"); top:SetPoint("TOPRIGHT"); top:SetHeight(START.ruleFade)
    local bottom = Part(c1 - fade, c1, 0, 1)
    bottom:SetPoint("BOTTOMLEFT"); bottom:SetPoint("BOTTOMRIGHT"); bottom:SetHeight(START.ruleFade)
    local middle = Part(c0 + fade, c1 - fade, 1, 1)
    middle:SetPoint("TOPLEFT", top, "BOTTOMLEFT"); middle:SetPoint("BOTTOMRIGHT", bottom, "TOPRIGHT")
    return rule
end

-- Shows page n of the start page (1 the letter, 2 the settings) and turns
-- the paging control to it.
local function ShowStartPageNumber(n)
    startPage.page, startPage.hidden = n, false
    startPage.first:SetShown(n == 1 or not startPage.pager)
    startPage.second:SetShown(n == 2 or not startPage.pager)
    if startPage.third then startPage.third:Hide() end
    -- One divider per page shown: under the letter's greeting, under Settings.
    local width, used = startPage.contentW or 0, 0
    if n == 1 or not startPage.pager then
        used = used + 1
        window.PlaceJournalDivider(used, startPage.greeting, width)
    end
    if n == 2 or not startPage.pager then
        used = used + 1
        window.PlaceJournalDivider(used, startPage.heading, width)
    end
    window.HideJournalDividers(used + 1)
    local pager = startPage.pager
    if pager then
        pager:SetMaxPages(2)
        pager.currentPage = n
        pager:UpdateControls()
    end
end

-- A page of notes, laid out in the notes area: headings across the page,
-- and bullets as a dot with the text in its own column beside it. The
-- strings are made as pages need them and kept.
local function NoteHeading(i)
    local heading = startPage.noteHeadings[i]
    if not heading then
        heading = InkedText(startPage.notesArea, "QuestFont")
        heading:SetJustifyH("LEFT")
        heading:SetSpacing(START.notesSpacing)
        startPage.noteHeadings[i] = heading
    end
    return heading
end

local function NoteBullet(i)
    local bullet = startPage.noteBullets[i]
    if not bullet then
        bullet = { dot = InkedText(startPage.notesArea, "QuestFont"), text = InkedText(startPage.notesArea, "QuestFont") }
        bullet.dot:SetText("•")
        bullet.text:SetJustifyH("LEFT")
        bullet.text:SetSpacing(START.notesSpacing)
        startPage.noteBullets[i] = bullet
    end
    return bullet
end

local function ShowNotes(lines)
    local width, area = startPage.contentW or 0, startPage.notesArea
    local y, headings, bullets = 0, 0, 0
    for _, line in ipairs(lines) do
        y = y + line.gap
        if line.kind == "heading" then
            headings = headings + 1
            local heading = NoteHeading(headings)
            heading:ClearAllPoints()
            heading:SetPoint("TOPLEFT", area, "TOPLEFT", 0, -y)
            heading:SetWidth(width)
            heading:SetText(line.text)
            heading:Show()
            y = y + (heading:GetStringHeight() or 0)
        else
            bullets = bullets + 1
            local bullet = NoteBullet(bullets)
            bullet.dot:ClearAllPoints()
            bullet.dot:SetPoint("TOPLEFT", area, "TOPLEFT", 0, -y)
            bullet.text:ClearAllPoints()
            bullet.text:SetPoint("TOPLEFT", area, "TOPLEFT", START.bulletIndent, -y)
            bullet.text:SetWidth(width - START.bulletIndent)
            bullet.text:SetText(line.text)
            bullet.dot:Show()
            bullet.text:Show()
            y = y + (bullet.text:GetStringHeight() or 0)
        end
    end
    for i = headings + 1, #startPage.noteHeadings do startPage.noteHeadings[i]:Hide() end
    for i = bullets + 1, #startPage.noteBullets do
        startPage.noteBullets[i].dot:Hide()
        startPage.noteBullets[i].text:Hide()
    end
end

-- Shows hidden page n behind the seal: the credits (1), or a page of a
-- version's notes under its heading, the paging control counting these.
local function ShowHiddenPage(n)
    local pages = startPage.hiddenPages or { { kind = "credits" } }
    n = math.max(1, math.min(n, #pages))
    startPage.hidden, startPage.hiddenPage = true, n
    startPage.first:Hide()
    startPage.second:Hide()
    startPage.third:Show()
    local entry = pages[n]
    local credits = entry.kind == "credits"
    startPage.creditsFrame:SetShown(credits)
    startPage.notesFrame:SetShown(not credits)
    local used = 0
    if not credits then
        startPage.notesTitle:SetText(L["Release Notes Version"]:format(entry.version))
        ShowNotes(entry.lines)
        used = 1
        window.PlaceJournalDivider(used, startPage.notesTitle, startPage.contentW or 0)
    end
    window.HideJournalDividers(used + 1)
    local pager = startPage.pager
    if pager then
        pager:SetMaxPages(#pages)
        pager.currentPage = n
        pager:UpdateControls()
    end
end

local startHost = {}
function startHost:OnPageChanged()
    local pager = startPage.pager
    if not pager then return end
    if startPage.hidden then ShowHiddenPage(pager:GetCurrentPage()) else ShowStartPageNumber(pager:GetCurrentPage()) end
end

-- Back from the first hidden page is the letter: the paging control's back
-- arrow stays on there, and leads out.
local function BackToLetter()
    if SOUNDKIT then PlaySound(SOUNDKIT.IG_ABILITY_PAGE_TURN) end
    ShowStartPageNumber(1)
end

-- The spellbook's paging control, as the Journal tab's (GetJournalPager),
-- for the start page's two pages. nil without the template.
local function CreateStartPager(parent)
    if not (C_XMLUtil and C_XMLUtil.GetTemplateInfo and C_XMLUtil.GetTemplateInfo("PagingControlsHorizontalTemplate")) then
        return nil
    end
    local pager = CreateFrame("Frame", nil, parent, "PagingControlsHorizontalTemplate")
    pager:SetPoint("BOTTOMRIGHT", journal.page, "BOTTOMRIGHT", -JOURNAL.pager.right, JOURNAL.pager.bottom)
    pager:SetFrameLevel(parent:GetFrameLevel() + 20)
    pager.spacing = 8
    pager.hideWhenSinglePage = true
    if SOUNDKIT then
        pager.prevPageSound = SOUNDKIT.IG_ABILITY_PAGE_TURN
        pager.nextPageSound = SOUNDKIT.IG_ABILITY_PAGE_TURN
    end
    pager.PageText:SetFontObject(SystemFont_Med3 or GameFontHighlight)
    pager.PageText:SetTextColor(Ink())
    pager:SetOverridePagedContentFrame(startHost)
    pager:SetMaxPages(2)
    pager.currentPage = 1
    local prev = pager.PrevPageButton
    if prev then
        hooksecurefunc(pager, "UpdateControls", function(self)
            if startPage.hidden then self.PrevPageButton:SetEnabled(true) end
        end)
        prev:HookScript("PreClick", function() startPage.leaving = startPage.hidden and startPage.hiddenPage == 1 end)
        prev:HookScript("OnClick", function()
            if startPage.leaving then
                startPage.leaving = false
                BackToLetter()
            end
        end)
    end
    pager:UpdateControls()
    return pager
end

local function BuildStartPage(parent)
    local page = CreateFrame("Frame", nil, parent)
    page:SetAllPoints(parent)

    -- Page 1: the header and subline, then the letter under its title and
    -- divider, in the fonts of the journal's header, chapter titles and text.
    local first = CreateFrame("Frame", nil, page)
    first:SetAllPoints(page)
    startPage.title = InkedText(first, "QuestFont_Huge")
    startPage.title:SetJustifyH("CENTER")
    startPage.title:SetText(L["Welcome Headline"])
    startPage.subtitle = InkedText(first, "QuestFont")
    startPage.subtitle:SetJustifyH("CENTER")
    startPage.greeting = InkedText(first, "QuestFont_Large")
    startPage.greeting:SetJustifyH("LEFT")
    startPage.text = InkedText(first, "QuestFont")
    startPage.text:SetJustifyH("LEFT")
    startPage.text:SetSpacing(START.textSpacing)
    startPage.seal = first:CreateTexture(nil, "ARTWORK")
    startPage.seal:SetTexture(START.seal.file)
    startPage.seal:SetSize(START.seal.size, START.seal.size)
    if startPage.seal.SetRotation then startPage.seal:SetRotation(START.seal.turn) end
    -- Spans from the page's bottom left to the letter's left edge: the seal
    -- takes its height from the page and its place across from the letter.
    startPage.sealSpot = CreateFrame("Frame", nil, first)
    -- Under the mouse the wax catches a warm light: the seal again, added on
    -- top. A click turns to the hidden page.
    local glow = first:CreateTexture(nil, "ARTWORK", nil, 1)
    glow:SetTexture(START.seal.file)
    glow:SetSize(START.seal.size, START.seal.size)
    glow:SetBlendMode("ADD")
    glow:SetVertexColor(START.sealGlow.color[1], START.sealGlow.color[2], START.sealGlow.color[3])
    glow:SetAlpha(0)
    if glow.SetRotation then glow:SetRotation(START.seal.turn) end
    glow:SetPoint("CENTER", startPage.seal, "CENTER")
    startPage.sealGlow = glow
    local sealButton = CreateFrame("Button", nil, first)
    sealButton:SetSize(START.seal.size * 0.66, START.seal.size * 0.66)
    sealButton:SetPoint("CENTER", startPage.seal, "CENTER")
    local target = 0
    local function Fade(_, elapsed)
        local alpha = glow:GetAlpha()
        local step = START.sealGlow.alpha * START.sealGlow.speed * elapsed
        alpha = alpha < target and math.min(target, alpha + step) or math.max(target, alpha - step)
        glow:SetAlpha(alpha)
        if alpha == target then sealButton:SetScript("OnUpdate", nil) end
    end
    sealButton:SetScript("OnEnter", function() target = START.sealGlow.alpha; sealButton:SetScript("OnUpdate", Fade) end)
    sealButton:SetScript("OnLeave", function() target = 0; sealButton:SetScript("OnUpdate", Fade) end)
    sealButton:SetScript("OnClick", function()
        if not startPage.pager then return end
        if SOUNDKIT then PlaySound(SOUNDKIT.IG_ABILITY_PAGE_TURN) end
        ShowHiddenPage(1)
    end)
    startPage.sealButton = sealButton

    -- Page 2: the settings, a list and what the setting under the mouse does.
    local second = CreateFrame("Frame", nil, page)
    second:SetAllPoints(page)
    startPage.heading = InkedText(second, "QuestFont_Large")
    startPage.heading:SetJustifyH("LEFT")
    startPage.heading:SetText(L["Settings Title"])
    startPage.list = CreateFrame("Frame", nil, second)
    startPage.rule = CreateRule(second)
    -- Lordaeron's gate in the bottom right corner, under everything else.
    local decor = START.decor
    startPage.decor = second:CreateTexture(nil, "BACKGROUND")
    startPage.decor:SetTexture(decor.file)
    startPage.decor:SetSize(decor.size, decor.size)
    startPage.decor:SetVertexColor(decor.color[1], decor.color[2], decor.color[3])
    startPage.decor:SetAlpha(decor.alpha)
    startPage.decor:SetPoint("BOTTOMRIGHT", journal.page, "BOTTOMRIGHT", -decor.right, decor.bottom)
    startPage.panelText = InkedText(second, "QuestFont")
    startPage.panelText:SetJustifyH("LEFT")
    startPage.panelText:SetJustifyV("TOP")
    startPage.panelText:SetSpacing(3)
    for _, def in ipairs(SETTINGS) do
        startPage.rows[#startPage.rows + 1] = CreateRow(startPage.list, def)
    end

    -- The hidden pages, behind the seal: the credits, and a page for notes.
    local third = CreateFrame("Frame", nil, page)
    third:SetAllPoints(page)
    third:Hide()
    local credits = CreateFrame("Frame", nil, third)
    credits:SetAllPoints(third)
    startPage.creditsTitle = InkedText(credits, "QuestFont_Huge")
    startPage.creditsTitle:SetJustifyH("CENTER")
    startPage.creditsTitle:SetText(L["Addon Name"])
    startPage.creditsSub = InkedText(credits, "QuestFont")
    startPage.creditsSub:SetJustifyH("CENTER")
    -- Under the title, the version and build this is: the build is the
    -- packager's commit count (X-Build in the .toc); a checkout that wasn't
    -- packaged says dev.
    local GetMetadata = C_AddOns and C_AddOns.GetAddOnMetadata or GetAddOnMetadata
    local version = GetMetadata and GetMetadata(addonName, "Version") or "?"
    local build = GetMetadata and GetMetadata(addonName, "X-Build")
    if not build or build == "" or build:find("@", 1, true) then build = "dev" end
    startPage.creditsSub:SetText(L["Credits Version"]:format(version, build))
    startPage.creditLines = {}
    local function Credit(kind, font, text)
        local line = InkedText(credits, font)
        line:SetJustifyH("CENTER")
        line:SetText(text)
        if kind ~= "name" then line:SetAlpha(START.roleAlpha) end
        startPage.creditLines[#startPage.creditLines + 1] = { kind = kind, text = line }
    end
    for _, credit in ipairs(CREDITS) do
        Credit("role", "QuestFont", L[credit.role])
        for _, name in ipairs(credit.names) do Credit("name", "QuestFont_Large", name) end
        if credit.contact then
            startPage.creditLines[#startPage.creditLines + 1] = { kind = "contact", text = ContactBox(credits, credit.contact) }
        end
    end
    local notes = CreateFrame("Frame", nil, third)
    notes:SetAllPoints(third)
    startPage.notesTitle = InkedText(notes, "QuestFont_Large")
    startPage.notesTitle:SetJustifyH("LEFT")
    startPage.notesArea = CreateFrame("Frame", nil, notes)
    startPage.noteHeadings, startPage.noteBullets = {}, {}
    -- Measures notes for the pages, unseen.
    startPage.notesMeasure = InkedText(notes, "QuestFont")
    startPage.notesMeasure:SetJustifyH("LEFT")
    startPage.notesMeasure:SetSpacing(START.notesSpacing)
    startPage.notesMeasure:SetAlpha(0)
    -- Every version's notes, newest first: each L["Release Notes x.y.z"].
    local versions = {}
    for key in pairs(L) do
        if type(key) == "string" then
            local a, b, c = key:match("^Release Notes (%d+)%.(%d+)%.(%d+)$")
            if a then
                versions[#versions + 1] = { key = key, version = a .. "." .. b .. "." .. c, order = tonumber(a) * 1e6 + tonumber(b) * 1e3 + tonumber(c) }
            end
        end
    end
    table.sort(versions, function(x, y) return x.order > y.order end)
    startPage.versions = versions
    startPage.third, startPage.creditsFrame, startPage.notesFrame = third, credits, notes

    startPage.frame, startPage.first, startPage.second = page, first, second
    startPage.pager = CreateStartPager(page)
    -- The mouse wheel turns the start page's pages too.
    local scroll = SM.DetailUI and SM.DetailUI.detailScroll
    if scroll and startPage.pager then
        scroll:HookScript("OnMouseWheel", function(_, delta)
            if not (startPage.shown and page:IsVisible()) then return end
            if startPage.hidden and delta > 0 and startPage.hiddenPage == 1 then
                BackToLetter()
                return
            end
            if delta > 0 then startPage.pager:PreviousPage() else startPage.pager:NextPage() end
        end)
    end
    page:SetShown(startPage.shown)
end

-- Cuts release notes into pages no taller than room at width, measured with
-- measure. The notes are sections (split at blank lines) of a heading and
-- bullets ("• "), a bullet's text in a column bulletIndent in. A section goes
-- whole onto a page if it fits there, else onto the next; one taller than a
-- page flows on a line at a time, never leaving a heading without its first
-- bullet. Returns the pages, each a list of { kind, text, gap } lines, gap
-- the space above the line.
function window.SplitToPages(text, measure, width, room)
    local sections, current = {}, nil
    for line in (text .. "\n"):gmatch("(.-)\n") do
        if line == "" then
            current = nil
        else
            if not current then
                current = {}
                sections[#sections + 1] = current
            end
            local bullet = line:match("^• (.*)$")
            current[#current + 1] = bullet and { kind = "bullet", text = bullet } or { kind = "heading", text = line }
        end
    end
    local function Height(line)
        measure:SetWidth(line.kind == "bullet" and width - START.bulletIndent or width)
        measure:SetText(line.text)
        return measure:GetStringHeight() or 0
    end
    local pages, page, used = {}, nil, 0
    local function NewPage()
        page, used = {}, 0
        pages[#pages + 1] = page
    end
    NewPage()
    for _, section in ipairs(sections) do
        local heights, total = {}, 0
        for i, line in ipairs(section) do
            heights[i] = Height(line)
            total = total + heights[i] + ((i > 1 and line.kind == "bullet") and START.bulletGap or 0)
        end
        if #page > 0 and used + START.sectionGap + total > room and total <= room then NewPage() end
        for i, line in ipairs(section) do
            local function Gap()
                if #page == 0 then return 0 end
                if i == 1 then return START.sectionGap end
                return line.kind == "bullet" and START.bulletGap or 0
            end
            local need = Gap() + heights[i]
            if line.kind == "heading" and section[i + 1] then need = need + START.bulletGap + heights[i + 1] end
            if #page > 0 and used + need > room then NewPage() end
            local gap = Gap()
            page[#page + 1] = { kind = line.kind, text = line.text, gap = gap }
            used = used + gap + heights[i]
        end
    end
    if #page == 0 then pages[#pages] = nil end
    return pages
end

-- Whether the start page can be a journal page (the spellbook art loaded).
function window.HasStartPage()
    return journal.page ~= nil
end

function window.IsStartPageShown()
    return startPage.shown
end

-- Lays the start page out on parent (the detail page), padding in from its
-- sides. Returns page 1's last element, for the detail page to fit to.
function window.LayoutStartPage(parent, padding)
    if not startPage.frame then BuildStartPage(parent) end
    local width = (parent:GetWidth() or 0) - padding * 2
    startPage.contentW = width

    -- Page 1: the header and subline, the greeting, the letter with its
    -- closing as its last paragraph, and the seal in the page's bottom left.
    local function Span(region, above, gap)
        region:ClearAllPoints()
        region:SetPoint("TOP", above, "BOTTOM", 0, -gap)
        region:SetPoint("LEFT", parent, "LEFT", padding, 0)
        region:SetPoint("RIGHT", parent, "RIGHT", -padding, 0)
        if width > 20 then region:SetWidth(width) end
    end
    startPage.title:ClearAllPoints()
    startPage.title:SetPoint("TOP", parent, "TOP", 0, -START.titleTop)
    local name = UnitName and UnitName("player")
    startPage.subtitle:SetText(name and L["Welcome Subline Format"]:format(name) or L["Welcome Subline"])
    Span(startPage.subtitle, startPage.title, START.subtitleGap)
    startPage.greeting:SetText(SM.ApplyGenderTokens(L["Welcome Letter Greeting"]))
    Span(startPage.greeting, startPage.subtitle, START.headerGap)
    Span(startPage.text, startPage.greeting, START.textGap)
    startPage.text:SetText(SM.ApplyGenderTokens(L["Welcome Letter"]) .. "\n\n" .. L["Welcome Letter Closing"])
    startPage.seal:ClearAllPoints()
    if startPage.pager then
        local spot = startPage.sealSpot
        spot:ClearAllPoints()
        spot:SetPoint("BOTTOMLEFT", journal.page, "BOTTOMLEFT", 0, START.seal.y)
        spot:SetPoint("TOPRIGHT", startPage.text, "BOTTOMLEFT", 0, 0)
        startPage.seal:SetPoint("CENTER", spot, "BOTTOMRIGHT", START.seal.x, 0)
    else
        startPage.seal:SetPoint("CENTER", startPage.text, "BOTTOM", START.seal.byX, START.seal.byY)
    end

    -- Page 2 (under page 1 where there's no paging control).
    startPage.heading:ClearAllPoints()
    if startPage.pager then
        startPage.heading:SetPoint("TOPLEFT", parent, "TOPLEFT", padding, -START.headingTop)
    else
        startPage.heading:SetPoint("TOP", startPage.seal, "BOTTOM", 0, -START.headingTop)
        startPage.heading:SetPoint("LEFT", parent, "LEFT", padding, 0)
        startPage.heading:SetPoint("RIGHT", parent, "RIGHT", -padding, 0)
    end
    startPage.heading:SetWidth(width)
    local listW = math.floor(width * START.listShare - START.columnGap / 2)
    local list = startPage.list
    list:ClearAllPoints()
    list:SetPoint("TOPLEFT", startPage.heading, "BOTTOMLEFT", 0, -(START.splitGap + 14))
    list:SetSize(listW, START.splitH)
    startPage.rule:ClearAllPoints()
    startPage.rule:SetPoint("TOPLEFT", list, "TOPRIGHT", START.columnGap / 2 - startPage.rule.core, 0)
    startPage.rule:SetHeight(START.splitH)
    local panelLeft = listW + START.columnGap
    startPage.panelText:ClearAllPoints()
    startPage.panelText:SetPoint("TOPLEFT", list, "TOPLEFT", panelLeft, -6)
    startPage.panelText:SetWidth(width - panelLeft)

    local above, firstShown
    for _, row in ipairs(startPage.rows) do
        local shown = not row.def.available or row.def.available()
        row:SetShown(shown)
        if shown then
            row:ClearAllPoints()
            if above then
                row:SetPoint("TOPLEFT", above, "BOTTOMLEFT", 0, -6)
                row:SetPoint("TOPRIGHT", above, "BOTTOMRIGHT", 0, -6)
            else
                row:SetPoint("TOPLEFT", list, "TOPLEFT", 0, 0)
                row:SetPoint("TOPRIGHT", list, "TOPRIGHT", 0, 0)
            end
            RefreshRow(row)
            above, firstShown = row, firstShown or row
        end
    end
    if not (startPage.focus and startPage.focus:IsShown()) and firstShown then SetFocus(firstShown) end
    ShowExplanation()

    -- The hidden pages. The credits: the title and subline as page 1's
    -- header, then each role and its names, centred down the page.
    startPage.creditsTitle:ClearAllPoints()
    startPage.creditsTitle:SetPoint("TOP", parent, "TOP", 0, -START.titleTop)
    Span(startPage.creditsSub, startPage.creditsTitle, START.subtitleGap)
    local above, last = startPage.creditsSub, nil
    for _, line in ipairs(startPage.creditLines) do
        local gap = line.kind == "role" and (last and START.creditGap or START.creditsTop)
            or line.kind ~= "role" and last == "role" and START.roleGap or START.nameGap
        Span(line.text, above, gap)
        above, last = line.text, line.kind
    end
    -- The notes: the version under its divider, then its text, cut into
    -- pages that fit above the paging control.
    startPage.notesTitle:ClearAllPoints()
    startPage.notesTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", padding, -START.headingTop)
    startPage.notesTitle:SetWidth(width)
    startPage.notesTitle:SetText(L["Release Notes Version"]:format("0.0.0"))
    local area = startPage.notesArea
    area:ClearAllPoints()
    area:SetPoint("TOPLEFT", startPage.notesTitle, "BOTTOMLEFT", 0, -START.textGap)
    area:SetSize(math.max(1, width), 1)
    local pageH = journal.page and journal.page:GetHeight() or 0
    if pageH < 200 then pageH = START.pageFallback end
    local room = pageH - START.headingTop - (startPage.notesTitle:GetStringHeight() or 16) - START.textGap - START.notesBottom
    startPage.hiddenPages = { { kind = "credits" } }
    for _, entry in ipairs(startPage.versions) do
        for _, part in ipairs(window.SplitToPages(L[entry.key], startPage.notesMeasure, width, room)) do
            startPage.hiddenPages[#startPage.hiddenPages + 1] = { kind = "notes", version = entry.version, lines = part }
        end
    end

    if startPage.hidden then ShowHiddenPage(startPage.hiddenPage) else ShowStartPageNumber(startPage.page) end
    startPage.frame:SetShown(startPage.shown)
    return startPage.pager and startPage.text or list
end

-- Shows the start page with the intro and hides it with it, and the journal
-- page under it.
function window.ShowStartPage(shown)
    -- It opens on the letter, or on the settings when asked (ShowSettingsPage).
    if shown and not startPage.shown then
        startPage.page, startPage.hidden = startPage.openOnSettings and 2 or 1, false
        startPage.openOnSettings = nil
    end
    startPage.shown = shown
    if startPage.frame then startPage.frame:SetShown(shown) end
    journal.start = shown
    UpdateJournalPage()
    if shown and startPage.frame then
        if startPage.hidden then ShowHiddenPage(startPage.hiddenPage) else ShowStartPageNumber(startPage.page) end
    end
end

-- Turns the start page to the settings: now if it's shown, else the next
-- time it shows.
function window.ShowSettingsPage()
    if startPage.shown and startPage.frame then
        ShowStartPageNumber(2)
    else
        startPage.openOnSettings = true
    end
end

-- ── Story list cards ────────────────────────────────────────────────────────
-- The story list uses the Group Finder's category cards
-- (LFGListingCategoryTemplate in Blizzard_GroupFinder_VanillaStyle, drawn with
-- Forever's c60 art): the card frame over the story's art, its pressed and
-- hover frames, the selected card lit, and the name on the left in gold.
-- The frame is 418 x 67 and the list is narrower, so a card shows the frame at
-- its own size: its left end (the dark fade behind the name) and its right
-- end, meeting in the plain middle, which nothing is missing from. Nothing is
-- scaled or stretched, and the story art fills the frame's window, cropped.

local LIST_CARD = {
    frame = "groupfinder-button-cover",
    pressed = "groupfinder-button-cover-down",
    hover = "groupfinder-button-cover-hover",
    leftEnd = 190,                                       -- the frame is plain from here to 380
    art = { left = 5, top = 7, right = 5, bottom = 5 },  -- the frame's window
    textLeft = 20,                                       -- the Group Finder's label inset
    artShade = 0.6,                                      -- its pictures are dimmed a little
    ribbonScale = 0.85, ribbonRight = 14, ribbonTop = 2, -- the finished flag, hung from the top edge
}
local GOLD = { 1, 0.82, 0 }
local WHITE = { 1, 1, 1 }

function window.ListCardHeight()
    local info = C_Texture.GetAtlasInfo(LIST_CARD.frame)
    return info and info.height or 67
end

-- Draws atlas across width at its own size, as two pieces on layer: its left
-- end and as much of its right end as the rest of the width needs.
local function DrawFrame(card, layer, sublevel, atlas, width)
    local info, file = GetAtlasFile(atlas)
    if not info then return nil end
    local leftW = math.min(LIST_CARD.leftEnd, width)
    local rightW = width - leftW
    local u = (info.rightTexCoord - info.leftTexCoord) / info.width
    local pieces = {}
    for i, piece in ipairs({ { 0, leftW, "TOPLEFT" }, { info.width - rightW, rightW, "TOPRIGHT" } }) do
        local tex = card:CreateTexture(nil, layer, nil, sublevel)
        tex:SetTexture(file)
        tex:SetSize(piece[2], info.height)
        tex:SetPoint(piece[3])
        tex:SetTexCoord(info.leftTexCoord + piece[1] * u, info.leftTexCoord + (piece[1] + piece[2]) * u,
            info.topTexCoord, info.bottomTexCoord)
        pieces[i] = tex
    end
    return pieces
end

local function ShowPieces(pieces, shown)
    for _, tex in ipairs(pieces or {}) do tex:SetShown(shown) end
end

-- Gives card (a list Button, width wide) the Group Finder card's look. art is
-- the story's art texture, nameLabel and subLabel its two lines, ribbon the
-- finished flag; any of them may be nil. Returns the colours for the lines.
-- card:SetListCardLit(lit) shows the hover frame, for the selected card too.
function window.StyleListCard(card, width, art, nameLabel, subLabel, ribbon)
    local inset = LIST_CARD.art
    if art then
        art:ClearAllPoints()
        art:SetPoint("TOPLEFT", card, "TOPLEFT", inset.left, -inset.top)
        art:SetPoint("BOTTOMRIGHT", card, "BOTTOMRIGHT", -inset.right, inset.bottom)
        art:SetAlpha(1)
        art:SetVertexColor(LIST_CARD.artShade, LIST_CARD.artShade, LIST_CARD.artShade)
    end
    DrawFrame(card, "ARTWORK", 0, LIST_CARD.frame, width)
    local pressed = DrawFrame(card, "ARTWORK", 1, LIST_CARD.pressed, width)
    local hover = DrawFrame(card, "ARTWORK", 2, LIST_CARD.hover, width)
    ShowPieces(pressed, false)
    ShowPieces(hover, false)
    card:HookScript("OnMouseDown", function() ShowPieces(pressed, true) end)
    card:HookScript("OnMouseUp", function() ShowPieces(pressed, false) end)
    function card:SetListCardLit(lit) ShowPieces(hover, lit) end

    if nameLabel then
        nameLabel:SetFontObject(GameFontNormalMed3 or GameFontNormal)
        nameLabel:SetTextColor(GOLD[1], GOLD[2], GOLD[3])
        -- A hard shadow keeps the name readable on bright pictures.
        nameLabel:SetShadowColor(0, 0, 0, 1)
        nameLabel:SetShadowOffset(1, -1)
        if art then nameLabel:SetPoint("LEFT", card, "LEFT", LIST_CARD.textLeft, 0) end
    end
    if subLabel then
        subLabel:SetFontObject(GameFontHighlightSmall)
        subLabel:SetTextColor(WHITE[1], WHITE[2], WHITE[3])
        subLabel:SetShadowColor(0, 0, 0, 1)
        subLabel:SetShadowOffset(1, -1)
    end
    if ribbon then
        ribbon:SetScale(LIST_CARD.ribbonScale)
        ribbon:ClearAllPoints()
        ribbon:SetPoint("TOPRIGHT", card, "TOPRIGHT",
            -LIST_CARD.ribbonRight / LIST_CARD.ribbonScale, -LIST_CARD.ribbonTop / LIST_CARD.ribbonScale)
    end
    return GOLD, WHITE
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
-- like the Legacy window's tabs (LegacySystemTabTemplate): Forever's own
-- side-tab icons for Adventure (the map) and Progress (the quest log's "!"),
-- and a quill for the Journal.

local DETAIL_TABS = {
    { key = "story", label = "Tab Adventure", icon = "Interface/ICONS/INV_SideTab_FullMap_c60" },
    { key = "progress", label = "Tab Progress", icon = "Interface/ICONS/INV_SideTab_QuestLog_c60" },
    { key = "journal", label = "Tab Journal", icon = "Interface/ICONS/INV_Feather_07" },
    { key = "scarlet", label = "Tab Scarlet Crusader", icon = "Interface\\Icons\\Spell_Holy_SealOfWrath" },
}

local function SetTabIcon(tab, icon)
    tab.Icon:SetTexture(icon)
end
local detailTabs = {}

function window.AddDetailTabs(frame, onSelect)
    local previous
    for _, info in ipairs(DETAIL_TABS) do
        local tab = CreateFrame("Frame", nil, frame, "LargeSideTabButtonTemplate")
        tab:EnableMouse(true)
        tab.tooltipText = L[info.label]
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
-- The selected chapter is always in full colour, with no arrow under it, and
-- the chapter the story sends the player to next looks the same, even before
-- any of its quests are done.
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

function window.StyleChapterNode(node, complete, active, selected, current)
    node.ring:Hide()
    node.squareBorder:Hide()
    SM.SetSimpleBorder(node.portraitBorder, 0, 0, 0, 0)
    node.checkmark:Hide()
    for _, mask in ipairs({ node.portraitMask, node.glowMask, node.hoverGlowMask }) do
        if mask then mask:SetAtlas(ICON_MASK) end
    end

    local open = active or selected or current
    local frameKey = complete and "done" or (open and "open") or "later"
    node.legacyFrame:SetAtlas(CHAPTER_FRAME[frameKey])
    local colored = complete or open
    node.isDimmed = not colored
    node.portrait:SetDesaturation(colored and 0 or 0.8)
    local shade = colored and 1 or 0.7
    node.portrait:SetVertexColor(shade, shade, shade)
    if node.downArrow then node.downArrow:Hide() end
    -- The selected chapter's warm tint over the portrait, on the current one too.
    if node.activeGlow then node.activeGlow:SetShown((selected or current) == true) end
    node.isCurrentChapter = current == true
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
    tuck = 2,    -- how far the line starts under the chapter's frame
}

function window.CreateChapterArrow(parent)
    local arrow = CreateFrame("Frame", nil, parent)
    arrow:SetAllPoints(parent)
    -- Under the chapters, so the line's start tucks under the frame.
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
    -- From the edge of the chapter's frame, not its middle: a chapter at the
    -- track's edge fades out, and the line would show through its portrait.
    local startX = fromNode.portrait:GetWidth() * 60 / 50 / 2 - ARROW.tuck
    arrow.line:SetStartPoint("CENTER", fromNode.portrait, startX, 0)
    arrow.line:SetEndPoint("CENTER", toNode.portrait, headX, 0)
    arrow.head:ClearAllPoints()
    arrow.head:SetPoint("CENTER", toNode.portrait, "CENTER", headX, 0)
    arrow:Show()
end

-- ── Story progress ──────────────────────────────────────────────────────────
-- The header shows the selected story's progress in the Legacy challenge
-- page's bar: it fills with finished quests, and its text counts chapters
-- and quests.

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

    summary:Hide()
    progress = { frame = summary, bar = bar, text = text }
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
    progress.bar:SetValue(questsTotal > 0 and questsDone / questsTotal or 0)
    progress.text:SetText(string.format(L["Progress Summary Format"], chaptersDone, #chapters, questsDone, questsTotal))
    progress.frame:Show()
end

-- Shows the tabs and progress for a story, or hides them on the start page.
function window.ShowStory(data, showScarletTab)
    for key, tab in pairs(detailTabs) do
        tab:SetShown(data ~= nil and (key ~= "scarlet" or showScarletTab == true))
    end
    ShowProgress(data)
    journal.story = data ~= nil
    UpdateJournalPage()
end

-- Opens the window where the Legacy window opens, until it's dragged
-- somewhere else. Called once StoryMode.lua has set the window's scripts,
-- since SetScript drops earlier hooks.
function window.Attach(frame)
    local moved = false
    frame:HookScript("OnDragStop", function() moved = true end)
    frame:HookScript("OnShow", function(self)
        if not moved then PlaceLikeLegacyWindow(self) end
    end)
    PlaceLikeLegacyWindow(frame)
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
