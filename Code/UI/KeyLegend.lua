-- A bar of controller keys and what they do, drawn like the game's own (its
-- input legend, under the bags in the controller UI): a snippet to copy as is
-- into an addon (devAddons/luaSnippets; README.md there says how to use it).
--
-- Built from the game's art and sizes, not its legend code (which belongs to
-- the game's controller UI): the gamepad-footer slot, 24 px icons, GameFontNormal,
-- with the connected controller's icons (a letter where it has none).
-- Sizes from Blizzard_GamepadSharedUtility/InputPrompts (forever):
-- InputLegendPromptGroup.lua LEGEND_BACKGROUND_PADDING, ICON_SIZE,
-- STANDARD_PROMPT_PADDING; InputPrompts.xml the icon-to-text gap.
--
-- Use:
--   local legend = addonTable.KeyLegend.New(parent)   -- a frame: anchor and show it
--   legend.SetPrompts({ { key = "PAD1", fallback = "A", label = "Buy" }, ... })
--   legend.Refresh()   -- again when the controller may have changed (on show)
-- SetPrompts lays it out and sizes it; prompts can change any time, and an
-- empty list hides it. legend.Describe() says it in words ("A: Buy   B: Close").
local _, addonTable = ...

local KeyLegend = {
    PADDING = 10,
    ICON_SIZE = 24,
    ICON_TEXT_GAP = 4,
    PROMPT_GAP = 15,
    SLOT_ATLAS = "gamepad-footer-slot-bg",
    BORDER_ATLAS = "gamepad-footer-slot-frameneutral",
}
addonTable.KeyLegend = KeyLegend

-- The connected controller's icon for a key (an atlas), or nil.
function KeyLegend.IconAtlas(key)
    local iconUtility = _G.InputIconTextureSetUtility
    if type(iconUtility) ~= "table" or type(iconUtility.GetNormalActiveInputIconButtonTexture) ~= "function" then
        return nil
    end
    local ok, atlas = pcall(iconUtility.GetNormalActiveInputIconButtonTexture, key)
    return ok and type(atlas) == "string" and atlas or nil
end

function KeyLegend.New(parent)
    local legend = CreateFrame("Frame", nil, parent)
    local slot = legend:CreateTexture(nil, "BACKGROUND")
    slot:SetAtlas(KeyLegend.SLOT_ATLAS)
    slot:SetAllPoints()
    local border = legend:CreateTexture(nil, "BORDER")
    border:SetAtlas(KeyLegend.BORDER_ATLAS)
    border:SetAllPoints()

    local prompts = {}
    local entries = {}   -- an icon and a text per prompt, made once and reused

    local function Entry(index)
        if not entries[index] then
            local icon = legend:CreateTexture(nil, "ARTWORK")
            icon:SetSize(KeyLegend.ICON_SIZE, KeyLegend.ICON_SIZE)
            entries[index] = { icon = icon, text = legend:CreateFontString(nil, "OVERLAY", "GameFontNormal") }
        end
        return entries[index]
    end

    function legend.Refresh()
        local x = KeyLegend.PADDING
        for index, prompt in ipairs(prompts) do
            local entry = Entry(index)
            local atlas = KeyLegend.IconAtlas(prompt.key)
            entry.icon:ClearAllPoints()
            entry.text:ClearAllPoints()
            entry.text:Show()
            if atlas then
                entry.icon:SetAtlas(atlas)
                entry.icon:SetPoint("LEFT", legend, "LEFT", x, 0)
                entry.icon:Show()
                entry.text:SetPoint("LEFT", entry.icon, "RIGHT", KeyLegend.ICON_TEXT_GAP, 0)
                entry.text:SetText(prompt.label)
                x = x + KeyLegend.ICON_SIZE + KeyLegend.ICON_TEXT_GAP
            else
                entry.icon:Hide()
                entry.text:SetPoint("LEFT", legend, "LEFT", x, 0)
                entry.text:SetText(prompt.fallback .. ": " .. prompt.label)
            end
            x = x + entry.text:GetStringWidth() + KeyLegend.PROMPT_GAP
        end
        for index = #prompts + 1, #entries do
            entries[index].icon:Hide()
            entries[index].text:Hide()
        end
        legend:SetSize(x - KeyLegend.PROMPT_GAP + KeyLegend.PADDING, KeyLegend.PADDING * 2 + KeyLegend.ICON_SIZE)
    end

    function legend.SetPrompts(newPrompts)
        prompts = newPrompts or {}
        legend:SetShown(#prompts > 0)
        legend.Refresh()
    end

    function legend.Describe()
        local words = {}
        for _, prompt in ipairs(prompts) do words[#words + 1] = prompt.fallback .. ": " .. prompt.label end
        return table.concat(words, "   ")
    end

    return legend
end
