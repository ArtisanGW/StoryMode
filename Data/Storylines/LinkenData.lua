local addonName, SM = ...

-- =============================================================================
-- Classic: Linken's Adventure
-- A lost gnome, a broken sword, and Azeroth's longest wink at Hyrule.
-- =============================================================================

SM.LinkenData = {
    title = "Linken's Adventure",
    description = "A battered raft in Un'Goro holds a few odd belongings: a compass, a map, a key, and a photograph. No one stands nearby to explain them. Only the crater, the wreckage, and the sense that someone lost more than supplies.\n\nFollow the clues from Marshal's Refuge and help piece together what happened to their owner. The trail is strange, old-fashioned, and not eager to explain itself.",
    zone = "Un'Goro Crater / Tanaris / Felwood / Winterspring",
    expansion = "Classic",
    recommendedLevel = { min = 47, max = 56 },
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.30, 0.66, 0.34 },
    icon = 135346,
    portraitDisplayID = 8012,
    adventureCoverTexture = 131863, -- Raid loading screen: shared Classic/TBC adventure cover
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 3844, name = "It's a Secret to Everybody", npc = "A Wrecked Raft", location = "the Marshlands, Un'Goro Crater" },
    startMapID = 78,
    startX = 0.6300,
    startY = 0.6800,

    npcLocations = {
        ["A Wrecked Raft"] = { mapID = 78, x = 0.6300, y = 0.6800, location = "the Marshlands, Un'Goro Crater" },
        ["A Small Pack"] = { mapID = 78, x = 0.6300, y = 0.6900, location = "beside the wrecked raft, Un'Goro Crater" },
        ["Linken"] = { mapID = 78, x = 0.4450, y = 0.0810, location = "Marshal's Refuge, Un'Goro Crater" },
        ["J.D. Collie"] = { mapID = 78, x = 0.4192, y = 0.0270, location = "Marshal's Refuge, Un'Goro Crater" },
        ["Donova Snowden"] = { mapID = 83, x = 0.3100, y = 0.4500, location = "Frostfire Hot Springs, Winterspring" },
        ["Gaeriyan"] = { mapID = 71, x = 0.5300, y = 0.2900, location = "Gadgetzan, Tanaris" },
        ["Eridan Bluewind"] = { mapID = 77, x = 0.5100, y = 0.8200, location = "Emerald Sanctuary, Felwood" },
        ["Aquementas"] = { mapID = 78, x = 0.7100, y = 0.7600, location = "the lakes east of Fire Plume Ridge, Un'Goro Crater" },
        ["Blazerunner"] = { mapID = 78, x = 0.4900, y = 0.5100, location = "Fire Plume Ridge, Un'Goro Crater" },
        ["Gregan Brewspewer"] = { mapID = 69, x = 0.4512, y = 0.2557, location = "the Twin Colossals, Feralas" },
    },

    npcDisplayIDs = {
        ["Linken"] = 8012,
        ["Donova Snowden"] = 8949,
        ["Gaeriyan"] = 8717,
        ["Eridan Bluewind"] = 9136,
        ["Aquementas"] = 5564,
        ["Blazerunner"] = 1204,
        -- Quest givers' models from the cmangos Classic database.
        ["J.D. Collie"] = 8478,
        ["Gregan Brewspewer"] = 6995,
    },

    chapterDisplayIDs = {
        ["A Secret to Everybody"] = 8012,
        ["Linken's Memory"] = 9136,
        ["Aquementas"] = 5564,
        ["It's Dangerous to Go Alone"] = 1204,
    },

    chapterIcons = {
        ["A Secret to Everybody"] = 134269,
        ["Linken's Memory"] = 133738,
        ["Aquementas"] = 135861,
        ["It's Dangerous to Go Alone"] = 135346,
    },

    chapters = {
        {
            chapter = "A Secret to Everybody",
            summary = "There's a wrecked raft in a pond in Un'Goro Crater, out in the southeastern marshes. Nobody aboard, nobody waiting nearby. Poke around in the water and you might learn whose it was.",
            recap = "There's a wrecked raft in a pond in Un'Goro, and if you poke around it you'll find a small pack. Inside: a large compass, a curled map, a key with a lion's head on it, and a photograph of a gnome dressed in green.\n\nWell. Marshal's Refuge isn't far, and there's a gnome there called Linken. You can see where this is going.\n\nLinken knew the things were his. Linken did not know much else. Where he'd been, what the key opened, why he'd been rafting through a crater full of dinosaurs: all gone. What he did have was a sword, and a name to take it to. Donova Snowden, in Winterspring.\n\nThe far end of Kalimdor, naturally. I've noticed that about lost things. They're never lost anywhere close.",
            quests = {
                { id = 3844, name = "It's a Secret to Everybody", npc = "A Wrecked Raft" },
                { id = 3845, name = "It's a Secret to Everybody", npc = "A Small Pack" },
                { id = 3908, name = "It's a Secret to Everybody", npc = "Linken" },
            },
        },
        {
            chapter = "Linken's Memory",
            summary = "Donova Snowden at Frostfire Hot Springs in Winterspring has an idea about Linken's sword, and it needs a rare brew, the Videre Elixir. Gregan Brewspewer, in northern Feralas, knows how to come by one.",
            recap = "Donova Snowden took one look at Linken's sword and decided the answer was in a graveyard. Getting there was the strange part.\n\nIt took a trip to Feralas for something called the Videre Elixir, and then the graveyard outside Gadgetzan, where Donova's instructions were very clear. Drink the elixir by the gravestone. I drank it. I died.\n\nThat was the plan, mind you. As a ghost I could meet Gaeriyan, who told me which grave to look at once I had a body again. So I walked back to my body, got up, found the gravestone, and came away with a better sword than the one I'd brought.\n\nFirst time I ever died on instructions. Strangely restful.",
            quests = {
                { id = 3909, name = "The Videre Elixir", npc = "Donova Snowden" },
                -- Gregan makes the elixir; his quest only opens while Donova's is in the log.
                { id = 4041, name = "The Videre Elixir", npc = "Gregan Brewspewer", parallel = true },
                { id = 3912, name = "Meet at the Grave", npc = "Donova Snowden" },
                { id = 3913, name = "A Grave Situation", npc = "Gaeriyan", mapID = 71, x = 0.5300, y = 0.2900, location = "the grave outside Gadgetzan, Tanaris" },
                { id = 3914, name = "Linken's Sword", npc = "A Conspicuous Gravestone", mapID = 71, x = 0.5300, y = 0.2900, location = "the grave outside Gadgetzan, Tanaris" },
                { id = 3941, name = "A Gnome's Assistance", npc = "Linken" },
                { id = 3942, name = "Linken's Memory", npc = "J.D. Collie" },
            },
        },
        {
            chapter = "Aquementas",
            summary = "Eridan Bluewind, at the Emerald Sanctuary in southern Felwood, has the next piece of Linken's story. It starts with a silver heart, made from silvery claws and an irontree heart. Felwood's wildlife is still using both.",
            recap = "Eridan Bluewind, up in Felwood, knew what Linken had been trying to make: a silver heart.\n\nThat took a fistful of silvery claws and an irontree heart, which meant arguing with a good deal of local wildlife, and then a book. The Book of Aquor. Carry the lot down to Tanaris, open the book, and out comes Aquementas, a water elemental, standing in the middle of the desert.\n\nAquementas did not care to be summoned. Once we'd settled that, the claws and the heart had become the Silver Totem of Aquementas, and I carried it back to Linken.\n\nA water elemental, called up in the driest place I know, to make a totem for a gnome who couldn't remember where he'd been. You couldn't make that up. I didn't.",
            quests = {
                { id = 4084, name = "Silver Heart", npc = "Eridan Bluewind" },
                { id = 4005, name = "Aquementas", npc = "Eridan Bluewind" },
                { id = 3961, name = "Linken's Adventure", npc = "J.D. Collie" },
            },
        },
        {
            chapter = "It's Dangerous to Go Alone",
            summary = "Linken, back at Marshal's Refuge, has one last job, and it's what the Silver Totem is for. On Fire Plume Ridge, Blazerunner guards a cave behind an aura nothing gets through. Nearly nothing. It's dangerous to go alone.",
            recap = "Linken had one more job, and it was the reason for the totem. Fire Plume Ridge, just south of the Refuge. That's where Blazerunner lives, wrapped in a protective aura nothing gets through. Nothing except a silver totem made out of a water elemental.\n\nSomebody once said it's dangerous to go alone. I went anyway. I held up the totem, the aura went out like a candle in the rain, and Blazerunner turned out to be a lot less impressive without it. In the cave beyond sat the Golden Flame, and I carried it back to Linken.\n\nHe still doesn't remember everything. But he has his sword, his flame and an adventure to show for it. I have a story nobody believes. Tell it in any tavern and watch them smile at you like you've had one too many.",
            quests = {
                { id = 3962, name = "It's Dangerous to Go Alone", npc = "Linken" },
            },
        },
    },
}
