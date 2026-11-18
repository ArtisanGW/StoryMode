local addonName, SM = ...

-- =============================================================================
-- WoW Forever: Shen'dralas
-- The Magram-Gelkis feud spills into the Valley of Bones, and the old elven
-- ruins of Shen'dralas wake around it.
-- =============================================================================
--
-- The Magram and Gelkis lines are a reputation choice, not a faction split:
-- each player follows one clan. Magram lines hide once Ongeku (1373, the Gelkis
-- entry) is done; Gelkis lines hide once Broken Tears (1369, the Magram entry)
-- is done. Before the choice both entry quests show.

SM.ForeverShendralasData = {
    id = "shen-dralas",  -- from its earlier title, "Shen'dralas": saved progress and share links use it
    title = "The Valley of Bones",
    description = "The old feud between the Magram and the Gelkis has spilled into Shen'dralas, where elven ruins hide a valley of bones and a dark magic that answers to whoever reaches for it. Whichever clan you call friend, the dead there will not stay quiet.\n\nBeyond the centaur battle lines, cracked pylons hum in the forest, a reclusive order of elves still keeps its temple, and a gardener wonders what became of the treants she left to guard her flowers.",
    zone = "Desolace / Shen'dralas",
    expansion = "Classic",
    recommendedLevel = { min = 33, max = 49 },
    requiredLevel = 30,
    gameVersions = { forever = true },
    achievements = {},
    color = { 0.56, 0.48, 0.66 },
    icon = "Interface\\Icons\\Spell_Shadow_RaiseDead",
    adventureCoverTexture = 131850,  -- Maraudon, Desolace's dungeon
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 1369, name = "Broken Tears", npc = "Warug", location = "Magram Village, Desolace" },
    startMapID = 1443,
    startX = 0.7480,
    startY = 0.6800,

    npcLocations = {
        ["Warug"] = { mapID = 1443, x = 0.7480, y = 0.6800, location = "Magram Village, Desolace" },
        ["Uthek the Wise"] = { mapID = 1443, x = 0.3620, y = 0.7920, location = "Gelkis Village, Desolace" },
        ["Captain Pentigast"] = { mapID = 1443, x = 0.6640, y = 0.1080, location = "Nijel's Point, Desolace" },
        ["Gurda Wildmane"] = { mapID = 1443, x = 0.5620, y = 0.5940, location = "Ghost Walker Post, Desolace" },
    },

    npcDisplayIDs = {
        -- Quest givers' models from the cmangos Classic database.
        ["Warug"] = 1258,
        ["Uthek the Wise"] = 4875,
        -- Quest givers' models from Wowhead's WoW Forever data.
        ["Orgrul"] = 9433,
        ["Nerlokh"] = 9422,
        ["Rokren"] = 9436,
        ["Hagiak"] = 9430,
        ["Mordent Evenshade"] = 30120,
        ["Historian Biraxas"] = 138905,
        ["Mithera"] = 138264,
        ["Woodwyrd"] = 138335,
        ["Kog'thug the Brave"] = 143817,
        ["Captain Pentigast"] = 4693,
        ["Gurda Wildmane"] = 4695,
    },

    chapters = {
        {
            chapter = "The Valley of Bones",
            summaryAlliance = "Two centaur clans, the Magram and the Gelkis, have feuded for generations. Captain Pentigast at Nijel's Point wants the Alliance to have a friend in one of them. Which one is up to you. Either way, the road leads to the Valley of Bones.",
            summaryHorde = "Two centaur clans, the Magram and the Gelkis, have feuded for generations. Gurda Wildmane at Ghost Walker Post wants the Horde to have a friend in one of them. Which one is up to you. Either way, the road leads to the Valley of Bones.",
            recap = "The Magram and the Gelkis have been feuding longer than anyone can remember, and each wanted me on their side. I'm not saying which one got me. Either way I ended up in the Valley of Bones, where skeletons were clawing up out of the ground. Not centaur skeletons, either.\n\nThe Magram looked at that and saw an army. Orgrul wanted bones to build it with, gently cursed, and wanted exactly four hundred and twenty-six of them. Somebody there can count. The Gelkis looked at the necromancers' robes, saw their own exiles, and wanted the curse broken.\n\nEither way, I ended up holding somebody else's staff and pointing it at the dead. What it did depended on who'd made it.",
            quests = {
                -- Magram. Each clan's path hides once the player does a quest only the
                -- other clan gives.
                { id = 1385, name = "Brutal Politics", npc = "Captain Pentigast", faction = "Alliance", hideIf = { 1382, 1384, 1368, 1370, 1373 }, gameVersions = { forever = true } },
                { id = 1386, name = "Assault on the Kolkar", npc = "Warug", faction = "Alliance", hideIf = { 1382, 1384, 1368, 1370, 1373 }, gameVersions = { forever = true } },
                { id = 1367, name = "Magram Alliance", npc = "Gurda Wildmane", faction = "Horde", hideIf = { 1382, 1384, 1368, 1370, 1373 }, gameVersions = { forever = true } },
                { id = 1369, name = "Broken Tears", npc = "Warug", hideIf = { 1382, 1384, 1368, 1370, 1373 }, gameVersions = { forever = true } },
                { id = 92743, name = "A Conqueror's Crown", npc = "Warug", hideIf = { 1382, 1384, 1368, 1370, 1373 }, gameVersions = { forever = true } },
                { id = 92841, name = "Valley of Bones", npc = "Warug", hideIf = { 1382, 1384, 1368, 1370, 1373 }, gameVersions = { forever = true } },
                { id = 92844, name = "Mountain of Bones", npc = "Orgrul", location = "the northern entrance to the Valley of Bones, Shen'dralas", hideIf = { 1382, 1384, 1368, 1370, 1373 }, gameVersions = { forever = true } },
                { id = 92846, name = "Outcast Necromancers", location = "the Valley of Bones, Shen'dralas", parallel = true, hideIf = { 1382, 1384, 1368, 1370, 1373 }, gameVersions = { forever = true } },
                { id = 92847, name = "Corrupting Tears", npc = "Orgrul", location = "the northern entrance to the Valley of Bones, Shen'dralas", hideIf = { 1382, 1384, 1368, 1370, 1373 }, gameVersions = { forever = true } },
                { id = 92873, name = "Proof of Concept", npc = "Orgrul", location = "the northern entrance to the Valley of Bones, Shen'dralas", hideIf = { 1382, 1384, 1368, 1370, 1373 }, gameVersions = { forever = true } },
                { id = 92893, name = "No Mercy for the Weak", npc = "Orgrul", location = "the northern entrance to the Valley of Bones, Shen'dralas", hideIf = { 1382, 1384, 1368, 1370, 1373 }, gameVersions = { forever = true } },
                { id = 92894, name = "Bone Raising", npc = "Orgrul", location = "the northern entrance to the Valley of Bones, Shen'dralas", parallel = true, hideIf = { 1382, 1384, 1368, 1370, 1373 }, gameVersions = { forever = true } },
                -- Gelkis
                { id = 1382, name = "Strange Alliance", npc = "Captain Pentigast", faction = "Alliance", parallel = true, hideIf = { 1385, 1386, 1367, 1369 }, gameVersions = { forever = true } },
                { id = 1384, name = "Raid on the Kolkar", npc = "Uthek the Wise", faction = "Alliance", hideIf = { 1385, 1386, 1367, 1369 }, gameVersions = { forever = true } },
                { id = 1370, name = "Stealing Supplies", npc = "Uthek the Wise", faction = "Alliance", hideIf = { 1385, 1386, 1367, 1369 }, gameVersions = { forever = true } },
                { id = 1368, name = "Gelkis Alliance", npc = "Gurda Wildmane", faction = "Horde", parallel = true, hideIf = { 1385, 1386, 1367, 1369 }, gameVersions = { forever = true } },
                { id = 1373, name = "Ongeku", npc = "Uthek the Wise", parallel = true, hideIf = { 1385, 1386, 1367, 1369 }, gameVersions = { forever = true } },
                { id = 93034, name = "Valley of Bones", npc = "Uthek the Wise", hideIf = { 1385, 1386, 1367, 1369 }, gameVersions = { forever = true } },
                { id = 93035, name = "Ravaging Ravagers", npc = "Nerlokh", location = "the southern entrance to the Valley of Bones, Shen'dralas", hideIf = { 1385, 1386, 1367, 1369 }, gameVersions = { forever = true } },
                { id = 93037, name = "Outing Outcasts", npc = "Nerlokh", location = "the southern entrance to the Valley of Bones, Shen'dralas", parallel = true, hideIf = { 1385, 1386, 1367, 1369 }, gameVersions = { forever = true } },
                { id = 93041, name = "Facing the Truth", npc = "Nerlokh", location = "the southern entrance to the Valley of Bones, Shen'dralas", hideIf = { 1385, 1386, 1367, 1369 }, gameVersions = { forever = true } },
                { id = 93044, name = "A Cleansing Cry", npc = "Uthek the Wise", hideIf = { 1385, 1386, 1367, 1369 }, gameVersions = { forever = true } },
                { id = 93045, name = "Test Your Theory", npc = "Uthek the Wise", hideIf = { 1385, 1386, 1367, 1369 }, gameVersions = { forever = true } },
            },
        },
        {
            chapter = "Khan Jehn",
            requiredLevel = 35,
            summary = "Neither clan is finished with the Valley of Bones. Ride with the Magram, and Orgrul has work for you at the valley's northern entrance. Ride with the Gelkis, and Nerlokh waits at the southern one. The feud is far from settled.",
            recap = "Ride with the Gelkis, and the khan of the Magram is the problem. With so many Magram tied up in the valley their village was nearly empty, and Khan Jehn died in his own home at the hands of outsiders working for the Gelkis.\n\nRide with the Magram, and the khan's death is the news waiting for you when you come back from the front. Orgrul didn't rage about it. Orgrul just handed the necromancy staff back to the Magram, and in a tent by the village lake, Khan Jehn got up again.\n\nWhich ride was mine, I'm keeping to myself. Either way, the khan had a worse week than I did.",
            quests = {
                -- Gelkis
                { id = 93058, name = "Saving Our Own", npc = "Nerlokh", location = "the southern entrance to the Valley of Bones, Shen'dralas", hideIf = 1369, gameVersions = { forever = true } },
                { id = 93062, name = "Bone Burying", location = "the southern entrance to the Valley of Bones, Shen'dralas", parallel = true, hideIf = 1369, gameVersions = { forever = true } },
                { id = 93122, name = "Checking Things Out", npc = "Nerlokh", location = "the southern entrance to the Valley of Bones, Shen'dralas", hideIf = 1369, gameVersions = { forever = true } },
                { id = 93128, name = "Khan Jehn", npc = "Nerlokh", location = "the southern entrance to the Valley of Bones, Shen'dralas", hideIf = 1369, gameVersions = { forever = true } },
                { id = 93125, name = "Going Home", npc = "Rokren", location = "the Outcast Hideaway, Shen'dralas", optional = true, hideIf = 1369, gameVersions = { forever = true } },
                -- Magram
                { id = 93066, name = "Bristleback Retreat", npc = "Orgrul", location = "the northern entrance to the Valley of Bones, Shen'dralas", hideIf = 1373, gameVersions = { forever = true } },
                { id = 93072, name = "Long-Term Solutions", npc = "Hagiak", location = "the Magram Front, Shen'dralas", hideIf = 1373, gameVersions = { forever = true } },
                { id = 93129, name = "Threat of Starvation", npc = "Hagiak", location = "the Magram Front, Shen'dralas", parallel = true, hideIf = 1373, gameVersions = { forever = true } },
                { id = 93188, name = "Return to Orgrul", npc = "Hagiak", location = "the Magram Front, Shen'dralas", hideIf = 1373, gameVersions = { forever = true } },
                { id = 93196, name = "Khan Jehn", npc = "Orgrul", location = "the northern entrance to the Valley of Bones, Shen'dralas", hideIf = 1373, gameVersions = { forever = true } },
            },
        },
        {
            chapter = "The Shen'dralar Pylons",
            requiredLevel = 35,
            summary = "A cracked crystal pylon stands among the elven ruins of Shen'dralas, past the centaur battle lines, and it's still humming. Ruins don't usually hum. Look for others like it, and for whoever still looks after them.",
            recap = "In the woods past the centaur lines I found a crystal pylon, cracked and humming, and Mordent Evenshade, who wanted it fixed. Its missing pieces had been carried off as trophies to both centaur villages. I took them back. From both.\n\nThen I wandered the woods with a borrowed relic, scooping up loose mana and pouring it into the pylons, and right about the time they hummed properly, the sky changed. Mordent only got round to explaining afterward.\n\nThe temple's historian was still rattled that I'd carried that relic through haunted woods, but not too rattled to send me after a dying protector's crystal heart and point me at an unstable rift. Was there still enough mana here to make new guardians?\n\nI threw it. We found out.",
            quests = {
                { id = 92914, name = "Strange Pylons", location = "a Shen'dralar pylon, Shen'dralas", gameVersions = { forever = true } },
                { id = 96010, name = "Fragments of the Pylons", npc = "Mordent Evenshade", location = "the ruins outside the temple, Shen'dralas", gameVersions = { forever = true } },
                { id = 96018, name = "Powering the Pylons", npc = "Mordent Evenshade", location = "the ruins outside the temple, Shen'dralas", gameVersions = { forever = true } },
                { id = 93016, name = "A Brief History Lesson", npc = "Mordent Evenshade", location = "the ruins outside the temple, Shen'dralas", gameVersions = { forever = true } },
                { id = 93394, name = "Meeting the Magister", npc = "Mordent Evenshade", location = "the ruins outside the temple, Shen'dralas", gameVersions = { forever = true } },
                { id = 99257, name = "A Heart of Crystal", npc = "Historian Biraxas", location = "inside the temple, Shen'dralas", parallel = true, gameVersions = { forever = true } },
                { id = 99258, name = "Mana Mania", npc = "Historian Biraxas", location = "inside the temple, Shen'dralas", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "The Forlorn Gardens",
            requiredLevel = 35,
            summary = "Mithera, at the temple in Shen'dralas, once kept a garden nearby and left treants to guard the flowers. Now Mithera wonders what became of them. Go and look in on the Forlorn Gardens. The name isn't encouraging.",
            recap = "Mithera's garden had gone wild and mean, and the necklace that woke its treants was missing from its shrine. Her old friend Woodwyrd was still there, dead and still feeling the flames. I put Woodwyrd out with a vial of water from the depths of Maraudon, which is not a sentence I ever expected to say.\n\nThe thieves were quilboar. Kog'thug the Brave owned up to it, which was brave, I suppose, but the necklace was with Kog'thug's mate now, and the two of them weren't speaking. Peace took a bouquet from the very garden they'd robbed and the blood of Agamaggan from Razorfen Downs. Not Razorfen Kraul. Kog'thug made very sure I knew the difference.\n\nThe necklace went home with its magic spent. Still from her daughter, though.",
            quests = {
                { id = 93341, name = "Forlorn Gardens", npc = "Mithera", location = "the temple, Shen'dralas", gameVersions = { forever = true } },
                { id = 93594, name = "Word of the Woods", npc = "Mithera", location = "the temple, Shen'dralas", gameVersions = { forever = true } },
                { id = 93404, name = "Rot and Regret", npc = "Woodwyrd", location = "the Forlorn Gardens, Shen'dralas", gameVersions = { forever = true } },
                { id = 93601, name = "Passing the Blame", npc = "Woodwyrd", location = "the Forlorn Gardens, Shen'dralas", gameVersions = { forever = true } },
                { id = 93604, name = "Agamaggan's Blood", npc = "Kog'thug the Brave", location = "Bristleback Retreat, Shen'dralas", gameVersions = { forever = true } },
                { id = 93606, name = "Not on Squealing Terms", npc = "Kog'thug the Brave", location = "Bristleback Retreat, Shen'dralas", gameVersions = { forever = true } },
                { id = 93609, name = "Forlorn Necklace", location = "Bristleback Retreat, Shen'dralas", gameVersions = { forever = true } },
            },
        },
    },
}
