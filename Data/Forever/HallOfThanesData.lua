local addonName, SM = ...

-- =============================================================================
-- WoW Forever: An Ancient Grudge
-- A Wildhammer's campfire above Gol'Bolar Quarry, Dark Iron spies in Dun
-- Morogh, and the Hall of Thanes beneath Ironforge's High Seat.
-- =============================================================================
--
-- Chain order and givers, from warcraft.wiki.gg's WoW Forever quest pages and
-- Warcraft Tavern's Hall of Thanes guides: A Visitor to Dun Morogh (96408) is
-- an optional breadcrumb to Earthseer Farsen, whose Farsen's Watch (96392) >
-- Nip 'Em in the Bud (96390) > Underground Map (96391, from the Dark Iron Map
-- a spy drops) > Old Ironforge Incursion (96393, turned in to King Magni).
-- Afadra Dunwall and Thom Filch wait on the way down to the instance, the
-- Ghostly Attendant inside it, and The Treaty of Understanding (98423) starts
-- at a tablet in the last room. Every quest is Alliance except An Ancient
-- Grudge, which the Horde can take too if they fight their way into Ironforge;
-- no Horde way in is known, so the story is the Alliance's.
-- Side branches that can be played alongside the main line are `parallel`.

SM.ForeverHallOfThanesData = {
    title = "An Ancient Grudge",
    description = "Beldin Steelgrill in Kharanos has heard about a campfire on the hills above Gol'Bolar Quarry, high up where it looks down over the whole quarry. It's probably nothing, but Beldin would like someone to go up and see who's sitting by it.\n\nFrom there the trail leads back to Ironforge and down beneath it, past the High Seat to the Hall of Thanes, a part of the city most visitors never see. Take a few friends along for that.",
    zone = "Dun Morogh / Ironforge",
    faction = "Alliance",
    expansion = "Classic",
    recommendedLevel = { min = 13, max = 18 },
    requiredLevel = 9,
    gameVersions = { forever = true },
    achievements = {},
    color = { 0.50, 0.54, 0.62 },
    icon = "Interface\\Icons\\INV_Misc_Head_Dwarf_01",  -- Durgen Dirgehammer's Head's icon
    adventureCoverTexture = 7963781,  -- WoW Forever's Old Ironforge loading screen
    adventureCoverTexCoords = { 0, 1, 0.1592, 0.8408 },  -- the picture, between its transparent bands
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 96408, name = "A Visitor to Dun Morogh", npc = "Beldin Steelgrill", location = "Steelgrill's Depot, Kharanos, Dun Morogh", gameVersions = { forever = true } },
    startMapID = 1426,
    startX = 0.5040,
    startY = 0.4900,

    npcLocations = {
        ["Beldin Steelgrill"] = { mapID = 1426, x = 0.5040, y = 0.4900, location = "Steelgrill's Depot, Kharanos, Dun Morogh" },
        ["Earthseer Farsen"] = { mapID = 1426, x = 0.6480, y = 0.5840, location = "the Tundrid Hills above Gol'Bolar Quarry, Dun Morogh" },
        ["Afadra Dunwall"] = { mapID = 1455, x = 0.3360, y = 0.4860, location = "Old Ironforge, beneath the High Seat, Ironforge" },
        ["Thom Filch"] = { mapID = 1455, x = 0.3240, y = 0.4440, location = "the bridge before the Hall of Thanes, Old Ironforge, Ironforge" },
        ["King Magni Bronzebeard"] = { mapID = 1455, x = 0.3940, y = 0.5580, location = "the High Seat, Ironforge" },
    },

    npcDisplayIDs = {
        -- Quest givers' models from the cmangos Classic database.
        ["Beldin Steelgrill"] = 3389,
        ["King Magni Bronzebeard"] = 3597,
        -- Quest givers' models from Wowhead's WoW Forever data.
        ["Earthseer Farsen"] = 144321,
        ["Afadra Dunwall"] = 144322,
        ["Thom Filch"] = 144349,
        ["Ghostly Attendant"] = 144348,
    },

    chapterIcons = {
        ["Farsen's Watch"] = "Interface\\Icons\\INV_Misc_Map06",  -- the Dark Iron Map's icon
        ["The Hall of Thanes"] = "Interface\\Icons\\INV_Misc_Head_Dwarf_01",
    },

    chapters = {
        {
            chapter = "Farsen's Watch",
            summary = "Beldin Steelgrill at Steelgrill's Depot in Kharanos has heard about a fire burning on the high ground above Gol'Bolar Quarry, to the east. It's probably a harmless camp, and Beldin would still like someone to climb up and say hello, one way or the other.",
            recap = "The camp on the hill above Gol'Bolar Quarry belonged to Earthseer Farsen, a Wildhammer visiting from Aerie Peak, who greeted me like an old friend. Farsen had noticed Dark Irons creeping around Dun Morogh and, instead of explaining, lent me far sight. I floated over the hills for a while looking down at spies and troggs. There were more of them, Farsen said, than you can see from the sky.\n\nSo I went east to Ironband's Compound and dealt with the spies. One carried a map of tunnels that all met under Ironforge, marked in Dark Iron runes I couldn't read. Then the wind spoke to me in a dwarf's voice and said Farsen needed to see it.\n\nI took it back up the hill. The spies had been scouts, according to the earthseer, and the Dark Irons meant to break into the city's vaults. I was told to hurry.",
            quests = {
                { id = 96408, name = "A Visitor to Dun Morogh", npc = "Beldin Steelgrill", optional = true, breadcrumbFor = 96392, recapAfter = 0, gameVersions = { forever = true }, recap = "Beldin Steelgrill in Kharanos had heard from a mountaineer about a fire up on the hills above Gol'Bolar Quarry. Probably nothing, Beldin said. If the campers were friendly, no harm done, and if they weren't, I'd know how to handle it." },
                { id = 96392, name = "Farsen's Watch", npc = "Earthseer Farsen", gameVersions = { forever = true } },
                { id = 96390, name = "Nip 'Em in the Bud", npc = "Earthseer Farsen", gameVersions = { forever = true } },
                -- Starts from the Dark Iron Map, which a Dark Iron Spy drops.
                { id = 96391, name = "Underground Map", mapID = 1426, x = 0.7670, y = 0.6070, location = "the Dark Iron Spies, Ironband's Compound, Dun Morogh", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "The Hall of Thanes",
            summary = "Earthseer Farsen is sure the Dark Irons are after Ironforge's vaults, and their map's tunnels meet in the Hall of Thanes, beneath the High Seat. Take friends and get there first. King Magni, an old friend of Farsen's, will want a report.",
            recap = "Off the High Seat, past a lot of cobwebs and a fair bit of lava, is the Hall of Thanes, where Ironforge keeps its old lords. Lorekeeper Afadra Dunwall had work to do down there and no patience for ghosts. Something had woken the dead, and I was to settle them.\n\nMost of them were just angry. One was polite. A ghostly attendant begged me to help Faldrim Anvilmar, the thane, who couldn't rest for an old grudge. Faldrim had no interest in resting. My friends and I insisted.\n\nI brought the Dark Iron commander's head up to King Magni, with the earthseer's regards, along with a tablet I'd found behind a vault door. It was the treaty that ended the War of the Three Hammers. Magni pointed out that the Bronzebeards and the Wildhammers both signed it, and the Dark Irons never did.",
            quests = {
                { id = 96393, name = "Old Ironforge Incursion", npc = "Earthseer Farsen", instance = "dungeon", gameVersions = { forever = true } },
                { id = 96394, name = "The Restless Dead", npc = "Afadra Dunwall", instance = "dungeon", parallel = true, gameVersions = { forever = true } },
                { id = 96403, name = "Important Heirlooms", npc = "Thom Filch", instance = "dungeon", optional = true, parallel = true, gameVersions = { forever = true }, recap = "Thom Filch, a gnome by the bridge, claimed to have been patrolling the vaults when the Dark Irons came up from below in mole machines and left valuables lying about. Important cultural heirlooms, Thom called them, rubbing both hands together, and every one would be catalogued and returned to its proper place. I collected eight. Thom paid as promised, and afterward I found I was better thought of in Gadgetzan, which is a long way from Ironforge." },
                { id = 96395, name = "An Ancient Grudge", npc = "Ghostly Attendant", location = "the Hall of Thanes, Ironforge", instance = "dungeon", parallel = true, gameVersions = { forever = true } },
                -- Starts at a tablet behind a vault door in the Reliquary of Kings, the last room.
                { id = 98423, name = "The Treaty of Understanding", location = "the Reliquary of Kings, the Hall of Thanes", instance = "dungeon", parallel = true, gameVersions = { forever = true } },
            },
        },
    },
}
