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
            summary = "Earn your place with Warug of the Magram or Uthek the Wise of the Gelkis. Either clan will send you toward the Valley of Bones, where something has begun to stir.",
            recap = "Warug wanted the Gelkis' sacred tears shattered and a conqueror's crown carried home from the Badlands, while Uthek wanted a shard of draenethyst from the Swamp of Sorrows. Both roads led to the Valley of Bones, where skeletons that were never centaur clawed their way out of the ground. Orgrul saw only power in it: he bound stolen tears and cursed wood into staves and had you raise the dead for the Magram. Nerlokh saw the necromancers' robes and knew them for Gelkis exiles, and Uthek turned Theradras' tears and the draenethyst into a weapon to break the curse instead.",
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
            summary = "Follow your clan's war deeper into the Valley of Bones, toward the outcasts' hideaway and the khan who rules the Magram.",
            recap = "Gelkis allies freed their captured kin and laid the failed summons back in the earth, while Magram allies cut through the Bristleback and the outcast hideaway from Hagiak's front. With so many Magram drawn into the valley, Nerlokh judged their village nearly unguarded, and Khan Jehn fell in his own home to outsiders working for the Gelkis. Orgrul met the news without rage. He pressed the necromancy staff back into Magram hands, and in a tent by the village lake, the khan was raised again.",
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
            summary = "A cracked crystal pylon hums faintly among the elven ruins. Search Shen'dralas for others like it and find out who still tends them.",
            recap = "The crystal you found was one of several Shen'dralar pylons, and their missing shards had been carried off as trophies to the Magram and Gelkis villages. Mordent Evenshade had you bring the fragments back, then borrow the temple's Mana Sieve to gather the loose mana drifting through the woods and pour it into the pylons. Only once they hummed again, under a sky that had suddenly changed, did Mordent stop to explain, before sending you into the temple to find an old friend, Magister Kirandis. Inside, Historian Biraxas, still rattled at seeing the precious relic carried through the haunted woods, found a use for your meddling: feeding a dying protector's crystal heart to an unstable rift, to learn whether Shen'dralas still held enough mana to make new guardians.",
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
            summary = "Mithera once kept a garden beside the temple and left treants, woken by a necklace from her daughter, to tend it in her stead. Find out what became of her garden and her old friend Woodwyrd.",
            recap = "The Forlorn Gardens had turned wild and hostile, and the necklace that woke their treants was gone from its shrine. Woodwyrd lingered there still, haunted by flames he could feel even in death, and he asked for pristine water from Maraudon to put them out. Then he named the thieves: the Bristleback. Kog'thug the Brave owned up to the theft, but the necklace now sat with his mate, Quolga the Wise, and making peace between them took the Virulent Blood of Agamaggan from Razorfen Downs and a bouquet from the very garden they had robbed. The necklace went home to Mithera with its magic spent.",
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
