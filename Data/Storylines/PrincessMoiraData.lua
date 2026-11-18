local addonName, SM = ...

-- =============================================================================
-- Classic: Princess Moira
-- Ironforge, Thrall, and the succession crisis hidden in Blackrock Depths.
-- =============================================================================

SM.PrincessMoiraData = {
    title = "The Princess of Ironforge",
    description = "In Blackrock Depths, rumors about Princess Moira Bronzebeard have become too serious for Ironforge to ignore. The Dark Irons say one thing, the kingdom fears another, and no one outside the mountain has the full truth.\n\nEnter the depths on your faction's orders and find out what became of the princess. Rescue may not be as simple as it sounds.",
    zone = "Blackrock Depths / Ironforge / Orgrimmar",
    expansion = "Classic",
    recommendedLevel = { min = 48, max = 60 },
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.76, 0.48, 0.28 },
    icon = 133416,
    portraitDisplayID = 8705,
    adventureGuideInstanceName = "Blackrock Depths",
    adventureCoverTexture = 131824,
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 3702, name = "The Smoldering Ruins of Thaurissan", npc = "Royal Historian Archesonus", location = "Ironforge", faction = "Alliance" },
    startMapID = 87,
    startX = 0.3900,
    startY = 0.5600,

    npcLocations = {
        ["King Magni Bronzebeard"] = { mapID = 87, x = 0.3900, y = 0.5600, location = "the High Seat, Ironforge" },
        ["Royal Historian Archesonus"] = { mapID = 87, x = 0.3800, y = 0.5500, location = "the High Seat, Ironforge" },
        ["Kharan Mighthammer"] = { mapID = 242, x = 0.4552, y = 0.8656, location = "the Detention Block, Blackrock Depths" },
        ["Princess Moira Bronzebeard"] = { mapID = 242, x = 0.7657, y = 0.0923, location = "the Imperial Seat, Blackrock Depths" },
        ["Galamav the Marksman"] = { mapID = 15, x = 0.0500, y = 0.4700, location = "Kargath, Badlands" },
        ["Commander Gor'shak"] = { mapID = 242, x = 0.4392, y = 0.9023, location = "the Detention Block, Blackrock Depths" },
        ["Thrall"] = { mapID = 85, x = 0.3200, y = 0.3800, location = "Grommash Hold, Orgrimmar" },
    },

    npcDisplayIDs = {
        ["King Magni Bronzebeard"] = 3597,
        ["Royal Historian Archesonus"] = 8171,
        ["Kharan Mighthammer"] = 8708,
        ["Princess Moira Bronzebeard"] = 8705,
        ["Galamav the Marksman"] = 8334,
        ["Commander Gor'shak"] = 8703,
        ["Thrall"] = 61727,
    },

    chapterDisplayIDs = {
        ["Kharan's Tale"] = 8708,
        ["The Royal Rescue"] = 8705,
        ["The Warchief's Rescue"] = 4527,
    },

    chapterIcons = {
        ["Kharan's Tale"] = 133739,
        ["The Royal Rescue"] = 133416,
        ["The Warchief's Rescue"] = 132349,
    },

    chapters = {
        {
            chapter = "Kharan's Tale",
            faction = "Alliance",
            summary = "Royal Historian Archesonus, by the High Seat in Ironforge, has a long history of the Dark Iron dwarves to tell. Hear it out. King Magni has questions about his daughter, Moira, and the answers lie in Blackrock Depths.",
            recap = "If you want to understand Princess Moira, the Royal Historian in Ironforge will explain, and it takes a while. The Dark Irons, the War of the Three Hammers, and how the Burning Steppes came to be burning. Then, so I'd really understand, I was sent out to the Ruins of Thaurissan to read the old relics myself. History lessons, in the hottest classroom in the Eastern Kingdoms.\n\nThat was the warm-up. King Magni wanted me to find Kharan Mighthammer, a prisoner deep in Blackrock Depths. Kharan had a tale about Moira. I listened. It was not the tale Magni wanted.\n\nThen I had to go back to Ironforge and tell him. Here's some free advice. If you're ever handed bad news for a king about his daughter, see if anyone else is going that way.",
            quests = {
                { id = 3702, name = "The Smoldering Ruins of Thaurissan", npc = "Royal Historian Archesonus" },
                { id = 3701, name = "The Smoldering Ruins of Thaurissan", displayName = "Burning Steppes", npc = "Royal Historian Archesonus" },
                { id = 4341, name = "Kharan Mighthammer", npc = "King Magni Bronzebeard" },
                { id = 4342, name = "Kharan's Tale", npc = "Kharan Mighthammer" },
                { id = 4361, name = "The Bearer of Bad News", npc = "Kharan Mighthammer" },
            },
        },
        {
            chapter = "The Royal Rescue",
            faction = "Alliance",
            summary = "King Magni has heard enough. His orders from the High Seat are plain: back into Blackrock Depths, through the Dark Iron city to Emperor Dagran Thaurissan, and bring Princess Moira home.",
            recap = "Magni's orders were plain. Back into Blackrock Depths, kill Emperor Dagran Thaurissan, and bring Moira home.\n\nBlackrock Depths is a city, not a cellar, and the emperor sits at the far end of it. We got there. We did the first part. The emperor went down, and I turned around to rescue the princess.\n\nThe princess did not want rescuing. She'd married him, and she was mourning her husband. She also had news. She was carrying his child, and that child would be heir to Ironforge.\n\nThat news went back to her father by way of me. Of every report I've ever made, that's the one where I most wished I'd taken the long road. Magni wanted his daughter back. What he got was a grandchild, and a problem nobody could kill.",
            quests = {
                { id = 4362, name = "The Fate of the Kingdom", npc = "King Magni Bronzebeard" },
                { id = 4363, name = "The Princess's Surprise", npc = "Princess Moira Bronzebeard" },
            },
        },
        {
            chapter = "The Warchief's Rescue",
            faction = "Horde",
            summary = "Galamav the Marksman in Kargath shows you a crude drawing of an orc, bars scrawled across the face. The orc is Commander Gor'shak, and the bars suggest a prison. Blackrock Depths has a big one.",
            recap = "I was shown a drawing of an orc. Crude, with bars scribbled over the face. That was the whole clue. So I went looking for a prison, and Blackrock Depths has a big one, and in it was Commander Gor'shak.\n\nThe Dark Irons didn't care for us talking, and halfway through they came at us in waves. I made sure the commander lived to finish the story. Another prisoner nearby had the real news: Princess Moira Bronzebeard, kidnapped by the Dark Irons.\n\nThrall heard me out and sent me back in to kill the emperor and free the princess from his spell.\n\nI did the killing. The princess did not look like anyone under a spell. She looked like a widow, carrying the emperor's child, an heir with a claim on Ironforge. I took that back to Orgrimmar and watched the Warchief do some very careful thinking.",
            quests = {
                { id = 3981, name = "Commander Gor'shak", npc = "Galamav the Marksman" },
                { id = 3982, name = "What Is Going On?", npc = "Commander Gor'shak" },
                { id = 4001, name = "What Is Going On?", npc = "Commander Gor'shak" },
                { id = 4002, name = "The Eastern Kingdoms", npc = "Thrall" },
                { id = 4003, name = "The Royal Rescue", npc = "Thrall" },
                { id = 4004, name = "The Princess Saved?", npc = "Princess Moira Bronzebeard" },
            },
        },
    },
}
