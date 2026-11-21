local addonName, SM = ...

-- =============================================================================
-- WoW Forever: Lost in the Thicket
-- Two families waiting on news, the Greenwarden and the Deathstalkers all look
-- up into the Wetlands highlands, to the dig at Excavation Site: Wetlands.
-- =============================================================================
--
-- Chain order, from warcraft.wiki.gg's WoW Forever quest pages and the Warcraft
-- Tavern and Method guides:
--   Alliance: Horrors in the Highland (95646) needs Rethiel's Classic chain
--   (The Greenwarden 463 > Tramping Paws 276 > Fire Taboo 277 > Blisters on the
--   Land 275), and Highland Hides (98815) needs Young Crocolisk Skins (484).
--   Seeking Caitlin (95737), from Llana in Astranaar, leads to Lost in the
--   Thicket Things (95647). Inside, Ardin Grassman gives Heartwoven (95809) and
--   Daewyn Songblade's body gives Fallen in the Fen (95795).
--   Horde: Dragonmaw Rumors (95663), from Zaruk at Hammerfall, leads to the
--   Deathstalker Agent and Open the Maw (95682). Changing Tastes (95697) is
--   Borstan's, in Orgrimmar.
--   Both: the Relic Guardian drops a Titan Relic for each faction, starting
--   Lost Relic Carry (95810) > Prehistoric Prism (98824) for the Alliance and
--   Elder Knowledge (95664) > Earthen Echo (98823) for the Horde.
-- Side branches that can be played alongside the main line are `parallel`, so
-- finishing them first doesn't count the main line as done.

