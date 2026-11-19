local addonName, SM = ...

-- =============================================================================
-- Classic: Thunderfury, Blessed Blade of the Windseeker
-- The Bindings from Garr and Baron Geddon, Highlord Demitrian in Silithus,
-- Ragnaros' essence and the summoning of Prince Thunderaan.
-- Only warriors, paladins, hunters and rogues can carry the Bindings, so each
-- quest names those classes.
-- =============================================================================

SM.ThunderfuryData = {
    title = "Thunderfury",
    description = "Deep in Molten Core, Garr and Baron Geddon each keep half of a relic called the Bindings of the Windseeker. They give them up rarely, and only after a great many evenings of asking.\n\nCarry a half to Silithus and see where it leads. Legends are made at the end of roads like this one, provided you bring patience, a great deal of arcanite, and thirty-nine friends.",
    zone = "Molten Core / Silithus",
    expansion = "Classic",
    recommendedLevel = { min = 60, max = 60 },
    -- Hidden on WoW Forever until Molten Core opens: its first raids are Barrow
    -- Deeps, Hyjal Summit and Onyxia's Lair, and the Bindings drop in Molten Core.
    gameVersions = { classicEra = true, tbc = true, forever = false },
    achievements = {},
    color = { 0.38, 0.66, 0.96 },
    icon = 135349,
    portraitDisplayID = 14992,
    adventureGuideInstanceName = "Molten Core",
    adventureCoverTexture = 131851, -- Molten Core loading screen
    adventureCoverIsLoadingScreen = true,

    -- Demitrian hands over the Vessel of Rebirth, which starts the quest, to
    -- anyone holding either half of the Bindings.
    startQuest = { id = 7785, name = "Examine the Vessel", npc = "Highlord Demitrian", location = "the Ravaged Twilight Camp, Silithus" },
    startMapID = 81,
    startX = 0.2160,
    startY = 0.0840,

    npcLocations = {
        ["Highlord Demitrian"] = { mapID = 81, x = 0.2160, y = 0.0840, location = "the Ravaged Twilight Camp, Silithus" },
        ["Prince Thunderaan"] = { mapID = 81, x = 0.2340, y = 0.1100, location = "the Ravaged Twilight Camp, Silithus" },
    },

    npcDisplayIDs = {
        ["Garr"] = 12110,
        ["Baron Geddon"] = 12129,
        ["Ragnaros"] = 11121,
        -- Quest givers' models from the cmangos Classic database.
        ["Highlord Demitrian"] = 14395,
        ["Prince Thunderaan"] = 14992,
    },

    chapterDisplayIDs = {
        ["The Bindings of the Windseeker"] = 12129,
        ["Thunderaan the Windseeker"] = 11121,
        ["Rise, Thunderfury!"] = 14992,
    },

    chapterIcons = {
        ["The Bindings of the Windseeker"] = 135988,
        ["Thunderaan the Windseeker"] = 135826,
        ["Rise, Thunderfury!"] = 135349,
    },

    chapters = {
        {
            chapter = "The Bindings of the Windseeker",
            summary = "Deep in Molten Core, Garr and Baron Geddon each carry half of the Bindings of the Windseeker, and neither gives it up often. Win either half, then take it to Highlord Demitrian at the Ravaged Twilight Camp in northwestern Silithus.",
            recap = "Garr and Baron Geddon live down in Molten Core, and each of them carries half of the Bindings of the Windseeker. They carry them the way a miser carries his coin: rarely seen, never offered. We killed the pair of them week after week. I won't say how many weeks. Some of the people who were there still won't talk about it.\n\nThen one night a half dropped, and it was mine.\n\nIt led me to Silithus, to a ruined Twilight camp and a man called Highlord Demitrian, who took one look at it and fell to his knees. My Master's eternal prison, he said. He must be released. He gave me a vessel to examine, I examined it, and he asked the Master to bless my efforts.\n\nI noticed the word Master. I decided to worry about it later.",
            quests = {
                { id = 7785, name = "Examine the Vessel", npc = "Highlord Demitrian", class = { "WARRIOR", "PALADIN", "HUNTER", "ROGUE" } },
            },
        },
        {
            chapter = "Thunderaan the Windseeker",
            summary = "Highlord Demitrian, in his ruined camp in Silithus, knows how to free the Windseeker from his prison. It takes both halves of the Bindings, ten bars of elementium, and the Essence of the Firelord, which only Ragnaros can give up.",
            recap = "Demitrian's list was short. Both halves of the Bindings. Ten bars of elementium to fortify his vessel. And the Essence of the Firelord, which you only get by destroying Ragnaros' body at the bottom of Molten Core.\n\nThe second half of the Bindings took its own sweet time, same as the first. Ragnaros took some persuading. The elementium took everything else. Every bar wants ten bars of arcanite and a fiery core besides, so a hundred bars of arcanite went into a sword I hadn't even seen yet. I stopped counting the gold. The banker didn't.\n\nWhen I finally laid it all out, Demitrian didn't thank me. He called on his Master to rise and break his bonds, and told me to behold him who is older than existence.\n\nSo I beheld. He was free, and he was not in a grateful mood.",
            quests = {
                { id = 7786, name = "Thunderaan the Windseeker", npc = "Highlord Demitrian", class = { "WARRIOR", "PALADIN", "HUNTER", "ROGUE" }, instance = "raid" },
            },
        },
        {
            chapter = "Rise, Thunderfury!",
            summary = "The Dormant Wind Kissed Blade is in your hands, and it sleeps. Highlord Demitrian, at the Ravaged Twilight Camp in Silithus, has the craft to wake it. Go and ask him. Firmly.",
            recap = "For someone who'd spent ages in a prison that had been riding around in my bags, Prince Thunderaan came out swinging. It took forty of us to put him down. When he went, he left a sword behind, dormant, with the wind still moving in it.\n\nDemitrian was a different man by then. He cowered. He begged me to spare him and hand over the blade, and he'd wake it with the very materials I'd brought for his Master's return. Then I could leave him to reshape his pathetic life. His words. I didn't argue with any of them.\n\nSo he made it. Thunderfury, Blessed Blade of the Windseeker. It takes longer to say than to swing, and far longer to get than either.\n\nNow and then someone in a tavern asks, did someone say Thunderfury? Someone did. It was me.",
            quests = {
                { id = 7787, name = "Rise, Thunderfury!", npc = "Prince Thunderaan", class = { "WARRIOR", "PALADIN", "HUNTER", "ROGUE" } },
            },
        },
    },
}
