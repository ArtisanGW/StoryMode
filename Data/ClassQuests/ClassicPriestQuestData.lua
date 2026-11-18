local addonName, SM = ...

-- =============================================================================
-- Classic priest quests
-- Curated identity chains: iconic abilities, tools, weapons, and mounts.
-- =============================================================================

SM.ClassicPriestQuestData = {
    title = "Benediction",
    description = "If the Eye of Divinity comes into your possession, seek Eris Havenfire in the Eastern Plaguelands. She has a trial that asks for more than quick hands and bright prayers.\n\nStand between panic and shadow, save who you can, and learn whether your faith holds when every mistake has a cost.",
    zone = "Molten Core / Eastern Plaguelands",
    expansion = "Classic",
    class = "PRIEST",
    -- Hidden on WoW Forever: its server refused this quest in the 1.60.1.70938 scan. The scan report flags it once the server answers.
    gameVersions = { classicEra = true, tbc = true, forever = false },
    color = { 1.00, 1.00, 1.00 },
    icon = 135940,
    adventureCoverTexture = 131851, -- Molten Core: source of the Eye of Divinity before the Benediction trial
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 7622, name = "The Balance of Light and Shadow", npc = "Eris Havenfire", mapID = 23, x = 0.1700, y = 0.1400, location = "Eris Havenfire, Eastern Plaguelands" },
    startMapID = 23,
    startX = 0.1700,
    startY = 0.1400,

    chapterIcons = {
        ["The Balance of Light and Shadow"] = 135939,
    },

    chapters = {
        {
            chapter = "The Balance of Light and Shadow",
            requiredLevel = 60,
            summary = "With the Eye of Divinity in hand, seek Eris Havenfire and protect the spirits entrusted to you.",
            recap = "Eris Havenfire's trial tested mercy under pressure. You kept the fallen moving, held shadow at bay, and earned Benediction through discipline and compassion.",
            quests = {
                { id = 7622, name = "The Balance of Light and Shadow", npc = "Eris Havenfire", mapID = 23, x = 0.1700, y = 0.1400, location = "Eris Havenfire, Eastern Plaguelands" },
            },
        },
    },
}
