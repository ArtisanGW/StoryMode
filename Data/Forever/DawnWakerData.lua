local addonName, SM = ...

-- =============================================================================
-- WoW Forever: The Dawn Waker
-- Forever's first secret: an old ring from Zephras Isle, a hilt in the ruins
-- of Ban'aethal, and a befouled water globe carried across Kalimdor to be
-- made clean.
-- =============================================================================
--
-- A secret story: it stays out of the list until the player finds a way in,
-- so it never gives the secret away. The parts can be done in any order, so
-- any of them reveals it: The Ancient Hilt, Eluvi'ana or Baron Marinous in the
-- log or done (revealedBy), or holding one of the secret's own items
-- (revealedByItems). Not the Ancient Heirloom, which every Skyborne gets, and
-- not Baron Aquanis, a Classic quest many players do without it. Steps and
-- places follow Wowhead's walkthrough by the WoW Secret Finding Discord
-- (wowhead.com/forever/guide/dawn-waker-secret-walkthrough, updated
-- 2026-11-16).
--
-- Only four steps are quests: The Ancient Hilt (93161), Eluvi'ana (97029),
-- Baron Marinous (98028, Alliance) or Baron Aquanis (6922, Horde), and
-- Libram of Binding (98685). The rest happen in conversation or with hidden
-- objects, so they are item steps (item = itemID): a step is done once the
-- character has held its item, and stays done after the item is used up.
-- Item IDs are Wowhead Forever's.
--
-- The chain has no known end yet. The last chapter stops at the Scrawled
-- Note; when the community finds what comes after, it goes here.

