local addonName, SM = ...

-- =============================================================================
-- Classic shaman quests
-- Curated identity chains: iconic abilities, tools, weapons, and mounts.
-- =============================================================================

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
