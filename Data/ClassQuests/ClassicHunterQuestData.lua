local addonName, SM = ...

-- =============================================================================
-- Classic hunter quests
-- Curated identity chains: iconic abilities, tools, weapons, and mounts.
-- =============================================================================

SM.ClassicHunterQuestData = {
    title = "The Hunter's Path",
    description = "When your hunter trainer turns from weapons to trust, learn how to tame and train a beast. Later, if an ancient leaf ever finds its way into your hands, answer the stranger calling from Felwood.",
    zone = "Teldrassil / Dun Morogh / Mulgore / Durotar / Felwood / Molten Core",
    expansion = "Classic",
    class = "HUNTER",
    gameVersions = { classicEra = true, tbc = true },
    color = { 0.67, 0.83, 0.45 },
    icon = 132164,
    adventureCoverTexture = 131851, -- Molten Core: source of the Ancient Petrified Leaf for Rhok'delar
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 6074, name = "The Hunter's Path", npc = "Thorgas Grimson", faction = "Alliance", race = "Dwarf", mapID = 27, x = 0.2918, y = 0.6745, location = "Thorgas Grimson, Dun Morogh" },
    startMapID = 1,
    startX = 0.4600,
    startY = 0.5300,

    chapterIcons = {
        ["Taming the Beast"] = 132164,
        ["Rhok'delar"] = 135489,
    },

    npcDisplayIDs = {
        -- Quest givers' models from the cmangos Classic database.
        ["Jocaste"] = 2206,
        ["Dazalar"] = 1703,
        ["Thorgas Grimson"] = 3395,
        ["Grif Wildheart"] = 3558,
        ["Jen'shan"] = 1882,
        ["Sian'dur"] = 4241,
        ["Thotar"] = 3744,
        -- Quest givers' models from Wowhead's WoW Forever data.
        ["Josephine Carson"] = 137105,
        ["Quel'ana Quickgale"] = 140075,
    },

    chapters = {
        {
            chapter = "Taming the Beast",
            requiredLevel = 10,
            summary = "Use the taming rod on the beasts your trainer names, then return to learn how to keep a companion.",
            recap = "You approached the wild as a hunter must: with patience, caution, and respect. When the final beast yielded, you were no longer meant to travel alone.",
            quests = {
                { id = 94792, name = "Taming the Beast", npc = "Josephine Carson", race = "Human", faction = "Alliance", location = "Josephine Carson, Elwynn Forest", gameVersions = { forever = true } },
                { id = 94863, name = "Taming the Beast", npc = "Josephine Carson", race = "Human", faction = "Alliance", location = "Josephine Carson, Elwynn Forest", gameVersions = { forever = true } },
                { id = 94864, name = "Taming the Beast", npc = "Josephine Carson", race = "Human", faction = "Alliance", location = "Josephine Carson, Elwynn Forest", gameVersions = { forever = true } },
                { id = 94793, name = "Training the Beast", npc = "Josephine Carson", race = "Human", faction = "Alliance", location = "Josephine Carson, Elwynn Forest", gameVersions = { forever = true } },
                { id = 94007, name = "Taming the Beast", race = "Skyborne", location = "Zephras Isle", gameVersions = { forever = true } },
                { id = 94978, name = "Taming the Beast", npc = "Quel'ana Quickgale", race = "Skyborne", location = "Quel'ana Quickgale, Valanaar, Zephras Isle", gameVersions = { forever = true } },
                { id = 94979, name = "Taming the Beast", npc = "Quel'ana Quickgale", race = "Skyborne", location = "Quel'ana Quickgale, Valanaar, Zephras Isle", gameVersions = { forever = true } },
                { id = 94013, name = "Taming the Beast", npc = "Quel'ana Quickgale", race = "Skyborne", location = "Quel'ana Quickgale, Valanaar, Zephras Isle", gameVersions = { forever = true } },
                { id = 94050, name = "Training the Beast", npc = "Quel'ana Quickgale", race = "Skyborne", location = "Quel'ana Quickgale, Valanaar, Zephras Isle", gameVersions = { forever = true } },
                { id = 6071, altIds = { 6073, 6722, 6721, 6072 }, name = "The Hunter's Path", npc = "Jocaste", race = "NightElf", faction = "Alliance", mapID = 89, x = 0.4038, y = 0.0854, location = "Jocaste, Darnassus" },
                { id = 6063, name = "Taming the Beast", npc = "Dazalar", race = "NightElf", mapID = 57, x = 0.5668, y = 0.5949, location = "Dazalar, Teldrassil" },
                { id = 6101, name = "Taming the Beast", npc = "Dazalar", race = "NightElf", mapID = 57, x = 0.5668, y = 0.5949, location = "Dazalar, Teldrassil" },
                { id = 6102, name = "Taming the Beast", npc = "Dazalar", race = "NightElf", mapID = 57, x = 0.5668, y = 0.5949, location = "Dazalar, Teldrassil" },
                { id = 6103, name = "Training the Beast", npc = "Dazalar", race = "NightElf", mapID = 57, x = 0.5668, y = 0.5949, location = "Dazalar, Teldrassil" },
                { id = 6074, altIds = { 6076, 6075 }, name = "The Hunter's Path", npc = "Thorgas Grimson", race = "Dwarf", faction = "Alliance", mapID = 27, x = 0.2918, y = 0.6745, location = "Thorgas Grimson, Dun Morogh" },
                { id = 6064, name = "Taming the Beast", npc = "Grif Wildheart", race = "Dwarf", mapID = 27, x = 0.4581, y = 0.5304, location = "Grif Wildheart, Dun Morogh" },
                { id = 6084, name = "Taming the Beast", npc = "Grif Wildheart", race = "Dwarf", mapID = 27, x = 0.4581, y = 0.5304, location = "Grif Wildheart, Dun Morogh" },
                { id = 6085, name = "Taming the Beast", npc = "Grif Wildheart", race = "Dwarf", mapID = 27, x = 0.4581, y = 0.5304, location = "Grif Wildheart, Dun Morogh" },
                { id = 6086, name = "Training the Beast", npc = "Grif Wildheart", race = "Dwarf", mapID = 27, x = 0.4581, y = 0.5304, location = "Grif Wildheart, Dun Morogh" },
                { id = 6065, altIds = { 6067, 6066 }, name = "The Hunter's Path", npc = "Kary Thunderhorn", race = "Tauren", faction = "Horde", mapID = 88, x = 0.5849, y = 0.8833, location = "Kary Thunderhorn, Thunder Bluff" },
                { id = 6061, name = "Taming the Beast", npc = "Yaw Sharpmane", race = "Tauren", mapID = 7, x = 0.4782, y = 0.5569, location = "Yaw Sharpmane, Mulgore" },
                { id = 6087, name = "Taming the Beast", npc = "Yaw Sharpmane", race = "Tauren", mapID = 7, x = 0.4782, y = 0.5569, location = "Yaw Sharpmane, Mulgore" },
                { id = 6088, name = "Taming the Beast", npc = "Yaw Sharpmane", race = "Tauren", mapID = 7, x = 0.4782, y = 0.5569, location = "Yaw Sharpmane, Mulgore" },
                { id = 6089, name = "Training the Beast", npc = "Yaw Sharpmane", race = "Tauren", mapID = 7, x = 0.4782, y = 0.5569, location = "Yaw Sharpmane, Mulgore" },
                { id = 6068, altIds = { 6070 }, name = "The Hunter's Path", npc = "Jen'shan", race = "Orc", faction = "Horde", mapID = 1, x = 0.4284, y = 0.6933, location = "Valley of Trials, Durotar" },
                { id = 6069, altIds = { 6070 }, name = "The Hunter's Path", npc = "Sian'dur", race = "Troll", faction = "Horde", mapID = 85, x = 0.6796, y = 0.1780, location = "Valley of Honor, Orgrimmar" },
                { id = 6062, name = "Taming the Beast", npc = "Thotar", race = { "Orc", "Troll" }, mapID = 1, x = 0.5185, y = 0.4349, location = "Thotar, Durotar" },
                { id = 6083, name = "Taming the Beast", npc = "Thotar", race = { "Orc", "Troll" }, mapID = 1, x = 0.5185, y = 0.4349, location = "Thotar, Durotar" },
                { id = 6082, name = "Taming the Beast", npc = "Thotar", race = { "Orc", "Troll" }, mapID = 1, x = 0.5185, y = 0.4349, location = "Thotar, Durotar" },
                { id = 6081, name = "Training the Beast", npc = "Thotar", race = { "Orc", "Troll" }, mapID = 1, x = 0.5185, y = 0.4349, location = "Thotar, Durotar" },
            },
        },
        {
            chapter = "Rhok'delar",
            requiredLevel = 60,
            summary = "Bring the Ancient Petrified Leaf to Felwood and hear what the ancients require of a hunter.",
            recap = "The Ancient Petrified Leaf proved to be a summons. The ancients named the demons, and by hunting them alone you earned the right to carry Rhok'delar.",
            quests = {
                { id = 7632, name = "The Ancient Leaf", npc = "Ancient Petrified Leaf", mapID = 77, x = 0.4800, y = 0.2400, location = "Irontree Woods, Felwood" },
                -- WoW Forever's server refused these three in the 1.60.1.70938 quest scan; the scan report flags them once it answers.
                { id = 7636, name = "Stave of the Ancients", npc = "Vartrus the Ancient", gameVersions = { classicEra = true, tbc = true, forever = false }, mapID = 77, x = 0.4800, y = 0.2400, location = "Vartrus the Ancient, Irontree Woods, Felwood" },
                { id = 7635, name = "A Proper String", npc = "Stoma the Ancient", gameVersions = { classicEra = true, tbc = true, forever = false }, mapID = 77, x = 0.4800, y = 0.2400, location = "Stoma the Ancient, Irontree Woods, Felwood" },
                { id = 7634, name = "Ancient Sinew Wrapped Lamina", npc = "Hastat the Ancient", gameVersions = { classicEra = true, tbc = true, forever = false }, mapID = 77, x = 0.4800, y = 0.2400, location = "Hastat the Ancient, Irontree Woods, Felwood" },
            },
        },
    },
}