SM.ForeverDawnWakerData = {
    id = "dawn-waker",
    title = "The Dawn Waker",
    description = "An old ring from Zephras Isle, dented, with Kaldorei writing worn into the band. A hilt in the ruins of Ban'aethal that only shows itself by torchlight. Ealaane Nimbuswalker knows something about the blade that once fit it.\n\nThis is a secret, and its end hasn't been found yet. The trail crosses Kalimdor as far as anyone has followed it, and some of it takes a group.",
    zone = "Zephras Isle / Darkshore / Ashenvale / Shen'dralas / Feralas / Azshara / Winterspring / Mount Hyjal",
    expansion = "Classic",
    recommendedLevel = { min = 15, max = 60 },
    gameVersions = { forever = true },
    revealedBy = { 93161, 97029, 98028 },  -- The Ancient Hilt, Eluvi'ana, Baron Marinous: in the log or done
    revealedByItems = {
        276188,  -- Eluvi'ana
        279277,  -- Mathystral Amulet
        279275,  -- Clouded Water Globe
        282337,  -- Befouled Water Globe
        282404,  -- Narassin's Tome
        282548,  -- Star of Elune
        282547,  -- Abyssal Mote
        282431,  -- Tears of Anguish
        282699,  -- Cleansed Water Globe
        283387,  -- Scrawled Note
    },
    achievements = {},
    color = { 0.96, 0.80, 0.47 },
    icon = "Interface\\Icons\\inv_sword_1h_skybornec60_b_01",  -- Eluvi'ana
    portraitDisplayID = 138006,  -- Ealaane Nimbuswalker
    adventureCoverTexture = 7950679,  -- Zephras Isle's loading screen
    adventureCoverTexCoords = { 0, 1, 0.1592, 0.8408 },  -- the picture, between its transparent bands
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 93161, name = "The Ancient Hilt", npc = "Ancient Hilt", location = "the Ruins of Ban'aethal, Zephras Isle" },
    startMapID = 2521,
    startX = 0.5813,
    startY = 0.2406,

    npcLocations = {
        ["Rorian the Dayseeker"] = { mapID = 2521, x = 0.4200, y = 0.2340, location = "Thendal Village, Zephras Isle" },
        ["Ealaane Nimbuswalker"] = { mapID = 2521, x = 0.6594, y = 0.7437, location = "Zephras Isle" },
        ["Onu"] = { mapID = 1439, x = 0.4360, y = 0.7640, location = "the Grove of the Ancients, Darkshore" },
        ["Je'neu Sancrea"] = { mapID = 1440, x = 0.1160, y = 0.3420, location = "Zoram'gar Outpost, Ashenvale" },
        ["Highborne Spirit"] = { mapID = 1440, x = 0.1568, y = 0.1933, location = "Zoram Strand, Ashenvale" },
        ["Mordent Evenshade"] = { mapID = 2652, x = 0.3505, y = 0.4649, location = "the ruins outside the temple, Shen'dralas" },
    },

    npcDisplayIDs = {
        -- Wowhead Forever's models for the Forever NPCs; the cmangos Classic
        -- database's for the Classic ones.
        ["Rorian the Dayseeker"] = 136966,
        ["Ealaane Nimbuswalker"] = 138006,
        ["Onu"] = 1455,
        ["Je'neu Sancrea"] = 12953,
        ["Highborne Spirit"] = 147509,
        ["Mordent Evenshade"] = 30120,
        ["Lorekeeper Lydros"] = 14407,
        ["Prince Tortheldrin"] = 11256,
    },

    chapters = {
        {
            chapter = "The Ancient Heirloom",
            summary = "Rorian the Dayseeker hands an old ring to every Skyborne who comes of age in Thendal Village, and another lies upstairs in a house close by. Wear it, carry a Night Watchman's Torch into the ruins of Ban'aethal, and see what the light turns up. Ealaane Nimbuswalker will want to hear about it.",
            recap = "I came by an old ring on Zephras Isle. It's dented, and the inside of the band carries a line of Kaldorei script worn so thin I could barely read it. I put it on because it fit.\n\nThere's a dragon asleep in the ruins of Ban'aethal and a hilt there that only shows up by torchlight. I let the dragon sleep and took the hilt to Ealaane Nimbuswalker. She went quiet for a while, then asked me to find the blade that belonged with it.\n\nThe blade wasn't anywhere you'd look on purpose, and I looked in a lot of places before I found it. Ealaane gave it its name, Eluvi'ana, the Night Dancer, and handed it back to me with the hilt. She watched the hilt until I put it away.",
            quests = {
                { item = 264908, name = "Ancient Heirloom", npc = "Rorian the Dayseeker", objective = "Get the Ancient Heirloom. Rorian the Dayseeker gives one to the Skyborne once they come of age, and another lies on the top floor of a house close by.", gameVersions = { forever = true } },
                { id = 93161, name = "The Ancient Hilt", npc = "Ancient Hilt", mapID = 2521, x = 0.5813, y = 0.2406, location = "the Ruins of Ban'aethal, Zephras Isle", gameVersions = { forever = true } },
                { id = 97029, name = "Eluvi'ana", npc = "Ealaane Nimbuswalker", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "The Befouled Water Globe",
            requiredLevel = 17,
            summaryAlliance = "The naga in Darkshore's Ruins of Mathystra each carry a piece of an old amulet. Put it together and take it to the water by the ruins, and something that has guarded them a long time will come up to meet you.",
            summaryHorde = "Baron Aquanis, a water elemental in the flooded halls of Blackfathom Deeps, guards a globe of strange water. Je'neu Sancrea of the Earthen Ring, at Zoram'gar Outpost, would very much like to see it.",
            recapAlliance = "The naga in the Ruins of Mathystra carry an old amulet around in pieces, a few to each naga. Twenty pieces later I had the whole thing, and at the water by the ruins it called up Baron Marinous. He came up angry and didn't last, and he left a clouded glass globe behind.\n\nI took the globe to Onu in the Grove of the Ancients. Onu held it a long while before giving it back, and by then the water inside had gone dark and foul. I've carried it around ever since.",
            recapHorde = "Baron Aquanis keeps to the flooded halls of Blackfathom Deeps. He's a water elemental, so keeping to anything is a loose way to put it. He left a globe of strange water behind, and Je'neu Sancrea of the Earthen Ring wanted a look.\n\nJe'neu studied it for a long time. When I asked for the globe back, he gave it to me. The water inside had gone dark and foul, and I've carried it around ever since.",
            quests = {
                -- Alliance: the amulet calls up Baron Marinous at a Fathom Stone.
                { item = 279277, name = "Mathystral Amulet", faction = "Alliance", mapID = 1439, x = 0.5890, y = 0.2260, location = "the Ruins of Mathystra, Darkshore", objective = "Collect 20 Mathystral Amulet Fragments from the naga in the Ruins of Mathystra and put the amulet together.", gameVersions = { forever = true } },
                { id = 98028, name = "Baron Marinous", npc = "Clouded Water Globe", faction = "Alliance", mapID = 1439, x = 0.5890, y = 0.2260, location = "the water by the Ruins of Mathystra, Darkshore", gameVersions = { forever = true } },
                { item = 282337, name = "Befouled Water Globe", npc = "Onu", faction = "Alliance", objective = "Speak with Onu again and ask for the globe back.", gameVersions = { forever = true } },
                -- Horde: the same quest as Blackfathom Villainy's (909 is its second ID).
                { id = 6922, altIds = { 909 }, name = "Baron Aquanis", npc = "Strange Water Globe", faction = "Horde", instance = "dungeon", location = "Blackfathom Deeps, Ashenvale" },
                { item = 282337, name = "Befouled Water Globe", npc = "Je'neu Sancrea", faction = "Horde", objective = "Speak with Je'neu Sancrea again and ask for the globe back.", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "The Highborne Spirit",
            summary = "Wear the old ring on Zoram Strand, in Ashenvale, with the befouled globe in your pack, and you won't be alone on the beach for long.",
            recap = "On Zoram Strand, with the ring on my finger and the globe in my pack, I met a Highborne spirit who had been waiting a very long time for someone carrying exactly that. He sent me up the Tower of Althalaxx in Darkshore.\n\nAthrikus Narassin keeps the top of that tower, and he kept the key to the strongbox behind him on his belt. Inside the box was his tome. I brought it back to the beach, and the spirit sent me on to Shen'dralas.",
            quests = {
                { item = 282404, name = "Narassin's Tome", npc = "Highborne Spirit", objective = "Wear the Ancient Heirloom and speak with the Highborne Spirit on Zoram Strand while carrying the Befouled Water Globe. Then take the Azsharan Key from Athrikus Narassin at the top of the Tower of Althalaxx in Darkshore and open the strongbox behind him.", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "Synthesis",
            summary = "Mordent Evenshade, outside the temple in Shen'dralas, knows what Narassin's Tome is for. Bring him the tome with the hilt, the Night Dancer and the globe, and he'll tell you what it takes to make the water clean again. Some of it takes a group of five.",
            recap = "Mordent Evenshade read Narassin's tome and told me the globe needed a Star of Elune, an Abyssal Mote and the Tears of Anguish, none of them anywhere near Shen'dralas.\n\nThe star sat in a vault in the ogre temple in southern Feralas, a vault you only see with the ring on. Opening it took five of us, four pulling switches around the temple at once and one at the vault. The mote was in a chest at the bottom of the sea off Azshara. The tears came off the Highborne ghosts at Lake Kel'theril, and only some of them had any to give.",
            quests = {
                { item = 282548, name = "Star of Elune", mapID = 1444, x = 0.5850, y = 0.7160, location = "the ogre temple in southern Feralas", objective = "Wear the Ancient Heirloom and find the Shen'dralar Vault on the temple's ground floor. Four Ancient Switches around the temple must be pulled at the same moment to open it, so bring four friends.", gameVersions = { forever = true } },
                { item = 282547, name = "Abyssal Mote", parallel = true, mapID = 1447, x = 0.6600, y = 0.5410, location = "under the water off Azshara", objective = "Finish the quests that begin with Kirith and end with Azsharite, then open the Abyssal Chest under the water in Azshara.", gameVersions = { forever = true } },
                { item = 282431, name = "Tears of Anguish", parallel = true, mapID = 1452, x = 0.5360, y = 0.4320, location = "Lake Kel'theril, Winterspring", objective = "Once Mordent Evenshade has told you what the globe needs, take the Tears of Anguish from the Anguished Highborne and Suffering Highborne at Lake Kel'theril.", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "The Shrine of Coalescence",
            summary = "With the star, the mote and the tears in hand, Mordent sends you to Hyjal, to the Shrine of Coalescence.",
            recap = "At the Shrine of Coalescence in Hyjal I laid out the star, the mote and the tears and used the globe, and the water inside it cleared.\n\nWith the water clear I could see what the globe was. It held the last of an elemental that once guarded a Highborne city, and I had met that elemental at the bottom of its own ruins and killed it. When I brought the globe back to Shen'dralas, Mordent didn't hold that against me.",
            quests = {
                { item = 282699, name = "Cleansed Water Globe", mapID = 2482, x = 0.7270, y = 0.3720, location = "the Shrine of Coalescence, Mount Hyjal", objective = "Take the Star of Elune, the Abyssal Mote and the Tears of Anguish to the Shrine of Coalescence in Hyjal, and use the Befouled Water Globe there.", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "The Two Blades",
            summary = "Mordent has heard the clean globe out, and sends you to the last prince of Eldre'Thalas in Dire Maul. Prince Tortheldrin remembers two blades. This is as far as anyone has followed the Dawn Waker so far.",
            recap = "Mordent sent me to Dire Maul, to Prince Tortheldrin, who spoke of two blades, Eluvi'ana and Eluvi'tor, and of knowledge kept for those honored in his court. I had one of the blades on my belt already.\n\nLorekeeper Lydros made me an Arcanum of Binding out of a libram, a black diamond, two brilliant shards and an arcane crystal, and I bound the old hilt with it. When I went back, the prince gave me a scrawled note. It's a short riddle. Day has to wake where night dances, and something has to be cast in flames born of air.\n\nThat's where the trail stops for now, for me and for everyone else hunting it. I keep the hilt and the Night Dancer together, in case the answer turns up.",
            quests = {
                { id = 98685, name = "Libram of Binding", npc = "Lorekeeper Lydros", instance = "dungeon", location = "Dire Maul, Feralas", gameVersions = { forever = true } },
                { item = 283387, name = "Scrawled Note", npc = "Prince Tortheldrin", instance = "dungeon", location = "Dire Maul, Feralas", objective = "Use the Arcanum of Binding on the Ancient Hilt, then speak with Prince Tortheldrin again. The note's riddle is still unsolved.", gameVersions = { forever = true } },
            },
        },
    },
}
