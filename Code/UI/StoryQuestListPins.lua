local _, SM = ...

-- Story quests in the quest list beside the world map: the pin next to each
-- story quest takes the story's colour, as on the map. After the game builds
-- the list (a post-hook on QuestLogQuests_Update), its pins are painted; they
-- are pooled, so each pass puts back the look of the others.

local Marks = SM.StoryQuestMarks

local function QuestListButtons()
    local contents = QuestScrollFrame and QuestScrollFrame.Contents
    return contents and contents.buttonPool
end

local function RefreshQuestList()
    local buttonPool = QuestListButtons()
    if not buttonPool then return end
    for button in buttonPool:EnumerateActive() do
        Marks.UpdateQuestButton(button)
    end
end

Marks.OnChange(RefreshQuestList)

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:SetScript("OnEvent", function()
    if QuestLogQuests_Update then
        hooksecurefunc("QuestLogQuests_Update", RefreshQuestList)
    end
end)
