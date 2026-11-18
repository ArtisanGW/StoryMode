local addonName, SM = ...

-- =============================================================================
-- Classic: The Hakkari Trail
-- Yeh'kinya, the Mosh'aru Tablets, Hakkar, and the road to Zul'Gurub.
-- =============================================================================

SM.HakkariTrailData = {
    title = "The Hakkari Trail",
    description = "At Steamwheedle Port, Yeh'kinya asks for help with old troll spirits and older tablets. It sounds like simple archaeology, and Yeh'kinya is very polite about it.\n\nFollow the tablets from Feralas and Zul'Farrak into older and darker places, and see where an old troll's errand leads.",
    zone = "Tanaris / Feralas / Zul'Farrak / The Hinterlands / Sunken Temple / Blackrock Spire / Stranglethorn Vale",
    expansion = "Classic",
    recommendedLevel = { min = 40, max = 60 },
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.82, 0.54, 0.18 },
    icon = 136127,
    adventureGuideInstanceName = "Zul'Farrak",
    adventureCoverTexture = 131886, -- Zul'Gurub loading screen: Hakkari and Zandalar payoff
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 3520, name = "Screecher Spirits", npc = "Yeh'kinya", location = "Steamwheedle Port, Tanaris" },
    startMapID = 71,
    startX = 0.6680,
    startY = 0.2290,

    npcLocations = {
        ["Yeh'kinya"] = { mapID = 71, x = 0.6680, y = 0.2290, location = "Steamwheedle Port, Tanaris" },
        ["Prospector Ironboot"] = { mapID = 71, x = 0.6680, y = 0.2450, location = "Steamwheedle Port, Tanaris" },
        ["Theka the Martyr"] = { mapID = 219, x = 0.4500, y = 0.4400, location = "Zul'Farrak" },
        ["Hydromancer Velratha"] = { mapID = 219, x = 0.6200, y = 0.2800, location = "Zul'Farrak, near Gahz'rilla's pool" },
        ["Ancient Egg"] = { mapID = 26, x = 0.6600, y = 0.6600, location = "the summit cave at Jintha'Alor, The Hinterlands" },
        ["Avatar of Hakkar"] = { mapID = 220, x = 0.3400, y = 0.7800, location = "the Sanctum of the Fallen God, Temple of Atal'Hakkar" },
        ["Mosh'aru Tablets"] = { mapID = 23, x = 0.7200, y = 0.1500, location = "Zul'Mashar, Eastern Plaguelands" },
        ["Smolderthorn Tablets"] = { mapID = 250, x = 0.4200, y = 0.6800, location = "Lower Blackrock Spire" },
        ["Molthor"] = { mapID = 50, x = 0.1500, y = 0.1500, location = "Yojamba Isle, Stranglethorn Vale" },
    },

    chapterDisplayIDs = {
        ["Screecher Spirits"] = 3733,
        ["The Prophecy of Mosh'aru"] = 11279,
        ["The God Hakkar"] = 7842,
        ["The Final Tablets"] = 9291,
        ["The Hand of Rastakhan"] = 15295,
    },

    chapterIcons = {
        ["Screecher Spirits"] = 136122,
        ["The Prophecy of Mosh'aru"] = 133741,
        ["The God Hakkar"] = 136127,
        ["The Final Tablets"] = 134459,
        ["The Hand of Rastakhan"] = 132117,
    },

    npcDisplayIDs = {
        -- Quest givers' models from the cmangos Classic database.
        ["Yeh'kinya"] = 7902,
        ["Prospector Ironboot"] = 10195,
    },

    chapters = {
        {
            chapter = "Screecher Spirits",
            summary = "Yeh'kinya, a troll at Steamwheedle Port in Tanaris, has the oddest little job on the coast: go to Feralas and catch the spirits of three dead screechers. Yeh'kinya supplies the bramble. You supply the legs.",
            recap = "It started as the oddest little job. A troll in Steamwheedle Port named Yeh'kinya handed me a bramble and sent me to Feralas to catch ghosts. Not big ghosts. Screecher ghosts. Find a dead screecher, use the bramble, and its spirit comes along with you.\n\nThree of them, that's all he wanted. I brought them back, and whatever those spirits told him, he liked it. It had to do with an old troll prophecy.\n\nI remember thinking, what does a dead screecher know about prophecy? More than I did, as it turned out. That was the first thread. I had no idea how much was tied to the other end of it.",
            quests = {
                { id = 3520, name = "Screecher Spirits", npc = "Yeh'kinya" },
            },
        },
        {
            chapter = "The Prophecy of Mosh'aru",
            summary = "Whatever the screecher spirits told Yeh'kinya, it had to do with an old troll prophecy written on tablets. The first two Mosh'aru tablets are in Zul'Farrak, among the sand trolls, and Yeh'kinya would very much like to read them.",
            recap = "The prophecy, it turned out, was written on tablets, and the tablets were in Zul'Farrak. Where else. Sand, heat, sand trolls, more sand. I brought two of them back and Yeh'kinya read them like a letter from home.\n\nThe tablets spoke of an ancient egg from the days of the old troll empires, and that egg sat in a cave at the top of Jintha'Alor, with every Vilebranch in the Hinterlands between me and it. I went up. I came down with the egg. The Vilebranch had a lot to say about that, most of it at the tops of their voices.\n\nYeh'kinya held it like a newborn. I've seen parents with less care.",
            quests = {
                { id = 3527, name = "The Prophecy of Mosh'aru", npc = "Yeh'kinya" },
                { id = 4787, name = "The Ancient Egg", npc = "Yeh'kinya" },
            },
        },
        {
            chapter = "The God Hakkar",
            summary = "Yeh'kinya has the ancient egg from Jintha'Alor and now wants it filled with the essence of Hakkar. That means the very bottom of the sunken Temple of Atal'Hakkar, in the Swamp of Sorrows. Don't go alone.",
            recap = "Then Yeh'kinya told me what the egg was for. It was a vessel, and he wanted it filled. With Hakkar.\n\nSo down into the Temple of Atal'Hakkar I went, the sunken one in the Swamp of Sorrows, and not alone, because that place doesn't take visitors one at a time. At the very bottom, in the Sanctum of the Fallen God, the Avatar of Hakkar rose up to meet us. Big. Winged. Furious. We put it down, I used the egg, and the egg drank in the essence of a god like dry ground takes rain.\n\nI carried it back to Tanaris in my pack, between my bedroll and my supper, and felt it the whole way.\n\nLooking back, that was the moment to start asking questions. I didn't. It was a very nice egg.",
            quests = {
                { id = 3528, name = "The God Hakkar", npc = "Yeh'kinya" },
            },
        },
        {
            chapter = "The Final Tablets",
            summary = "Prospector Ironboot at Steamwheedle Port has a question about the Mosh'aru tablets: how many do you think there are? Two more lie in Zul'Mashar, in the Eastern Plaguelands, and the prospector would like them brought back.",
            recap = "Back in Steamwheedle Port, Prospector Ironboot stopped me with a question. Did I know there were six Mosh'aru tablets? Not two. Six. Yeh'kinya had somehow forgotten to mention the other four.\n\nTwo of them were in Zul'Mashar, out in the Eastern Plaguelands, which is a fine place to visit if you enjoy being chewed on. The last two were in Lower Blackrock Spire, which is worse. I fetched all four, and Ironboot read the whole set.\n\nRead whole, the prophecy said something else entirely. Two tablets sounded like a way to keep Hakkar out of the world. Six sounded like a way to let him back in.\n\nI thought about that egg, and every mile I'd carried it. I'd been a great help to somebody. I just hadn't asked who.",
            quests = {
                { id = 5065, name = "The Lost Tablets of Mosh'aru", npc = "Prospector Ironboot" },
                { id = 4788, name = "The Final Tablets", npc = "Prospector Ironboot" },
            },
        },
        {
            chapter = "The Hand of Rastakhan",
            summary = "Prospector Ironboot has read all six Mosh'aru tablets and thinks it's time you and Yeh'kinya had a talk. Yeh'kinya is still at Steamwheedle Port, just down the way. The walk is the easy part.",
            recap = "The prospector reckoned I ought to go and have a word with Yeh'kinya. The prospector was right.\n\nI won't give you the whole conversation. The short of it was that Hakkar the Soulflayer was coming back into the world through Zul'Gurub, and the trolls who meant to meet him there were the Zandalar. Somebody had to carry word to their man Molthor, out on Yojamba Isle off the coast of Stranglethorn. That was me.\n\nSo a job that started with a bramble and three dead screechers ended with me on a beach full of Zandalar, with Zul'Gurub the obvious next stop.\n\nThat one's a story for another night. Buy the next round and I might tell it.",
            quests = {
                { id = 8181, name = "Confront Yeh'kinya", npc = "Prospector Ironboot" },
                { id = 8182, name = "The Hand of Rastakhan", npc = "Prospector Ironboot" },
            },
        },
    },
}
