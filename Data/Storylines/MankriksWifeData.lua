local addonName, SM = ...

-- =============================================================================
-- Classic: Mankrik's Wife
-- A short Barrens story with one of Classic's most remembered quest texts.
-- =============================================================================

SM.MankriksWifeData = {
    title = "Lost in Battle",
    description = "At the Crossroads, Mankrik is looking for his wife. He last saw her on the Gold Road, and the Barrens offers little comfort to anyone searching through quillboar territory.\n\nTake his question with you into the heat and dust. What you find, if you find anything, belongs first to the husband still waiting.",
    zone = "The Barrens",
    expansion = "Classic",
    recommendedLevel = { min = 14, max = 20 },
    faction = "Horde",
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.72, 0.52, 0.24 },
    icon = 133469,
    portraitDisplayID = 3855,
    adventureCoverTexture = 131882, -- Wailing Caverns: closest Classic loading screen rooted in The Barrens
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 4921, name = "Lost in Battle", npc = "Mankrik", location = "the Crossroads, The Barrens" },
    startMapID = 10,
    startX = 0.5520,
    startY = 0.4100,

    npcLocations = {
        ["Mankrik"] = { mapID = 10, x = 0.5195, y = 0.3158, location = "the Crossroads, The Barrens" },
    },

    npcDisplayIDs = {
        ["Mankrik"] = 3855,
    },

    chapterDisplayIDs = {
        ["Lost in Battle"] = 3855,
    },

    chapterIcons = {
        ["Lost in Battle"] = 133469,
    },

    chapters = {
        {
            chapter = "Lost in Battle",
            summary = "Quillboar fell on Mankrik and his wife at a small tauren camp, and the fighting split them up. Mankrik woke on the Gold Road with a tauren druid tending his wounds. Now he waits at the Crossroads, asking for any sign of her.",
            recap = "Mankrik waits at the Crossroads. A big orc, built for a fight, and he'd lost one: quillboar hit him on the Gold Road, and his wife didn't come back from it. He asked me to find her. That was the whole of it. Find her.\n\nThe Barrens is a great deal of nothing in every direction, and I walked a lot of it. South of the Crossroads, I found her. Too late, by a long way.\n\nI went back and told him. You don't dress that kind of thing up.\n\nThen he asked for tusks. Bristleback tusks, sixty of them. I didn't argue the number. Grief keeps its own count, and Mankrik's came to sixty.\n\nHer name was Olgra. Somebody ought to say it.",
            quests = {
                { id = 4921, name = "Lost in Battle", npc = "Mankrik" },
                { id = 95774, name = "Her Name Is Olgra", npc = "Mankrik", gameVersions = { forever = true } },
                { id = 899, name = "Consumed by Hatred", npc = "Mankrik" },
            },
        },
    },
}
