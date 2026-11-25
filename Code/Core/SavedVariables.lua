local addonName, SM = ...

local defaults = {
    version = "1.7.0",
    selectedQuestline = 1,
    selectedQuestlineID = nil,
    hideUnrelatedQuestTrackerQuests = false,
    hiddenQuestTrackerWatches = {},
    questTrackerStoryID = nil,
    minimapIconStyle = "borderless",
    characterChapterFlags = {},
    viewedLoreChapters = {},
    playedChapters = {},
}

local function ChapterFlagKey(storylineTitle, chapterName)
    return (storylineTitle or "") .. "|" .. (chapterName or "")
end

local function CharacterKey()
    local name, realm
    if UnitFullName then
        name, realm = UnitFullName("player")
    end
    if not name or name == "" then
        name = UnitName and UnitName("player")
    end
    if not name or name == "" then
        return nil
    end
    if not realm or realm == "" then
        realm = GetNormalizedRealmName and GetNormalizedRealmName()
    end
    if not realm or realm == "" then
        realm = GetRealmName and GetRealmName()
    end
    return (realm or "UnknownRealm") .. ":" .. name
end

local function GetCharacterChapterFlags(flagType, create)
    if not StoryModeDB then return nil end

    local characterKey = CharacterKey()
    if not characterKey then return nil end

    if create and not StoryModeDB.characterChapterFlags then
        StoryModeDB.characterChapterFlags = {}
    end
    local allCharacterFlags = StoryModeDB.characterChapterFlags
    if not allCharacterFlags then return nil end

    if create and not allCharacterFlags[characterKey] then
        allCharacterFlags[characterKey] = {}
    end
    local characterFlags = allCharacterFlags[characterKey]
    if not characterFlags then return nil end

    if create and not characterFlags[flagType] then
        characterFlags[flagType] = {}
    end
    return characterFlags[flagType]
end

function SM.ApplySavedVariableDefaults()
    StoryModeDB = StoryModeDB or {}
    for key, value in pairs(defaults) do
        if StoryModeDB[key] == nil then
            StoryModeDB[key] = type(value) == "table" and CopyTable(value) or value
        end
    end
end

function SM.IsLoreChapterViewed(storylineTitle, chapterName)
    local viewedLoreChapters = GetCharacterChapterFlags("viewedLoreChapters", false)
    if not viewedLoreChapters then return false end
    return viewedLoreChapters[ChapterFlagKey(storylineTitle, chapterName)] == true
end

function SM.SetLoreChapterViewed(storylineTitle, chapterName)
    local viewedLoreChapters = GetCharacterChapterFlags("viewedLoreChapters", true)
    if not viewedLoreChapters then return end
    viewedLoreChapters[ChapterFlagKey(storylineTitle, chapterName)] = true
    if SM.InvalidateProgressCache then SM.InvalidateProgressCache() end
end

-- When this character turned in a story quest, for the date WoW Forever's
-- Legacy cards show. The game keeps no such date, so only quests turned in
-- while Story Mode is installed have one.
function SM.RecordQuestTurnInDate(questID)
    local dates = questID and GetCharacterChapterFlags("questTurnInDates", true)
    if dates then dates[questID] = time() end
end

function SM.GetQuestTurnInDate(quest)
    local dates = GetCharacterChapterFlags("questTurnInDates", false)
    if not (dates and quest) then return nil end
    for _, questID in ipairs(SM.GetQuestIDs(quest)) do
        if dates[questID] then return dates[questID] end
    end
    return nil
end

-- How quest cards show a story (WoW Forever): "guided" shows every quest,
-- "explorer" keeps the ones the player hasn't reached yet hidden. One
-- choice for the whole account; guided until the player picks explorer.
function SM.GetQuestCardMode()
    return StoryModeDB and StoryModeDB.questCardMode == "explorer" and "explorer" or "guided"
end

function SM.SetQuestCardMode(mode)
    if not StoryModeDB then return end
    StoryModeDB.questCardMode = mode == "explorer" and "explorer" or nil
end

function SM.IsExplorerMode()
    return SM.GetQuestCardMode() == "explorer"
end

local function GetCharacterRecord(create)
    if not StoryModeDB then return nil end
    local characterKey = CharacterKey()
    if not characterKey then return nil end
    if create and not StoryModeDB.characterChapterFlags then
        StoryModeDB.characterChapterFlags = {}
    end
    local allCharacterFlags = StoryModeDB.characterChapterFlags
    if not allCharacterFlags then return nil end
    if create and not allCharacterFlags[characterKey] then
        allCharacterFlags[characterKey] = {}
    end
    return allCharacterFlags[characterKey]
end

function SM.GetScarletKillCount()
    local record = GetCharacterRecord(false)
    return (record and tonumber(record.scarletKills)) or 0
end

function SM.IncrementScarletKillCount()
    local record = GetCharacterRecord(true)
    if not record then return 0 end
    record.scarletKills = (tonumber(record.scarletKills) or 0) + 1
    return record.scarletKills
end

-- Items this character has held, for story steps that are an item rather
-- than a quest (q.item): once seen, the step stays done after the item is
-- used up, sold or destroyed.
function SM.HasRecordedFoundItem(itemID)
    local record = GetCharacterRecord(false)
    return (record and record.foundItems and record.foundItems[itemID]) == true
end

-- Returns true when the item is new to the record.
function SM.RecordFoundItem(itemID)
    local record = GetCharacterRecord(true)
    if not (record and itemID) then return false end
    record.foundItems = record.foundItems or {}
    if record.foundItems[itemID] then return false end
    record.foundItems[itemID] = true
    return true
end

function SM.IsScarletCrusaderRevealed()
    local record = GetCharacterRecord(false)
    return (record and record.scarletCrusaderRevealed == true) or false
end

function SM.SetScarletCrusaderRevealed()
    local record = GetCharacterRecord(true)
    if not record or record.scarletCrusaderRevealed then return end
    record.scarletCrusaderRevealed = true
    if SM.InvalidateProgressCache then SM.InvalidateProgressCache() end
end

function SM.RecordScarletNamedKill(key)
    if not key then return false end
    local record = GetCharacterRecord(true)
    if not record then return false end
    record.scarletNames = record.scarletNames or {}
    if record.scarletNames[key] then return false end
    record.scarletNames[key] = true
    return true
end

function SM.GetScarletNamedKills()
    local record = GetCharacterRecord(false)
    return record and record.scarletNames or nil
end

function SM.IsScarletVossBannerShown()
    local record = GetCharacterRecord(false)
    return (record and record.scarletVossBanner == true) or false
end

function SM.SetScarletVossBannerShown()
    local record = GetCharacterRecord(true)
    if not record then return end
    record.scarletVossBanner = true
end

function SM.IsScarletCapstoneBannerShown()
    local record = GetCharacterRecord(false)
    return (record and record.scarletCapstoneBanner == true) or false
end

function SM.SetScarletCapstoneBannerShown()
    local record = GetCharacterRecord(true)
    if not record then return end
    record.scarletCapstoneBanner = true
end

function SM.IsChapterPlayed(storylineTitle, chapterName)
    local playedChapters = GetCharacterChapterFlags("playedChapters", false)
    if not playedChapters then return false end
    return playedChapters[ChapterFlagKey(storylineTitle, chapterName)] == true
end

function SM.SetChapterPlayed(storylineTitle, chapterName)
    local playedChapters = GetCharacterChapterFlags("playedChapters", true)
    if not playedChapters then return end
    playedChapters[ChapterFlagKey(storylineTitle, chapterName)] = true
    if SM.InvalidateProgressCache then SM.InvalidateProgressCache() end
end
