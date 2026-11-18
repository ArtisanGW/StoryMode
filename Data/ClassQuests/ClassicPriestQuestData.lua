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
            summary = "If you ever bring the Eye of Divinity out of Molten Core, carry it to the Eastern Plaguelands. Eris Havenfire waits there for a priest who has it, with a trial that asks for more than bright prayers.",
            recap = "The Eye of Divinity came out of Molten Core and into my hands, and it led me to Eris Havenfire in the Eastern Plaguelands. Eris had a test in mind.\n\nPeasants. A whole stream of them, running for their lives with the Scourge behind them. My task was to get fifty through alive. If fifteen fell first, I'd failed. A post nearby keeps count of the dead, and you learn quickly not to look at it.\n\nYou learn other things, too. That frightened people run straight into trouble. That you can't heal everyone at once, so you choose, and keep choosing. That shadow is very good at clearing a path, and the Light is for whoever's on it.\n\nFifty made it. Eris gave me what I'd earned, and with the Eye it became Benediction. I never learned a single one of their names. I remember a good many faces.",
            quests = {
                { id = 7622, name = "The Balance of Light and Shadow", npc = "Eris Havenfire", mapID = 23, x = 0.1700, y = 0.1400, location = "Eris Havenfire, Eastern Plaguelands" },
            },
        },
    },
}
