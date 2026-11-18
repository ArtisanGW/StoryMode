local addonName, SM = ...

-- =============================================================================
-- Classic: Raene's Cleansing
-- Astranaar, Dartol's Rod, and the corrupted furbolg of Ashenvale.
-- =============================================================================

SM.RaenesCleansingData = {
    title = "Raene's Cleansing",
    description = "Raene Wolfrunner sends you west from Astranaar to look for Teronis, who went searching for answers to the furbolg attacks and did not return.\n\nFollow his trail through Ashenvale's moonwells, ruins, and old magic. If the forest is being changed, Raene wants to know how, and who is helping it spread.",
    zone = "Ashenvale",
    expansion = "Classic",
    recommendedLevel = { min = 18, max = 30 },
    faction = "Alliance",
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.42, 0.58, 0.36 },
    icon = 135139,
    portraitDisplayID = 1980,
    adventureCoverTexture = 131823, -- Blackfathom Deeps: Ashenvale's dungeon cover for Raene's zone story
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 991, name = "Raene's Cleansing", displayName = "Finding Teronis", npc = "Raene Wolfrunner", location = "Astranaar, Ashenvale" },
    startMapID = 63,
    startX = 0.3620,
    startY = 0.4980,

    npcLocations = {
        ["Raene Wolfrunner"] = { mapID = 63, x = 0.3620, y = 0.4980, location = "Astranaar, Ashenvale" },
        ["Teronis' Corpse"] = { mapID = 63, x = 0.2020, y = 0.4250, location = "Lake Falathim, Ashenvale" },
        ["Shael'dryn"] = { mapID = 63, x = 0.5354, y = 0.4622, location = "the moonwell east of Iris Lake, Ashenvale" },
        ["Hidden Shrine"] = { mapID = 63, x = 0.5600, y = 0.4900, location = "the hidden shrine southeast of Shael'dryn" },
        ["Krolg"] = { mapID = 63, x = 0.5084, y = 0.7508, location = "southeast of Mystral Lake, Ashenvale" },
        ["Ran Bloodtooth"] = { mapID = 63, x = 0.5200, y = 0.3800, location = "the furbolg camp near Mystral Lake, Ashenvale" },
    },

    npcDisplayIDs = {
        ["Raene Wolfrunner"] = 1980,
        ["Shael'dryn"] = 2721,
        ["Krolg"] = 1010,
        ["Ran Bloodtooth"] = 1012,
        -- Quest givers' models from the cmangos Classic database.
        ["Teronis' Corpse"] = 1983,
    },

    chapterDisplayIDs = {
        ["Teronis' Journal"] = 1980,
        ["Dartol's Rod"] = 2721,
        ["The Uncorrupted Furbolg"] = 1010,
    },

    chapterIcons = {
        ["Teronis' Journal"] = 133741,
        ["Dartol's Rod"] = 135139,
        ["The Uncorrupted Furbolg"] = 132183,
    },

    chapters = {
        {
            chapter = "Teronis' Journal",
            summary = "Raene Wolfrunner, in Astranaar, is worried about Teronis, who went west looking for a way to stop the furbolg attacks and hasn't come back. Raene would like Teronis found. Ashenvale is a big forest.",
            recap = "Raene Wolfrunner in Astranaar was worried about Teronis, who'd gone west looking for some way to stop the furbolg attacks and hadn't come back. Raene asked me to find Teronis. I did, out by Lake Falathim. The murlocs had found Teronis first.\n\nThere was a journal on the body, though, and a glowing gem still to be found. I found it, and brought both back to Astranaar.\n\nRaene read the journal and the job changed. Teronis had been onto something, a way to slow the attacks, and it wasn't finished. The next step was a moonwell to the northeast and someone there called Shael'dryn. So off I went. Errands from the dead are still errands.",
            quests = {
                { id = 991, name = "Raene's Cleansing", displayName = "Find Teronis", npc = "Raene Wolfrunner" },
                { id = 1023, name = "Raene's Cleansing", displayName = "Teronis' Journal", npc = "Teronis' Corpse" },
                { id = 1024, name = "Raene's Cleansing", displayName = "Find Shael'dryn", npc = "Raene Wolfrunner" },
            },
        },
        {
            chapter = "Dartol's Rod",
            summary = "Raene has read Teronis' journal, and it points to Shael'dryn, who keeps a moonwell east of Iris Lake. Shael'dryn knows what Teronis was after. Getting it will take you into some of Ashenvale's less pleasant corners.",
            recap = "Shael'dryn, at the moonwell, knew exactly what Teronis had been after: Dartol's Rod, broken into pieces and hidden around the worst corners of Ashenvale. So it was a scavenger hunt, with twisted treants up toward Felwood holding one of the pieces and not in a sharing mood.\n\nThe pommel was the low point. It was down in the Dor'danil barrow den, and I'll spare you exactly where I found it. I washed my hands for a week.\n\nOnce the rod was whole I took it to a hidden shrine to wake it up again, and still nobody had told me what the thing actually did. That came later. It involved fur.",
            quests = {
                { id = 1026, name = "Raene's Cleansing", displayName = "Iron Shaft", npc = "Shael'dryn" },
                { id = 1027, name = "Raene's Cleansing", displayName = "Iron Pommel", npc = "Shael'dryn" },
                { id = 1028, name = "Raene's Cleansing", displayName = "Hidden Shrine", npc = "Shael'dryn" },
                { id = 1055, name = "Raene's Cleansing", displayName = "Return to Shael'dryn", npc = "Hidden Shrine", location = "the hidden shrine, Ashenvale" },
                { id = 1029, name = "Raene's Cleansing", displayName = "Return to Raene", npc = "Shael'dryn" },
            },
        },
        {
            chapter = "The Uncorrupted Furbolg",
            summary = "Raene Wolfrunner, back in Astranaar, has a use for Dartol's Rod. A few of Ashenvale's furbolg still aren't corrupted, and Raene wants you to talk to one. The rod, apparently, will help with the introductions.",
            recap = "Here's what Dartol's Rod does: you use it, and you're a furbolg. Raene wanted me to find one of the few furbolg left uncorrupted, and apparently walking up in my own skin was not the way to start that conversation.\n\nKrolg was the one, southeast of Mystral Lake. Krolg had no love for the night elves and blamed them for what had happened to the furbolg. Didn't hide it, either. But Ran Bloodtooth's lot had gone bad, and Krolg wanted Ran dead.\n\nSo I obliged. Four of the Bloodtooth guards, then Ran, and Ran's skull came home with me.\n\nRaene got the skull and the rod back. I kept the memory of having fur. Not my look, honestly. And itchy.",
            quests = {
                { id = 1030, name = "Raene's Cleansing", displayName = "Find Krolg", npc = "Raene Wolfrunner" },
                { id = 1045, name = "Raene's Cleansing", displayName = "Ran Bloodtooth", npc = "Krolg" },
                { id = 1046, name = "Raene's Cleansing", displayName = "Return to Raene", npc = "Krolg" },
            },
        },
    },
}
