local addonName, SM = ...

-- =============================================================================
-- Classic: The Missing Courier
-- Feathermoon's lost courier, a wrecked boat, and the first signs of silithid.
-- =============================================================================

SM.MissingCourierData = {
    title = "The Missing Courier",
    description = "Feathermoon Stronghold expected a courier from Thalanaar. He never arrived, and the coast of Feralas has a way of swallowing small boats and easy answers.\n\nSearch the wreckage, carry back what proof you can, and follow the signs inland if the sea is not the whole story.",
    zone = "Feralas / Darnassus",
    expansion = "Classic",
    recommendedLevel = { min = 43, max = 46 },
    faction = "Alliance",
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.30, 0.48, 0.70 },
    icon = 134328,
    portraitDisplayID = 2035,
    adventureCoverTexture = 131878, -- Blackfathom Deeps: night elf coastal ruin mood closest to Feathermoon's investigation
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 4124, name = "The Missing Courier", npc = "Latronicus Moonspear", location = "Feathermoon Stronghold, Feralas" },
    startMapID = 69,
    startX = 0.3050,
    startY = 0.4620,

    npcLocations = {
        ["Latronicus Moonspear"] = { mapID = 69, x = 0.3050, y = 0.4620, location = "Feathermoon Stronghold, Feralas" },
        ["Ginro Hearthkindle"] = { mapID = 69, x = 0.3200, y = 0.4500, location = "upstairs in Feathermoon Stronghold, Feralas" },
        ["Wrecked Row Boat"] = { mapID = 69, x = 0.4564, y = 0.6500, location = "the Forgotten Coast, Feralas" },
        ["Quintis Jonespyre"] = { mapID = 69, x = 0.3200, y = 0.4400, location = "the upper treehouse, Feathermoon Stronghold" },
        ["Large Leather Backpacks"] = { mapID = 69, x = 0.7300, y = 0.5600, location = "a Woodpaw gnoll camp in southern Feralas" },
        ["Undelivered Parcel"] = { mapID = 69, x = 0.7300, y = 0.5600, location = "inside the Large Leather Backpacks, southern Feralas" },
        ["Zukk'ash Pod"] = { mapID = 69, x = 0.7200, y = 0.6400, location = "inside the Writhing Deep, southern Feralas" },
        ["Falfindel Waywarder"] = { mapID = 69, x = 0.8900, y = 0.4600, location = "Thalanaar, southeastern Feralas" },
        ["Shandris Feathermoon"] = { mapID = 69, x = 0.3050, y = 0.4620, location = "Feathermoon Stronghold, Feralas" },
        ["Gracina Spiritmight"] = { mapID = 89, x = 0.4100, y = 0.8500, location = "the Temple of the Moon, Darnassus" },
    },

    npcDisplayIDs = {
        ["Latronicus Moonspear"] = 2035,
        ["Ginro Hearthkindle"] = 6789,
        ["Quintis Jonespyre"] = 7232,
        ["Falfindel Waywarder"] = 6978,
        ["Shandris Feathermoon"] = 2035,
        ["Gracina Spiritmight"] = 3796,
    },

    chapterDisplayIDs = {
        ["Wreckage"] = 6789,
        ["The Knife"] = 7232,
        ["The Courier's Trail"] = 6789,
        ["The Writhing Deep"] = 2035,
    },

    chapterIcons = {
        ["Wreckage"] = 134327,
        ["The Knife"] = 135650,
        ["The Courier's Trail"] = 133639,
        ["The Writhing Deep"] = 136045,
    },

    chapters = {
        {
            chapter = "Wreckage",
            summary = "Feathermoon Stronghold is missing a courier. Raschal set out from Thalanaar and never arrived. Latronicus Moonspear has already marked him missing in action, but upstairs in the stronghold, Ginro Hearthkindle hasn't given up.",
            recap = "Feathermoon was missing a courier. Raschal, coming from Thalanaar. Latronicus Moonspear had already written him down as missing in action, and once Feathermoon writes you down, you tend to stay written.\n\nGinro Hearthkindle hadn't given up. Ginro had spent a week combing Feralas and come back with nothing but gnoll teeth. So I took a turn along the Forgotten Coast and found the boat. A row boat with the Feathermoon crest on it, torn almost in two.\n\nNo Raschal. No body, either, which was something. Just a knife, lying in the mud by the wreck.\n\nI brought it back to Ginro. A knife can't tell you much, I thought. I was wrong about that, but that's the next part.",
            quests = {
                { id = 4124, name = "The Missing Courier", displayName = "Ginro Hearthkindle", npc = "Latronicus Moonspear" },
                { id = 4125, name = "The Missing Courier", displayName = "Wrecked Row Boat", npc = "Ginro Hearthkindle" },
                { id = 4127, name = "Boat Wreckage", npc = "Wrecked Row Boat" },
            },
        },
        {
            chapter = "The Knife",
            summary = "All the wreck gave up was a knife, and Ginro Hearthkindle thinks it can still tell you something. Take it to Quintis Jonespyre, up in Feathermoon's treehouse, who can read where a thing has been.",
            recap = "Ginro's next idea was a new one on me. Take the knife to Quintis Jonespyre, who can hold a thing and read where it's been.\n\nSo Quintis held the knife and told me what it remembered. Raschal, hauling two big leather backpacks inland. Raschal, fretting about Woodpaw gnolls the whole way. And Raschal, not noticing the water elementals forming up behind him.\n\nThat last part was not encouraging.\n\nHandy trick, psychometry. I'd hate to have it at a dinner party, though. Imagine picking up somebody's fork. Still, it beat a week of turning over rocks, and now we knew where to look: inland, toward the gnolls, after a courier who'd had a worse day than anyone had guessed.",
            quests = {
                { id = 4129, name = "The Knife Revealed", npc = "Ginro Hearthkindle" },
                { id = 4130, name = "Psychometric Reading", npc = "Quintis Jonespyre" },
            },
        },
        {
            chapter = "The Courier's Trail",
            summary = "The knife points inland, to the Woodpaw gnolls of southern Feralas. Ginro Hearthkindle wants their camps searched for Raschal's belongings, or for Raschal. Gnolls are not known for returning lost property.",
            recap = "The Woodpaw camps are about what you'd expect. Gnolls, bones, a smell you take home with you. I went through them looking for anything of Raschal's and found both his packs, pinned to a tree like a trophy, Feathermoon insignia and all.\n\nThe other thing in the packs was a note, and the note changed the whole picture. Raschal had seen strange insect creatures south of the gnoll camps, and gone to have a look.\n\nNot lost, then. Not dragged off by gnolls, either. Our courier had gone looking for trouble on purpose. I liked him already.",
            quests = {
                { id = 4131, name = "The Woodpaw Gnolls", npc = "Ginro Hearthkindle" },
                { id = 4281, name = "Thalanaar Delivery", npc = "Undelivered Parcel", optional = true, recapAfter = 1, recap = "Inside was a parcel he'd never delivered, meant for Falfindel Waywarder in Thalanaar. I took it there myself. A courier's job ought to get finished, even if the courier can't finish it." },
            },
        },
        {
            chapter = "The Writhing Deep",
            summary = "Raschal's note points south of the Woodpaw camps, to a place called the Writhing Deep. Whatever he went to look at down there, he hasn't come back from it. Go and find him, or what's left of him.",
            recap = "South of the gnolls there's a hole in the ground called the Writhing Deep, and it's full of Zukk'ash. Insects, big ones, all legs and mandibles. Somewhere in there was Raschal, or what was left of him.\n\nWhat was left of him turned out to be all of him, sealed up in a pod. I got him out, and he had a report to make.\n\nBack at Feathermoon, Shandris Feathermoon read that report and sent me straight to Darnassus with it, where somebody finally put a name to what was under Feralas.\n\nSilithid.\n\nI went out looking for one lost courier and came back with a warning for all of Kalimdor. Not bad for a knife in the mud.",
            quests = {
                { id = 4135, name = "The Writhing Deep", npc = "Large Leather Backpacks" },
                { id = 4265, name = "Freed from the Hive", npc = "Zukk'ash Pod" },
                { id = 4266, name = "A Hero's Welcome", npc = "Ginro Hearthkindle" },
                { id = 4267, name = "Rise of the Silithid", npc = "Shandris Feathermoon" },
            },
        },
    },
}
