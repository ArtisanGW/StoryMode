local addonName, SM = ...

-- =============================================================================
-- Classic: The Scythe of Elune
-- Velinde Starsong, the missing scythe, and the worgen trail to Duskwood.
-- =============================================================================

SM.ScytheOfEluneData = {
    title = "The Scythe of Elune",
    description = "Near Ashenvale's northern border, the Howling Vale is full of wolf-men that should not be there. Sentinel Melyria Frostshadow believes the Tome of Mel'Thandris may explain why.\n\nFollow Velinde Starsong's trail from Ashenvale to Darnassus, Ratchet, Booty Bay, and Duskwood. The scythe's story is not tidy, but it is one of Classic's clearest windows into the first mysteries of the worgen.",
    zone = "Ashenvale / Darnassus / The Barrens / Stranglethorn Vale / Duskwood",
    expansion = "Classic",
    recommendedLevel = { min = 28, max = 35 },
    faction = "Alliance",
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.42, 0.54, 0.78 },
    icon = 135139,
    adventureCoverTexture = 131869, -- Shadowfang Keep: closest Classic cover for the worgen trail into Duskwood
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 1022, name = "The Howling Vale", npc = "Sentinel Melyria Frostshadow", location = "the Shrine of Aessina, Ashenvale" },
    startMapID = 63,
    startX = 0.2220,
    startY = 0.5280,

    npcLocations = {
        ["Sentinel Melyria Frostshadow"] = { mapID = 63, x = 0.2220, y = 0.5280, location = "the Shrine of Aessina, Ashenvale" },
        ["Tome of Mel'Thandris"] = { mapID = 63, x = 0.5000, y = 0.3900, location = "the Howling Vale, Ashenvale" },
        ["Thyn'tel Bladeweaver"] = { mapID = 89, x = 0.6200, y = 0.3900, location = "the Warrior's Terrace, Darnassus" },
        ["Velinde's Chest"] = { mapID = 89, x = 0.6200, y = 0.8100, location = "the Sentinels' bunkhouse, Darnassus" },
        ["Wharfmaster Dizzywig"] = { mapID = 10, x = 0.6300, y = 0.3800, location = "Ratchet, The Barrens" },
        ["Caravaneer Ruzzgot"] = { mapID = 50, x = 0.2700, y = 0.7400, location = "Booty Bay, Stranglethorn Vale" },
        ["Clerk Daltry"] = { mapID = 47, x = 0.7230, y = 0.4660, location = "Darkshire Town Hall, Duskwood" },
        ["Jonathan Carevin"] = { mapID = 47, x = 0.7530, y = 0.4890, location = "Darkshire, Duskwood" },
        ["Mound of Dirt"] = { mapID = 47, x = 0.7300, y = 0.7900, location = "Roland's Doom, Duskwood" },
    },

    npcDisplayIDs = {
        ["Sentinel Melyria Frostshadow"] = 1957,
        ["Thyn'tel Bladeweaver"] = 7275,
        ["Clerk Daltry"] = 1720,
        ["Jonathan Carevin"] = 4338,
    },

    chapterIcons = {
        ["The Howling Vale"] = 136172,
        ["Velinde Starsong"] = 134331,
        ["Across the Sea"] = 132270,
        ["The Carevin Family"] = 132203,
        ["Answered Questions"] = 135139,
    },

    chapters = {
        {
            chapter = "The Howling Vale",
            summary = "Sentinel Melyria Frostshadow, at the Shrine of Aessina in Ashenvale, has a wolf problem. These wolves walk on two legs and roam the Howling Vale, where they have no business being. An old book there, the Tome of Mel'Thandris, may explain them.",
            recap = "Sentinel Melyria Frostshadow had a problem with wolves. Wolves on two legs, up in the Howling Vale, where they had no business being. Worgen, in Ashenvale. The Sentinel thought an old book might explain it, the Tome of Mel'Thandris, and the book was right there in the Vale with the worgen.\n\nSo I went and read it. Not the most relaxing reading I've ever done.\n\nIt told a story, and not a happy one. A priestess named Velinde Starsong prayed for help against the demons, and the help she was given was the Scythe of Elune. Whatever she did with it, the worgen came after. Melyria liked that story about as much as I did, which is to say not at all.",
            quests = {
                { id = 1022, name = "The Howling Vale", npc = "Sentinel Melyria Frostshadow" },
            },
        },
        {
            chapter = "Velinde Starsong",
            summary = "The Tome of Mel'Thandris gave Sentinel Melyria a name: Velinde Starsong. Melyria wants to know what became of Velinde, and sends you to Darnassus to ask Thyn'tel Bladeweaver on the Warrior's Terrace.",
            recap = "Darnassus remembered Velinde fondly. Melyria sent me to Thyn'tel Bladeweaver on the Warrior's Terrace, and Thyn'tel handed me the key to Velinde's chest, which had sat in storage since she left.\n\nGoing through somebody else's chest feels like burglary, even with the key. I found what I was after, Velinde's journal, and brought it back with the key.\n\nIt wasn't a confession, exactly. Velinde had used the scythe and the worgen had come, and then she couldn't hold them. So she'd gone looking for help, somewhere a long way from Ashenvale. The journal knew where she'd meant to go. It didn't know whether she'd got there. Neither did anybody in Darnassus.",
            quests = {
                { id = 1037, name = "Velinde Starsong", npc = "Sentinel Melyria Frostshadow" },
                { id = 1038, name = "Velinde's Effects", npc = "Thyn'tel Bladeweaver" },
            },
        },
        {
            chapter = "Across the Sea",
            summary = "Velinde Starsong left Ashenvale to find help a long way off, and Darnassus hasn't heard from Velinde since. Thyn'tel Bladeweaver thinks the trail starts at the docks. Wharfmaster Dizzywig, in Ratchet, might remember a passenger.",
            recap = "Velinde's trail started at the docks. Thyn'tel sent me to Ratchet, and the wharfmaster there remembered Velinde taking passage to Booty Bay. So I took passage to Booty Bay. Following a priestess's travel plans across the world is a strange way to spend your days.\n\nIn Booty Bay the caravan records had her on the road north. Up through Stranglethorn. Toward Duskwood.\n\nNobody goes to Duskwood on purpose. Velinde apparently did, so I did too, and the road north was as friendly as it always is, which is not at all. At the end of it was Darkshire, where the sun doesn't bother.",
            quests = {
                { id = 1039, name = "The Barrens Port", npc = "Thyn'tel Bladeweaver" },
                { id = 1040, name = "Passage to Booty Bay", npc = "Wharfmaster Dizzywig" },
                { id = 1041, name = "The Caravan Road", npc = "Caravaneer Ruzzgot" },
            },
        },
        {
            chapter = "The Carevin Family",
            summary = "Velinde's trail has come all the way to Darkshire, in Duskwood, where the sun doesn't bother. Clerk Daltry, at the town hall, keeps the records. Somebody here must remember a night elf priestess passing through.",
            recap = "Clerk Daltry had no Velinde in any of the Darkshire records. What Daltry did have was a name: Jonathan Carevin. The Carevins hunt the things in Duskwood's woods and have done for a long while, and if anybody in town knew about worgen, it'd be them.\n\nCarevin wasn't thrilled to have a stranger asking about the Scythe of Elune. Fair enough. But we came to an arrangement: whatever I found out there, Darkshire would hear about it too.\n\nWhat I found was in Roland's Doom, an old mine I'd rather not go back to, under a mound of dirt. Not the scythe. Evidence of it. Proof it had been there, in Duskwood, a very long way from home. I took it back to Carevin as promised.",
            quests = {
                { id = 1042, name = "The Carevin Family", npc = "Clerk Daltry" },
                { id = 1043, name = "The Scythe of Elune", npc = "Jonathan Carevin" },
            },
        },
        {
            chapter = "Answered Questions",
            summary = "What you dug out of Roland's Doom belongs in Darnassus. Jonathan Carevin, in Darkshire, wants Thyn'tel Bladeweaver to see it, and that means crossing the sea again. Mind it on the boat.",
            recap = "Darnassus again. Carevin sent me back to Thyn'tel Bladeweaver with what I'd found, and that's a long way to carry an answer nobody's going to like.\n\nThyn'tel heard me out. The scythe had been in Duskwood. Velinde's trail had come apart somewhere around Roland's Doom. And whatever she'd called up with it was still loose in the world, in more forests than one.\n\nThyn'tel thanked me and meant it, and looked as uneasy as I've ever seen anyone look while saying thank you. I understood. We had answers now. That was the trouble. None of them came with the scythe attached, and the scythe was still out there somewhere.\n\nI've followed a lot of trails. That's the only one that crossed the whole world and finished on a question.",
            quests = {
                { id = 1044, name = "Answered Questions", npc = "Jonathan Carevin" },
            },
        },
    },
}
