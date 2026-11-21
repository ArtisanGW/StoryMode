local addonName, SM = ...

-- =============================================================================
-- Classic: The Mithril Order
-- Blacksmithing's quests: Orokk Omosh's barbaric iron (Horde), Galvan the
-- Ancient and his Mithril Order, then armorsmith or weaponsmith.
-- =============================================================================
--
-- Only characters who know Blacksmithing see this story.
--
-- Order. The Horde reach McGavan through Aturk the Anvil and Ox, the Alliance
-- through Hank the Hammer; The Mithril Order (2760) is shared from there.
-- Galvan's three lessons each follow 2760 and teach one ornate mithril piece
-- (pants, gloves, shoulder), and Trenton's three trades each need one of those
-- pieces, so the lessons come before Galvan's Finest Pupil (2764, which
-- classicdb lists after Smelt On, Smelt Off) and the trades after it. Did You
-- Lose This? (3321) follows the three trades, and cmangos makes Expert
-- Blacksmith! (2765) follow 3321, so Galvan's signet closes the chain. Every
-- quest on the way is needed for the next, so none is optional.
--
-- Armorsmith and Weaponsmith are a choice: finishing one bars the other.
-- Armorsmith lines hide once a Weaponsmith quest is done (5284, its Forever
-- copy 82662, 5302), Weaponsmith lines once an Armorsmith quest is done (5283,
-- 5301); before the choice both show. The three masters in Everlook teach
-- weaponsmiths only, one weapon each, and taking one bars the other two: each
-- master's quest hides once an Armorsmith quest or another master's quest is
-- done. They share the specialization's chapter, so an armorsmith's chapter
-- still has a quest in it.

