local addonName, SM = ...

-- =============================================================================
-- Classic: Blackfathom Villainy
-- The Argent Dawn's missing scout, the Earthen Ring at Zoram'gar, and the
-- Twilight's Hammer in the drowned temple on the Zoram Strand.
-- =============================================================================

SM.BlackfathomData = {
    title = "Blackfathom Villainy",
    description = "On Ashenvale's Zoram Strand, the ruins of an old night elf temple run down under the sea. The naga have moved into its flooded halls, and the rumors say they aren't alone down there.\n\nThe Argent Dawn wants to know what is going on in Blackfathom Deeps, and so does the Earthen Ring. Both could use someone willing to go in and look.",
    descriptionAlliance = "Rumors have reached Darnassus that the naga in Blackfathom Deeps, a drowned temple on the coast of Ashenvale, have joined forces with the Twilight's Hammer. The Argent Dawn sent a scout to look into it weeks ago and is still waiting for a report.\n\nStart with Dawnwatcher Shaedlass, at the Argent Dawn's embassy in Darnassus. Ironforge and Auberdine each have an errand down there as well.",
    descriptionHorde = "At Zoram'gar Outpost, on the coast of Ashenvale, Je'neu Sancrea of the Earthen Ring needs help. A little way up the strand lies Blackfathom Deeps, a drowned temple full of naga, and the naga have been prying crystals out of its walls. Je'neu would like to know why.\n\nTsunaman, at Sun Rock Retreat in the Stonetalon Mountains, can send you on your way.",
    zone = "Ashenvale / Darnassus / Stonetalon Mountains / Thunder Bluff / Blackfathom Deeps",
    zoneByFaction = {
        Alliance = "Darnassus / Darkshore / Ironforge / Ashenvale / Blackfathom Deeps",
        Horde = "Stonetalon Mountains / Ashenvale / Thunder Bluff / Blackfathom Deeps",
    },
    expansion = "Classic",
    recommendedLevel = { min = 17, max = 30 },
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.20, 0.38, 0.52 },
    icon = 136189, -- spell_shadow_ritualofsacrifice
    portraitDisplayID = 4939, -- Twilight Lord Kelris
    adventureGuideInstanceName = "Blackfathom Deeps",
    adventureCoverTexture = 131823, -- Blackfathom Deeps loading screen
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 6562, name = "Trouble in the Deeps", npc = "Tsunaman", location = "Sun Rock Retreat, Stonetalon Mountains", faction = "Horde" },
    startMapID = 65,
    startX = 0.4720,
    startY = 0.6420,

    -- The Deeps have no map of their own on Classic clients: quests inside point
    -- at the dungeon's outer ruins on the Zoram Strand (the middle of the
    -- Blackfathom naga's spawns there, from Wowhead's Classic data).
    npcLocations = {
        ["Tsunaman"] = { mapID = 65, x = 0.4720, y = 0.6420, location = "Sun Rock Retreat, Stonetalon Mountains" },
        ["Je'neu Sancrea"] = { mapID = 63, x = 0.1160, y = 0.3420, location = "Zoram'gar Outpost, Ashenvale" },
        ["Dawnwatcher Shaedlass"] = { mapID = 89, x = 0.5540, y = 0.2440, location = "the Argent Dawn's embassy, Craftsmen's Terrace, Darnassus" },
        ["Argent Guard Manados"] = { mapID = 89, x = 0.5520, y = 0.2340, location = "the Argent Dawn's embassy, Craftsmen's Terrace, Darnassus" },
        ["Dawnwatcher Selgorm"] = { mapID = 89, x = 0.5580, y = 0.2420, location = "the Argent Dawn's embassy, Craftsmen's Terrace, Darnassus" },
        ["Gershala Nightwhisper"] = { mapID = 62, x = 0.3840, y = 0.4300, location = "Auberdine, Darkshore" },
        ["Gerrig Bonegrip"] = { mapID = 87, x = 0.5040, y = 0.0600, location = "the Forlorn Cavern, Ironforge" },
        ["Argent Guard Thaelrid"] = { mapID = 63, x = 0.1455, y = 0.1089, location = "inside Blackfathom Deeps, Zoram Strand, Ashenvale" },
        ["Bashana Runetotem"] = { mapID = 88, x = 0.7080, y = 0.3340, location = "Elder Rise, Thunder Bluff" },
    },

    npcDisplayIDs = {
        -- Quest givers' models from the cmangos Classic database.
        ["Tsunaman"] = 5562,
        ["Je'neu Sancrea"] = 12953,
        ["Dawnwatcher Shaedlass"] = 5225,
        ["Argent Guard Manados"] = 5084,
        ["Dawnwatcher Selgorm"] = 5226,
        ["Gershala Nightwhisper"] = 8229,
        ["Gerrig Bonegrip"] = 3599,
        ["Argent Guard Thaelrid"] = 4946,
        ["Bashana Runetotem"] = 8356,
    },

    chapterDisplayIDs = {
        ["Trouble in the Deeps"] = 5562, -- Tsunaman
        ["Blackfathom Deeps"] = 4946, -- Argent Guard Thaelrid
    },

    chapterIcons = {
        ["Trouble in the Deeps"] = 135861, -- spell_frost_summonwaterelemental
        ["Blackfathom Deeps"] = 134131, -- inv_misc_gem_sapphire_01
    },

    chapters = {
        {
            chapter = "Trouble in the Deeps",
            faction = "Horde",
            requiredLevel = 17,
            summary = "Tsunaman, at Sun Rock Retreat in the Stonetalon Mountains, has word that Je'neu Sancrea of the Earthen Ring needs help. Je'neu is at Zoram'gar Outpost, far off on the western shore of Ashenvale, where the Horde isn't especially welcome.",
            recap = "Tsunaman, up at Sun Rock Retreat, had word that Je'neu Sancrea of the Earthen Ring needed help on the coast of Ashenvale, and gave me directions to match. Through Windshear Crag or north through the Barrens, then west across the forest until it runs out at the sea. I was also told to be careful, which for the Horde in Ashenvale goes without saying.\n\nZoram'gar Outpost is a small camp on the Zoram Strand. Je'neu was there and pleased that Tsunaman had sent help. We had matters to discuss, he said, and most of them were up the beach in Blackfathom Deeps.",
            quests = {
                { id = 6562, name = "Trouble in the Deeps", npc = "Tsunaman", breadcrumbFor = 6563 },
            },
        },
        {
            chapter = "Blackfathom Deeps",
            requiredLevel = 18,
            summaryAlliance = "Dawnwatcher Shaedlass, at the Argent Dawn's embassy in Darnassus, sent a scout to Blackfathom Deeps weeks ago and is still waiting for a report. Argent Guard Manados, at the same embassy, wants the Twilight's Hammer down there paid a visit.",
            summaryHorde = "Je'neu Sancrea, at Zoram'gar Outpost, has heard that the naga of Blackfathom Deeps are prying sapphires off the walls of its first tunnels, and would rather they stopped. The Deeps lie a short way north along the Zoram Strand.",
            recapAlliance = "The Argent Dawn keeps an embassy in Darnassus, and one of its Dawnwatchers, Shaedlass, had mislaid a scout. Thaelrid had gone to Blackfathom Deeps weeks before to look into the naga and the Twilight's Hammer and hadn't reported back. A guard standing nearby asked me to bring back some cultists' pendants while I was at it.\n\nI found Thaelrid far inside, alive and out of strength. The place had been a temple of Elune, Thaelrid said, until the corruption of an Old God seeped up into its moonwell and the Old God's servant rose out of the water. Now the cult and the naga held it together, and the cult's leader, Kelris, was sacrificing innocents to that servant for power.\n\nI took the head of Kelris back to Darnassus. The Argent Dawn had long since put him down as dead or missing, and I'd made half of that true.",
            recapHorde = "Je'neu Sancrea started me off just inside the Deeps, where the naga had been prying sapphires off the cave walls. I pried them off first. Je'neu could feel water spirits clinging to them, and wanted a fathom core from the flooded ruins too.\n\nIn the Deeps I also came by a damp note in very poor handwriting. All the priestesses were to bring the crystals to whoever wrote it, and with their power, one day, the world would return to the rule of the Old Gods. The note gave Je'neu a name to go with the trouble, Lorgus Jett of the Twilight's Hammer. I found Lorgus in the Deeps, and that was the end of that plan.\n\nFurther in, an Argent Dawn guard who could barely stand asked me to take the head of the cult's leader, Kelris, to Thunder Bluff. I did, and the tauren there were thoroughly disgusted with him.",
            quests = {
                { id = 1198, name = "In Search of Thaelrid", npc = "Dawnwatcher Shaedlass", faction = "Alliance", instance = "dungeon" },
                { id = 1200, name = "Blackfathom Villainy", npc = "Argent Guard Thaelrid", faction = "Alliance" },
                { id = 1199, name = "Twilight Falls", npc = "Argent Guard Manados", faction = "Alliance", parallel = true },
                { id = 971, name = "Knowledge in the Deeps", npc = "Gerrig Bonegrip", faction = "Alliance", optional = true, parallel = true, recap = "Gerrig Bonegrip, down in the Forlorn Cavern in Ironforge, collects lore. Old lore, the sort that opens doorways and can wake Those Who Sleep. Gerrig had heard the Lorgalis Manuscript was lying at the bottom of Blackfathom Deeps and promised not to forget me for it, not even after the end days. I brought it up. Gerrig was overjoyed and is having copies made for all the brothers and sisters, whoever they are." },
                { id = 1275, name = "Researching the Corruption", npc = "Gershala Nightwhisper", faction = "Alliance", optional = true, parallel = true, recap = "Gershala Nightwhisper, in Auberdine, is worried about the blood elves and their demon magic, and wanted to know what the same sort of thing had already done to the naga and the satyrs. Blackfathom Deeps has plenty of both, so I came back with eight corrupted brain stems. Gershala thanked me for my selflessness and got straight to work. I left before the work got interesting." },
                { id = 78916, name = "The Heart of the Void", npc = "Blackfathom Pearl", faction = "Alliance", optional = true, parallel = true, mapID = 63, x = 0.1455, y = 0.1089, location = "the depths of Blackfathom Deeps, Ashenvale", gameVersions = { forever = true }, recap = "Past Kelris, at the far end of the Deeps, waited Aku'mai, the servant of the Old Gods. When it died it left a pearl behind, and Dawnwatcher Selgorm in Darnassus called the kill the stuff of real heroes. The pearl went off to be studied at once, for whatever it could tell about the Void." },
                { id = 6563, name = "The Essence of Aku'Mai", npc = "Je'neu Sancrea", faction = "Horde" },
                { id = 6921, name = "Amongst the Ruins", npc = "Je'neu Sancrea", faction = "Horde", parallel = true },
                { id = 6564, name = "Allegiance to the Old Gods", npc = "Damp Note", faction = "Horde", parallel = true, mapID = 63, x = 0.1455, y = 0.1089, location = "Blackfathom Deeps, Ashenvale" },
                { id = 6565, name = "Allegiance to the Old Gods", npc = "Je'neu Sancrea", faction = "Horde" },
                { id = 6561, name = "Blackfathom Villainy", npc = "Argent Guard Thaelrid", faction = "Horde", parallel = true },
                { id = 6922, altIds = { 909 }, name = "Baron Aquanis", npc = "Strange Water Globe", faction = "Horde", optional = true, parallel = true, mapID = 63, x = 0.1455, y = 0.1089, location = "Blackfathom Deeps, Ashenvale", recap = "Baron Aquanis, a water elemental in the Deeps, left a strange globe behind when it fell. Foul water sloshed about inside, and nothing I did would so much as scratch it. Je'neu Sancrea had long suspected the Baron of being corrupted, and said the globe would show by what, and how. I came away with the Earthen Ring's warmest regards and something more useful besides." },
                { id = 78917, name = "The Heart of the Void", npc = "Blackfathom Pearl", faction = "Horde", optional = true, parallel = true, mapID = 63, x = 0.1455, y = 0.1089, location = "the depths of Blackfathom Deeps, Ashenvale", gameVersions = { forever = true }, recap = "Past Kelris, at the far end of the Deeps, waited Aku'mai, the servant of the Old Gods. It left a pearl behind when it died, and Bashana Runetotem in Thunder Bluff called that a mighty service to all of Kalimdor. The pearl was to be studied at once, for what it might say about the Void, and I was sent off to walk with the Earth Mother." },
            },
        },
    },
}
