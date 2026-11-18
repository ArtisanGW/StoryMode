local addonName, SM = ...

-- =============================================================================
-- Classic: Hunt for Yenniku
-- Nimboya's search for the chief's son, from Bloodscalp trophies to Zanzil.
-- =============================================================================

SM.SavingYennikuData = {
    title = "Hunt for Yenniku",
    description = "At Grom'gol, Nimboya asks after Yenniku, youngest son of the Darkspear chief. The Bloodscalp trolls may know where he was taken, but Stranglethorn rarely gives up a captive cleanly.\n\nPress the jungle tribes for answers, listen when older spirits are called, and keep following the trail even when it turns toward magic no troll should take lightly.",
    zone = "Stranglethorn Vale",
    expansion = "Classic",
    recommendedLevel = { min = 30, max = 45 },
    faction = "Horde",
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.28, 0.58, 0.32 },
    icon = "Interface\\Icons\\INV_Misc_Head_Troll_01",
    portraitDisplayID = 4663,
    adventureCoverTexture = 131886, -- Zul'Gurub loading screen: closest Classic troll-jungle cover for Yenniku's story
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 581, name = "Hunt for Yenniku", npc = "Nimboya", location = "Grom'gol Base Camp, Stranglethorn Vale" },
    startMapID = 50,
    startX = 0.3220,
    startY = 0.2780,

    npcLocations = {
        ["Nimboya"] = { mapID = 50, x = 0.3220, y = 0.2780, location = "Grom'gol Base Camp, Stranglethorn Vale" },
        ["Bubbling Cauldron"] = { mapID = 50, x = 0.3220, y = 0.2770, location = "beside Kin'weelay at Grom'gol Base Camp" },
        ["Kin'weelay"] = { mapID = 50, x = 0.3220, y = 0.2770, location = "beside the Bubbling Cauldron at Grom'gol Base Camp" },
        ["Bloodscalp Trolls"] = { mapID = 50, x = 0.2450, y = 0.1150, location = "the Bloodscalp ruins north of Grom'gol" },
        ["Gan'zulah and Nezzliok"] = { mapID = 50, x = 0.2380, y = 0.0900, location = "deep inside the Bloodscalp ruins north of Grom'gol" },
        ["Gan'zulah"] = { mapID = 50, x = 0.2380, y = 0.0900, location = "deep inside the Bloodscalp ruins north of Grom'gol" },
        ["Nezzliok the Dire"] = { mapID = 50, x = 0.2380, y = 0.0900, location = "deep inside the Bloodscalp ruins north of Grom'gol" },
        ["Skullsplitter Trophies"] = { mapID = 50, x = 0.4600, y = 0.3800, location = "the Skullsplitter ruins in eastern Stranglethorn Vale" },
        ["Crystalvein Mine"] = { mapID = 50, x = 0.4100, y = 0.5000, location = "Crystalvein Mine, southeastern Stranglethorn Vale" },
        ["Mai'Zoth"] = { mapID = 50, x = 0.5200, y = 0.2700, location = "deep inside the Mosh'Ogg Ogre Mound" },
        ["Mosh'Ogg Ogre Mound"] = { mapID = 50, x = 0.5200, y = 0.2700, location = "Mosh'Ogg Ogre Mound, northern Stranglethorn Vale" },
        ["Yenniku"] = { mapID = 50, x = 0.3900, y = 0.5800, location = "the Ruins of Aboraz, along the Crystal Shore" },
    },

    npcDisplayIDs = {
        ["Nimboya"] = 4569,
        ["Kin'weelay"] = 4475,
        ["Gan'zulah"] = 4582,
        ["Nezzliok the Dire"] = 4584,
        ["Mai'Zoth"] = 11546,
        ["Yenniku"] = 4663,
    },

    chapterDisplayIDs = {
        ["Bloodscalp Trail"] = 4569,
        ["Heads in the Cauldron"] = 4584,
        ["The Mind's Eye"] = 4475,
        ["Zanzil's Hold"] = 4663,
    },

    chapterIcons = {
        ["Bloodscalp Trail"] = "Interface\\Icons\\INV_Misc_Head_Troll_01",
        ["Heads in the Cauldron"] = "Interface\\Icons\\INV_Misc_Bowl_01",
        ["The Mind's Eye"] = "Interface\\Icons\\INV_Misc_Gem_Pearl_05",
        ["Zanzil's Hold"] = "Interface\\Icons\\Spell_Shadow_SoulGem",
    },

    chapters = {
        {
            chapter = "Bloodscalp Trail",
            summary = "Yenniku, youngest son of the Darkspear chief, has been taken somewhere in Stranglethorn. Nimboya at Grom'gol Base Camp is searching for him, and the Bloodscalp trolls in the ruins north of camp are the only trail there is.",
            recap = "Nimboya had the kind of problem nobody at Grom'gol wanted to say out loud. The Darkspear chief's youngest son, Yenniku, was gone, and the Bloodscalps were the only trail anyone had.\n\nThe Bloodscalps don't take questions, so I started by collecting. Shrunken heads, twenty of them, so Nimboya could go through every one and make sure none of them was Yenniku. That's a job you remember. None of them was.\n\nOnly the Bloodscalp leaders knew more, and they weren't sharing. Nimboya had an answer for that as well. I brought back both their heads and dropped them in the cauldron at camp.\n\nTurns out a Bloodscalp gets a lot chattier once you've parted the talking end from the rest.",
            quests = {
                { id = 581, name = "Hunt for Yenniku", npc = "Nimboya" },
                { id = 582, name = "Headhunting", npc = "Nimboya" },
                { id = 584, name = "Bloodscalp Clan Heads", npc = "Nimboya" },
            },
        },
        {
            chapter = "Heads in the Cauldron",
            summary = "The heads of the two Bloodscalp leaders sit in the cauldron at Grom'gol, and death hasn't stopped them talking. It hasn't made them generous either. Before they say a word about Yenniku, they want paying.",
            recap = "Here's something nobody tells you about talking heads. They haggle.\n\nNezzliok's head spoke up from the cauldron first and wanted trophies out of the Skullsplitter ruins, one from each. Gan'zulah's wanted Skullsplitters, dead, by the dozen, and somebody's broken armor on top. Being dead hadn't made either of them any less Bloodscalp. If anything, it had given them time to think about what they wanted.\n\nI paid both bills. Only then did they tell me what they knew. The chief's son hadn't died with the Bloodscalps at all. Zanzil the Outcast had him.\n\nI've bargained with goblins in my time. The goblins were easier.",
            prerequisites = {
                { id = 584, name = "Bloodscalp Clan Heads", npc = "Nimboya" },
            },
            quests = {
                { id = 585, name = "Speaking with Nezzliok", npc = "Bubbling Cauldron" },
                { id = 586, name = "Speaking with Gan'zulah", npc = "Bubbling Cauldron", parallel = true },
            },
        },
        {
            chapter = "The Mind's Eye",
            summary = "Nezzliok's head has one last thing to say about the fate of Yenniku. After that it's over to Kin'weelay, who stands beside the cauldron at Grom'gol and doesn't seem the least bit bothered by talking heads.",
            recap = "Nezzliok had one more thing to say, and it wasn't cheerful. Zanzil didn't just have the chief's son. Zanzil had him body and soul, and you can't cut a soul loose with a blade. Believe me, that was my first idea.\n\nKin'weelay, who'd stood beside that cauldron the whole time as if talking heads were nothing new, knew an old Stranglethorn legend about something called the Mind's Eye. The Eye was in the Mosh'Ogg Ogre Mound, with an ogre sitting on it who didn't want to share. I made my case. Kin'weelay took the Eye and a few singing crystals I'd dug out of Crystalvein Mine and worked the lot into a Soul Gem.\n\nPretty thing. Not the sort you'd wear.",
            prerequisites = {
                { id = 585, name = "Speaking with Nezzliok", npc = "Bubbling Cauldron" },
                { id = 586, name = "Speaking with Gan'zulah", npc = "Bubbling Cauldron" },
            },
            quests = {
                { id = 588, name = "The Fate of Yenniku", npc = "Bubbling Cauldron" },
                { id = 589, name = "The Singing Crystals", npc = "Kin'weelay" },
                { id = 591, name = "The Mind's Eye", npc = "Kin'weelay" },
            },
        },
        {
            chapter = "Zanzil's Hold",
            summary = "Kin'weelay's Soul Gem is ready, and it's no good to anyone sitting in your pack. Yenniku is somewhere out in the jungle, in Zanzil's hold. Nimboya waits at Grom'gol for whatever you bring back.",
            recap = "I had the Soul Gem and a very short plan. Find Yenniku. Use the gem. Bring it back full.\n\nHe was down at the Ruins of Aboraz, by the Crystal Shore, with Zanzil's people all around him. The chief's son, standing in the jungle with somebody else's will where his own should be. Not easy to look at. I got close enough, I used the gem, and whatever Zanzil had wrapped around his soul let go. The soul went into the stone.\n\nI carried that gem back to Grom'gol the way you'd carry a full cup through a crowded tavern. Nimboya took it, and for once there was no next errand. Just a promise: the Darkspear would remember who brought their chief's son home.\n\nI've been paid in gold plenty of times. That was better.",
            prerequisites = {
                { id = 591, name = "The Mind's Eye", npc = "Kin'weelay" },
            },
            quests = {
                { id = 592, name = "Saving Yenniku", npc = "Kin'weelay" },
            },
        },
    },
}
