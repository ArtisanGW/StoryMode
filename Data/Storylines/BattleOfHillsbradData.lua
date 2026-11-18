local addonName, SM = ...

-- =============================================================================
-- Classic: Battle of Hillsbrad
-- The Forsaken campaign against Hillsbrad, Azureload Mine, and Dun Garok.
-- =============================================================================

SM.BattleOfHillsbradData = {
    id = "battle-of-hillsbrad",  -- from its earlier title, "Battle of Hillsbrad": saved progress and share links use it
    title = "The Battle of Hillsbrad",
    description = "High Executor Darthalia has work for anyone willing to serve Tarren Mill. The humans of Hillsbrad still farm, trade, and guard the roads as if the Forsaken claim means nothing.\n\nReport for orders and carry the campaign from the fields to the mines and beyond. Darthalia will tell you who must fall next.",
    zone = "Hillsbrad Foothills",
    expansion = "Classic",
    recommendedLevel = { min = 19, max = 32 },
    faction = "Horde",
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.54, 0.44, 0.36 },
    icon = 132349,
    portraitDisplayID = 1645,
    adventureCoverTexture = 131867, -- Ruins of Lordaeron battleground loading screen
    adventureCoverIsLoadingScreen = true,
    -- WoW Forever redrew the Ruins of Lordaeron screen in full resolution.
    foreverCover = { texture = 7963782, texCoords = { 0, 1, 0.1592, 0.8408 } },

    startQuest = { id = 527, name = "Battle of Hillsbrad", npc = "High Executor Darthalia", location = "Tarren Mill, Hillsbrad Foothills" },
    startMapID = 25,
    startX = 0.6200,
    startY = 0.1950,

    npcLocations = {
        ["High Executor Darthalia"] = { mapID = 25, x = 0.6200, y = 0.1950, location = "Tarren Mill, Hillsbrad Foothills" },
        ["Deathguard Samsa"] = { mapID = 25, x = 0.6200, y = 0.2000, location = "Tarren Mill, Hillsbrad Foothills" },
        ["WANTED"] = { mapID = 25, x = 0.6250, y = 0.1970, location = "the wanted poster outside the inn in Tarren Mill" },
        ["Varimathras"] = { mapID = 90, x = 0.5600, y = 0.9200, location = "the Royal Quarter, Undercity" },
        ["Hillsbrad Fields"] = { mapID = 25, x = 0.3200, y = 0.4500, location = "Hillsbrad Fields, Hillsbrad Foothills" },
        ["Hillsbrad Town"] = { mapID = 25, x = 0.3100, y = 0.4200, location = "Hillsbrad, Hillsbrad Foothills" },
        ["Azureload Mine"] = { mapID = 25, x = 0.3000, y = 0.5800, location = "Azureload Mine, Hillsbrad Foothills" },
        ["Dun Garok"] = { mapID = 25, x = 0.6900, y = 0.7600, location = "Dun Garok, Hillsbrad Foothills" },
        -- WoW Forever only; where Wowhead's Forever data places him.
        ["Deathstalker Masoj"] = { mapID = 25, x = 0.6400, y = 0.5380, location = "Hillsbrad Foothills" },
    },

    npcDisplayIDs = {
        ["High Executor Darthalia"] = 1645,
        ["Varimathras"] = 11658,
        -- Quest givers' models from Wowhead's WoW Forever data.
        ["Deathstalker Masoj"] = 146378,
    },

    chapterDisplayIDs = {
        ["Hillsbrad Fields"] = 1645,
        ["Town and Mine"] = 1645,
        ["Dun Garok"] = 11658,
    },

    chapterIcons = {
        ["Hillsbrad Fields"] = 132349,
        ["Town and Mine"] = 134708,
        ["Dun Garok"] = 132355,
    },

    chapters = {
        {
            chapter = "Hillsbrad Fields",
            summary = "High Executor Darthalia runs Tarren Mill like a war room. Down the hill, the humans of Hillsbrad still farm and trade as if the Forsaken weren't there. Darthalia means to change that, and the farms come first.",
            recap = "High Executor Darthalia runs Tarren Mill like a war room, because it is one. Down in Hillsbrad the humans were still farming and trading as if the Forsaken weren't sitting up the hill, and Darthalia meant to correct that.\n\nFirst orders were the northern farms, with a couple of farmers named outright. Darthalia likes names on a list. After that, the peasants. Grim work. It got done.\n\nDeathguard Samsa had a sideline going too: thirty human skulls. Thirty. Samsa didn't explain, and in Tarren Mill you learn quickly which questions aren't worth the answer.\n\nThat was the opening move. Darthalia already had the next one picked out.",
            quests = {
                { id = 527, name = "Battle of Hillsbrad", displayName = "The Northern Farms", npc = "High Executor Darthalia" },
                { id = 528, name = "Battle of Hillsbrad", displayName = "The Peasants", npc = "High Executor Darthalia" },
                { id = 546, name = "Souvenirs of Death", npc = "Deathguard Samsa", optional = true, showIf = 527 },
            },
        },
        {
            chapter = "Town and Mine",
            summary = "Darthalia's list moves on to Hillsbrad itself: the blacksmith, the town hall, and the mine that keeps the town supplied. Report to the High Executor in Tarren Mill for the next set of orders.",
            recap = "After the farms, the town. Darthalia took Hillsbrad apart like a clock: the smithy, the town hall, the mine. I walked out of the town hall with the registry under my arm and the proclamation destroyed behind me. Hard to run a town without a smith, a council or its paperwork.\n\nThe best bit, though, was the wanted poster outside the inn in Tarren Mill. Four names on it: a clerk, a citizen, a miner and a farmer, every one of them marked dangerous. A farmer, I can see. A miner, sure. But I'd have paid good money to see the clerk be dangerous.",
            quests = {
                { id = 529, name = "Battle of Hillsbrad", displayName = "The Blacksmith", npc = "High Executor Darthalia" },
                { id = 532, name = "Battle of Hillsbrad", displayName = "The Town Hall", npc = "High Executor Darthalia" },
                { id = 567, name = "Dangerous!", npc = "WANTED", optional = true },
                { id = 539, name = "Battle of Hillsbrad", displayName = "Azureload Mine", npc = "High Executor Darthalia" },
            },
        },
        {
            chapter = "Dun Garok",
            summary = "Next on Darthalia's map is Dun Garok, the dwarven fort in the south of the foothills. Dwarves dig in deep and shoot straight, and these have had years of practice. The High Executor in Tarren Mill has your orders.",
            recap = "Dun Garok is a dwarven fort down in the south of the foothills, and it was the last thing standing between Darthalia and a finished campaign. Ten mountaineers, eight riflemen, four priests and Captain Ironhill. The riflemen were the worst of it. Dwarves can shoot, and they've had a lot of practice.\n\nOnce Ironhill fell, Darthalia sealed up a commendation and sent me down to the Undercity to hand it to Varimathras. My own praise, sealed, and not for my eyes. I carried it the whole way without peeking and handed it over with a perfectly straight face.\n\nI like to think it was flattering. I'll never know. That's the trouble with sealed letters. They're all about you, and none of them are for you.",
            quests = {
                -- WoW Forever scouts the dwarves first: orders for Deathstalker Masoj, in the hills north of Dun Garok.
                { id = 98094, name = "Scout Support", npc = "High Executor Darthalia", gameVersions = { forever = true } },
                { id = 98095, name = "Valuable Vantages", npc = "Deathstalker Masoj", gameVersions = { forever = true } },
                { id = 541, name = "Battle of Hillsbrad", displayName = "Dun Garok", npc = "High Executor Darthalia" },
                { id = 550, name = "Battle of Hillsbrad", displayName = "Darthalia's Commendation", npc = "High Executor Darthalia" },
            },
        },
    },
}