SM.ForeverExcavationSiteData = {
    title = "Lost in the Thicket",
    description = "A dig crew went up into the Wetlands highlands, and the news coming back down has dried up. In Menethil Harbor and in Lakeshire, families are waiting to hear from people who went up there. At Hammerfall there's a rumor that the Dragonmaw are planning something in the same hills.\n\nRethiel the Greenwarden says the land up there is sick. The Deathstalkers want someone to go and look before they move.",
    descriptionAlliance = "Caitlin Grassman's husband went up into the Wetlands highlands to see a grass a dig crew had told him about, and he hasn't come home to Menethil Harbor. In Lakeshire, Dorin Songblade's brother took a crew of diggers into the same hills, and his letters have stopped coming.\n\nOut in the marsh, Rethiel the Greenwarden can feel something wrong with the land, and the creatures up in the hills are taking it badly.",
    descriptionHorde = "Word has reached Hammerfall that the Dragonmaw are planning something in the Wetlands, and the Deathstalkers want to know more before they move. Their agent is waiting in the hills above the Dragonmaw camp for anyone with the nerve to help.\n\nIn Orgrimmar, Borstan has seen the size of the raptor talons coming back from a dig in the Wetlands highlands, and would like to know how the rest of the raptor tastes.",
    zone = "Wetlands / Excavation Site: Wetlands",
    zoneByFaction = {
        Alliance = "Wetlands / Excavation Site: Wetlands / Redridge Mountains / Ironforge",
        Horde = "Arathi Highlands / Wetlands / Excavation Site: Wetlands / Mulgore",
    },
    expansion = "Classic",
    recommendedLevel = { min = 21, max = 31 },
    requiredLevel = 20,
    gameVersions = { forever = true },
    achievements = {},
    color = { 0.44, 0.52, 0.32 },
    icon = "Interface\\Icons\\INV_Pet_ScorchedStone",  -- the Titan Relic's icon
    adventureCoverTexture = 7963777,  -- WoW Forever's Excavation Site: Wetlands, a camp of crates and carts
    adventureCoverTexCoords = { 0, 1, 0.1592, 0.8408 },  -- the picture, between its transparent bands
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 276, name = "Tramping Paws", npc = "Rethiel the Greenwarden", location = "east of the Dun Modr road, Wetlands", faction = "Alliance", gameVersions = { forever = true } },
    startMapID = 1437,
    startX = 0.5620,
    startY = 0.4040,

    npcLocations = {
        -- Alliance
        ["First Mate Fitzsimmons"] = { mapID = 1437, x = 0.1080, y = 0.5940, location = "Menethil Harbor, Wetlands" },
        ["Rethiel the Greenwarden"] = { mapID = 1437, x = 0.5620, y = 0.4040, location = "east of the Dun Modr road, Wetlands" },
        ["James Halloran"] = { mapID = 1437, x = 0.0860, y = 0.5560, location = "Menethil Harbor, Wetlands" },
        ["Llana"] = { mapID = 1440, x = 0.3500, y = 0.4840, location = "Astranaar, Ashenvale" },
        ["Caitlin Grassman"] = { mapID = 1437, x = 0.1180, y = 0.5880, location = "Menethil Harbor, Wetlands" },
        ["Dorin Songblade"] = { mapID = 1433, x = 0.3080, y = 0.4660, location = "Lakeshire, Redridge Mountains" },
        ["Prospector Whelgar"] = { mapID = 1437, x = 0.3880, y = 0.5220, location = "Whelgar's Excavation Site, Wetlands" },
        ["High Explorer Magellas"] = { mapID = 1455, x = 0.6960, y = 0.1860, location = "the Hall of Explorers, Ironforge" },
        -- Horde
        ["Zaruk"] = { mapID = 1417, x = 0.7440, y = 0.3560, location = "Hammerfall, Arathi Highlands" },
        ["Deathstalker Agent"] = { mapID = 1437, x = 0.5140, y = 0.5920, location = "the hills above the Dragonmaw camp, Wetlands" },
        ["Borstan"] = { mapID = 1454, x = 0.5740, y = 0.5340, location = "the Drag, Orgrimmar" },
        ["Bashana Runetotem"] = { mapID = 1456, x = 0.7080, y = 0.3380, location = "Elder Rise, Thunder Bluff" },
        ["Muln Earthfury"] = { mapID = 1412, x = 0.3340, y = 0.2240, location = "the Skywatcher Plateau, Mulgore" },
    },

    npcDisplayIDs = {
        -- Quest givers' models from the cmangos Classic database.
        ["First Mate Fitzsimmons"] = 1699,
        ["Rethiel the Greenwarden"] = 480,
        ["James Halloran"] = 1408,
        ["Llana"] = 2057,
        ["Caitlin Grassman"] = 3486,
        ["Dorin Songblade"] = 3353,
        ["Prospector Whelgar"] = 1399,
        ["High Explorer Magellas"] = 3596,
        ["Zaruk"] = 4463,
        ["Deathstalker Agent"] = 2863,
        ["Borstan"] = 1390,
        ["Bashana Runetotem"] = 8356,
        -- Quest givers' models from the WoW Forever client's creature cache.
        ["Muln Earthfury"] = 137889,
        -- Ardin Grassman (262681) and Daewyn Songblade (262465) are Forever's
        -- own, inside the dungeon; their models aren't known yet.
    },

    chapters = {
        {
            chapter = "The Greenwarden",
            faction = "Alliance",
            summary = "Out in the marsh east of the Dun Modr road lives Rethiel the Greenwarden, who watches over the Wetlands and could use a hand. First Mate Fitzsimmons in Menethil Harbor knows the way, but would rather you didn't go.",
            recap = "Rethiel the Greenwarden lives out in the marsh east of the Dun Modr road, and told me the roots and ferns spoke well of me. I've had worse references. The land was weeping from festered wounds, Rethiel said, and I was to heal it.\n\nMost of the wound was Mosshide gnolls. There were more of them all the time, cutting down trees and warming themselves with the burning wood, so I thinned them out and took away the flints they used to start their fires. Rethiel meant to smash every one and throw the pieces into the sea.\n\nThe fen creepers were the rest of it. Rethiel called them blisters on the land and wanted them settled back into the marsh, and I obliged. By the end the Greenwarden's faith in my people, which had been tested before, was coming back.",
            quests = {
                { id = 463, name = "The Greenwarden", npc = "First Mate Fitzsimmons", faction = "Alliance", optional = true, breadcrumbFor = 276, gameVersions = { forever = true }, recap = "First Mate Fitzsimmons in Menethil Harbor knew where to find the Greenwarden, out in the marsh east of the Dun Modr road, and seemed to hope I wasn't really going. I was. The first mate also told me to leave my money behind. I kept it, and the Greenwarden never mentioned it." },
                { id = 276, name = "Tramping Paws", npc = "Rethiel the Greenwarden", faction = "Alliance", gameVersions = { forever = true } },
                { id = 277, name = "Fire Taboo", npc = "Rethiel the Greenwarden", faction = "Alliance", gameVersions = { forever = true } },
                { id = 275, name = "Blisters on the Land", npc = "Rethiel the Greenwarden", faction = "Alliance", gameVersions = { forever = true } },
                { id = 484, name = "Young Crocolisk Skins", npc = "James Halloran", faction = "Alliance", optional = true, parallel = true, gameVersions = { forever = true }, recap = "James Halloran, the tanner in Menethil Harbor, ships cured crocolisk skins to ports all over the world and was running short of the soft ones that come off young crocolisks. I went out into the marsh and came back with a stack. Halloran called them superb and wanted to start curing them at once, but had more work for me first." },
            },
        },
        {
            chapter = "The Highland Dig",
            requiredLevel = 24,
            summaryAlliance = "Caitlin Grassman in Menethil Harbor hasn't seen her husband since he went up into the highlands, and Dorin Songblade in Lakeshire hasn't heard from his brother, who led a dig crew into the same hills. Rethiel the Greenwarden is worried about those hills too.",
            summaryHorde = "Zaruk at Hammerfall has heard the Dragonmaw are planning something in the Wetlands, and a Deathstalker agent is waiting in the hills above their camp for help. Borstan in Orgrimmar wants meat from the raptors at the dig in the highlands.",
            recapAlliance = "So there's an alchemist in Menethil Harbor, Caitlin Grassman, whose husband climbs mountains to pick her herbs. When a dig crew came through talking about towering grass in the highlands, he went to see it and stayed gone.\n\nDorin Songblade, the armorer in Lakeshire, had a brother up in those hills with diggers from Loch Modan. Dorin would have gone along if not for a pile of girdles to refit. His brother always wrote, and this time he hadn't.\n\nThe dig was in shambles after a run of accidents. Caitlin's husband was alive and very glad to see me. Dorin's brother was in a tent, dead. He had Dorin's face, and DLS carved into the stock of his gun.\n\nFor the Greenwarden I brought back the root core of a Highland Horror. Something ancient was stirring under those hills, Rethiel said, and the diggers should stop digging for their own good.",
            recapHorde = "Word reached Hammerfall that the Dragonmaw were planning a show in the Wetlands, the kind where a dragon is made to do as it's told. The Deathstalkers won't move on a rumor, so I met their agent in the hills above the camp. She asked if I was the courageous few and told me to keep my voice down.\n\nThe Dragonmaw at the dig thought they'd found a way back to power. I cleared out enough of them for the Deathstalkers to slip in and took a dispatch off one of their casters, which the agent snatched out of my hand. They were hoping to win over Rend. She called that a waste of effort and the news well worth the Dark Lady's time. I'm not to talk about the mission, so I'll stop there.\n\nBorstan in Orgrimmar got the raptor meat and wondered what those raptors had been eating to marble like that.",
            quests = {
                { id = 95737, name = "Seeking Caitlin", npc = "Llana", faction = "Alliance", optional = true, breadcrumbFor = 95647, gameVersions = { forever = true }, recap = "Llana, who sells reagents in Astranaar, swaps notes on rare plants with an alchemist in Menethil Harbor. The alchemist's last letter said her husband had joined a dig that was turning up signs of some long-lost grass, and then said nothing more about it. So I sailed to the Wetlands to ask. Caitlin Grassman guessed Llana was wondering about the seeds she'd been promised, but she had a bad feeling about that dig herself." },
                { id = 95647, name = "Lost in the Thicket Things", npc = "Caitlin Grassman", faction = "Alliance", instance = "dungeon", gameVersions = { forever = true } },
                { id = 95772, name = "Songblade Search", npc = "Dorin Songblade", faction = "Alliance", instance = "dungeon", parallel = true, gameVersions = { forever = true } },
                { id = 95646, name = "Horrors in the Highland", npc = "Rethiel the Greenwarden", faction = "Alliance", instance = "dungeon", parallel = true, gameVersions = { forever = true } },
                { id = 98815, name = "Highland Hides", npc = "James Halloran", faction = "Alliance", instance = "dungeon", optional = true, parallel = true, gameVersions = { forever = true }, recap = "James Halloran had heard about the ruins up in the highlands and the raptors living around them. The raptors could hide all they liked, as far as Halloran was concerned, so long as they had hides. I brought back four. They'll make good trim, I'm told, and I got to try on the tanner's stock and pick something in trade." },
                { id = 95663, name = "Dragonmaw Rumors", npc = "Zaruk", faction = "Horde", gameVersions = { forever = true } },
                { id = 95682, name = "Open the Maw", npc = "Deathstalker Agent", faction = "Horde", instance = "dungeon", gameVersions = { forever = true } },
                { id = 95697, name = "Changing Tastes", npc = "Borstan", faction = "Horde", instance = "dungeon", parallel = true, gameVersions = { forever = true } },
            },
        },
        {
            chapter = "Carried Home",
            faction = "Alliance",
            requiredLevel = 24,
            summary = "Ardin Grassman, at the far end of the dig, has something for you to carry home to his wife in Menethil Harbor. In Lakeshire, Dorin Songblade is waiting to hear about his brother.",
            recap = "Caitlin's husband needed a rest before he could walk out on his own, along the path I'd cleared. While he rested he braided some reeds into a heart and asked me to take it to her, and to tell her he'd be home soon. Caitlin held it close and started planning him a hearty supper.\n\nBefore I left the dig I covered Daewyn with his cloak. Then I went to Lakeshire and told Dorin. He blamed himself for staying behind. He'd been making gear for his brother as a surprise, and finished it after Daewyn had already gone. He couldn't bring himself to sell it or rework it, so he gave it to me.",
            quests = {
                { id = 95809, name = "Heartwoven", npc = "Ardin Grassman", faction = "Alliance", location = "Excavation Site: Wetlands", gameVersions = { forever = true } },
                { id = 95795, name = "Fallen in the Fen", npc = "Daewyn Songblade", faction = "Alliance", location = "Excavation Site: Wetlands", parallel = true, gameVersions = { forever = true } },
            },
        },
        {
            chapter = "Old Light",
            requiredLevel = 24,
            summaryAlliance = "Something at the far end of the dig is worth carrying out, if you can get to it. Prospector Whelgar's excavation site in the Wetlands is close by, and the prospector will want a close look at whatever you bring.",
            summaryHorde = "Something at the far end of the dig is worth carrying out, if you can get to it. The elders on Thunder Bluff's Elder Rise know old things better than anyone, and will want to see it.",
            recapAlliance = "The stone machine at the far end of the dig left a piece of itself behind when it went down. It was made of something I'd never handled and threw light around like a kaleidoscope, so I took it to Whelgar's camp outside. The prospector was impressed I'd lived and wanted a good look at it.\n\nThe marks on it looked like titan work. A find like that belonged in the Hall of Explorers, Whelgar said, with the finder's name written in the museum catalogue. High Explorer Magellas admired the keepers' marks on it and wrote my name down. There's a catalogue in Ironforge with me in it now, right next to a rock.",
            recapHorde = "The stone machine at the far end of the dig left a shard of itself behind when it went down. It threw light around like a kaleidoscope and felt older than anything I'd ever held, and the people who know about old things live on the Elder Rise in Thunder Bluff.\n\nBashana Runetotem called it fascinating, more than a carving, and sent me on to Muln Earthfury of the Earthen Ring, up on the Skywatcher Plateau. Muln said there were memories in its light, and that it had waited lifetimes to be understood. The Earthen Ring will look after it and study it, and pass on what it has to say once they can hear it.",
            quests = {
                -- Lost Relic Carry and Elder Knowledge start from the Titan Relic,
                -- which the Relic Guardian drops (a separate item for each faction).
                { id = 95810, name = "Lost Relic Carry", faction = "Alliance", location = "Excavation Site: Wetlands", gameVersions = { forever = true } },
                { id = 98824, name = "Prehistoric Prism", npc = "Prospector Whelgar", faction = "Alliance", gameVersions = { forever = true } },
                { id = 95664, name = "Elder Knowledge", faction = "Horde", location = "Excavation Site: Wetlands", gameVersions = { forever = true } },
                { id = 98823, name = "Earthen Echo", npc = "Bashana Runetotem", faction = "Horde", gameVersions = { forever = true } },
            },
        },
    },
}
