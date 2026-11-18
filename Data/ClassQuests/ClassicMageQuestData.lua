local addonName, SM = ...

-- =============================================================================
-- Classic mage quests
-- Curated identity chains: iconic abilities, tools, weapons, and mounts.
-- =============================================================================

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

    npcDisplayIDs = {
        -- Quest givers' models from the cmangos Classic database.
        ["Jennea Cannon"] = 3292,
        ["Tabetha"] = 5375,
        ["Magus Tirth"] = 5374,
        ["Archmage Xylem"] = 7591,
        ["Lorekeeper Lydros"] = 14407,
        -- Quest givers' models from Wowhead's WoW Forever data.
        ["Belann Windwood"] = 139671,
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