SM.ClassicBlacksmithingData = {
    title = "The Mithril Order",
    description = "Galvan the Ancient, a dwarf smith of the old school, left Booty Bay long ago, but the order he belongs to still keeps members in town, looking for a successor.\n\nYour trainer can point you their way, south into the jungles of Stranglethorn, and in time you'll have to choose between armor and weapons.",
    descriptionAlliance = "Years ago a dwarf named Galvan trained Hank the Hammer, then left for Booty Bay, and Hank promised to pass the teaching on. Hank still keeps that promise, in Stormwind's Dwarven District.\n\nFrom there the road runs south to Stranglethorn and Gadgetzan before it brings you back to the Great Forge in Ironforge, where armorsmiths and weaponsmiths each want you for their own.",
    descriptionHorde = "Orokk Omosh, in Orgrimmar's Valley of Honor, is the last of twenty generations of Omosh smiths and wants the family recipes to outlive him. Aturk the Anvil, a few steps away, has older ways to teach.\n\nFrom there the road runs south to Stranglethorn and Gadgetzan before it brings you back to the Valley of Honor, where armorsmiths and weaponsmiths each want you for their own.",
    zone = "Stranglethorn Vale / Tanaris / Winterspring",
    zoneByFaction = {
        Alliance = "Stormwind / Stranglethorn Vale / Tanaris / Ironforge / Winterspring",
        Horde = "Orgrimmar / Stranglethorn Vale / Tanaris / Winterspring",
    },
    expansion = "Classic",
    profession = 164,  -- Blacksmithing
    recommendedLevel = { min = 32, max = 60 },
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.72, 0.46, 0.24 },
    icon = "Interface\\Icons\\Trade_BlackSmithing",
    portraitDisplayID = 6846,  -- Galvan the Ancient, at the heart of the Mithril Order
    adventureCoverTexture = 131886,  -- Zul'Gurub loading screen: Galvan the Ancient lives just outside it, in Stranglethorn Vale
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 2758, name = "The Origins of Smithing", npc = "Hank the Hammer", faction = "Alliance", location = "the Dwarven District, Stormwind" },
    startMapID = 84,
    startX = 0.5600,
    startY = 0.1600,

    npcLocations = {
        ["Orokk Omosh"] = { mapID = 85, x = 0.7940, y = 0.2240, location = "the Valley of Honor, Orgrimmar" },
        ["Aturk the Anvil"] = { mapID = 85, x = 0.8040, y = 0.2320, location = "the Valley of Honor, Orgrimmar" },
        ["Ox"] = { mapID = 85, x = 0.8040, y = 0.2360, location = "the Valley of Honor, Orgrimmar" },
        ["Hank the Hammer"] = { mapID = 84, x = 0.5600, y = 0.1600, location = "the Dwarven District, Stormwind" },
        ["McGavan"] = { mapID = 50, x = 0.2880, y = 0.7540, location = "Booty Bay, Stranglethorn Vale" },
        ["Galvan the Ancient"] = { mapID = 50, x = 0.5040, y = 0.2040, location = "between Zul'Gurub and the Mosh'Ogg Ogre Mound, Stranglethorn Vale" },
        ["Trenton Lighthammer"] = { mapID = 71, x = 0.5140, y = 0.2860, location = "Gadgetzan, Tanaris" },
        ["Grumnus Steelshaper"] = { mapID = 87, x = 0.4940, y = 0.4300, location = "the Great Forge, Ironforge" },
        ["Ironus Coldsteel"] = { mapID = 87, x = 0.4940, y = 0.4480, location = "the Great Forge, Ironforge" },
        ["Okothos Ironrager"] = { mapID = 85, x = 0.7980, y = 0.2340, location = "the Valley of Honor, Orgrimmar" },
        ["Borgosh Corebender"] = { mapID = 85, x = 0.7940, y = 0.2340, location = "the Valley of Honor, Orgrimmar" },
        ["Lilith the Lithe"] = { mapID = 83, x = 0.6120, y = 0.3720, location = "Everlook, Winterspring" },
        ["Kilram"] = { mapID = 83, x = 0.6120, y = 0.3700, location = "Everlook, Winterspring" },
        ["Seril Scourgebane"] = { mapID = 83, x = 0.6120, y = 0.3720, location = "Everlook, Winterspring" },
    },

    npcDisplayIDs = {
        -- Quest givers' models from the cmangos Classic database.
        ["Orokk Omosh"] = 6873,
        ["Aturk the Anvil"] = 6843,
        ["Ox"] = 6854,
        ["McGavan"] = 6853,
        ["Hank the Hammer"] = 6844,
        ["Galvan the Ancient"] = 6846,
        ["Trenton Lighthammer"] = 6868,
        ["Grumnus Steelshaper"] = 3099,
        ["Ironus Coldsteel"] = 10694,
        ["Okothos Ironrager"] = 10696,
        ["Borgosh Corebender"] = 10697,
        ["Lilith the Lithe"] = 10725,
        ["Kilram"] = 10726,
        ["Seril Scourgebane"] = 10724,
    },

    chapters = {
        {
            chapter = "Joys of Omosh",
            faction = "Horde",
            requiredLevel = 32,
            summary = "Twenty generations of Omosh have held the hammer Orokk Omosh holds now, in Orgrimmar's Valley of Honor, and he has no heir for the family recipes. Bring your best bronze work and show him you could carry them on.",
            recap = "There's a smith in the Valley of Honor named Orokk Omosh. Twenty generations of Omosh have held the same hammer, and Orokk is the last of them, with the family recipes and no one to leave them to. He looked me over and decided I would have to do.\n\nThe recipes cost me more bronze than I knew Orgrimmar had, and then iron. Every delivery bought one set of barbaric iron plans and a short speech about the fear I'd see in my enemies' eyes. Once he said I was like his own grandfather, Chief Gorokk, and I took that kindly.\n\nThe last family secret was a dance. Orokk was not crying, he told me, there was soot in his eye. Then he taught me the Omosh Dance of Joy, and was panting a bit by the end. I still do it at the forge when a piece comes out right.",
            quests = {
                { id = 2751, name = "Barbaric Battlements", npc = "Orokk Omosh" },
                { id = 2752, name = "On Iron Pauldrons", npc = "Orokk Omosh" },
                { id = 2753, name = "Trampled Under Foot", npc = "Orokk Omosh" },
                { id = 2754, name = "Horns of Frenzy", npc = "Orokk Omosh" },
                { id = 2755, name = "Joys of Omosh", npc = "Orokk Omosh" },
            },
        },
        {
            chapter = "Galvan the Ancient",
            requiredLevel = 40,
            summaryAlliance = "Hank the Hammer, in Stormwind's Dwarven District, was trained by a dwarf named Galvan, who made Hank promise to teach any smith with the will to go further. For six golden scale bracers, Hank will show you where smithing comes from.",
            summaryHorde = "Aturk the Anvil, in Orgrimmar's Valley of Honor, remembers the days of crushed skulls and has little use for peacetime. Bring four steel breastplates and four steel helms, and he will give you a taste of war.",
            recapAlliance = "Hank the Hammer learned the trade from Galvan, a dwarf who left for Booty Bay years ago. For six golden scale bracers, Hank taught me where smithing comes from. It never comes from here, I was told, twice, and only from here. I still couldn't tell you which here was which.\n\nThen Hank gave me an insignia to take to McGavan at the Booty Bay smithy. McGavan kept it and swore by Blackhoof's back hair that I was worthy of the Mithril Order. What I got back was a pin to show Galvan, far to the north.\n\nGalvan teaches mining before smithing, so every lesson started with forty bars of mithril. Truesilver got a lecture to itself. He calls it the great silver deceiver, and spent more than ten years in the Alterac Mountains learning why. When my arms worked again, he sent me on to Gadgetzan.",
            recapHorde = "Aturk the Anvil remembers grinding the bones of fallen enemies into filament powder, and hasn't made peace with the Warchief's peace. For four steel breastplates and four helms, Aturk taught me orcish war leggings and made it plain I was a disappointment.\n\nAturk's neighbor was more cheerful, and knew a guy who knew a guy at the smithy in Booty Bay. That was McGavan, who kept the insignia I'd been handed and swore by Blackhoof's back hair that I was worthy of the Mithril Order. I got a pin in exchange, and directions north to Galvan.\n\nGalvan teaches mining before smithing, so every lesson started with forty bars of mithril. Truesilver got a lecture to itself. He calls it the great silver deceiver, and spent more than ten years in the Alterac Mountains learning why. When my arms worked again, he sent me on to Gadgetzan.",
            quests = {
                { id = 2756, name = "The Old Ways", npc = "Aturk the Anvil", faction = "Horde" },
                { id = 2757, name = "Booty Bay or Bust!", npc = "Ox", faction = "Horde" },
                { id = 2758, name = "The Origins of Smithing", npc = "Hank the Hammer", faction = "Alliance" },
                { id = 2759, name = "In Search of Galvan", npc = "Hank the Hammer", faction = "Alliance" },
                { id = 2760, name = "The Mithril Order", npc = "McGavan" },
                { id = 2761, name = "Smelt On, Smelt Off", npc = "Galvan the Ancient" },
                { id = 2762, name = "The Great Silver Deceiver", npc = "Galvan the Ancient", parallel = true },
                { id = 2763, name = "The Art of the Imbue", npc = "Galvan the Ancient", parallel = true },
                { id = 2764, name = "Galvan's Finest Pupil", npc = "Galvan the Ancient" },
            },
        },
        {
            chapter = "The Mithril Kid",
            requiredLevel = 40,
            summary = "Galvan has sent you to Gadgetzan, in Tanaris, to meet Trenton Lighthammer, the old smith's finest pupil. Trenton can teach you about ornate mithril, and has a blacksmithing championship to get ready for.",
            recap = "Trenton Lighthammer is known in Gadgetzan as the Mithril Kid. Galvan had taught each of us half of the ornate mithril set and left us to find each other, and Trenton saw the plan straight away. So we traded, piece for piece, until we both knew all of it.\n\nThe boots meant the most to Trenton. At last year's All-Valley Blacksmithing Championship, a rival from the Venture Co. Foundry swept his leg, and ornate mithril boots kept him going to the win. This year he wanted the pants too. When we were done, Trenton declared me unsweepable.\n\nAfter that I stood and watched Trenton work. Then I was handed an insignia very like the one I'd given McGavan, and named a blacksmith of the Mithril Order. Galvan had the last word, and a signet worth far more than what I'd given up.",
            quests = {
                { id = 2771, name = "A Good Head On Your Shoulders", npc = "Trenton Lighthammer" },
                { id = 2772, name = "The World At Your Feet", npc = "Trenton Lighthammer", parallel = true },
                { id = 2773, name = "The Mithril Kid", npc = "Trenton Lighthammer", parallel = true },
                { id = 3321, name = "Did You Lose This?", npc = "Trenton Lighthammer" },
                { id = 2765, name = "Expert Blacksmith!", npc = "Galvan the Ancient" },
            },
        },
        {
            chapter = "Armorsmith or Weaponsmith",
            requiredLevel = 40,
            summaryAlliance = "At the Great Forge in Ironforge, Grumnus Steelshaper trains armorsmiths and Ironus Coldsteel trains weaponsmiths. You can follow only one of them, so hear both out. From level 50, weaponsmiths can seek out three masters in Everlook, in Winterspring.",
            summaryHorde = "In Orgrimmar's Valley of Honor, Okothos Ironrager trains armorsmiths and Borgosh Corebender trains weaponsmiths. You can follow only one of them, so hear both out. From level 50, weaponsmiths can seek out three masters in Everlook, in Winterspring.",
            recapAlliance = "At the Great Forge there are two trainers who will take a smith further, and each thinks the other went wrong. Grumnus Steelshaper calls armor the smart decision. Ironus Coldsteel says weaponsmiths are the ones with all the gold, and was stacking coins into neat piles while saying it.\n\nBoth wanted a pile of finished work before they'd teach a thing, and a smith only gets to pick one of them. I made my choice and the work to go with it. Which one I took is between me and my anvil.\n\nUp in Everlook, three masters each teach a single weapon to weaponsmiths who bring them a trophy from a dungeon. Picking one of them closes the other two doors for good.",
            recapHorde = "In the Valley of Honor there are two trainers who will take a smith further. Okothos Ironrager makes armor for the satisfaction of it, and means to pound steel until there's no breath left to do it with. Borgosh Corebender makes weapons and dreams of a hammer fit for a Warchief, a life's work still in progress.\n\nBoth wanted a pile of finished work first, and both offered one last chance to back out. I made my choice and the work to go with it. Which one I took is between me and my anvil.\n\nUp in Everlook, three masters each teach a single weapon to weaponsmiths who bring them a trophy from a dungeon. Picking one of them closes the other two doors for good.",
            quests = {
                -- Armorsmith: hides once a Weaponsmith quest is done.
                { id = 5283, name = "The Art of the Armorsmith", npc = "Grumnus Steelshaper", faction = "Alliance", parallel = true, hideIf = { 5284, 82662, 5302 }, recap = "I took up armor. Grumnus Steelshaper went over my stack of ornate mithril and told me there was no turning back after this, and that it wasn't too late to become a toy maker. A weaponsmith, he meant. I've had a forge tan ever since." },
                { id = 5301, name = "The Art of the Armorsmith", npc = "Okothos Ironrager", faction = "Horde", parallel = true, hideIf = { 5284, 82662, 5302 }, recap = "I took up armor. Okothos Ironrager checked my ornate mithril and offered me one last chance to back out. I didn't take it, and was wished a lifetime of glory, which I've been working through one helm at a time." },
                -- Weaponsmith: hides once an Armorsmith quest is done. 82662 is
                -- Forever's later copy of 5284 with fixed requirements.
                { id = 5284, altIds = { 82662 }, name = "The Way of the Weaponsmith", npc = "Ironus Coldsteel", faction = "Alliance", parallel = true, hideIf = { 5283, 5301 }, recap = "I took up weapons. Ironus Coldsteel had customers waiting and took my axes and maces almost before I'd set them down, then told me to pay attention. I've had customers waiting myself ever since, and I'm still looking for all that gold." },
                { id = 5302, name = "The Way of the Weaponsmith", npc = "Borgosh Corebender", faction = "Horde", parallel = true, hideIf = { 5283, 5301 }, recap = "I took up weapons. Borgosh Corebender looked over my work and offered me a last chance to back out, then told me to prepare to be consumed by knowledge. He wasn't wrong. Some nights I dream in axe heads." },
                -- Master weaponsmiths, weaponsmiths only: each hides once an
                -- Armorsmith quest or another master's quest is done. 8869 is a
                -- second Sweet Serenity with the same text and objective.
                { id = 5305, altIds = { 8869 }, name = "Sweet Serenity", npc = "Lilith the Lithe", parallel = true, instance = "dungeon", hideIf = { 5283, 5301, 5306, 5307 }, recap = "Lilith the Lithe sent me into the Scarlet Bastion in Stratholme, where the Crimson Hammersmith guards the recipe for a hammer called Serenity with his life. He meant it. I brought Lilith his apron and became a hammersmith, with the sword and the axe closed to me from then on." },
                { id = 5306, name = "Snakestone of the Shadow Huntress", npc = "Kilram", parallel = true, instance = "dungeon", hideIf = { 5283, 5301, 5305, 8869, 5307 }, recap = "Kilram has a scar from Vosh'gajin, the shadow huntress of Blackrock Spire, and warned me not to let her beauty fool me. I brought back her snakestone, which the legend says keeps an axe razor sharp for a thousand years. Kilram made me an axesmith for it, and the sword and the hammer were closed to me for good." },
                { id = 5307, name = "Corruption", npc = "Seril Scourgebane", parallel = true, instance = "dungeon", hideIf = { 5283, 5301, 5305, 8869, 5306 }, recap = "Seril Scourgebane was short with me, and said there was a reason for it. The Black Guard, Baron Rivendare's skeletal elite, had stolen the plans for the great blade Corruption, and their swordsmith in Stratholme was keeping them. I destroyed him and brought his insignia back to Everlook, and Seril made me a swordsmith. The hammer and the axe are closed to me now." },
            },
        },
    },
}
