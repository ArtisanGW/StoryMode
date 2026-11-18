local addonName, SM = ...

-- =============================================================================
-- Classic warrior quests
-- Curated identity chains: iconic abilities, tools, weapons, and mounts.
-- =============================================================================

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
