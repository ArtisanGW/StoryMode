local addonName, SM = ...

-- =============================================================================
-- Classic: Hogger
-- A short Alliance Elwynn story around Classic's earliest infamous elite.
-- =============================================================================

SM.HoggerData = {
    id = "hogger",  -- from its earlier title, "Hogger": saved progress and share links use it
    title = "Wanted: Hogger",
    description = "Marshal Dughan has posted a bounty at Westbrook Garrison. A Riverpaw brute named Hogger is prowling the woods, and Stormwind wants proof that the roads are safer.\n\nTake the warrant, follow the ridge southwest, and see why the locals speak his name with more concern than a single gnoll should earn.",
    zone = "Elwynn Forest",
    expansion = "Classic",
    recommendedLevel = { min = 5, max = 11 },
    faction = "Alliance",
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.78, 0.55, 0.28 },
    icon = "Interface\\Icons\\INV_Misc_MonsterClaw_04",
    portraitDisplayID = 384,
    adventureCoverTexture = 131838, -- Dungeon: darker Classic loading screen for Hogger's lair mood
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 176, name = "Wanted: \"Hogger\"", npc = "Wanted Poster", location = "Westbrook Garrison, Elwynn Forest" },
    startMapID = 37,
    startX = 0.2470,
    startY = 0.7900,

    npcLocations = {
        ["Wanted Poster"] = { mapID = 37, x = 0.2470, y = 0.7900, location = "Westbrook Garrison, Elwynn Forest" },
        ["Hogger"] = { mapID = 37, x = 0.2590, y = 0.8840, location = "Forest's Edge, Elwynn Forest" },
        ["Marshal Dughan"] = { mapID = 37, x = 0.4210, y = 0.6590, location = "Goldshire, Elwynn Forest" },
    },

    npcDisplayIDs = {
        ["Hogger"] = 384,
        ["Marshal Dughan"] = 1985,
    },

    chapterDisplayIDs = {
        ["The Scourge of Elwynn"] = 384,
    },

    chapterIcons = {
        ["The Scourge of Elwynn"] = "Interface\\Icons\\INV_Misc_MonsterClaw_04",
    },

    chapters = {
        {
            chapter = "The Scourge of Elwynn",
            summary = "There's a wanted poster outside Westbrook Garrison. A huge gnoll called Hogger is prowling the woods of southwestern Elwynn, and he has beaten every attempt to catch him. Marshal Dughan in Goldshire pays the bounty.",
            recap = "There's a poster outside Westbrook Garrison. WANTED, it says, and then Hogger, in quotes, as if even the marshal wasn't sure that was his real name. A Riverpaw brute, out at Forest's Edge. Bring back his claw.\n\nOne gnoll, I thought. How bad can one gnoll be?\n\nHere's what nobody tells you about Hogger. He's big, he's quick, he hits like a runaway cart, and he doesn't live alone. The Riverpaw are thick in those woods, and every one of them takes his side. Say his name in Goldshire and watch the room go quiet.\n\nI brought back the claw, and it's a big one. You could rake a garden with it. Marshal Dughan looked at it for a good while, and then paid me.\n\nThe road to Westfall is a little safer now. A little.",
            quests = {
                { id = 176, name = "Wanted: \"Hogger\"", npc = "Wanted Poster" },
            },
        },
    },
}
