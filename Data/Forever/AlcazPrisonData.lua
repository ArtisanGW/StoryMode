local addonName, SM = ...

-- =============================================================================
-- WoW Forever: The Secret Prison
-- SI:7 and the Kor'kron follow separate trails to a hidden prison on Alcaz Island.
-- =============================================================================

SM.ForeverAlcazPrisonData = {
    title = "The Secret Prison",
    description = "Jaina Proudmoore's marines have brought in a man found washed up on the shore, and his claim is one SI:7 cannot ignore. Master Mathias Shaw wants someone discreet in Theramore to learn the truth. In Orgrimmar, Eitrigg has a worry of his own: a band of Kor'kron Elite sent into Dustwallow Marsh is long overdue.\n\nBoth trails bend toward Alcaz Island, an old ruin off the marsh's coast that hardly anyone thinks about. Whatever waits beneath its keep, someone has gone to great lengths to hide it.",
    descriptionAlliance = "Jaina Proudmoore's marines have brought in a man found washed up on the shore, and his claim is one SI:7 cannot ignore. Master Mathias Shaw wants someone discreet in Theramore to learn the truth.\n\nThe trail bends toward Alcaz Island, an old ruin off the marsh's coast that hardly anyone thinks about. Whatever waits beneath its keep, someone has gone to great lengths to hide it.",
    descriptionHorde = "In Orgrimmar, Eitrigg has a worry: a band of Kor'kron Elite sent into Dustwallow Marsh is long overdue, and nobody has heard a word from them.\n\nThe trail bends toward Alcaz Island, an old ruin off the marsh's coast that hardly anyone thinks about. Whatever waits beneath its keep, someone has gone to great lengths to hide it.",
    zone = "Dustwallow Marsh",
    expansion = "Classic",
    recommendedLevel = { min = 48, max = 53 },
    requiredLevel = 48,
    gameVersions = { forever = true },
    achievements = {},
    color = { 0.34, 0.47, 0.40 },
    icon = "Interface\\Icons\\INV_Misc_Key_03",
    adventureCoverTexture = 7963734,  -- Alcaz Prison's loading screen
    adventureCoverTexCoords = { 0, 1, 0.1592, 0.8408 },  -- the picture, between its transparent bands
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 95194, name = "Our Man in Theramore", npc = "Master Mathias Shaw", location = "SI:7, Old Town, Stormwind City", faction = "Alliance", gameVersions = { forever = true } },
    startMapID = 1453,
    startX = 0.7580,
    startY = 0.5980,

    npcLocations = {
        ["Archmage Lan'dalock"] = { mapID = 1416, x = 0.1540, y = 0.7380, location = "Dalaran, Alterac Mountains" },
        ["Master Mathias Shaw"] = { mapID = 1453, x = 0.7580, y = 0.5980, location = "SI:7, Old Town, Stormwind City" },
        ["Sully McCleary"] = { mapID = 1445, x = 0.6340, y = 0.4240, location = "behind the graveyard outside Theramore, Dustwallow Marsh" },
        ["Eitrigg"] = { mapID = 1454, x = 0.3420, y = 0.3900, location = "Grommash Hold, Orgrimmar" },
        ["Nazeer Bloodpike"] = { mapID = 1445, x = 0.3520, y = 0.3060, location = "Brackenwall Village, Dustwallow Marsh" },
        ["Sergeant Ulka"] = { mapID = 1445, x = 0.7030, y = 0.1910, location = "near Alcaz Island, Dustwallow Marsh" },
        ["Renzik \"The Shiv\""] = { mapID = 1453, x = 0.7580, y = 0.6020, location = "SI:7, Old Town, Stormwind City" },
        ["Nazgrel"] = { mapID = 1454, x = 0.3240, y = 0.3600, location = "Grommash Hold, Orgrimmar" },
    },

    npcDisplayIDs = {
        -- Quest givers' models from the cmangos Classic database.
        ["Master Mathias Shaw"] = 1736,
        ["Eitrigg"] = 1619,
        ["Renzik \"The Shiv\""] = 7613,
        ["Nazgrel"] = 1872,
        -- Quest givers' models from Wowhead's WoW Forever data.
        ["Sully McCleary"] = 142287,
        ["Sergeant Ulka"] = 142827,
        ["Commander Folkar"] = 142414,
        -- Wowhead has two Mason Connerys (264770, 264845) with different
        -- models and doesn't say which gives his quests; the first one's.
        ["Mason Connery"] = 144257,
    },

    chapters = {
        {
            chapter = "Rumors and Silence",
            summaryAlliance = "Master Mathias Shaw at SI:7 in Stormwind is curious. Jaina's marines found a man washed up on the shore near Theramore, and whatever he's telling them, Shaw wants to hear it too.",
            summaryHorde = "Eitrigg in Grommash Hold is worried. A band of Kor'kron went into Dustwallow Marsh and never came back.",
            recapAlliance = "Shaw sends me to Theramore to meet his man there, Sully McCleary. Sully won't say a word in the inn. Too many ears. Out behind the graveyard he hands me a disguise kit, and next thing I know I'm one of Jaina's marines, standing guard in her tower while she and her people talk.\n\nYou learn a lot standing still in a room full of important people who think you're furniture. A man had washed up on the shore, and what he claimed had them all worried. And there it was again and again in their talk: the island.\n\nI walked out of there slow, like a marine with nowhere to be, and didn't breathe right until I was back in the marsh.",
            recapHorde = "Eitrigg doesn't waste words. A band of Kor'kron went into Dustwallow Marsh and didn't come back. Find out. That's the whole briefing.\n\nAt Brackenwall, Nazeer Bloodpike remembered them all right. Loud, proud, and talking about the island. Which island? Nobody thought to ask a Kor'kron.\n\nThe trail ran out at Sergeant Ulka, sitting by the water with a wound that would have dropped most people, insisting everything was under control. I offered a hand. The sergeant would not take it. That's the Kor'kron for you. You'd admire it if it weren't so tiring.",
            quests = {
                { id = 95194, name = "Our Man in Theramore", npc = "Master Mathias Shaw", faction = "Alliance", gameVersions = { forever = true } },
                { id = 95196, name = "Watch Yer Back", npc = "Sully McCleary", faction = "Alliance", mapID = 1445, x = 0.6620, y = 0.4520, location = "the inn at Theramore Isle, Dustwallow Marsh", gameVersions = { forever = true } },
                { id = 95198, name = "The Return of the King?", npc = "Sully McCleary", faction = "Alliance", gameVersions = { forever = true } },
                { id = 95283, name = "The Missing Kor'kron", npc = "Eitrigg", faction = "Horde", gameVersions = { forever = true } },
                { id = 95284, name = "The Elite of the Elite", npc = "Nazeer Bloodpike", faction = "Horde", gameVersions = { forever = true } },
                { id = 95285, name = "Right Place, Wrong Time", npc = "Sergeant Ulka", faction = "Horde", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "Beneath the Keep",
            summaryAlliance = "All the talk in Jaina's tower kept coming back to one place: Alcaz Island, an old ruin off the marsh's coast. Sully McCleary, behind the graveyard outside Theramore, wants you to go and see what's hidden under its keep.",
            summaryHorde = "Sergeant Ulka, wounded and waiting by the water near Alcaz Island, has a job for you after all. Commander Folkar took the rest of the Kor'kron into the prison under the island's old keep. Somebody has to go in after them.",
            recapAlliance = "Alcaz Island. An old keep, rotten docks, and under it a prison nobody was ever supposed to know about. By the time I got down there it was already a brawl: guards in blood-red bandanas, naga coming up out of the water, and black dragons, because of course.\n\nI went looking for the king. Found a torturer they called the Questioner instead, and he had a key, and the key fit the chains on a fellow named Mason Connery. Nice man. Very grateful. Then a note on the floor told me the rest. The king had died trying to escape, just before the naga came in.\n\nI read it twice. Then I took it back to Sully, and Sully went very quiet.",
            recapHorde = "Ulka sent me in after Commander Folkar. Alcaz Prison was a mess: guards in blood-red bandanas, naga out of the sea, black dragons for good measure. Folkar was alive, barely, his axe arm broken and most of his elites dead around him, and still every inch a Kor'kron. He told me why they'd come. The Warchief wanted Varian Wrynn, King of Stormwind, brought to Orgrimmar alive.\n\nSo I went looking for a king. I found a torturer called the Questioner, took his key, and let a chained prisoner named Mason Connery out of his irons. Then a note on the ground told me the rest. Varian had died trying to escape, just before the naga hit.\n\nI had to go back and tell Folkar. Longest short walk of my life.",
            quests = {
                { id = 95262, name = "The Secret Prison", npc = "Sully McCleary", faction = "Alliance", gameVersions = { forever = true } },
                { id = 95309, name = "No Orc Left Behind", npc = "Sergeant Ulka", faction = "Horde", gameVersions = { forever = true } },
                { id = 95454, name = "The Honor of the Kor'kron", npc = "Commander Folkar", faction = "Horde", location = "Alcaz Prison, Dustwallow Marsh", gameVersions = { forever = true } },
                { id = 96335, name = "The Man in the Iron Chains", npc = "Mason Connery", location = "Alcaz Prison, Dustwallow Marsh", gameVersions = { forever = true } },
                { id = 95263, name = "Somber News", faction = "Alliance", location = "Alcaz Prison, Dustwallow Marsh", gameVersions = { forever = true } },
                { id = 96369, name = "Bad News for Folkar", faction = "Horde", location = "Alcaz Prison, Dustwallow Marsh", gameVersions = { forever = true } },
                { id = 96381, name = "A Bit of Wet Work", npc = "Sully McCleary", faction = "Alliance", optional = true, gameVersions = { forever = true }, recap = "Sully had been watching Alcaz through his looking glass and saw naga coming ashore, led by a sorceress barking orders. He asked me to thin them out while I was in there and bring back her head. I did both. As Sully put it, the enemy of your enemy is still a naga." },
                { id = 96772, name = "The Dragon's Journal", npc = "Archmage Lan'dalock", faction = "Alliance", optional = true, gameVersions = { forever = true }, recap = "Archmage Lan'dalock had been scrying Alcaz Island from Dalaran until someone on the island noticed and shut the spell down. Just before that, it caught a journal written in old draconic, and Lan'dalock wanted it. I found it. I can't read a word of draconic, so I'm taking the archmage's word that it was worth the trip." },
                { id = 96332, name = "A Little Payback", npc = "Sergeant Ulka", faction = "Horde", optional = true, gameVersions = { forever = true }, recap = "Sergeant Ulka had lost good orcs on Alcaz and wanted it squared, naga for orc, starting with the sorceress giving the orders. I came back with her head and a long list of naga who wouldn't be needing theirs. Ulka didn't smile, exactly. From the Kor'kron, that's practically a hug." },
                { id = 96334, name = "Blood Red Bandanas", npc = "Sergeant Ulka", faction = "Horde", optional = true, gameVersions = { forever = true }, recap = "Ulka's people had been fighting humans in red bandanas on Alcaz, which put Ulka in mind of a gang from the Eastern Kingdoms. I collected the bandanas and carried them to Eitrigg in Orgrimmar. Eitrigg confirmed it: Defias, a very long way from Westfall. Nobody could tell me what they were doing there." },
            },
        },
        {
            chapter = "Tell No One Else",
            summaryAlliance = "Sully McCleary has one request: tell no one what you found under Alcaz but Master Shaw in Stormwind. And the prisoner you freed pressed a note into your hand on the way out, promising a treasure worth more than gold.",
            summaryHorde = "Commander Folkar is in no shape to travel, so it falls to you to tell Thrall in Orgrimmar what you found under Alcaz. And the prisoner you freed pressed a note into your hand, promising a treasure worth more than gold.",
            recapAlliance = "Sully begged me to tell no one but Shaw, so I told Shaw, and Shaw took it the way he takes everything, which is to say you'd never know.\n\nConnery had pressed a note into my hand on the way out. A treasure, he said, worth more than gold, buried in Westfall. I dug it up. A box of papers. Worth more than gold to somebody, I'm sure. Renzik, Shaw's goblin, was dying to see them, and a goblin in Booty Bay named Rix Xizzix would have paid me for them instead. I'll let you guess.\n\nConnery only asked one thing in return. If anyone wonders, he's dead. Caught in dragonfire and blown out to sea. So, for the record: tragic. Never met the man.",
            recapHorde = "Folkar couldn't make the trip himself, so I carried it to Thrall: the king was dead, and the Kor'kron had come home with nothing but bad news and a broken arm. Thrall listened. Thrall always listens. Somehow that's worse.\n\nConnery had pressed a note into my hand on the way out. A treasure in Westfall, worth more than gold. It was a box of papers. Nazgrel, who advises the Warchief, wanted a look, and a goblin in Booty Bay named Rix Xizzix would have paid me for them instead. I'll let you guess.\n\nConnery only asked one thing in return. If anyone wonders, he's dead. Caught in dragonfire and blown out to sea. So, for the record: tragic. Never met the man.",
            quests = {
                { id = 95264, name = "Shaw Needs To Know", npc = "Sully McCleary", faction = "Alliance", gameVersions = { forever = true } },
                { id = 95483, name = "Thrall Needs to Know", npc = "Commander Folkar", faction = "Horde", location = "Alcaz Prison, Dustwallow Marsh", gameVersions = { forever = true } },
                { id = 96337, name = "More Valuable Than Gold", npc = "Mason Connery", location = "Alcaz Prison, Dustwallow Marsh", gameVersions = { forever = true } },
                -- One Document Box, three buyers: Renzik (Alliance), Nazgrel (Horde) or Rix Xizzix in Booty Bay (96379, either faction).
                { id = 96377, altIds = { 96379 }, name = "State Secrets", npc = "Renzik \"The Shiv\"", faction = "Alliance", gameVersions = { forever = true } },
                { id = 96376, altIds = { 96379 }, name = "State Secrets", npc = "Nazgrel", faction = "Horde", gameVersions = { forever = true } },
            },
        },
    },
}
