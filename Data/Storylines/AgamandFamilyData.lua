local addonName, SM = ...

-- =============================================================================
-- Classic: The Agamand Family
-- A short Forsaken story at the Agamand Mills outside Brill.
-- =============================================================================

SM.AgamandFamilyData = {
    title = "The Agamand Family",
    description = "North of Brill, the Agamand Mills still carry the family name. Coleman Farthing wants proof of what happened there, Deathguard Dillinger wants the dead cleared out, and Magistrate Sevren has heard enough about the family crypt to be concerned.\n\nSearch the old estate, bring back what the Forsaken ask for, and see why Tirisfal's dead rarely stay where they are put.",
    zone = "Tirisfal Glades",
    expansion = "Classic",
    recommendedLevel = { min = 4, max = 13 },
    faction = "Horde",
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.46, 0.56, 0.44 },
    icon = 136123,
    portraitDisplayID = 3516,
    adventureCoverTexture = 131829, -- Cave loading screen
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 404, name = "A Putrid Task", npc = "Deathguard Dillinger", location = "Brill, Tirisfal Glades" },
    startMapID = 18,
    startX = 0.5820,
    startY = 0.5145,

    npcLocations = {
        ["Deathguard Dillinger"] = { mapID = 18, x = 0.5820, y = 0.5145, location = "Brill, Tirisfal Glades" },
        ["Coleman Farthing"] = { mapID = 18, x = 0.6172, y = 0.5229, location = "Gallows' End Tavern, Brill" },
        ["Magistrate Sevren"] = { mapID = 18, x = 0.6126, y = 0.5084, location = "Brill, Tirisfal Glades" },
        ["Yvette Farthing"] = { mapID = 18, x = 0.6130, y = 0.5270, location = "Gallows' End Tavern, Brill" },
        ["Devlin Agamand"] = { mapID = 18, x = 0.4734, y = 0.4078, location = "Agamand Mills, Tirisfal Glades" },
        ["Gregor Agamand"] = { mapID = 18, x = 0.4674, y = 0.2931, location = "Agamand Mills, Tirisfal Glades" },
        ["Nissa Agamand"] = { mapID = 18, x = 0.4974, y = 0.3634, location = "Agamand Mills, Tirisfal Glades" },
        ["Thurman Agamand"] = { mapID = 18, x = 0.4400, y = 0.3364, location = "Agamand Mills, Tirisfal Glades" },
        ["Captain Dargol"] = { mapID = 18, x = 0.5281, y = 0.2635, location = "the Agamand Family Crypt, Tirisfal Glades" },
    },

    npcDisplayIDs = {
        ["Deathguard Dillinger"] = 2855,
        ["Coleman Farthing"] = 3516,
        ["Magistrate Sevren"] = 3514,
        ["Yvette Farthing"] = 3517,
        ["Devlin Agamand"] = 11399,
        ["Gregor Agamand"] = 646,
        ["Nissa Agamand"] = 10702,
        ["Thurman Agamand"] = 1196,
        ["Captain Dargol"] = 733,
    },

    chapterDisplayIDs = {
        ["The Haunted Mills"] = 3516,
        ["The Family Crypt"] = 3514,
    },

    chapterIcons = {
        ["The Haunted Mills"] = 136123,
        ["The Family Crypt"] = 136129,
    },

    chapters = {
        {
            chapter = "The Haunted Mills",
            summary = "The Scourge are trying to dig in at the Agamand Mills, northwest of Brill, and Deathguard Dillinger wants them beaten back. Coleman Farthing, at the Gallows' End Tavern, once worked those mills and has his own business with the family that owned them.",
            recap = "The Agamands owned the mills north of Brill, back when they were alive. They're still there. They just don't run the place anymore.\n\nThe deathguard wanted the grounds cleared, and Coleman Farthing wanted something more personal: the family. Devlin Agamand haunts those mills, and Coleman wanted Devlin's remains, and then the remains of the rest of them, one after another. The whole family, one sack at a time.\n\nSomewhere in the middle of it I came across a letter one of the Agamands had written and never got round to delivering. So I delivered it. Late, admittedly. The post in Tirisfal has never been quick.\n\nColeman had wanted proof of what became of the Agamands. I brought back most of the Agamands. That seemed to settle the question.",
            quests = {
                { id = 404, name = "A Putrid Task", npc = "Deathguard Dillinger" },
                { id = 426, name = "The Mills Overrun", npc = "Deathguard Dillinger" },
                { id = 362, name = "The Haunted Mills", npc = "Coleman Farthing" },
                { id = 354, name = "Deaths in the Family", npc = "Coleman Farthing" },
                { id = 361, name = "A Letter Undelivered", npc = "Yvette Farthing", optional = true },
            },
        },
        {
            chapter = "The Family Crypt",
            summary = "Coleman Farthing has had his revenge on the Agamands, but says the mills still threaten every Forsaken in Tirisfal. Magistrate Sevren in Brill has heard about your work out there and wants a word.",
            recap = "Coleman sent me on to Magistrate Sevren, and Sevren had heard things about the crypt under the mills. Turns out the Agamands I'd already met weren't the only Agamands. There were older ones down in the dark, generations of them, and not one of them was resting.\n\nSo down I went. Wailing ancestors and rotting ancestors, and the wailing ones are worse. Take my word for it. A rotting ancestor goes down easily enough, but a wailing one stays in your ears for days.\n\nAt the back of it all was Captain Dargol. I brought the captain's skull back to Sevren, and that was the end of the Agamand family's trouble, as far as Brill was concerned. One grave at a time, every one of them left quieter than I found it.",
            quests = {
                { id = 355, name = "Speak with Sevren", npc = "Coleman Farthing" },
                { id = 408, name = "The Family Crypt", npc = "Magistrate Sevren" },
            },
        },
    },
}
