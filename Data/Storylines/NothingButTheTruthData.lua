local addonName, SM = ...

-- =============================================================================
-- Classic: Nothing But The Truth
-- A short Horde story around Beggar's Haunt, Stonard, and Forsaken secrecy.
-- =============================================================================

SM.NothingButTheTruthData = {
    title = "Nothing But The Truth",
    description = "North of the road into Deadwind Pass, two Forsaken agents keep a quiet post at Beggar's Haunt. A human infiltrator has seen too much, and Stonard's orcs have taken him alive before the matter could be settled.\n\nWork with Deathstalker Zraedus and Apothecary Faustin on a serum meant to draw out the truth.",
    zone = "Duskwood / Swamp of Sorrows / Desolace",
    expansion = "Classic",
    recommendedLevel = { min = 37, max = 42 },
    faction = "Horde",
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.46, 0.62, 0.36 },
    icon = 136066,
    portraitDisplayID = 4342,
    adventureCoverTexture = 131869, -- Shadowfang Keep: closest Classic loading screen for Duskwood's gothic tone.
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 1372, name = "Nothing But The Truth", npc = "Deathstalker Zraedus", location = "Beggar's Haunt, Duskwood" },
    startMapID = 47,
    startX = 0.8760,
    startY = 0.3550,

    npcLocations = {
        ["Deathstalker Zraedus"] = { mapID = 47, x = 0.8760, y = 0.3550, location = "Beggar's Haunt, Duskwood" },
        ["Apothecary Faustin"] = { mapID = 47, x = 0.8740, y = 0.3550, location = "Beggar's Haunt, Duskwood" },
        ["Infiltrator Marksen"] = { mapID = 51, x = 0.4450, y = 0.5250, location = "Stonard, Swamp of Sorrows" },
        ["Mire Lord"] = { mapID = 51, x = 0.0560, y = 0.3140, location = "Misty Valley, Swamp of Sorrows" },
        ["Shadow Panthers"] = { mapID = 51, x = 0.7600, y = 0.3100, location = "eastern Swamp of Sorrows" },
        ["Deepstrider Giants"] = { mapID = 66, x = 0.3500, y = 0.2700, location = "the coast near Ethel Rethor, Desolace" },
    },

    npcDisplayIDs = {
        ["Deathstalker Zraedus"] = 4342,
        ["Apothecary Faustin"] = 4341,
        ["Infiltrator Marksen"] = 4557,
    },

    chapterDisplayIDs = {
        ["Beggar's Haunt"] = 4342,
    },

    chapterIcons = {
        ["Beggar's Haunt"] = 136066,
    },

    chapters = {
        {
            chapter = "Beggar's Haunt",
            summary = "Deathstalker Zraedus keeps a quiet Forsaken camp at Beggar's Haunt in Duskwood. A human spy was watching it, but the orcs got to him first and hauled him off to Stonard. Zraedus would like to help them get the truth out of him.",
            recap = "The orcs at Stonard had caught themselves a spy. A human, Infiltrator Marksen, who'd seen more than he should. Out at Beggar's Haunt, two of the Forsaken offered to help get the truth out of him: Deathstalker Zraedus and Apothecary Faustin. A truth serum. Very neighborly.\n\nThe recipe called for panther hearts, a rare fungus and a tumor out of a giant. I'll leave the tumor there. Faustin brewed it all up and I carried it to Zraedus, and what came back to me was called Zraedus's Brew.\n\nI took it down to Stonard and gave it to Marksen. Marksen drank it. Marksen didn't have a great deal to say after that.\n\nZraedus was very pleased with how helpful we'd all been.",
            quests = {
                { id = 1372, name = "Nothing But The Truth", displayName = "Zraedus's Request", npc = "Deathstalker Zraedus" },
                { id = 1383, name = "Nothing But The Truth", displayName = "Faustin's Serum", npc = "Apothecary Faustin" },
                { id = 1388, name = "Nothing But The Truth", displayName = "The Truth Serum", npc = "Apothecary Faustin" },
                { id = 1391, name = "Nothing But The Truth", displayName = "Stonard's Prisoner", npc = "Deathstalker Zraedus" },
            },
        },
    },
}
