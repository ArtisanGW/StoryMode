local addonName, SM = ...

-- =============================================================================
-- WoW Forever: The Secret Prison
-- SI:7 and the Kor'kron follow separate trails to a hidden prison on Alcaz Island.
-- =============================================================================

SM.ForeverAlcazPrisonData = {
    title = "The Secret Prison",
    description = "Jaina Proudmoore's marines have brought in a man found washed up on the shore, and his claim is one SI:7 cannot ignore. Master Mathias Shaw wants someone discreet in Theramore to learn the truth. In Orgrimmar, Eitrigg has a worry of his own: a band of Kor'kron Elite sent into Dustwallow Marsh is long overdue.\n\nBoth trails bend toward Alcaz Island, an old ruin off the marsh's coast that hardly anyone thinks about. Whatever waits beneath its keep, someone has gone to great lengths to hide it.",
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
        ["Master Mathias Shaw"] = { mapID = 1453, x = 0.7580, y = 0.5980, location = "SI:7, Old Town, Stormwind City" },
        ["Sully McCleary"] = { mapID = 1445, x = 0.6340, y = 0.4240, location = "behind the graveyard outside Theramore, Dustwallow Marsh" },
        ["Eitrigg"] = { mapID = 1454, x = 0.3420, y = 0.3900, location = "Grommash Hold, Orgrimmar" },
        ["Nazeer Bloodpike"] = { mapID = 1445, x = 0.3520, y = 0.3060, location = "Brackenwall Village, Dustwallow Marsh" },
        ["Sergeant Ulka"] = { mapID = 1445, x = 0.7030, y = 0.1910, location = "near Alcaz Island, Dustwallow Marsh" },
        ["Renzik \"The Shiv\""] = { mapID = 1453, x = 0.7580, y = 0.6020, location = "SI:7, Old Town, Stormwind City" },
        ["Nazgrel"] = { mapID = 1454, x = 0.3240, y = 0.3600, location = "Grommash Hold, Orgrimmar" },
    },

    chapters = {
        {
            chapter = "Rumors and Silence",
            summary = "Answer your faction's call to Dustwallow Marsh. For the Alliance, meet an SI:7 contact in Theramore about a stranger's impossible claim; for the Horde, find out where the overdue Kor'kron went.",
            recap = "In Theramore, Sully McCleary would not talk inside the inn. Behind the graveyard he gave you a glamour that passed for a Kul Tiras marine, and you crept into Jaina's tower to listen to her inner circle. On the Horde's road, Nazeer Bloodpike recalled Kor'kron who had spoken of \"the island,\" and the trail ended at Sergeant Ulka, wounded and too proud to take a helping hand. Every lead now pointed to a prison on Alcaz Island that no one had heard of.",
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
            summary = "Go down into the dungeons beneath the old keep on Alcaz Island and learn what someone went to such lengths to hide. If you march for the Horde, find Commander Folkar there first.",
            recap = "The dungeons beneath Alcaz were already a battlefield of guards in blood-red bandanas, naga raiders and black dragons. Commander Folkar, his axe arm broken and most of his elites dead, told the Horde why the Kor'kron had come: the Warchief wanted Varian Wrynn, King of Stormwind, brought to Orgrimmar alive. Deeper in, you took the shackle key from the torturer called the Questioner and freed a chained prisoner named Mason Connery. Then a note on the ground told the rest: the king had been killed in an escape attempt just before the naga attacked.",
            quests = {
                { id = 95262, name = "The Secret Prison", npc = "Sully McCleary", faction = "Alliance", gameVersions = { forever = true } },
                { id = 95309, name = "No Orc Left Behind", npc = "Sergeant Ulka", faction = "Horde", gameVersions = { forever = true } },
                { id = 95454, name = "The Honor of the Kor'kron", npc = "Commander Folkar", faction = "Horde", location = "Alcaz Prison, Dustwallow Marsh", gameVersions = { forever = true } },
                { id = 96335, name = "The Man in the Iron Chains", npc = "Mason Connery", location = "Alcaz Prison, Dustwallow Marsh", gameVersions = { forever = true } },
                { id = 95263, name = "Somber News", faction = "Alliance", location = "Alcaz Prison, Dustwallow Marsh", gameVersions = { forever = true } },
                { id = 96369, name = "Bad News for Folkar", faction = "Horde", location = "Alcaz Prison, Dustwallow Marsh", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "Tell No One Else",
            summary = "Carry what you learned at Alcaz to the people who sent you, then follow the note the freed prisoner pressed into your hand toward a treasure he promised was worth more than gold.",
            recap = "Sully begged you to tell no one but Shaw, and Commander Folkar trusted you to carry the news to Thrall in his stead. Mason Connery's note led to his treasure in Westfall, and it was not gold but a box of documents. Shaw's goblin Renzik \"The Shiv\" or the Warchief's advisor Nazgrel was the natural reader, though Rix Xizzix in Booty Bay would pay for them instead. Connery asked only one thing in return: if anyone wondered, the man who gave you that note had died, vaporized by dragonfire and blown out to sea.",
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
