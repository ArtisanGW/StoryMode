local _, SM = ...

-- The art for story quests' areas on the minimap and the maps, per story
-- colour, drawn by _Dev/art/quest-areas.py: the game's textures, each pixel
-- in the story's colour at the brightness of its strongest channel, alpha
-- kept. Named with .tga: without an extension the game looks for a .blp
-- first.
--
-- The minimap draws an addon's file only once the UI has loaded it. Given
-- it before, the minimap draws "not found" (solid green) for that file until
-- the game restarts, /reload included, and a texture on a hidden frame
-- doesn't load it (measured with devAddons/DevBlobProbe). So textures the
-- player can't see keep each file loaded, and the game's frames get the
-- files only once IsObjectLoaded says they're all in.

local Marks = SM.StoryQuestMarks
local AreaArt = {}
SM.StoryAreaArt = AreaArt

local ART = "Interface\\AddOns\\StoryMode\\Art\\"

local function StoryFiles(story)
    return {
        minimapOutside = ART .. "Minimap\\QuestAreaOutside" .. story .. ".tga",
        minimapRing = ART .. "Minimap\\QuestAreaRing" .. story .. ".tga",
        mapInside = ART .. "WorldMap\\QuestAreaInside" .. story .. ".tga",
        mapOutside = ART .. "WorldMap\\QuestAreaOutside" .. story .. ".tga",
    }
end

local filesByColor = {
    [Marks.FOLLOWED_STORY_COLOR] = StoryFiles("Followed"),
    [Marks.OTHER_STORY_COLOR] = StoryFiles("Other"),
}
local loaded = false
local listeners = {}

-- A story colour's files, or nil: for no colour, or while they load.
function AreaArt.ForColor(color)
    return loaded and filesByColor[color] or nil
end

-- Runs once the files are loaded.
function AreaArt.OnLoaded(listener)
    listeners[#listeners + 1] = listener
end

-- One texture per file, at alpha 0. The frame has no parent, so hiding the
-- UI doesn't hide it: the files stay loaded.
local artFrame = CreateFrame("Frame")
artFrame:SetSize(64, 64)
artFrame:SetPoint("BOTTOMLEFT")
local artTextures = {}
for _, files in pairs(filesByColor) do
    for _, file in pairs(files) do
        local texture = artFrame:CreateTexture()
        texture:SetAllPoints()
        texture:SetAlpha(0)
        texture:SetTexture(file)
        artTextures[#artTextures + 1] = texture
    end
end
artFrame:SetScript("OnUpdate", function(self)
    for _, texture in ipairs(artTextures) do
        if not texture:IsObjectLoaded() then return end
    end
    self:SetScript("OnUpdate", nil)
    loaded = true
    for _, listener in ipairs(listeners) do listener() end
end)
