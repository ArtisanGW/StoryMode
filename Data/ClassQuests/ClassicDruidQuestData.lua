local addonName, SM = ...

-- =============================================================================
-- Classic druid quests
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
