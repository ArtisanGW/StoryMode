local addonName, SM = ...

-- =============================================================================
-- Classic: Master of the Wild Leather
-- Leatherworking's quests: Wild Leather in Feralas, then one of the three
-- specializations.
-- =============================================================================
--
-- Only characters who know Leatherworking see this story. The Master quest
-- (2853, 2860) needs all five Wild Leather pieces (Wowhead lists all five
-- under Requires, cmangos puts them in one all-required group, and the trainer
-- says you've mastered the other patterns), so no piece is optional.
--
-- Dragonscale, Elemental and Tribal are a choice: finishing one specialization
-- quest bars the other two. Each specialization's quests hide once another
-- specialization's quest is done, on either faction; before the choice all
-- three show.

SM.ClassicLeatherworkingData = {
    title = "Master of the Wild Leather",
    description = "Two leatherworkers in Feralas know how to stitch wildvines into armor, and whichever one teaches you will want you working for them while you learn, paying for each pattern in finished leather.\n\nBeyond Wild Leather the trade divides into three high arts, each with a master of its own, and a leatherworker only ever gets to learn one of them.",
    descriptionAlliance = "Pratt McGrubben, at Feathermoon Stronghold in Feralas, knows how to stitch wildvines into armor. He'll teach you, if you don't mind working for him while you learn and paying for each pattern in finished leather.\n\nBeyond Wild Leather the trade divides into three high arts, each with a master of its own, and a leatherworker only ever gets to learn one of them.",
    descriptionHorde = "Jangdor Swiftstrider, at Camp Mojache in Feralas, knows how to stitch wildvines into armor. He'll teach you, if you don't mind working for him while you learn and paying for each pattern in finished leather.\n\nBeyond Wild Leather the trade divides into three high arts, each with a master of its own, and a leatherworker only ever gets to learn one of them.",
    zone = "Feralas / Darnassus / Thunder Bluff / Azshara / Searing Gorge / Badlands / Arathi Highlands / Stranglethorn Vale",
    zoneByFaction = {
        Alliance = "Feralas / Darnassus / Azshara / Searing Gorge",
        Horde = "Feralas / Thunder Bluff / Badlands / Arathi Highlands / Stranglethorn Vale",
    },
    expansion = "Classic",
    profession = 165,  -- Leatherworking
    recommendedLevel = { min = 30, max = 55 },
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.62, 0.44, 0.26 },
    icon = "Interface\\Icons\\Trade_LeatherWorking",
    portraitDisplayID = 6892,  -- Pratt McGrubben, who teaches Wild Leather at Feathermoon Stronghold
    adventureCoverTexture = 131835,  -- Dire Maul loading screen: Feralas's own dungeon, between the two Wild Leather trainers
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 2847, name = "Wild Leather Armor", npc = "Pratt McGrubben", faction = "Alliance", location = "Feathermoon Stronghold, Feralas" },
    startMapID = 69,
    startX = 0.3060,
    startY = 0.4260,

    npcLocations = {
        ["Pratt McGrubben"] = { mapID = 69, x = 0.3060, y = 0.4260, location = "Feathermoon Stronghold, Feralas" },
        ["Jangdor Swiftstrider"] = { mapID = 69, x = 0.7440, y = 0.4280, location = "Camp Mojache, Feralas" },
        ["Telonis"] = { mapID = 89, x = 0.6450, y = 0.2150, location = "the Craftsmen's Terrace, Darnassus" },
        ["Una"] = { mapID = 88, x = 0.4160, y = 0.4240, location = "Thunder Bluff" },
        ["Peter Galen"] = { mapID = 76, x = 0.3740, y = 0.6540, location = "southern Azshara" },
        ["Thorkaf Dragoneye"] = { mapID = 15, x = 0.6240, y = 0.5740, location = "eastern Badlands" },
        ["Sarah Tanner"] = { mapID = 32, x = 0.6360, y = 0.7560, location = "southeastern Searing Gorge" },
        ["Brumn Winterhoof"] = { mapID = 14, x = 0.2820, y = 0.4500, location = "western Arathi Highlands" },
        ["Caryssia Moonhunter"] = { mapID = 69, x = 0.8940, y = 0.4640, location = "Thalanaar, Feralas" },
        ["Se'Jib"] = { mapID = 50, x = 0.3640, y = 0.3400, location = "southeast of Grom'gol, Stranglethorn Vale" },
    },

    npcDisplayIDs = {
        -- Quest givers' models from the cmangos Classic database.
        ["Pratt McGrubben"] = 6892,
        ["Jangdor Swiftstrider"] = 6893,
        ["Telonis"] = 2270,
        ["Una"] = 2127,
        ["Peter Galen"] = 6917,
        ["Thorkaf Dragoneye"] = 6916,
        ["Sarah Tanner"] = 7030,
        ["Brumn Winterhoof"] = 6918,
        ["Caryssia Moonhunter"] = 6919,
        ["Se'Jib"] = 7042,
    },

    chapters = {
        {
            chapter = "Wild Leather Armor",
            requiredLevel = 30,
            summaryAlliance = "Pratt McGrubben, at Feathermoon Stronghold in Feralas, thinks you're getting good with leather. He knows how to work wildvines into armor and will teach you, though you'll be working for him a while, and he wants ten pieces of thick leather to start.",
            summaryHorde = "Word of your leatherwork has reached Jangdor Swiftstrider at Camp Mojache in Feralas. He knows how to work wildvines into armor and will teach you, though you'll be working for him a while, and he wants ten pieces of thick leather to start.",
            recapAlliance = "Pratt McGrubben teaches Wild Leather at Feathermoon Stronghold, and warned me up front that I'd be working for him while I learned. I pictured sweeping the shop. He meant armor, made by me and handed to him in pairs of turtle scale and nightscape, with a wildvine tucked into every order.\n\nThe wildvines are the trick. They're potent and chaotic, so whatever you stitch one into comes out strong in ways you can't call in advance. Pratt calls the result second to none, guaranteed.\n\nWith every pattern paid for but one, Pratt wrote a letter and sent me to his own teacher, Telonis, in Darnassus. Telonis read it and allowed that Pratt reminds him of a night elf sometimes, which I took to be the warmest thing Darnassus says about a human. Then the cloak pattern was mine. Few in the world know it, Telonis says.",
            recapHorde = "Jangdor Swiftstrider teaches Wild Leather at Camp Mojache, and warned me up front that I'd be working for him while I learned. I pictured hauling hides. He meant armor, made by me and handed to him in pairs of turtle scale and nightscape, with a wildvine tucked into every order.\n\nThe wildvines are the trick. They're potent and chaotic, so whatever you stitch one into comes out strong in ways you can't call in advance. Jangdor calls the result second to none, guaranteed.\n\nWith every pattern paid for but one, Jangdor wrote a letter and sent me up to Thunder Bluff, to Una, who brought him into the craft. Una read it and was pleased to see one of her finest students with a student of his own. I was pleased to get the cloak pattern. Few in the world know it, Una says.",
            quests = {
                -- Alliance. The five pieces open together once Wild Leather Armor is done.
                { id = 2847, name = "Wild Leather Armor", npc = "Pratt McGrubben", faction = "Alliance" },
                { id = 2848, name = "Wild Leather Shoulders", npc = "Pratt McGrubben", faction = "Alliance" },
                { id = 2849, altIds = { 82657 }, name = "Wild Leather Vest", npc = "Pratt McGrubben", faction = "Alliance", parallel = true },
                { id = 2850, name = "Wild Leather Helmet", npc = "Pratt McGrubben", faction = "Alliance", parallel = true },
                { id = 2851, name = "Wild Leather Boots", npc = "Pratt McGrubben", faction = "Alliance", parallel = true },
                { id = 2852, name = "Wild Leather Leggings", npc = "Pratt McGrubben", faction = "Alliance", parallel = true },
                { id = 2853, name = "Master of the Wild Leather", npc = "Pratt McGrubben", faction = "Alliance", location = "Pratt McGrubben, Feathermoon Stronghold, then Telonis, Darnassus" },
                -- Horde
                { id = 2854, name = "Wild Leather Armor", npc = "Jangdor Swiftstrider", faction = "Horde" },
                { id = 2855, name = "Wild Leather Shoulders", npc = "Jangdor Swiftstrider", faction = "Horde" },
                { id = 2856, altIds = { 82656 }, name = "Wild Leather Vest", npc = "Jangdor Swiftstrider", faction = "Horde", parallel = true },
                { id = 2857, name = "Wild Leather Helmet", npc = "Jangdor Swiftstrider", faction = "Horde", parallel = true },
                { id = 2858, name = "Wild Leather Boots", npc = "Jangdor Swiftstrider", faction = "Horde", parallel = true },
                { id = 2859, name = "Wild Leather Leggings", npc = "Jangdor Swiftstrider", faction = "Horde", parallel = true },
                { id = 2860, name = "Master of the Wild Leather", npc = "Jangdor Swiftstrider", faction = "Horde", location = "Jangdor Swiftstrider, Camp Mojache, then Una, Thunder Bluff" },
            },
        },
        {
            chapter = "The Three Arts",
            requiredLevel = 40,
            summaryAlliance = "The leatherworking trade has three high arts, and you may learn only one. Peter Galen in Azshara teaches dragonscale. Sarah Tanner in Searing Gorge teaches elemental leatherworking, and Caryssia Moonhunter at Thalanaar in Feralas teaches tribal. Each has a price for taking you on.",
            summaryHorde = "The leatherworking trade has three high arts, and you may learn only one. Thorkaf Dragoneye in the Badlands teaches dragonscale. Brumn Winterhoof in the Arathi Highlands teaches elemental leatherworking, and Se'Jib in Stranglethorn Vale teaches tribal. Each has a price for taking you on.",
            recap = "At the top, the leatherworking trade splits three ways, and each way has a master of its own. Every one of them asks for the same promise before teaching you a thing. Learn this art and the other two are closed to you for good.\n\nI thought it over longer than I'd admit to a customer. Then I made up my mind, gathered what my new master wanted, and went to make the promise.",
            quests = {
                -- One specialization per character. Each hides once the other two
                -- specializations' quests (either faction) are done.
                -- Dragonscale
                { id = 5141, name = "Dragonscale Leatherworking", npc = "Peter Galen", faction = "Alliance", parallel = true, hideIf = { 5144, 5146, 5143, 5148 }, recap = "Peter Galen, out in Azshara, teaches dragonscale and wanted two kinds of proof before taking me on. Samples of my best scorpid work came first, two breastplates and two pairs of gloves. Then ten worn dragonscales, to show I could get hold of the staple of the trade. Peter said it takes a strong will to make a permanent decision like mine. It takes a fair number of scorpids, too." },
                { id = 5145, name = "Dragonscale Leatherworking", npc = "Thorkaf Dragoneye", faction = "Horde", parallel = true, hideIf = { 5144, 5146, 5143, 5148 }, recap = "Thorkaf Dragoneye teaches dragonscale out in the Badlands and wanted to see my scorpid work first, two breastplates and two pairs of gloves. Those I could make. The ten worn dragonscales I had to go out and find, which I suspect was the point. Once Thorkaf had the lot, the other two arts were closed to me, and I've been working in mail ever since." },
                -- Elemental
                { id = 5144, name = "Elemental Leatherworking", npc = "Sarah Tanner", faction = "Alliance", parallel = true, hideIf = { 5141, 5145, 5143, 5148 }, recap = "Sarah Tanner teaches elemental leatherworking in Searing Gorge and wanted proof that I was in tune with the elements, which meant bringing two each of their purest essences. Fire, water, earth and wind. I got them the usual way, off the elementals themselves. Sarah said the elements accepted me. They hadn't seemed to at the time." },
                { id = 5146, name = "Elemental Leatherworking", npc = "Brumn Winterhoof", faction = "Horde", parallel = true, hideIf = { 5141, 5145, 5143, 5148 }, recap = "Brumn Winterhoof teaches elemental leatherworking out in the Arathi Highlands, and a place cost two each of the elements' essences, hearts of fire, globes of water, cores of earth and breaths of wind. I got them the usual way, off the elementals themselves, who had opinions about it. Once Brumn had them all, the other two arts were closed to me." },
                -- Tribal
                { id = 5143, name = "Tribal Leatherworking", npc = "Caryssia Moonhunter", faction = "Alliance", parallel = true, hideIf = { 5141, 5145, 5144, 5146 }, recap = "Caryssia Moonhunter teaches tribal leatherworking at Thalanaar, on the eastern edge of Feralas, and asked first for an offering to nature. Nature, it seems, wanted my finest Wild Leather, a vest and a helmet. I'd have liked to see nature wear them. Caryssia took them on nature's behalf and promised I'd soon be bending it to my will." },
                { id = 5148, name = "Tribal Leatherworking", npc = "Se'Jib", faction = "Horde", parallel = true, hideIf = { 5141, 5145, 5144, 5146 }, recap = "Se'Jib teaches tribal leatherworking southeast of Grom'gol, in Stranglethorn, and asked first for an offering to nature. Nature wanted my finest Wild Leather, a vest and a helmet. I'd have liked to see nature wear them. Se'Jib took them on nature's behalf, and after that the other two arts were closed to me." },
            },
        },
    },
}
