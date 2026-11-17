local addonName, SM = ...

-- =============================================================================
-- Classic class quests
-- Curated identity chains: iconic abilities, tools, weapons, and mounts.
-- =============================================================================

SM.ClassicDruidQuestData = {
    title = "The Cenarion Path",
    description = "Your trainer sends you to Moonglade for lessons that cannot be taught in a city. The Cenarion Circle has work for young druids who are ready to listen to spirits, heal sick beasts, and follow the call of distant waters.",
    zone = "Moonglade / Darkshore / Westfall / The Barrens",
    expansion = "Classic",
    class = "DRUID",
    gameVersions = { classicEra = true, tbc = true },
    color = { 1.00, 0.49, 0.04 },
    icon = 136041,
    adventureCoverTexture = 131882, -- Wailing Caverns: Cenarion/Naralex nature imagery closest to Classic druid class fantasy
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 5923, name = "Heeding the Call", excludeRace = "Skyborne", npc = "Kal", faction = "Alliance", mapID = 57, x = 0.5595, y = 0.6156, location = "Kal, Teldrassil" },
    startMapID = 80,
    startX = 0.5600,
    startY = 0.3000,

    chapterIcons = {
        ["Bear Form"] = 132276,
        ["Cure Poison"] = 136067,
        ["Aquatic Form"] = 132112,
    },

    chapters = {
        {
            chapter = "Bear Form",
            requiredLevel = 10,
            summary = "Travel to Moonglade, hear the Great Bear Spirit, and return ready for the trial of body and heart.",
            recap = "You answered the call to Moonglade and learned from the Great Bear Spirit. When the final trial was done, the strength of the bear was yours to call upon in battle.",
            quests = {
                { id = 94006, name = "The Great Ursera Spirit", race = "Skyborne", location = "Zephras Isle", gameVersions = { forever = true } },
                { id = 94638, name = "Strength and Mercy", npc = "Urs'endris", race = "Skyborne", location = "Urs'endris, falls northeast of Valanaar, Zephras Isle", gameVersions = { forever = true } },
                { id = 5923, altIds = { 5924, 5925 }, name = "Heeding the Call", excludeRace = "Skyborne", npc = "Kal", faction = "Alliance", mapID = 57, x = 0.5595, y = 0.6156, location = "Kal, Teldrassil" },
                { id = 5921, altIds = { 94914 }, name = "Moonglade", excludeRace = "Skyborne", npc = "Mathrengyl Bearwalker", faction = "Alliance", mapID = 89, x = 0.3537, y = 0.0840, location = "Mathrengyl Bearwalker, Darnassus" },
                { id = 5929, name = "Great Bear Spirit", excludeRace = "Skyborne", npc = "Dendrite Starblaze", faction = "Alliance", mapID = 80, x = 0.5621, y = 0.3064, location = "Dendrite Starblaze, Nighthaven, Moonglade" },
                { id = 5931, name = "Back to Darnassus", excludeRace = "Skyborne", npc = "Dendrite Starblaze", faction = "Alliance", mapID = 80, x = 0.5621, y = 0.3064, location = "Dendrite Starblaze, Nighthaven, Moonglade" },
                { id = 6001, name = "Body and Heart", excludeRace = "Skyborne", npc = "Mathrengyl Bearwalker", faction = "Alliance", mapID = 89, x = 0.3537, y = 0.0840, location = "Mathrengyl Bearwalker, Darnassus" },
                { id = 5926, altIds = { 5927, 5928 }, name = "Heeding the Call", excludeRace = "Skyborne", npc = "Gennia Runetotem", faction = "Horde", mapID = 7, x = 0.4848, y = 0.5964, location = "Gennia Runetotem, Mulgore" },
                { id = 5922, altIds = { 94913 }, name = "Moonglade", excludeRace = "Skyborne", npc = "Turak Runetotem", faction = "Horde", mapID = 88, x = 0.7648, y = 0.2722, location = "Turak Runetotem, Thunder Bluff" },
                { id = 5930, name = "Great Bear Spirit", excludeRace = "Skyborne", npc = "Dendrite Starblaze", faction = "Horde", mapID = 80, x = 0.5621, y = 0.3064, location = "Dendrite Starblaze, Nighthaven, Moonglade" },
                { id = 5932, name = "Back to Thunder Bluff", excludeRace = "Skyborne", npc = "Dendrite Starblaze", faction = "Horde", mapID = 80, x = 0.5621, y = 0.3064, location = "Dendrite Starblaze, Nighthaven, Moonglade" },
                { id = 6002, name = "Body and Heart", excludeRace = "Skyborne", npc = "Turak Runetotem", faction = "Horde", mapID = 88, x = 0.7648, y = 0.2722, location = "Turak Runetotem, Thunder Bluff" },
            },
        },
        {
            chapter = "Cure Poison",
            requiredLevel = 14,
            summary = "Follow the Circle's instructions, gather what is needed for a cure, and cleanse the sick beasts you find.",
            recap = "The Circle sent you from lesson to remedy. You found the source of the sickness, gathered the cure, and restored creatures that had been left to suffer.",
            quests = {
                { id = 6121, name = "Lessons Anew", npc = "Mathrengyl Bearwalker", faction = "Alliance", mapID = 89, x = 0.3537, y = 0.0840, location = "Mathrengyl Bearwalker, Darnassus" },
                { id = 6122, name = "The Principal Source", npc = "Dendrite Starblaze", faction = "Alliance", mapID = 80, x = 0.5621, y = 0.3064, location = "Dendrite Starblaze, Nighthaven, Moonglade" },
                { id = 6123, name = "Gathering the Cure", npc = "Alanndarian Nightsong", faction = "Alliance", mapID = 62, x = 0.3769, y = 0.4066, location = "Alanndarian Nightsong, Auberdine, Darkshore" },
                { id = 6124, name = "Curing the Sick", npc = "Alanndarian Nightsong", faction = "Alliance", mapID = 62, x = 0.3769, y = 0.4066, location = "Alanndarian Nightsong, Auberdine, Darkshore" },
                { id = 6125, name = "Power over Poison", npc = "Dendrite Starblaze", faction = "Alliance", mapID = 80, x = 0.5621, y = 0.3064, location = "Dendrite Starblaze, Nighthaven, Moonglade" },
                { id = 6126, name = "Lessons Anew", npc = "Turak Runetotem", faction = "Horde", mapID = 88, x = 0.7648, y = 0.2722, location = "Turak Runetotem, Thunder Bluff" },
                { id = 6127, name = "The Principal Source", npc = "Dendrite Starblaze", faction = "Horde", mapID = 80, x = 0.5621, y = 0.3064, location = "Dendrite Starblaze, Nighthaven, Moonglade" },
                { id = 6128, name = "Gathering the Cure", npc = "Torwa Pathfinder", faction = "Horde", mapID = 78, x = 0.7161, y = 0.7593, location = "Torwa Pathfinder, Un'Goro Crater" },
                { id = 6129, name = "Curing the Sick", npc = "Tonga Runetotem", faction = "Horde", mapID = 10, x = 0.5226, y = 0.3193, location = "Tonga Runetotem, The Barrens" },
                { id = 6130, name = "Power over Poison", npc = "Dendrite Starblaze", faction = "Horde", mapID = 80, x = 0.5621, y = 0.3064, location = "Dendrite Starblaze, Nighthaven, Moonglade" },
            },
        },
        {
            chapter = "Aquatic Form",
            requiredLevel = 16,
            summary = "Seek the halves of the pendant across lake and sea so the form of the sea lion may be taught.",
            recap = "The water trial carried you beyond the safety of your trainer. When the pendant was made whole, the sea lion form answered, and deeper waters opened to you.",
            quests = {
                { id = 26, name = "A Lesson to Learn", npc = "Mathrengyl Bearwalker", faction = "Alliance", mapID = 89, x = 0.3537, y = 0.0840, location = "Mathrengyl Bearwalker, Darnassus" },
                { id = 29, name = "Trial of the Lake", npc = "Dendrite Starblaze", faction = "Alliance", mapID = 80, x = 0.5621, y = 0.3064, location = "Dendrite Starblaze, Nighthaven, Moonglade" },
                { id = 272, name = "Trial of the Sea Lion", npc = "Tajarri", faction = "Alliance", mapID = 80, x = 0.3652, y = 0.4010, location = "Tajarri, Nighthaven, Moonglade" },
                { id = 5061, name = "Aquatic Form", npc = "Dendrite Starblaze", faction = "Alliance", mapID = 80, x = 0.5621, y = 0.3064, location = "Dendrite Starblaze, Nighthaven, Moonglade" },
                { id = 27, name = "A Lesson to Learn", npc = "Turak Runetotem", faction = "Horde", mapID = 88, x = 0.7648, y = 0.2722, location = "Turak Runetotem, Thunder Bluff" },
                { id = 28, name = "Trial of the Lake", npc = "Dendrite Starblaze", faction = "Horde", mapID = 80, x = 0.5621, y = 0.3064, location = "Dendrite Starblaze, Nighthaven, Moonglade" },
                { id = 30, name = "Trial of the Sea Lion", npc = "Tajarri", faction = "Horde", mapID = 80, x = 0.3652, y = 0.4010, location = "Tajarri, Nighthaven, Moonglade" },
                { id = 31, name = "Aquatic Form", npc = "Dendrite Starblaze", faction = "Horde", mapID = 80, x = 0.5621, y = 0.3064, location = "Dendrite Starblaze, Nighthaven, Moonglade" },
            },
        },
        {
            chapter = "Cat Form",
            requiredLevel = 20,
            gameVersions = { forever = true },
            summary = "Answer Dendrite Starblaze's summons to Moonglade and seek the cat spirit on the southern hills, which teaches cunning and stealth only to those who earn them.",
            recap = "Dendrite Starblaze sent you to a spirit of the cat in southern Moonglade. It asked for the relics of fang, claw, and silent shadow hidden in the Stormrage Barrow Dens, and you brought them back. With its blessing the feline shape was yours, and Dendrite sent you home to the teacher who had sent you.",
            quests = {
                { id = 98393, name = "The Great Cat Spirit", npc = "Mathrengyl Bearwalker", faction = "Alliance", mapID = 89, x = 0.3537, y = 0.0840, location = "Mathrengyl Bearwalker, Darnassus", gameVersions = { forever = true } },
                { id = 98340, name = "The Great Cat Spirit", npc = "Turak Runetotem", faction = "Horde", mapID = 88, x = 0.7648, y = 0.2722, location = "Turak Runetotem, Thunder Bluff", gameVersions = { forever = true } },
                { id = 98394, name = "The Great Cat Spirit", npc = "Dendrite Starblaze", faction = "Alliance", mapID = 80, x = 0.5621, y = 0.3064, location = "Dendrite Starblaze, Nighthaven, Moonglade", gameVersions = { forever = true } },
                { id = 98405, name = "The Great Cat Spirit", npc = "Dendrite Starblaze", faction = "Horde", mapID = 80, x = 0.5621, y = 0.3064, location = "Dendrite Starblaze, Nighthaven, Moonglade", gameVersions = { forever = true } },
                { id = 98341, name = "The Great Windborne Cat Spirit", npc = "Dendrite Starblaze", race = "Skyborne", mapID = 80, x = 0.5621, y = 0.3064, location = "Dendrite Starblaze, Nighthaven, Moonglade", gameVersions = { forever = true } },
                { id = 98396, name = "The Great Cat Spirit", npc = "Great Cat Spirit", faction = "Alliance", mapID = 1450, x = 0.5440, y = 0.7500, location = "Great Cat Spirit, Moonglade", gameVersions = { forever = true } },
                { id = 98342, name = "The Great Cat Spirit", npc = "Great Cat Spirit", faction = "Horde", mapID = 1450, x = 0.5440, y = 0.7500, location = "Great Cat Spirit, Moonglade", gameVersions = { forever = true } },
                { id = 98404, name = "The Great Windborne Cat Spirit", npc = "Avatar of Saeyleenan", race = "Skyborne", mapID = 1450, x = 0.4390, y = 0.7340, location = "Avatar of Saeyleenan, Moonglade", gameVersions = { forever = true } },
                { id = 98731, name = "Blessings of the Great Cat Spirit", npc = "Great Cat Spirit", faction = "Alliance", mapID = 1450, x = 0.5440, y = 0.7500, location = "Great Cat Spirit, Moonglade", gameVersions = { forever = true } },
                { id = 98739, name = "Blessings of the Great Cat Spirit", npc = "Great Cat Spirit", faction = "Horde", mapID = 1450, x = 0.5440, y = 0.7500, location = "Great Cat Spirit, Moonglade", gameVersions = { forever = true } },
                { id = 98738, name = "Blessings of the Great Windborne Cat Spirit", npc = "Avatar of Saeyleenan", race = "Skyborne", mapID = 1450, x = 0.4390, y = 0.7340, location = "Avatar of Saeyleenan, Moonglade", gameVersions = { forever = true } },
                { id = 98397, name = "To Darnassus", npc = "Dendrite Starblaze", faction = "Alliance", mapID = 80, x = 0.5621, y = 0.3064, location = "Dendrite Starblaze, Nighthaven, Moonglade", gameVersions = { forever = true } },
                { id = 98362, name = "To Thunder Bluff", npc = "Dendrite Starblaze", faction = "Horde", mapID = 80, x = 0.5621, y = 0.3064, location = "Dendrite Starblaze, Nighthaven, Moonglade", gameVersions = { forever = true } },
            },
        },
    },
}

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

