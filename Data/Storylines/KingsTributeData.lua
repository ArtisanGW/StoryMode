local addonName, SM = ...

-- =============================================================================
-- Classic: A King's Tribute
-- Sully Balloo's hidden letter, Sara Balloo's plea, and Magni's memorial.
-- =============================================================================

SM.KingsTributeData = {
    title = "A King's Tribute",
    description = "Under the broken Thandol Span, a dwarf's remains lie where few travelers think to look. Among them is a letter that never reached the woman waiting in Ironforge.\n\nCarry Sully Balloo's words home and let Sara Balloo decide what should be done with them. Some duties begin after the battle is already over.",
    zone = "Arathi Highlands / Ironforge / Hillsbrad Foothills",
    expansion = "Classic",
    recommendedLevel = { min = 26, max = 31 },
    faction = "Alliance",
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.70, 0.52, 0.28 },
    icon = 133471,
    portraitDisplayID = 1670,
    adventureCoverTexture = 131824, -- Blackrock Depths: closest Classic dwarven stonework loading screen
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 637, name = "Sully Balloo's Letter", npc = "Waterlogged Envelope", location = "beneath the Thandol Span, Arathi Highlands" },
    startMapID = 14,
    startX = 0.4430,
    startY = 0.9290,

    npcLocations = {
        ["Waterlogged Envelope"] = { mapID = 14, x = 0.4430, y = 0.9290, location = "beneath the Thandol Span, Arathi Highlands" },
        ["Sara Balloo"] = { mapID = 87, x = 0.6380, y = 0.6760, location = "the Military Ward, Ironforge" },
        ["King Magni Bronzebeard"] = { mapID = 87, x = 0.3900, y = 0.5600, location = "the High Seat, Ironforge" },
        ["Grand Mason Marblesten"] = { mapID = 87, x = 0.3680, y = 0.8770, location = "near the Ironforge Visitor's Center, Ironforge" },
    },

    npcDisplayIDs = {
        ["Sara Balloo"] = 1670,
        ["King Magni Bronzebeard"] = 3597,
        ["Grand Mason Marblesten"] = 5410,
    },

    chapterDisplayIDs = {
        ["The Waterlogged Letter"] = 1670,
        ["The Memorial"] = 3597,
    },

    chapterIcons = {
        ["The Waterlogged Letter"] = 133471,
        ["The Memorial"] = 133739,
    },

    chapters = {
        {
            chapter = "The Waterlogged Letter",
            summary = "Under the broken Thandol Span, where few travelers think to look, lie a dwarf's remains and a waterlogged envelope. It's addressed to Sara Balloo in Ironforge. It never got there.",
            recap = "Under the Thandol Span, where the bridge is broken, there's a stretch of riverbed nobody bothers to look at. I looked. There was what was left of a dwarf down there, and a waterlogged envelope.\n\nIt was a letter from Sully Balloo to Sara Balloo in Ironforge. Not orders. Not a map to anything. A man writing home to his wife, saying goodbye in case he didn't get another chance. He didn't.\n\nSo I carried it to Ironforge and found Sara. You don't want to be the one handing over a letter like that, but somebody has to. Sara read it, wrote a note of her own and asked me to take it to King Magni. She wanted her king to know what Sully had given. So up to the High Seat I went.",
            quests = {
                { id = 637, name = "Sully Balloo's Letter", npc = "Waterlogged Envelope" },
                { id = 683, name = "Sara Balloo's Plea", npc = "Sara Balloo" },
            },
        },
        {
            chapter = "The Memorial",
            summary = "Sara Balloo's plea is in King Magni's hands now, up on the High Seat in Ironforge. The king has read it and made up his mind. It involves the Grand Mason, and it involves you.",
            recap = "Kings get a lot of letters. Magni read Sara's and decided Sully Balloo would have a memorial, and that the Grand Mason would build it.\n\nThe Grand Mason took one look at the commission and decided only the best stone would do: Alterac Granite, five pieces of it. Long way to go for rocks. Very good rocks, I'm told. I carried every one of them back to Ironforge and felt each of them in my shoulders the next morning.\n\nThen I reported back to the king, and Sully got his memorial. Kings hand out a lot of things, titles and medals and land. A stone for one soldier nobody else was out looking for isn't the grandest of them. I liked it best.",
            quests = {
                { id = 686, name = "A King's Tribute", displayName = "Magni's Commission", npc = "King Magni Bronzebeard" },
                { id = 689, name = "A King's Tribute", displayName = "Alterac Granite", npc = "Grand Mason Marblesten" },
                { id = 700, name = "A King's Tribute", displayName = "The Memorial", npc = "Grand Mason Marblesten" },
            },
        },
    },
}
