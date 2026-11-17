local addonName, SM = ...

-- =============================================================================
-- WoW Forever: The Cozy Sleeping Bag
-- A trail of hidden notes from a burned-out wreck to a satchel on Thoradin's
-- Wall. Every step starts at an object, not an NPC. Each faction begins at
-- its own burned-out remains and turns the note in at the other's, across
-- the sea, where the trail goes on for both.
-- Quest IDs and places: Forever's /sm scan and the Forever Mastery and
-- wow.gg guides (Wowhead data).
-- =============================================================================

SM.ForeverCozySleepingBagData = {
    title = "The Cozy Sleeping Bag",
    description = "Someone left more than ash in a burned-out wreck: a note, written for whoever thought to look, and a plank nailed up where it would be found.\n\nFollow the trail across both continents, through a hidden camp in the mountains and over a great dam, to whatever its writer went to such lengths to hide.",
    zone = "Stonetalon Mountains / Arathi Highlands",
    expansion = "Classic",
    recommendedLevel = { min = 22, max = 32 },
    requiredLevel = 14,
    gameVersions = { forever = true },
    achievements = {},
    color = { 0.72, 0.55, 0.36 },
    icon = "Interface\\Icons\\INV_Misc_Note_02",
    adventureCoverTexture = 7963777,  -- WoW Forever's Excavation Site: Wetlands, a camp of crates and carts
    adventureCoverTexCoords = { 0, 1, 0.1592, 0.8408 },  -- the picture, between its transparent bands
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 79008, name = "... and that note you found", faction = "Alliance", mapID = 1436, x = 0.3710, y = 0.5010, location = "Burned-Out Remains, Westfall", gameVersions = { forever = true } },
    startMapID = 1436,
    startX = 0.3710,
    startY = 0.5010,

    chapterIcons = {
        ["A Note in the Ashes"] = "Interface\\Icons\\INV_Misc_Note_02",
        ["The Hidden Camp"] = "Interface\\Icons\\INV_Misc_Bag_09",
        ["Thoradin's Wall"] = "Interface\\Icons\\INV_Misc_Bag_10",
    },

    chapters = {
        {
            chapter = "A Note in the Ashes",
            summary = "A burned-out wreck holds a note that someone meant to be found. Read it, and follow where it points.",
            recap = "The note led across the sea to a second burned-out ruin, the twin of the first. Whoever wrote it had left the same sign on both continents, and beside the second ruin a plank was nailed up with the next instruction.",
            quests = {
                { id = 79008, name = "... and that note you found", faction = "Alliance", mapID = 1436, x = 0.3710, y = 0.5010, location = "Burned-Out Remains, Westfall", gameVersions = { forever = true } },
                { id = 79007, name = "... and that note you found", faction = "Horde", mapID = 1413, x = 0.4610, y = 0.7430, location = "Burned-Out Remains, The Barrens", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "The Hidden Camp",
            summary = "The plank points to an abandoned camp high in the Stonetalon Mountains, and to the litter its owner left behind.",
            recap = "The camp had been left in a hurry, its crates still holding tools and two sturdy bags. The pocket litter sent you to the cliff edge, and a leap of faith landed you beside a mound of fresh dirt on the ledge below.",
            quests = {
                -- The plank stands by the remains the note was turned in at: the other faction's.
                { id = 79192, name = "Stepping Stones", faction = "Alliance", mapID = 1413, x = 0.4610, y = 0.7430, location = "Burned-Out Remains, The Barrens", gameVersions = { forever = true } },
                { id = 79192, name = "Stepping Stones", faction = "Horde", mapID = 1436, x = 0.3710, y = 0.5010, location = "Burned-Out Remains, Westfall", gameVersions = { forever = true } },
                { id = 79980, name = "Scramble", mapID = 1442, x = 0.4060, y = 0.5240, location = "Abandoned camp, Stonetalon Mountains", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "Thoradin's Wall",
            summary = "What was buried on the ledge sends you east, first to the great dam of Loch Modan, then up onto Thoradin's Wall.",
            recap = "A carved eagle waited on the stone heads of Stonewrought Dam, and its fist pointed to Thoradin's Wall. Up on the old wall a messenger bag held the last note, and just beneath it lay the satchel the whole trail had been guarding: a cozy sleeping bag, ready for the road.",
            quests = {
                { id = 79974, name = "Wet Job", mapID = 1442, x = 0.3960, y = 0.4990, location = "Mound of Dirt, Stonetalon Mountains", gameVersions = { forever = true } },
                { id = 79975, name = "Eagle's Fist", mapID = 1432, x = 0.4940, y = 0.1290, location = "Stonewrought Dam, Loch Modan", gameVersions = { forever = true } },
                { id = 79976, name = "This Must Be The Place", mapID = 1417, x = 0.2250, y = 0.2420, location = "Thoradin's Wall, Arathi Highlands", gameVersions = { forever = true } },
            },
        },
    },
}