SM.ClassicMageQuestData = {
    id = "mage-s-wand",  -- from its earlier title, "Mage's Wand": saved progress and share links use it
    title = "Tabetha's Lessons",
    description = "Your mage trainer sends you to Tabetha in Dustwallow Marsh, where practical magic begins with travel, errands, and materials that will not gather themselves.\n\nFollow the lessons that turn study into tools: a wand, a strange polymorph, and food enough for hungry companions.",
    zone = "Dustwallow Marsh / Scarlet Monastery / Azshara / Dire Maul",
    expansion = "Classic",
    class = "MAGE",
    gameVersions = { classicEra = true, tbc = true },
    color = { 0.25, 0.78, 0.92 },
    icon = 135932,
    adventureCoverTexture = 131835, -- Dire Maul: arcane library setting for Arcane Refreshment
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 1947, name = "Journey to the Marsh", npc = "Jennea Cannon", mapID = 84, x = 0.3854, y = 0.7934, location = "Jennea Cannon, Stormwind" },
    startMapID = 70,
    startX = 0.4600,
    startY = 0.5700,

    chapterIcons = {
        ["Boughs in the Wind"] = 135463,
        ["Mage's Wand"] = 135463,
        ["Polymorph: Pig"] = 135997,
        ["Arcane Refreshment"] = 132805,
    },

    chapters = {
        {
            chapter = "Boughs in the Wind",
            requiredLevel = 10,
            gameVersions = { forever = true },
            summary = "Take part in one of the High Order's oldest traditions and seek out Belann Windwood in Valanaar to craft a spell focus of your own.",
            recap = "Belann Windwood had shaped staves and wands for the High Order for more than a century, and he asked only for a fallen bough from the oldest trees of Zephras, touched by the wind. You found one and brought it to him, and from it he made a focus that was yours alone.",
            quests = {
                { id = 93791, name = "Speak with Belann", race = "Skyborne", location = "Zephras Isle", gameVersions = { forever = true } },
                { id = 93797, name = "Boughs in the Wind", npc = "Belann Windwood", race = "Skyborne", location = "Belann Windwood, Valanaar, Zephras Isle", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "Mage's Wand",
            requiredLevel = 30,
            summary = "Go to Tabetha in Dustwallow Marsh, recover the knowledge she needs, and prepare a wand of your chosen school.",
            recap = "Tabetha's work asked for texts, materials, and a measure of field sense. When the ritual was complete, your studies had a proper focus in hand.",
            quests = {
                { id = 1947, name = "Journey to the Marsh", npc = "Jennea Cannon", faction = "Alliance", mapID = 84, x = 0.3854, y = 0.7934, location = "Jennea Cannon, Stormwind" },
                { id = 1947, name = "Journey to the Marsh", npc = "Deino", faction = "Horde", mapID = 85, x = 0.3845, y = 0.8613, location = "Deino, Orgrimmar" },
                { id = 1949, name = "Hidden Secrets", npc = "Tabetha", mapID = 70, x = 0.4606, y = 0.5709, location = "Tabetha, Dustwallow Marsh" },
                { id = 1950, name = "Get the Scoop", npc = "Magus Tirth", mapID = 64, x = 0.7829, y = 0.7570, location = "Magus Tirth, Thousand Needles" },
                { id = 1951, name = "Rituals of Power", npc = "Magus Tirth", mapID = 64, x = 0.7829, y = 0.7570, location = "Magus Tirth, Thousand Needles" },
                { id = 1948, name = "Items of Power", npc = "Tabetha", mapID = 70, x = 0.4606, y = 0.5709, location = "Tabetha, Dustwallow Marsh" },
                { id = 1952, name = "Mage's Wand", npc = "Tabetha", mapID = 70, x = 0.4606, y = 0.5709, location = "Tabetha, Dustwallow Marsh" },
            },
        },
        {
            chapter = "Polymorph: Pig",
            requiredLevel = 60,
            summary = "Answer Archmage Xylem's request in Azshara and study the magic left by Warlord Krellian.",
            recap = "Krellian's magic broke apart in curious ways, and Xylem knew what to make of it. The result was odd, useful, and unmistakably a mage's lesson.",
            quests = {
                { id = 9362, name = "Warlord Krellian", npc = "Archmage Xylem", mapID = 76, x = 0.2971, y = 0.4052, location = "Archmage Xylem, Azshara" },
                { id = 90789, name = "Scalebeard", npc = "Archmage Xylem", optional = true, mapID = 76, x = 0.2971, y = 0.4052, location = "Archmage Xylem, Azshara", gameVersions = { forever = true } },
                { id = 9364, name = "Fragmented Magic", npc = "Archmage Xylem", mapID = 76, x = 0.2971, y = 0.4052, location = "Archmage Xylem, Azshara" },
            },
        },
        {
            chapter = "Arcane Refreshment",
            requiredLevel = 60,
            summary = "Enter Dire Maul and recover the knowledge Lorekeeper Lydros keeps in the Athenaeum.",
            recap = "Lorekeeper Lydros entrusted you with a spell every company of adventurers comes to value. Power is not always flame and frost; sometimes it is preparation.",
            quests = {
                { id = 7463, name = "Arcane Refreshment", npc = "Lorekeeper Lydros", mapID = 234, x = 0.2470, y = 0.6480, location = "Lorekeeper Lydros, Athenaeum, Dire Maul" },
            },
        },
    },
}

SM.ClassicPaladinQuestData = {
    title = "The Tome of Valor",
    description = "Speak with Duthorian Rall and take up the Tome of Valor. A paladin's lessons are not only prayers; they ask for aid given, judgment shown, and materials gathered with care.\n\nFollow the order's tests from early duty to the rites reserved for those who have carried the Light long enough to be trusted with more.",
    zone = "Stormwind / Ironforge / Western Plaguelands / Scholomance",
    -- WoW Forever adds Forsaken paladins, so the Alliance limit sits on the
    -- Alliance chapters and quest lines rather than on the story.
    zoneByFaction = {
        Alliance = "Stormwind / Ironforge / Western Plaguelands / Scholomance",
        Horde = "Tirisfal Glades / Silverpine Forest / Scholomance",
    },
    expansion = "Classic",
    class = "PALADIN",
    gameVersions = { classicEra = true, tbc = true },
    color = { 0.96, 0.55, 0.73 },
    icon = 135920,
    adventureCoverTexture = 131868, -- Scholomance: final charger judgment and redemption trial
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 1793, name = "The Tome of Valor", npc = "Duthorian Rall", faction = "Alliance", mapID = 84, x = 0.3981, y = 0.2980, location = "Duthorian Rall, Stormwind" },
    startMapID = 84,
    startX = 0.3900,
    startY = 0.3200,

    chapterIcons = {
        ["The Tome of Valor"] = 133739,
        ["The Test of Righteousness"] = 132401,
        ["A Paladin's Steed"] = 136103,
        ["The Charger"] = 136103,
    },

    chapters = {
        {
            chapter = "Rediscovering the Light",
            requiredLevel = 2,
            faction = "Horde",
            gameVersions = { forever = true },
            summary = "Rise in Deathknell with the Light still burning in you, and learn from Aramis Hammerhand what it means to be a paladin among the Forsaken.",
            recap = "The Light hurt to hold at first, but Aramis Hammerhand taught you to turn it toward mending the Deathguard. You sought out a frightened brother who could not yet accept what he had become, and then the road led east to Brill, where Shari Stilwell waited to continue your training.",
            quests = {
                { id = 90902, name = "Rediscovering the Light", npc = "Aramis Hammerhand", faction = "Horde", race = "Scourge", mapID = 1420, x = 0.3100, y = 0.6620, location = "Aramis Hammerhand, Deathknell, Tirisfal Glades", gameVersions = { forever = true } },
                { id = 91208, name = "Coming to Terms", npc = "Aramis Hammerhand", faction = "Horde", race = "Scourge", mapID = 1420, x = 0.3100, y = 0.6620, location = "Aramis Hammerhand, Deathknell, Tirisfal Glades", gameVersions = { forever = true } },
                { id = 91209, name = "Continue Your Training", npc = "Aramis Hammerhand", faction = "Horde", race = "Scourge", mapID = 1420, x = 0.3100, y = 0.6620, location = "Aramis Hammerhand, Deathknell, Tirisfal Glades", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "A Second Home",
            requiredLevel = 8,
            faction = "Horde",
            gameVersions = { forever = true },
            summary = "Follow Shari Stilwell's directions to Bandarion Keep, where risen paladins are building a home of their own on the western edge of Tirisfal.",
            recap = "Breton Samuels welcomed you once the Vile Fin murlocs were driven from the gates, and Danitha Morr showed you what the keep could become. When the tarnished paladins who still turned their blades on their own kind were put down, you carried Commander Rudolph Gelhardt's head to Sylvanas Windrunner, a token of good faith from an order she barely trusts.",
            quests = {
                { id = 91282, name = "A Second Home", npc = "Shari Stilwell", faction = "Horde", race = "Scourge", mapID = 1420, x = 0.6020, y = 0.5260, location = "Shari Stilwell, Brill, Tirisfal Glades", gameVersions = { forever = true } },
                { id = 91285, name = "Murlocs at the Gates", npc = "Breton Samuels", faction = "Horde", race = "Scourge", mapID = 1420, x = 0.2180, y = 0.4520, location = "Breton Samuels, Bandarion Keep, Tirisfal Glades", gameVersions = { forever = true } },
                { id = 91294, name = "Touring the Grounds", npc = "Breton Samuels", faction = "Horde", race = "Scourge", mapID = 1420, x = 0.2180, y = 0.4520, location = "Breton Samuels, Bandarion Keep, Tirisfal Glades", gameVersions = { forever = true } },
                { id = 91317, name = "The Tarnished", npc = "Danitha Morr", faction = "Horde", race = "Scourge", mapID = 1420, x = 0.2200, y = 0.4460, location = "Danitha Morr, Bandarion Keep, Tirisfal Glades", gameVersions = { forever = true } },
                { id = 95803, name = "A Token of Good Faith", npc = "Danitha Morr", faction = "Horde", mapID = 1420, x = 0.2200, y = 0.4460, location = "Danitha Morr, Bandarion Keep, Tirisfal Glades", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "A Lesson in Divinity",
            requiredLevel = 12,
            faction = "Horde",
            gameVersions = { forever = true },
            summary = "Danitha Morr teaches that a paladin pursues goodness for its own sake. Seek out Tanis Alderwood in the Undercity and see where the lesson leads.",
            recap = "Tanis Alderwood asked only for linen to hold his failing wife together, and he could not understand why a paladin would bother. Danitha then placed the Symbol of Life in your hands. At Venomweb Vale you raised Deathguard Falgan from his second death and took the Scarlet Crusade's attack plans, so the Deathguard could ready themselves before the blow fell on Brill.",
            quests = {
                { id = 94427, name = "A Lesson in Divinity", npc = "Danitha Morr", faction = "Horde", mapID = 1420, x = 0.2200, y = 0.4460, location = "Danitha Morr, Bandarion Keep, Tirisfal Glades", gameVersions = { forever = true } },
                { id = 94434, name = "A Lesson in Divinity", npc = "Tanis Alderwood", faction = "Horde", mapID = 1458, x = 0.6480, y = 0.3860, location = "Tanis Alderwood, Undercity", gameVersions = { forever = true } },
                { id = 94435, name = "A Lesson in Divinity", npc = "Tanis Alderwood", faction = "Horde", mapID = 1458, x = 0.6480, y = 0.3860, location = "Tanis Alderwood, Undercity", gameVersions = { forever = true } },
                { id = 94436, name = "A Lesson in Divinity", npc = "Danitha Morr", faction = "Horde", mapID = 1420, x = 0.2200, y = 0.4460, location = "Danitha Morr, Bandarion Keep, Tirisfal Glades", gameVersions = { forever = true } },
                { id = 94438, name = "A Lesson in Divinity", npc = "Deathguard Billmuth", faction = "Horde", location = "Deathguard Billmuth, Bandarion Keep, Tirisfal Glades", gameVersions = { forever = true } },
                { id = 94440, name = "A Lesson in Divinity", npc = "Deathguard Falgan", faction = "Horde", location = "Deathguard Falgan, Venomweb Vale, Tirisfal Glades", gameVersions = { forever = true } },
                { id = 94441, name = "A Lesson in Divinity", npc = "Deathguard Billmuth", faction = "Horde", location = "Deathguard Billmuth, Bandarion Keep, Tirisfal Glades", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "The Moonsilver Blade",
            requiredLevel = 18,
            faction = "Horde",
            gameVersions = { forever = true },
            summary = "Danitha Morr sees a chance for Bandarion Keep to prove its worth to the Horde. Travel to the Sepulcher and help find the Earthen Ring travelers who vanished in Silverpine Forest.",
            recap = "One traveler lay dead on Fenris Isle, but Lumina Windsinger of the Windshaper Skyborne was alive in Fenris Keep, and you fought your way out at her side. She told you a worgen had struck them on the road, and that one of those beasts would not stay dead. You gathered what Trevan Rol asked for, Ott of Tarren Mill forged it into the Moonsilver Blade, and with it you went hunting for Old Fire-Eye.",
            quests = {
                { id = 91858, name = "Diplomatic Incident", npc = "Danitha Morr", faction = "Horde", race = "Scourge", mapID = 1420, x = 0.2200, y = 0.4460, location = "Danitha Morr, Bandarion Keep, Tirisfal Glades", gameVersions = { forever = true } },
                { id = 91859, name = "A Curious Pair", npc = "Trevan Rol", faction = "Horde", race = "Scourge", mapID = 1421, x = 0.4340, y = 0.4100, location = "Trevan Rol, The Sepulcher, Silverpine Forest", gameVersions = { forever = true } },
                { id = 91860, name = "A Grim Fate", npc = "Deathguard Baldren", faction = "Horde", race = "Scourge", mapID = 1421, x = 0.4560, y = 0.4180, location = "Deathguard Baldren, The Sepulcher, Silverpine Forest", gameVersions = { forever = true } },
                { id = 91861, name = "Into Fenris Keep", faction = "Horde", race = "Scourge", mapID = 1421, x = 0.6500, y = 0.3420, location = "Fenris Isle, Silverpine Forest", gameVersions = { forever = true } },
                { id = 91862, name = "Lumina Windsinger", npc = "Lumina Windsinger", faction = "Horde", race = "Scourge", mapID = 1421, x = 0.6570, y = 0.2740, location = "Lumina Windsinger, Fenris Keep, Silverpine Forest", gameVersions = { forever = true } },
                { id = 96204, name = "The Windshaper's Wrath", npc = "Lumina Windsinger", faction = "Horde", race = "Scourge", mapID = 1421, x = 0.6570, y = 0.2740, location = "Lumina Windsinger, Fenris Keep, Silverpine Forest", gameVersions = { forever = true } },
                { id = 95034, name = "The Debt", npc = "Lumina Windsinger", faction = "Horde", race = "Scourge", mapID = 1421, x = 0.4320, y = 0.4100, location = "Lumina Windsinger, The Sepulcher, Silverpine Forest", gameVersions = { forever = true } },
                { id = 95036, name = "A Moon-Kissed Blade", npc = "Lumina Windsinger", faction = "Horde", race = "Scourge", mapID = 1421, x = 0.4320, y = 0.4100, location = "Lumina Windsinger, The Sepulcher, Silverpine Forest", gameVersions = { forever = true } },
                { id = 95111, name = "An Underrated Talent", npc = "Trevan Rol", faction = "Horde", race = "Scourge", mapID = 1421, x = 0.4340, y = 0.4100, location = "Trevan Rol, The Sepulcher, Silverpine Forest", gameVersions = { forever = true } },
                { id = 95125, name = "Ott's Masterwork", npc = "Ott", faction = "Horde", race = "Scourge", mapID = 1424, x = 0.6040, y = 0.2600, location = "Ott, Tarren Mill, Hillsbrad Foothills", gameVersions = { forever = true } },
                { id = 95126, name = "The Moonsilver Blade", npc = "Ott", faction = "Horde", race = "Scourge", mapID = 1424, x = 0.6040, y = 0.2600, location = "Ott, Tarren Mill, Hillsbrad Foothills", gameVersions = { forever = true } },
                { id = 95140, name = "Old Fire-Eye", npc = "Lumina Windsinger", faction = "Horde", mapID = 1421, x = 0.4320, y = 0.4100, location = "Lumina Windsinger, The Sepulcher, Silverpine Forest", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "The Tome of Valor",
            requiredLevel = 20,
            faction = "Alliance",
            summary = "Carry Duthorian Rall's lesson to Westfall and prove that valor protects those who cannot stand alone.",
            recap = "The Tome of Valor led you to Daphne Stilwell and a hard lesson in service. Valor was not spoken over you; it was proven on a dangerous road.",
            quests = {
                { id = 1793, name = "The Tome of Valor", npc = "Duthorian Rall", faction = "Alliance", mapID = 84, x = 0.3981, y = 0.2980, location = "Duthorian Rall, Stormwind" },
                { id = 1649, name = "The Tome of Valor", npc = "Daphne Stilwell", faction = "Alliance", mapID = 52, x = 0.4175, y = 0.8913, location = "Daphne Stilwell, Westfall" },
                { id = 1650, name = "The Tome of Valor", npc = "Duthorian Rall", faction = "Alliance", mapID = 84, x = 0.3981, y = 0.2980, location = "Duthorian Rall, Stormwind" },
                { id = 1651, name = "The Tome of Valor", npc = "Daphne Stilwell", faction = "Alliance", mapID = 52, x = 0.4175, y = 0.8913, location = "Daphne Stilwell, Westfall" },
                { id = 1652, name = "The Tome of Valor", npc = "Daphne Stilwell", faction = "Alliance", mapID = 52, x = 0.4175, y = 0.8913, location = "Daphne Stilwell, Westfall" },
            },
        },
        {
            chapter = "The Test of Righteousness",
            requiredLevel = 20,
            faction = "Alliance",
            summary = "Gather Jordan Stilwell's materials from distant dangers and help forge Verigan's Fist.",
            recap = "You carried ore, gems, and other hard-won materials back to Jordan Stilwell. Verigan's Fist was not granted by ceremony alone; it was made through effort.",
            quests = {
                { id = 1653, name = "The Test of Righteousness", npc = "Duthorian Rall", faction = "Alliance", mapID = 84, x = 0.3981, y = 0.2980, location = "Duthorian Rall, Stormwind" },
                { id = 1654, name = "The Test of Righteousness", npc = "Jordan Stilwell", faction = "Alliance", mapID = 27, x = 0.5249, y = 0.3692, location = "Jordan Stilwell, Dun Morogh" },
                { id = 1655, name = "Bailor's Ore Shipment", npc = "Bailor Stonehand", faction = "Alliance", mapID = 48, x = 0.3595, y = 0.4491, location = "Bailor Stonehand, Loch Modan" },
                { id = 1442, name = "Seeking the Kor Gem", npc = "Thundris Windweaver", faction = "Alliance", mapID = 62, x = 0.3740, y = 0.4013, location = "Thundris Windweaver, Auberdine, Darkshore" },
                { id = 1806, name = "The Test of Righteousness", npc = "Jordan Stilwell", faction = "Alliance", mapID = 27, x = 0.5249, y = 0.3692, location = "Jordan Stilwell, Dun Morogh" },
            },
        },
        {
            chapter = "A Paladin's Steed",
            requiredLevel = 40,
            faction = "Horde",
            gameVersions = { forever = true },
            summary = "Danitha Morr has called you back to Bandarion Keep. A paladin's warhorse is consecrated for battle, and it is time you had one of your own.",
            recap = "Danitha Morr summoned you home to Bandarion Keep and taught you to call a warhorse of your own, a consecrated steed as fearless as the paladins it carries into battle.",
            quests = {
                { id = 97022, name = "Report to Danitha", faction = "Horde", gameVersions = { forever = true } },
                { id = 94971, name = "A Paladin's Steed", npc = "Danitha Morr", faction = "Horde", mapID = 1420, x = 0.2200, y = 0.4460, location = "Danitha Morr, Bandarion Keep, Tirisfal Glades", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "The Charger",
            requiredLevel = 60,
            summary = "Begin Lord Grayson Shadowbreaker's rite and prepare yourself for the charger's judgment.",
            recap = "The charger's trial demanded sacrifice, craft, and courage in haunted places. At the end, the spirit answered the Light and came to your side.",
            quests = {
                { id = 97174, name = "A Worthy Endeavor", faction = "Horde", gameVersions = { forever = true } },
                { id = 97175, name = "Due Sacrifice", npc = "Danitha Morr", faction = "Horde", mapID = 1420, x = 0.2200, y = 0.4460, location = "Danitha Morr, Bandarion Keep, Tirisfal Glades", gameVersions = { forever = true } },
                { id = 97177, name = "Acts of Mercy", npc = "Zayus", faction = "Horde", mapID = 1454, x = 0.3540, y = 0.8720, location = "Zayus, Orgrimmar", gameVersions = { forever = true } },
                { id = 97176, name = "Exorcising Terrordale", npc = "Danitha Morr", faction = "Horde", mapID = 1420, x = 0.2200, y = 0.4460, location = "Danitha Morr, Bandarion Keep, Tirisfal Glades", gameVersions = { forever = true } },
                { id = 97178, name = "Ott of Tarren Mill", faction = "Horde", gameVersions = { forever = true } },
                { id = 97179, name = "Collection of Goods", npc = "Ott", faction = "Horde", mapID = 1424, x = 0.6040, y = 0.2600, location = "Ott, Tarren Mill, Hillsbrad Foothills", gameVersions = { forever = true } },
                { id = 97180, name = "Ott's Finest Work", npc = "Ott", faction = "Horde", mapID = 1424, x = 0.6040, y = 0.2600, location = "Ott, Tarren Mill, Hillsbrad Foothills", gameVersions = { forever = true } },
                { id = 97182, name = "An Offering of Vengeance", npc = "Danitha Morr", faction = "Horde", mapID = 1420, x = 0.2200, y = 0.4460, location = "Danitha Morr, Bandarion Keep, Tirisfal Glades", gameVersions = { forever = true } },
                { id = 97186, name = "Manna-Enriched Horse Feed", npc = "Nathanos Blightcaller", faction = "Horde", mapID = 1423, x = 0.2640, y = 0.7480, location = "Nathanos Blightcaller, Eastern Plaguelands", gameVersions = { forever = true } },
                { id = 97183, name = "Blessed Arcanite Barding", npc = "Ancient Equine Spirit", faction = "Horde", mapID = 234, x = 0.3220, y = 0.7635, location = "Ancient Equine Spirit, Dire Maul", gameVersions = { forever = true } },
                { id = 97184, name = "The Divination Scryer", npc = "Danitha Morr", faction = "Horde", mapID = 1420, x = 0.2200, y = 0.4460, location = "Danitha Morr, Bandarion Keep, Tirisfal Glades", gameVersions = { forever = true } },
                { id = 97185, name = "Justice and Retribution", npc = "Danitha Morr", faction = "Horde", mapID = 1420, x = 0.2200, y = 0.4460, location = "Danitha Morr, Bandarion Keep, Tirisfal Glades", gameVersions = { forever = true } },
                { id = 7638, name = "Lord Grayson Shadowbreaker", npc = "Duthorian Rall", faction = "Alliance", mapID = 84, x = 0.3981, y = 0.2980, location = "Duthorian Rall, Stormwind" },
                { id = 7639, name = "To Show Due Judgment", npc = "High Priest Rohan", faction = "Alliance", mapID = 87, x = 0.2323, y = 0.0719, location = "High Priest Rohan, Ironforge" },
                { id = 7637, name = "Emphasis on Sacrifice", npc = "Lord Grayson Shadowbreaker", faction = "Alliance", mapID = 84, x = 0.3714, y = 0.3326, location = "Lord Grayson Shadowbreaker, Stormwind" },
                { id = 7640, name = "Exorcising Terrordale", npc = "Lord Grayson Shadowbreaker", faction = "Alliance", mapID = 84, x = 0.3714, y = 0.3326, location = "Lord Grayson Shadowbreaker, Stormwind" },
                { id = 7641, name = "The Work of Grimand Elmore", npc = "Lord Grayson Shadowbreaker", faction = "Alliance", mapID = 84, x = 0.3714, y = 0.3326, location = "Lord Grayson Shadowbreaker, Stormwind" },
                { id = 7642, name = "Collection of Goods", npc = "Grimand Elmore", faction = "Alliance", mapID = 84, x = 0.5176, y = 0.1207, location = "Grimand Elmore, Stormwind" },
                { id = 7648, name = "Grimand's Finest Work", npc = "Grimand Elmore", faction = "Alliance", mapID = 84, x = 0.5176, y = 0.1207, location = "Grimand Elmore, Stormwind" },
                { id = 7643, name = "Ancient Equine Spirit", npc = "Lord Grayson Shadowbreaker", faction = "Alliance", mapID = 84, x = 0.3714, y = 0.3326, location = "Lord Grayson Shadowbreaker, Stormwind" },
                { id = 7645, name = "Manna-Enriched Horse Feed", npc = "Merideth Carlson", faction = "Alliance", mapID = 25, x = 0.5219, y = 0.5548, location = "Merideth Carlson, Southshore, Hillsbrad Foothills" },
                { id = 7644, name = "Blessed Arcanite Barding", npc = "Ancient Equine Spirit", faction = "Alliance", mapID = 234, x = 0.3220, y = 0.7635, location = "Ancient Equine Spirit, Dire Maul" },
                { id = 7646, name = "The Divination Scryer", npc = "Lord Grayson Shadowbreaker", faction = "Alliance", mapID = 84, x = 0.3714, y = 0.3326, location = "Lord Grayson Shadowbreaker, Stormwind" },
                { id = 7647, name = "Judgment and Redemption", npc = "Lord Grayson Shadowbreaker", faction = "Alliance", mapID = 84, x = 0.3714, y = 0.3326, location = "Lord Grayson Shadowbreaker, Stormwind" },
            },
        },
    },
}

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

SM.ClassicRogueQuestData = {
    id = "poisons",  -- from its earlier title, "Poisons": saved progress and share links use it
    title = "The Road to Ravenholdt",
    description = "Master Mathias Shaw and Shenthul do not teach by lecture. They send rogues into guarded places, locked boxes, and situations where an antidote matters as much as a blade.\n\nBegin with your faction's poison work, then follow the hints that lead beyond city trainers into a wider trade of signals and reputation.",
    zone = "Westfall / The Barrens / Hillsbrad Foothills / Ravenholdt",
    zoneByFaction = {
        Alliance = "Westfall / Ravenholdt",
        Horde = "The Barrens / Hillsbrad Foothills / Ravenholdt",
    },
    expansion = "Classic",
    class = "ROGUE",
    gameVersions = { classicEra = true, tbc = true },
    color = { 1.00, 0.96, 0.41 },
    icon = 132320,
    adventureCoverTexture = 131833, -- Deadmines: the Defias hideout, where SI:7 first sends its rogues
    adventureCoverIsLoadingScreen = true,
    -- WoW Forever's Ruins of Lordaeron: an iron gate in the hills, like the way into Ravenholdt Manor.
    foreverCover = { texture = 7963782, texCoords = { 0, 1, 0.1592, 0.8408 } },

    startQuest = { id = 2360, name = "Mathias and the Defias", npc = "Master Mathias Shaw", location = "SI:7, Old Town, Stormwind", faction = "Alliance", mapID = 84, x = 0.7578, y = 0.5984, location = "Master Mathias Shaw, Stormwind" },
    startMapID = 84,
    startX = 0.7620,
    startY = 0.6010,

    npcLocations = {
        ["Master Mathias Shaw"] = { mapID = 84, x = 0.7620, y = 0.6010, location = "SI:7, Old Town, Stormwind" },
        ["Shenthul"] = { mapID = 85, x = 0.4300, y = 0.5360, location = "Cleft of Shadow, Orgrimmar" },
    },

    -- Quest givers' creature display IDs, from WoW Forever's creature cache
    -- (build 70938). Givers missing here show the chapter's icon.
    npcDisplayIDs = {
        ["Shenthul"] = 4360,
        ["Serge Hinott"] = 3678,
        ["Gest"] = 1327,
        ["Myrokos Silentform"] = 13150,
        ["Anastasia Miller"] = 144897,
    },

    chapterIcons = {
        ["The Touch of Zanzil"] = 132273,
        ["Ravenholdt"] = 132331,
    },

    chapters = {
        {
            chapter = "The Touch of Zanzil",  -- both factions' poison work turns on Zanzil's mixture
            requiredLevel = 20,
            summary = "Follow your faction's rogue trainer into guarded ground, locked boxes, and the antidote work needed for poisons.",
            recap = "Your poison training taught the trade plainly: enter unseen, open what is locked, and survive the danger you mean to wield.",
            quests = {
                { id = 2360, name = "Mathias and the Defias", npc = "Master Mathias Shaw", faction = "Alliance", mapID = 84, x = 0.7578, y = 0.5984, location = "Master Mathias Shaw, Stormwind" },
                { id = 2359, name = "Klaven's Tower", npc = "Agent Kearnen", faction = "Alliance", mapID = 52, x = 0.6849, y = 0.7008, location = "Agent Kearnen, Westfall" },
                { id = 2607, name = "The Touch of Zanzil", npc = "Master Mathias Shaw", faction = "Alliance", mapID = 84, x = 0.7578, y = 0.5984, location = "Master Mathias Shaw, Stormwind" },
                { id = 2609, name = "The Touch of Zanzil", npc = "Doc Mixilpixil", faction = "Alliance", mapID = 84, x = 0.7804, y = 0.5876, location = "Doc Mixilpixil, Stormwind" },
                { id = 2460, name = "The Shattered Salute", npc = "Shenthul", faction = "Horde", mapID = 85, x = 0.4305, y = 0.5374, location = "Shenthul, Orgrimmar" },
                { id = 2458, name = "Deep Cover", npc = "Shenthul", faction = "Horde", mapID = 85, x = 0.4305, y = 0.5374, location = "Shenthul, Orgrimmar" },
                { id = 2478, name = "Mission: Possible But Not Probable", npc = "Taskmaster Fizzule", faction = "Horde", mapID = 10, x = 0.5544, y = 0.0556, location = "Taskmaster Fizzule, The Barrens" },
                { id = 2479, name = "Hinott's Assistance", npc = "Shenthul", faction = "Horde", mapID = 85, x = 0.4305, y = 0.5374, location = "Shenthul, Orgrimmar" },
                { id = 2480, name = "Hinott's Assistance", npc = "Serge Hinott", faction = "Horde", mapID = 25, x = 0.6163, y = 0.1919, location = "Serge Hinott, Tarren Mill, Hillsbrad Foothills" },
            },
        },
        {
            chapter = "Ravenholdt",
            requiredLevel = 24,
            summary = "Find Ravenholdt Manor and present yourself to the rogues who keep their own company in the hills.",
            recap = "Ravenholdt opened a door beyond ordinary city training. There were signals to learn, reputations to mind, and thieves who knew the craft by its older rules.",
            -- On WoW Forever the manor's work goes on: Myrokos Silentform's war on the Syndicate.
            foreverText = {
                summary = "Find Ravenholdt Manor and present yourself to the rogues who keep their own company in the hills. Myrokos Silentform has work for Ravenholdt's agents. The Syndicate has grown bold in the hills of Alterac and Arathi, and someone must cut it where it will bleed the most.",
                recap = "Ravenholdt opened a door beyond ordinary city training. There were signals to learn, reputations to mind, and thieves who knew the craft by its older rules. You began by removing Lord Tomas from Durnholde Keep. Later, Myrokos had you lift a scouting report from a Syndicate pocket and beat its searchers to the heirlooms of House Perenolde in the ruins of Alterac. In a stolen uniform you walked into Stromgarde Keep, found the leverage to make Anastasia talk, and broke up the secret handoff at Thoradin's Wall, carrying the prize back to Ravenholdt.",
            },
            quests = {
                { id = 6681, name = "The Manor, Ravenholdt", npc = "Osborne the Night Man", faction = "Alliance", mapID = 84, x = 0.7400, y = 0.5200, location = "SI:7, Old Town, Stormwind, then Ravenholdt Manor" },
                { id = 6681, name = "The Manor, Ravenholdt", npc = "Gest", faction = "Horde", mapID = 85, x = 0.4300, y = 0.5360, location = "Cleft of Shadow, Orgrimmar, then Ravenholdt Manor" },
                { id = 96779, name = "Syndicate Sabotage", npc = "Myrokos Silentform", mapID = 1416, x = 0.8500, y = 0.8040, location = "Myrokos Silentform, Ravenholdt Manor, Alterac Mountains", gameVersions = { forever = true } },
                { id = 96781, name = "What's the Big Idea?", npc = "Myrokos Silentform", mapID = 1416, x = 0.8500, y = 0.8040, location = "Myrokos Silentform, Ravenholdt Manor, Alterac Mountains", gameVersions = { forever = true } },
                { id = 96782, name = "Covert Extraction", npc = "Myrokos Silentform", mapID = 1416, x = 0.8500, y = 0.8040, location = "Myrokos Silentform, Ravenholdt Manor, Alterac Mountains", gameVersions = { forever = true } },
                { id = 96783, name = "A Way In", npc = "Myrokos Silentform", mapID = 1416, x = 0.8500, y = 0.8040, location = "Myrokos Silentform, Ravenholdt Manor, Alterac Mountains", gameVersions = { forever = true } },
                { id = 96784, name = "Master of Disguise", location = "Stromgarde Keep, Arathi Highlands", gameVersions = { forever = true } },
                { id = 96785, name = "Ain't No Telling", npc = "Anastasia Miller", mapID = 1417, x = 0.2640, y = 0.6320, location = "Anastasia Miller, Stromgarde Keep, Arathi Highlands", gameVersions = { forever = true } },
                { id = 96786, name = "The Syndicate Sting", npc = "Anastasia Miller", mapID = 1417, x = 0.2640, y = 0.6320, location = "Anastasia Miller, Stromgarde Keep, Arathi Highlands", gameVersions = { forever = true } },
            },
        },
    },
}

SM.ClassicShamanQuestData = {
    title = "Call of the Elements",
    description = "Your first totem begins with a call, not a command. The elements answer through trials, offerings, and long walks between trainers, spirits, and hidden shrines.\n\nFollow earth, fire, water, and air as each power is earned in turn. Later, the same lessons point toward a deeper test of balance.",
    zone = "Durotar / Mulgore / The Barrens / Sunken Temple",
    -- WoW Forever adds dwarf shamans, so the Horde limit sits on the Horde
    -- chapters and quest lines rather than on the story.
    zoneByFaction = {
        Horde = "Durotar / Mulgore / The Barrens / Sunken Temple",
        Alliance = "Dun Morogh / Loch Modan / Wetlands / Arathi Highlands",
    },
    expansion = "Classic",
    class = "SHAMAN",
    gameVersions = { classicEra = true, tbc = true },
    color = { 0.00, 0.44, 0.87 },
    icon = 136048,
    adventureCoverTexture = 131872, -- Sunken Temple: final Elemental Mastery class trial
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 1516, name = "Call of Earth", npc = "Canaga Earthcaller", faction = "Horde", mapID = 1, x = 0.4240, y = 0.6917, location = "Canaga Earthcaller, Durotar" },
    startMapID = 10,
    startX = 0.5300,
    startY = 0.4300,

    chapterIcons = {
        ["Call of Earth"] = 136025,
        ["Call of Fire"] = 135824,
        ["Call of Water"] = 135861,
        ["Call of Air"] = 136022,
        ["Elemental Mastery"] = 136075,
    },

    chapters = {
        {
            chapter = "Call of Earth",
            requiredLevel = 4,
            summary = "Seek the earth's sapta, speak with its manifestation, and return with your first totem.",
            recap = "You carried the sapta, listened to the earth, and proved steady enough to bear its totem. The first element had answered.",
            quests = {
                { id = 96243, name = "Call of Earth", npc = "Eldrun Stormbreaker", race = { "Dwarf", "Gnome", "Skyborne" }, faction = "Alliance", mapID = 1455, x = 0.4740, y = 0.1340, location = "Eldrun Stormbreaker, Ironforge", gameVersions = { forever = true } },
                { id = 94373, name = "Call of Earth", npc = "Teo Hammerstorm", race = "Dwarf", faction = "Alliance", mapID = 1426, x = 0.2880, y = 0.6620, location = "Teo Hammerstorm, Anvilmar, Dun Morogh", gameVersions = { forever = true } },
                { id = 94374, name = "Call of Earth", npc = "Teo Hammerstorm", race = "Dwarf", faction = "Alliance", mapID = 1426, x = 0.2880, y = 0.6620, location = "Teo Hammerstorm, Anvilmar, Dun Morogh", gameVersions = { forever = true } },
                { id = 94375, name = "Call of Earth", npc = "Minor Manifestation of Earth", race = "Dwarf", faction = "Alliance", mapID = 1426, x = 0.2480, y = 0.6180, location = "Minor Manifestation of Earth, Dun Morogh", gameVersions = { forever = true } },
                { id = 92466, name = "Call of Earth", race = "Skyborne", location = "Thendal Grove, Zephras Isle", gameVersions = { forever = true } },
                { id = 92467, name = "Call of Earth", npc = "Windshaper Boro", race = "Skyborne", location = "Windshaper Boro, Thendal Grove, Zephras Isle", gameVersions = { forever = true } },
                { id = 92468, name = "Call of Earth", race = "Skyborne", location = "Rise of Spirits, Zephras Isle", gameVersions = { forever = true } },
                { id = 1516, name = "Call of Earth", npc = "Canaga Earthcaller", race = { "Orc", "Troll" }, faction = "Horde", mapID = 1, x = 0.4240, y = 0.6917, location = "Canaga Earthcaller, Durotar" },
                { id = 1517, name = "Call of Earth", npc = "Canaga Earthcaller", race = { "Orc", "Troll" }, faction = "Horde", mapID = 1, x = 0.4240, y = 0.6917, location = "Canaga Earthcaller, Durotar" },
                { id = 1518, name = "Call of Earth", npc = "Minor Manifestation of Earth", race = { "Orc", "Troll" }, faction = "Horde", mapID = 7, x = 0.5389, y = 0.8054, location = "Minor Manifestation of Earth, Mulgore" },
                { id = 1519, name = "Call of Earth", npc = "Seer Ravenfeather", race = "Tauren", faction = "Horde", mapID = 7, x = 0.4473, y = 0.7619, location = "Seer Ravenfeather, Mulgore" },
                { id = 1520, name = "Call of Earth", npc = "Seer Ravenfeather", race = "Tauren", faction = "Horde", mapID = 7, x = 0.4473, y = 0.7619, location = "Seer Ravenfeather, Mulgore" },
                { id = 1521, name = "Call of Earth", npc = "Minor Manifestation of Earth", race = "Tauren", faction = "Horde", mapID = 7, x = 0.5389, y = 0.8054, location = "Minor Manifestation of Earth, Mulgore" },
            },
        },
        {
            chapter = "Call of Fire",
            requiredLevel = 10,
            summary = "Follow the call of fire through offerings, reagents, and the flame that waits in Durotar.",
            recap = "Fire asked for risk, offering, and obedience to the rite. When the brazier answered, the flame became a servant at your side.",
            quests = {
                { id = 94449, name = "Call of Fire", npc = "Eldrun Stormbreaker", race = "Dwarf", faction = "Alliance", mapID = 1455, x = 0.4740, y = 0.1340, location = "Eldrun Stormbreaker, Ironforge", gameVersions = { forever = true } },
                { id = 94465, name = "Call of Fire", npc = "Bruegs Kindleborn", race = "Dwarf", faction = "Alliance", mapID = 1426, x = 0.8760, y = 0.4360, location = "Bruegs Kindleborn, Dun Morogh", gameVersions = { forever = true } },
                { id = 94466, name = "Call of Fire", npc = "Braldir Ashmantle", race = "Dwarf", faction = "Alliance", mapID = 1432, x = 0.3200, y = 0.6600, location = "Braldir Ashmantle, Loch Modan", gameVersions = { forever = true } },
                { id = 94467, name = "Call of Fire", npc = "Braldir Ashmantle", race = "Dwarf", faction = "Alliance", mapID = 1432, x = 0.3200, y = 0.6600, location = "Braldir Ashmantle, Loch Modan", gameVersions = { forever = true } },
                { id = 94468, name = "Call of Fire", race = "Dwarf", faction = "Alliance", location = "Shrine of Eternal Flame, Loch Modan", gameVersions = { forever = true } },
                { id = 98517, name = "Call of Fire", race = "Skyborne", gameVersions = { forever = true } },
                { id = 97243, name = "Call of Fire", race = "Skyborne", location = "Zephras Isle", gameVersions = { forever = true } },
                { id = 97244, name = "Call of Fire", npc = "Olariaan Swiftburn", race = "Skyborne", location = "Olariaan Swiftburn, Shrine of Flames, Zephras Isle", gameVersions = { forever = true } },
                { id = 97245, name = "Call of Fire", npc = "Olariaan Swiftburn", race = "Skyborne", location = "Olariaan Swiftburn, Shrine of Flames, Zephras Isle", gameVersions = { forever = true } },
                { id = 97257, name = "Call of Fire", npc = "Olariaan Swiftburn", race = "Skyborne", location = "Olariaan Swiftburn, Shrine of Flames, Zephras Isle", gameVersions = { forever = true } },
                { id = 1522, altIds = { 1523, 2983, 2984 }, name = "Call of Fire", excludeRace = "Skyborne", npc = "Searn Firewarder", faction = "Horde", mapID = 85, x = 0.3796, y = 0.3773, location = "Searn Firewarder, Orgrimmar" },
                { id = 1524, name = "Call of Fire", excludeRace = "Skyborne", npc = "Kranal Fiss", faction = "Horde", mapID = 10, x = 0.5603, y = 0.1989, location = "Kranal Fiss, The Barrens" },
                { id = 1525, name = "Call of Fire", excludeRace = "Skyborne", npc = "Telf Joolam", faction = "Horde", mapID = 1, x = 0.3855, y = 0.5896, location = "Telf Joolam, Durotar" },
                { id = 1526, name = "Call of Fire", excludeRace = "Skyborne", npc = "Telf Joolam", faction = "Horde", mapID = 1, x = 0.3855, y = 0.5896, location = "Telf Joolam, Durotar" },
                { id = 1527, name = "Call of Fire", excludeRace = "Skyborne", npc = "Brazier of the Dormant Flame", faction = "Horde", mapID = 1, x = 0.3896, y = 0.5822, location = "Brazier of the Dormant Flame, Durotar" },
            },
        },
        {
            chapter = "Call of Water",
            requiredLevel = 20,
            summary = "Carry waters between distant places and learn why this totem asks for patience.",
            recap = "The call of water sent you farther than the earlier trials. Through Barrens dust and distant roads, you learned the patience the element required.",
            quests = {
                { id = 94494, name = "Call of Water", faction = "Alliance", gameVersions = { forever = true } },
                { id = 94495, name = "Call of Water", npc = "Norric Lochthane", faction = "Alliance", location = "Norric Lochthane, Loch Modan", gameVersions = { forever = true } },
                { id = 94497, name = "Call of Water", npc = "Hervdana Saegrund", faction = "Alliance", mapID = 1437, x = 0.6560, y = 0.7640, location = "Hervdana Saegrund, Wetlands", gameVersions = { forever = true } },
                { id = 94499, name = "Call of Water", npc = "Hervdana Saegrund", faction = "Alliance", mapID = 1437, x = 0.6560, y = 0.7640, location = "Hervdana Saegrund, Wetlands", gameVersions = { forever = true } },
                { id = 94500, name = "Call of Water", npc = "Hervdana Saegrund", faction = "Alliance", mapID = 1437, x = 0.6560, y = 0.7640, location = "Hervdana Saegrund, Wetlands", gameVersions = { forever = true } },
                { id = 94501, name = "Call of Water", npc = "Hervdana Saegrund", faction = "Alliance", mapID = 1437, x = 0.6560, y = 0.7640, location = "Hervdana Saegrund, Wetlands", gameVersions = { forever = true } },
                { id = 94502, name = "Call of Water", npc = "Norric Lochthane", faction = "Alliance", location = "Norric Lochthane, Loch Modan", gameVersions = { forever = true } },
                { id = 94503, name = "Call of Water", faction = "Alliance", location = "Stendel's Pond, Westfall", gameVersions = { forever = true } },
                { id = 94505, name = "Call of Water", npc = "Minor Manifestation of Water", faction = "Alliance", location = "Minor Manifestation of Water, Stendel's Pond, Westfall", gameVersions = { forever = true } },
                { id = 1528, altIds = { 1529, 2985, 2986 }, name = "Call of Water", npc = "Searn Firewarder", faction = "Horde", mapID = 85, x = 0.3796, y = 0.3773, location = "Searn Firewarder, Orgrimmar" },
                { id = 1530, name = "Call of Water", npc = "Islen Waterseer", faction = "Horde", mapID = 10, x = 0.6583, y = 0.4378, location = "Islen Waterseer, The Barrens" },
                { id = 1535, name = "Call of Water", npc = "Brine", faction = "Horde", mapID = 10, x = 0.4342, y = 0.7741, location = "Brine, The Barrens" },
                { id = 1536, name = "Call of Water", npc = "Brine", faction = "Horde", mapID = 10, x = 0.4342, y = 0.7741, location = "Brine, The Barrens" },
                { id = 1534, name = "Call of Water", npc = "Brine", faction = "Horde", mapID = 10, x = 0.4342, y = 0.7741, location = "Brine, The Barrens" },
                { id = 220, name = "Call of Water", npc = "Brine", faction = "Horde", mapID = 10, x = 0.4342, y = 0.7741, location = "Brine, The Barrens" },
                { id = 63, name = "Call of Water", npc = "Islen Waterseer", faction = "Horde", mapID = 10, x = 0.6583, y = 0.4378, location = "Islen Waterseer, The Barrens" },
                { id = 100, name = "Call of Water", npc = "Brazier of Everfount", faction = "Horde", mapID = 21, x = 0.3826, y = 0.4456, location = "Brazier of Everfount, Silverpine Forest" },
                { id = 96, name = "Call of Water", npc = "Minor Manifestation of Water", faction = "Horde", mapID = 21, x = 0.3840, y = 0.4440, location = "Brazier of Everfount, Silverpine Forest" },
            },
        },
        {
            chapter = "Call of Air",
            requiredLevel = 30,
            summary = "Return to your trainer and receive the last totem needed to complete the circle of elements.",
            recap = "The call of air was brief, but it completed what the earlier trials began. Earth, fire, water, and air now stood with you.",
            quests = {
                { id = 94789, name = "Call of Air", faction = "Alliance", gameVersions = { forever = true } },
                { id = 96264, name = "Elemental Aid", npc = "Veyric Thunderhame", faction = "Alliance", mapID = 1417, x = 0.5980, y = 0.2740, location = "Veyric Thunderhame, Arathi Highlands", gameVersions = { forever = true } },
                { id = 79358, name = "Storm, Earth, and Fire", npc = "Veyric Thunderhame", faction = "Alliance", mapID = 1417, x = 0.5980, y = 0.2740, location = "Veyric Thunderhame, Arathi Highlands", gameVersions = { forever = true } },
                { id = 96135, name = "Heed My Call", npc = "Veyric Thunderhame", faction = "Alliance", mapID = 1417, x = 0.5980, y = 0.2740, location = "Veyric Thunderhame, Arathi Highlands", gameVersions = { forever = true } },
                { id = 96016, name = "The Tempest's Weapons", npc = "Veyric Thunderhame", faction = "Alliance", mapID = 1417, x = 0.5980, y = 0.2740, location = "Veyric Thunderhame, Arathi Highlands", gameVersions = { forever = true } },
                { id = 96136, name = "Call of Air", race = "Skyborne", gameVersions = { forever = true } },
                { id = 1531, name = "Call of Air", excludeRace = "Skyborne", npc = "Searn Firewarder", faction = "Horde", mapID = 85, x = 0.3796, y = 0.3773, location = "Searn Firewarder, Orgrimmar" },
            },
        },
        {
            chapter = "Elemental Mastery",
            requiredLevel = 50,
            faction = "Horde",
            summary = "Bring proof of the elements to the temple trial and show that the four powers can be held together.",
            recap = "The Sunken Temple trial asked you to carry the elements as one calling. When the proofs were gathered, your mastery had been tested in full.",
            quests = {
                { id = 8410, name = "Elemental Mastery", npc = "Kardris Dreamseeker", faction = "Horde", mapID = 85, x = 0.3880, y = 0.3637, location = "Kardris Dreamseeker, Orgrimmar" },
                { id = 8412, name = "Spirit Totem", npc = "Bath'rah the Windwatcher", faction = "Horde", mapID = 1416, x = 0.8040, y = 0.6300, location = "Bath'rah the Windwatcher, Ravenholdt Manor, Hillsbrad Foothills" },
            },
        },
        {
            chapter = "The Darkreaver Menace",
            requiredLevel = 58,
            faction = "Alliance",
            gameVersions = { forever = true },
            summary = "Eldrun Stormbreaker is building a device to cut through the shadows of the Great Ossuary in Scholomance, and he needs rare stones and a steady hand to finish it.",
            recap = "You brought Eldrun Stormbreaker the diamonds his scryer required. Deep in the Great Ossuary you used it to draw out the spirits bound to Death Knight Darkreaver, and you stood against what answered until his hold over the restless dead was broken.",
            quests = {
                { id = 97168, name = "Material Assistance", npc = "Eldrun Stormbreaker", faction = "Alliance", mapID = 1455, x = 0.4740, y = 0.1340, location = "Eldrun Stormbreaker, Ironforge", gameVersions = { forever = true } },
                { id = 97169, name = "The Darkreaver Menace", npc = "Eldrun Stormbreaker", faction = "Alliance", mapID = 1455, x = 0.4740, y = 0.1340, location = "Eldrun Stormbreaker, Ironforge", gameVersions = { forever = true } },
            },
        },
    },
}

SM.ClassicWarlockQuestData = {
    title = "The Binding",
    description = "Warlock trainers do not offer power freely. They give names, errands, and circles, then ask whether you can bind what answers.\n\nBegin with the first summons and follow the darker lessons through demons, tomes, mounts, and bargains that always ask for more than coin.",
    zone = "Capital Cities / The Barrens / Burning Steppes / Dire Maul",
    expansion = "Classic",
    class = "WARLOCK",
    gameVersions = { classicEra = true, tbc = true },
    color = { 0.53, 0.53, 0.93 },
    icon = 136145,
    adventureCoverTexture = 131835, -- Dire Maul: Dreadsteed of Xoroth ritual finale
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 1685, name = "Gakin's Summons", npc = "Remen Marcot", faction = "Alliance", mapID = 37, x = 0.4449, y = 0.6627, location = "Remen Marcot, Elwynn Forest" },
    startMapID = 84,
    startX = 0.2600,
    startY = 0.7800,

    chapterIcons = {
        ["Voidwalker"] = 136221,
        ["Succubus"] = 136220,
        ["Felhunter"] = 136217,
        ["Felsteed"] = 136103,
        ["Dreadsteed"] = 136103,
    },

    chapters = {
        {
            chapter = "Voidwalker",
            requiredLevel = 10,
            summary = "Answer your trainer's summons, draw a voidwalker into the circle, and bind it to your will.",
            recap = "The first binding taught the warlock's bargain clearly. A creature of the void answered, resisted, and was made to serve.",
            quests = {
                { id = 1685, name = "Gakin's Summons", npc = "Remen Marcot", race = { "Human", "Gnome" }, faction = "Alliance", mapID = 37, x = 0.4449, y = 0.6627, location = "Remen Marcot, Elwynn Forest" },
                { id = 1715, name = "The Slaughtered Lamb", npc = "Lago Blackwrench", race = { "Human", "Gnome" }, faction = "Alliance", mapID = 87, x = 0.4763, y = 0.0926, location = "Lago Blackwrench, Ironforge" },
                { id = 1688, name = "Surena Caledon", npc = "Gakin the Darkbinder", race = { "Human", "Gnome" }, faction = "Alliance", mapID = 84, x = 0.2525, y = 0.7856, location = "Gakin the Darkbinder, Stormwind" },
                { id = 1689, name = "The Binding", npc = "Gakin the Darkbinder", race = { "Human", "Gnome" }, faction = "Alliance", mapID = 84, x = 0.2525, y = 0.7856, location = "Gakin the Darkbinder, Stormwind" },
                { id = 1478, name = "Halgar's Summons", npc = "Ageron Kargal", race = "Scourge", faction = "Horde", mapID = 18, x = 0.6162, y = 0.5268, location = "Ageron Kargal, Tirisfal Glades" },
                { id = 1473, name = "Creature of the Void", npc = "Carendin Halgar", race = "Scourge", faction = "Horde", mapID = 90, x = 0.8506, y = 0.2599, location = "Carendin Halgar, Undercity" },
                { id = 1471, name = "The Binding", npc = "Carendin Halgar", race = "Scourge", faction = "Horde", mapID = 90, x = 0.8506, y = 0.2599, location = "Carendin Halgar, Undercity" },
                { id = 1506, name = "Gan'rul's Summons", npc = "Ophek", race = "Orc", faction = "Horde", mapID = 1, x = 0.5437, y = 0.4129, location = "Ophek, Durotar" },
                { id = 1501, name = "Creature of the Void", npc = "Gan'rul Bloodeye", race = "Orc", faction = "Horde", mapID = 85, x = 0.4825, y = 0.4528, location = "Gan'rul Bloodeye, Orgrimmar" },
                { id = 1504, name = "The Binding", npc = "Gan'rul Bloodeye", race = "Orc", faction = "Horde", mapID = 85, x = 0.4825, y = 0.4528, location = "Gan'rul Bloodeye, Orgrimmar" },
            },
        },
        {
            chapter = "Succubus",
            requiredLevel = 20,
            summary = "Follow the Devourer of Souls chain and prepare the binding of a subtler demon.",
            recap = "The succubus trial warned that not every danger arrives with brute force. You gathered what was required and bound temptation to command.",
            quests = {
                { id = 1472, name = "Devourer of Souls", npc = "Carendin Halgar", faction = "Horde", mapID = 90, x = 0.8506, y = 0.2599, location = "Carendin Halgar, Undercity" },
                { id = 1476, name = "Hearts of the Pure", npc = "Godrick Farsan", faction = "Horde", mapID = 90, x = 0.8481, y = 0.1483, location = "Godrick Farsan, Undercity" },
                { id = 1474, name = "The Binding", npc = "Carendin Halgar", faction = "Horde", mapID = 90, x = 0.8506, y = 0.2599, location = "Carendin Halgar, Undercity" },
                { id = 1717, name = "Gakin's Summons", npc = "Lago Blackwrench", faction = "Alliance", optional = true, mapID = 87, x = 0.4680, y = 0.1060, location = "Lago Blackwrench, Ironforge" },
                { id = 1716, name = "Devourer of Souls", npc = "Gakin the Darkbinder", faction = "Alliance", mapID = 84, x = 0.2525, y = 0.7856, location = "Gakin the Darkbinder, Stormwind" },
                { id = 1738, name = "Heartswood", npc = "Takar the Seer", faction = "Alliance", mapID = 10, x = 0.4931, y = 0.5710, location = "Takar the Seer, The Barrens" },
                { id = 1739, name = "The Binding", npc = "Gakin the Darkbinder", faction = "Alliance", mapID = 84, x = 0.2525, y = 0.7856, location = "Gakin the Darkbinder, Stormwind" },
            },
        },
        {
            chapter = "Felhunter",
            requiredLevel = 30,
            summary = "Seek Strahad Farsan, assemble the Tome of the Cabal, and prepare the felhunter binding.",
            recap = "The Tome of the Cabal led through old contacts and dangerous errands. When the binding was done, the felhunter's hunger became your weapon against magic.",
            quests = {
                -- Alliance: Lago Blackwrench, then Krom Stoutarm in Ironforge (Wowhead 1798 1758 1802 1804 1795).
                { id = 1798, name = "Seeking Strahad", npc = "Lago Blackwrench", faction = "Alliance", mapID = 87, x = 0.4680, y = 0.1060, location = "Lago Blackwrench, Ironforge" },
                { id = 1758, name = "Tome of the Cabal", npc = "Strahad Farsan", faction = "Alliance", mapID = 10, x = 0.6263, y = 0.3550, location = "Strahad Farsan, The Barrens" },
                { id = 1802, name = "Tome of the Cabal", npc = "Krom Stoutarm", faction = "Alliance", mapID = 87, x = 0.7419, y = 0.0939, location = "Krom Stoutarm, Ironforge" },
                { id = 1804, name = "Tome of the Cabal", npc = "Krom Stoutarm", faction = "Alliance", mapID = 87, x = 0.7419, y = 0.0939, location = "Krom Stoutarm, Ironforge" },
                -- Horde: Carendin Halgar, then Jorah Annison in the Undercity (3001 1801 1803 1805 1795).
                { id = 3001, name = "Seeking Strahad", npc = "Carendin Halgar", faction = "Horde", mapID = 90, x = 0.8506, y = 0.2599, location = "Carendin Halgar, Undercity" },
                { id = 1801, name = "Tome of the Cabal", npc = "Strahad Farsan", faction = "Horde", mapID = 10, x = 0.6263, y = 0.3550, location = "Strahad Farsan, The Barrens" },
                { id = 1803, name = "Tome of the Cabal", npc = "Jorah Annison", faction = "Horde", mapID = 90, x = 0.7592, y = 0.3789, location = "Jorah Annison, Undercity" },
                { id = 1805, name = "Tome of the Cabal", npc = "Jorah Annison", faction = "Horde", mapID = 90, x = 0.7592, y = 0.3789, location = "Jorah Annison, Undercity" },
                { id = 1795, name = "The Binding", npc = "Strahad Farsan", mapID = 10, x = 0.6263, y = 0.3550, location = "Strahad Farsan, The Barrens" },
            },
        },
        {
            chapter = "Felsteed",
            requiredLevel = 40,
            summary = "Speak with the proper trainer and bind the felsteed that will carry you on darker roads.",
            recap = "The felsteed was not purchased like an ordinary mount. It was called, bound, and made to bear the one who mastered the ritual.",
            quests = {
                { id = 4488, altIds = { 4487 }, name = "Summon Felsteed", npc = "Demisette Cloyce", faction = "Alliance", mapID = 84, x = 0.2540, y = 0.7820, location = "Demisette Cloyce, Stormwind" },
                { id = 4489, altIds = { 3631 }, name = "Summon Felsteed", npc = "Kaal Soulreaper", faction = "Horde", mapID = 90, x = 0.8621, y = 0.1593, location = "Kaal Soulreaper, Undercity" },
                { id = 4490, name = "Summon Felsteed", npc = "Strahad Farsan", mapID = 10, x = 0.6263, y = 0.3550, location = "Strahad Farsan, Ratchet, The Barrens" },
            },
        },
        {
            chapter = "Dreadsteed",
            requiredLevel = 60,
            summary = "Begin Mor'zul Bloodbringer's work, gather the ritual tools, and prepare the road to Xoroth.",
            recap = "Mor'zul and Gorzeeki sent you through blood, stardust, Jaedenar, and Scholomance. In Dire Maul the rite opened, and the dreadsteed came through bound to your command.",
            quests = {
                { id = 7562, name = "Mor'zul Bloodbringer", npc = "Spackle Thornberry", faction = "Alliance", mapID = 84, x = 0.2566, y = 0.7766, location = "Spackle Thornberry, Stormwind" },
                { id = 7562, name = "Mor'zul Bloodbringer", npc = "Kurgul", faction = "Horde", mapID = 85, x = 0.4752, y = 0.4672, location = "Kurgul, Orgrimmar" },
                { id = 7563, name = "Rage of Blood", npc = "Mor'zul Bloodbringer", mapID = 36, x = 0.1269, y = 0.3164, location = "Mor'zul Bloodbringer, Burning Steppes" },
                { id = 7564, name = "Wildeyes", npc = "Mor'zul Bloodbringer", mapID = 36, x = 0.1269, y = 0.3164, location = "Mor'zul Bloodbringer, Burning Steppes" },
                { id = 7623, name = "Lord Banehollow", npc = "Gorzeeki Wildeyes", mapID = 36, x = 0.1244, y = 0.3163, location = "Gorzeeki Wildeyes, Burning Steppes" },
                { id = 7624, name = "Ulathek the Traitor", npc = "Lord Banehollow", mapID = 77, x = 0.3593, y = 0.4442, location = "Lord Banehollow, Shadow Hold, Felwood" },
                { id = 7625, name = "Xorothian Stardust", npc = "Lord Banehollow", mapID = 77, x = 0.3593, y = 0.4442, location = "Lord Banehollow, Shadow Hold, Felwood" },
                { id = 7626, name = "Bell of Dethmoora", npc = "Mor'zul Bloodbringer", mapID = 36, x = 0.1269, y = 0.3164, location = "Mor'zul Bloodbringer, Burning Steppes" },
                { id = 7627, name = "Wheel of the Black March", npc = "Mor'zul Bloodbringer", mapID = 36, x = 0.1269, y = 0.3164, location = "Mor'zul Bloodbringer, Burning Steppes" },
                { id = 7628, name = "Doomsday Candle", npc = "Mor'zul Bloodbringer", mapID = 36, x = 0.1269, y = 0.3164, location = "Mor'zul Bloodbringer, Burning Steppes" },
                { id = 7629, name = "Imp Delivery", npc = "Gorzeeki Wildeyes", mapID = 36, x = 0.1244, y = 0.3163, location = "Gorzeeki Wildeyes, Burning Steppes" },
                { id = 7630, name = "Arcanite", npc = "Gorzeeki Wildeyes", mapID = 36, x = 0.1244, y = 0.3163, location = "Gorzeeki Wildeyes, Burning Steppes" },
                { id = 7631, name = "Dreadsteed of Xoroth", npc = "Mor'zul Bloodbringer", mapID = 36, x = 0.1269, y = 0.3164, location = "Mor'zul Bloodbringer, Burning Steppes" },
            },
        },
    },
}

SM.ClassicWarriorQuestData = {
    id = "whirlwind-weapon",  -- from its earlier title, "Whirlwind Weapon": saved progress and share links use it
    title = "The Warrior's Trials",
    description = "Your warrior trainer has a practical lesson first: learn to stand, endure, and fight with discipline. After that, older tests wait beyond the starting grounds.\n\nSeek the instructors who send warriors to brawls, islands, charms, and a windwatcher's summons. The reward is a weapon, but the road is the real trial.",
    zone = "The Barrens / Stranglethorn Vale / Arathi Highlands",
    expansion = "Classic",
    class = "WARRIOR",
    gameVersions = { classicEra = true, tbc = true },
    color = { 0.78, 0.61, 0.43 },
    icon = 132355,
    adventureCoverTexture = 131824, -- Blackrock Depths: martial arena imagery closest to the warrior weapon trial
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 1638, name = "A Warrior's Training", npc = "Lyria Du Lac", faction = "Alliance", mapID = 37, x = 0.4109, y = 0.6577, location = "Lyria Du Lac, Elwynn Forest" },
    startMapID = 10,
    startX = 0.6800,
    startY = 0.3600,

    chapterIcons = {
        ["Defensive Stance"] = 132341,
        ["Whirlwind Weapon"] = 132408,
    },

    chapters = {
        {
            chapter = "Defensive Stance",
            requiredLevel = 10,
            summary = "Complete your first warrior trial and learn the stance that keeps you standing when blows fall.",
            recap = "Your first warrior lesson was not about striking harder. You learned to take the blow, hold your ground, and live long enough to answer.",
            quests = {
                { id = 94003, name = "The Skybreaker Bulwark", race = "Skyborne", location = "Zephras Isle", gameVersions = { forever = true } },
                { id = 1638, name = "A Warrior's Training", npc = "Lyria Du Lac", race = "Human", faction = "Alliance", mapID = 37, x = 0.4109, y = 0.6577, location = "Lyria Du Lac, Elwynn Forest" },
                { id = 1639, name = "Bartleby the Drunk", npc = "Harry Burlguard", race = "Human", faction = "Alliance", mapID = 84, x = 0.7426, y = 0.3725, location = "Harry Burlguard, Stormwind" },
                { id = 1640, name = "Beat Bartleby", npc = "Bartleby", race = "Human", faction = "Alliance", mapID = 84, x = 0.7378, y = 0.3633, location = "Bartleby, Stormwind" },
                { id = 1665, name = "Bartleby's Mug", npc = "Bartleby", race = "Human", faction = "Alliance", mapID = 84, x = 0.7378, y = 0.3633, location = "Bartleby, Stormwind" },
                { id = 1684, name = "Elanaria", npc = "Kyra Windblade", race = "NightElf", faction = "Alliance", mapID = 57, x = 0.5622, y = 0.5920, location = "Kyra Windblade, Teldrassil" },
                { id = 1683, name = "Vorlus Vilehoof", npc = "Elanaria", race = "NightElf", faction = "Alliance", mapID = 89, x = 0.5730, y = 0.3460, location = "Elanaria, Darnassus" },
                { id = 1679, name = "Muren Stormpike", npc = "Granis Swiftaxe", race = { "Dwarf", "Gnome" }, faction = "Alliance", mapID = 27, x = 0.4736, y = 0.5265, location = "Granis Swiftaxe, Dun Morogh" },
                { id = 1678, name = "Vejrek", npc = "Muren Stormpike", race = { "Dwarf", "Gnome" }, faction = "Alliance", mapID = 87, x = 0.7077, y = 0.9027, location = "Muren Stormpike, Ironforge" },
                { id = 1680, name = "Tormus Deepforge", npc = "Muren Stormpike", race = { "Dwarf", "Gnome" }, faction = "Alliance", mapID = 87, x = 0.7077, y = 0.9027, location = "Muren Stormpike, Ironforge" },
                { id = 1681, name = "Ironband's Compound", npc = "Tormus Deepforge", race = { "Dwarf", "Gnome" }, faction = "Alliance", mapID = 87, x = 0.4840, y = 0.4300, location = "Tormus Deepforge, Ironforge" },
                { id = 1818, name = "Speak with Dillinger", npc = "Austil de Mon", race = "Scourge", faction = "Horde", mapID = 18, x = 0.6185, y = 0.5254, location = "Austil de Mon, Tirisfal Glades" },
                { id = 1819, name = "Ulag the Cleaver", npc = "Deathguard Dillinger", race = "Scourge", faction = "Horde", mapID = 18, x = 0.5820, y = 0.5145, location = "Deathguard Dillinger, Tirisfal Glades" },
                { id = 1820, name = "Speak with Coleman", npc = "Deathguard Dillinger", race = "Scourge", faction = "Horde", mapID = 18, x = 0.5820, y = 0.5145, location = "Deathguard Dillinger, Tirisfal Glades" },
                { id = 1821, name = "Agamand Heirlooms", npc = "Coleman Farthing", race = "Scourge", faction = "Horde", mapID = 18, x = 0.6172, y = 0.5229, location = "Gallows' End Tavern, Brill" },
                { id = 1505, name = "Veteran Uzzek", npc = "Krang Stonehoof", race = { "Orc", "Troll", "Tauren" }, faction = "Horde", mapID = 7, x = 0.4952, y = 0.6059, location = "Krang Stonehoof, Mulgore" },
                { id = 1498, name = "Path of Defense", npc = "Uzzek", race = { "Orc", "Troll", "Tauren" }, faction = "Horde", mapID = 10, x = 0.6138, y = 0.2112, location = "Uzzek, The Barrens" },
                { id = 1502, name = "Thun'grim Firegaze", npc = "Uzzek", race = { "Orc", "Troll", "Tauren" }, faction = "Horde", mapID = 10, x = 0.6138, y = 0.2112, location = "Uzzek, The Barrens" },
                { id = 1503, name = "Forged Steel", npc = "Thun'grim Firegaze", race = { "Orc", "Troll", "Tauren" }, faction = "Horde", mapID = 10, x = 0.5720, y = 0.3020, location = "Thun'grim Firegaze, The Barrens" },
            },
        },
        {
            chapter = "Whirlwind Weapon",
            requiredLevel = 30,
            summary = "Seek the Islander, gather the charms, and answer Bath'rah's summons for the whirlwind weapon.",
            recap = "The Islander tested your mettle, Bath'rah named the charms, and Cyclonian answered the call. When the storm was defeated, the weapon was yours.",
            quests = {
                { id = 1718, name = "The Islander", npc = "Wu Shen", faction = "Alliance", mapID = 84, x = 0.7868, y = 0.4579, location = "Wu Shen, Stormwind, then Fray Island, The Barrens" },
                { id = 1718, name = "The Islander", npc = "Sorek", faction = "Horde", mapID = 85, x = 0.8039, y = 0.3238, location = "Sorek, Orgrimmar, then Fray Island, The Barrens" },
                { id = 1719, name = "The Affray", npc = "Klannoc Macleod", mapID = 10, x = 0.6861, y = 0.4916, location = "Klannoc Macleod, The Barrens" },
                { id = 1791, name = "The Windwatcher", npc = "Klannoc Macleod", mapID = 10, x = 0.6861, y = 0.4916, location = "Klannoc Macleod, The Barrens" },
                { id = 1712, name = "Cyclonian", npc = "Bath'rah the Windwatcher", mapID = 25, x = 0.8050, y = 0.6692, location = "Bath'rah the Windwatcher, Ravenholdt Manor, Hillsbrad Foothills" },
                { id = 1714, name = "Essence of the Exile", npc = "Bath'rah's Cauldron", mapID = 25, x = 0.7826, y = 0.0689, location = "Bath'rah's Cauldron, Alterac Mountains" },
                { id = 1713, name = "The Summoning", npc = "Bath'rah the Windwatcher", mapID = 25, x = 0.8050, y = 0.6692, location = "Bath'rah the Windwatcher, Ravenholdt Manor, Hillsbrad Foothills" },
                { id = 1792, name = "Whirlwind Weapon", npc = "Bath'rah the Windwatcher", mapID = 25, x = 0.8050, y = 0.6692, location = "Bath'rah the Windwatcher, Ravenholdt Manor, Hillsbrad Foothills" },
            },
        },
    },
}
