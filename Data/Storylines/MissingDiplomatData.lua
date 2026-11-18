local addonName, SM = ...

-- =============================================================================
-- Classic: The Missing Diplomat
-- Stormwind intrigue, Defias evidence, Menethil, Theramore, and Jaina.
-- =============================================================================

SM.MissingDiplomatData = {
    title = "The Missing Diplomat",
    description = "Thomas has been asked to find an adventurer for Bishop DeLavey in Stormwind Keep. The bishop will not speak of the matter openly, only that discretion matters and the kingdom may have need of you.\n\nBegin in Stormwind and follow a quiet trail of favors, contacts, and rumors. What starts as a missing man soon points beyond a simple disappearance.",
    zone = "Stormwind / Duskwood / Wetlands / Dustwallow Marsh",
    expansion = "Classic",
    recommendedLevel = { min = 28, max = 38 },
    faction = "Alliance",
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.22, 0.42, 0.78 },
    icon = 134328,
    adventureCoverTexture = 131870, -- Stockade: closest Classic loading screen for Stormwind intrigue and Defias fallout
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 1274, name = "The Missing Diplomat", npc = "Thomas", location = "Cathedral Square, Stormwind" },
    startMapID = 84,
    startX = 0.5000,
    startY = 0.4600,

    npcLocations = {
        ["Thomas"] = { mapID = 84, x = 0.4168, y = 0.3183, location = "Cathedral Square, Stormwind" },
        ["Bishop DeLavey"] = { mapID = 84, x = 0.7830, y = 0.2545, location = "Stormwind Keep" },
        ["Jorgen"] = { mapID = 84, x = 0.7300, y = 0.7800, location = "the Valley of Heroes, Stormwind" },
        ["Elling Trias"] = { mapID = 84, x = 0.5991, y = 0.6418, location = "Trias' Cheese, Trade District, Stormwind" },
        ["Watcher Backus"] = { mapID = 47, x = 0.7200, y = 0.3500, location = "the north road out of Darkshire, Duskwood" },
        ["Defias Docket"] = { mapID = 47, x = 0.2400, y = 0.7200, location = "the small house at Addle's Stead, Duskwood" },
        ["Dashel Stonefist"] = { mapID = 84, x = 0.7053, y = 0.4488, location = "Old Town, Stormwind" },
        ["Mikhail"] = { mapID = 56, x = 0.1000, y = 0.6000, location = "the Deepwater Tavern, Menethil Harbor" },
        ["Tapoke \"Slim\" Jahn"] = { mapID = 56, x = 0.1000, y = 0.6000, location = "the Deepwater Tavern, Menethil Harbor" },
        ["Commander Samaul"] = { mapID = 70, x = 0.6700, y = 0.4700, location = "Foothold Citadel, Theramore" },
        ["Archmage Tervosh"] = { mapID = 70, x = 0.6640, y = 0.4920, location = "Jaina's tower, Theramore Isle" },
        ["Private Hendel"] = { mapID = 70, x = 0.4500, y = 0.2500, location = "the tents northwest of Theramore" },
        ["Lady Jaina Proudmoore"] = { mapID = 70, x = 0.6600, y = 0.4900, location = "Theramore Isle" },
    },

    npcDisplayIDs = {
        ["Thomas"] = 262,
        ["Bishop DeLavey"] = 2961,
        ["Jorgen"] = 4469,
        ["Elling Trias"] = 3246,
        ["Watcher Backus"] = 2380,
        ["Dashel Stonefist"] = 3238,
        ["Mikhail"] = 2964,
        ["Tapoke \"Slim\" Jahn"] = 2963,
        ["Commander Samaul"] = 2965,
        ["Archmage Tervosh"] = 2969,
        ["Private Hendel"] = 2967,
        ["Lady Jaina Proudmoore"] = 30867,
    },

    chapterDisplayIDs = {
        ["A Discreet Matter"] = 2961,
        ["The Defias Docket"] = 2380,
        ["Fist"] = 3238,
        ["Slim's Confession"] = 2963,
        ["Hendel"] = 3387,
    },

    chapterIcons = {
        ["A Discreet Matter"] = 134328,
        ["The Defias Docket"] = 134943,
        ["Fist"] = 132938,
        ["Slim's Confession"] = 133471,
        ["Hendel"] = 132349,
    },

    chapters = {
        {
            chapter = "A Discreet Matter",
            summary = "Thomas, in Cathedral Square in Stormwind, has a message for someone who can keep quiet: Bishop DeLavey would like to see you in Stormwind Keep. The bishop isn't saying why. Not out loud, anyway.",
            recap = "It began with a quiet word outside the cathedral: Bishop DeLavey wanted to see me up in Stormwind Keep. From the way it was said, I gathered it wasn't about my soul.\n\nThe bishop told me exactly as much as I needed and not a word more. A diplomat had gone missing, and it was not to be talked about. A contact in the Valley of Heroes handed me a sealed note for Elling Trias, a man with a cheese shop and, it turns out, a good deal more than that. Trias read it, sealed up a note of his own, and sent me off to a watchman in Duskwood.\n\nThat's how you know it's serious. Nobody says anything out loud. They write it down, seal it, and make you carry it.",
            quests = {
                { id = 1274, name = "The Missing Diplomat", displayName = "Bishop DeLavey", npc = "Thomas" },
                { id = 1241, name = "The Missing Diplomat", displayName = "Jorgen", npc = "Bishop DeLavey" },
                { id = 1242, name = "The Missing Diplomat", displayName = "Elling Trias", npc = "Jorgen" },
                { id = 1243, name = "The Missing Diplomat", displayName = "Watcher Backus", npc = "Elling Trias" },
            },
        },
        {
            chapter = "The Defias Docket",
            summary = "Elling Trias's sealed note has brought you to Watcher Backus, on the road north of Darkshire. Now the watcher wants you out at Addle's Stead in western Duskwood, where the Defias may have left some paperwork lying around.",
            recap = "Watcher Backus walks the road north of Darkshire. Backus read the note and sent me out to Addle's Stead, an old farm in western Duskwood, where a little house had some paperwork in it that the Defias wouldn't want found. The Defias Docket.\n\nHere's a thing about the Defias nobody warns you about. They keep records. Whether that's very organized or very stupid, I've never decided. It does make my job easier.\n\nBackus took one look at it and sent me straight back to Stormwind. Trias read it the way a man reads a bill he already knew was coming, and had my next stop picked out before he'd put it down.",
            quests = {
                { id = 1244, name = "The Missing Diplomat", displayName = "Addle's Stead", npc = "Watcher Backus" },
                { id = 1245, name = "The Missing Diplomat", displayName = "Back to Trias", npc = "Watcher Backus" },
            },
        },
        {
            chapter = "Fist",
            summary = "Elling Trias, back at the cheese shop in Stormwind's Trade District, has read the Defias docket and picked your next stop before putting it down: Dashel Stonefist, in Old Town.",
            recap = "The next lead was Dashel Stonefist, in Old Town. With a name like that, the conversation was always going to start with fists. Dashel didn't want to talk. Dashel wanted to settle things the old way, so we did, and when it was over Dashel was a good deal more reasonable.\n\nWhat Dashel told me sent me back to Trias, and Trias sent me out of the city altogether: north to the Wetlands, to Menethil Harbor and a contact there named Mikhail.\n\nI've always liked that part of a job. One minute you're trading punches in Old Town, the next you're on the road with a name in your pocket and a long way to go.",
            quests = {
                { id = 1246, name = "The Missing Diplomat", displayName = "Find Dashel", npc = "Elling Trias" },
                { id = 1447, name = "The Missing Diplomat", displayName = "Subdue Dashel", npc = "Dashel Stonefist" },
                { id = 1247, name = "The Missing Diplomat", displayName = "Dashel's Lead", npc = "Dashel Stonefist" },
                { id = 1248, name = "The Missing Diplomat", displayName = "Menethil", npc = "Elling Trias" },
            },
        },
        {
            chapter = "Slim's Confession",
            summary = "Mikhail, at the Deepwater Tavern in Menethil Harbor, has had an eye on a patron called Tapoke Jahn. Slim, to his friends. Slim takes a great interest in other people's business, and Mikhail thinks it's time someone returned the favor.",
            recap = "Mikhail works out of the Deepwater Tavern in Menethil Harbor and notices things. Lately Mikhail had noticed a fellow who listened to other people's business a little too hard.\n\nThat was Tapoke Jahn. Slim, to his friends, if he has any. The moment Slim saw me coming, he did what guilty men always do. He ran. He didn't get far. I subdued him, and after that Slim was very keen to be helpful.\n\nSlim's confession pointed south, across the sea, to Theramore. So Mikhail sent me to find a commander in Dustwallow Marsh, and I took the next boat out.",
            quests = {
                { id = 1249, name = "The Missing Diplomat", displayName = "Find Slim", npc = "Mikhail" },
                { id = 1250, name = "The Missing Diplomat", displayName = "Slim's Confession", npc = "Tapoke \"Slim\" Jahn" },
                { id = 1264, name = "The Missing Diplomat", displayName = "Commander Samaul", npc = "Mikhail" },
            },
        },
        {
            chapter = "Hendel",
            summary = "Commander Samaul, at Foothold Citadel in Theramore, has heard what brought you all this way. The commander sends you to Sentry Point, in Dustwallow Marsh, to look for any sign of a Private Hendel.",
            recap = "Theramore is Jaina Proudmoore's city. The commander there had me search Sentry Point for any sign of a Private Hendel. No Hendel. When a soldier isn't at his post, that tells you plenty.\n\nAn archmage in Jaina's tower knew where to look instead: some tents out northwest of the city. Hendel was there, and Hendel was not in a talking mood, so we had it out. When he finally yielded, Lady Jaina Proudmoore herself was there to take him off my hands, with a quiet word of thanks for me.\n\nQuiet. That was the whole job, start to finish. I never did learn the diplomat's name. But considering who sent me looking and who turned up to say thank you, I have a fair idea.",
            quests = {
                { id = 1265, name = "The Missing Diplomat", displayName = "Sentry Point", npc = "Commander Samaul" },
                { id = 1266, name = "The Missing Diplomat", displayName = "Private Hendel", npc = "Archmage Tervosh" },
                { id = 1324, name = "The Missing Diplomat", npc = "Private Hendel" },
                { id = 1267, name = "The Missing Diplomat", displayName = "Jaina Proudmoore", npc = "Archmage Tervosh" },
            },
        },
    },
}
