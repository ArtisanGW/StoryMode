local addonName, SM = ...

-- =============================================================================
-- WoW Forever: The City of Dalaran
-- The Kirin Tor quietly ask the Alliance for help, the Forsaken in Tarren Mill
-- go looking for a way in, and both end up in Dalaran's sewers and streets.
-- =============================================================================
--
-- Chain order, from Wowhead's WoW Forever quest tooltips, warcraft.wiki.gg and
-- Warcraft Tavern's City of Dalaran quest guide:
--   Alliance: An Alarming Request (92432, Emissary Jacques in Southshore) >
--   Heart of Disruption (92458, the Image of Archmage Modera by the sewer
--   entrance) > Friend of the Kirin Tor (92459, to Archmage Celindra).
--   Starving Arcane (92457) also needs An Alarming Request.
--   Horde: Prison Break In (544) and Key to the City (93680), both at the
--   Lordamere Internment Camp for Magus Wordeen Voidglare > Dalaran Patrols
--   (545) > Blood in the Streets (92434, to the Image) > Heart of Disruption
--   (96984, the Image > Wordeen) > Shrewd Negotiations (97287). Method's guide
--   calls Prison Break In optional, so Key to the City is `parallel`.
--   Shrewd Negotiations' tooltip sends the mote to the Image of Archmage Modera;
--   the wiki names Archmage Celindra, as it was in the beta.
-- Side quests that can be played alongside the main line are `parallel`, so
-- finishing them first doesn't count the main line as done.

SM.ForeverDalaranData = {
    title = "The City of Dalaran",
    description = "An emissary from Dalaran has come to Southshore asking the Alliance for help, and the Kirin Tor's high council would prefer that it stayed quiet. Over in Tarren Mill, Magus Wordeen Voidglare has business at the mages' prison camp on Lordamere Lake, and questions about the city beyond it.\n\nThe Kirin Tor rebuilt Dalaran after the Legion flattened it and have kept outsiders at arm's length ever since. Something has gone wrong inside, and for once they are asking for help.",
    descriptionAlliance = "An emissary of the Kirin Tor has come to the town hall in Southshore asking the Alliance for help, and the high council would prefer that it stayed quiet. Archmage Modera sent him, and she needs someone who can be discreet.\n\nThe Kirin Tor rebuilt Dalaran after the Legion flattened it and have kept outsiders at arm's length ever since. Something has gone wrong inside, badly enough that they are asking anyway.",
    descriptionHorde = "Magus Wordeen Voidglare came to Tarren Mill to study, but the Undercity has more urgent work for him. Four Forsaken thieves are locked up in the mages' prison camp on Lordamere Lake, and Wordeen has questions about the city behind it.\n\nThe Kirin Tor rebuilt Dalaran right on the Dark Lady's doorstep and have kept the Forsaken out ever since. Wordeen would very much like to know what they keep in there.",
    zone = "Alterac Mountains / City of Dalaran",
    zoneByFaction = {
        Alliance = "Hillsbrad Foothills / Silverpine Forest / City of Dalaran",
        Horde = "Hillsbrad Foothills / Alterac Mountains / City of Dalaran",
    },
    expansion = "Classic",
    recommendedLevel = { min = 30, max = 35 },
    requiredLevel = 30,
    gameVersions = { forever = true },
    achievements = {},
    color = { 0.55, 0.38, 0.80 },
    icon = "Interface\\Icons\\jewelcrafting_uncut-epic-gem_color1",  -- the Arcane Mote's icon
    adventureCoverTexture = 7963775,  -- the City of Dalaran's loading screen
    adventureCoverTexCoords = { 0, 1, 0.1592, 0.8408 },  -- the picture, between its transparent bands
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 92432, name = "An Alarming Request", npc = "Emissary Jacques", location = "the town hall, Southshore, Hillsbrad Foothills", faction = "Alliance", gameVersions = { forever = true } },
    startMapID = 1424,
    startX = 0.4820,
    startY = 0.6000,

    npcLocations = {
        -- Alliance
        ["Emissary Jacques"] = { mapID = 1424, x = 0.4820, y = 0.6000, location = "the town hall, Southshore, Hillsbrad Foothills" },
        ["Archmage Celindra"] = { mapID = 1416, x = 0.1420, y = 0.6000, location = "the Violet Citadel, Dalaran, Alterac Mountains" },
        ["Shylamiir"] = { mapID = 1453, x = 0.3150, y = 0.6300, location = "the Park, Stormwind City" },
        ["High Sorcerer Andromath"] = { mapID = 1453, x = 0.4880, y = 0.8750, location = "the top of the Wizard's Sanctum, Mage Quarter, Stormwind City" },
        -- Horde
        ["Magus Wordeen Voidglare"] = { mapID = 1424, x = 0.6150, y = 0.2080, location = "Tarren Mill, Hillsbrad Foothills" },
        ["Melisara"] = { mapID = 1424, x = 0.6250, y = 0.2050, location = "Tarren Mill, Hillsbrad Foothills" },
        ["Doctor Martin Felben"] = { mapID = 1458, x = 0.4640, y = 0.7430, location = "the Apothecarium, Undercity" },
        -- Both
        ["Image of Archmage Modera"] = { mapID = 1421, x = 0.6850, y = 0.4520, location = "by the Dalaran sewers on Lordamere Lake, Silverpine Forest" },
    },

    npcDisplayIDs = {
        -- Quest givers' models from the cmangos Classic database.
        ["Magus Wordeen Voidglare"] = 3682,
        ["Melisara"] = 10994,
        ["Doctor Martin Felben"] = 10576,
        ["Shylamiir"] = 3296,
        ["High Sorcerer Andromath"] = 5076,
        -- Quest givers' models from Wowhead's WoW Forever data.
        ["Image of Archmage Modera"] = 130165,
        ["Emissary Jacques"] = 130458,
        ["Rexxie Copperclutch"] = 147507,
    },

    chapters = {
        {
            chapter = "A Way In",
            summaryAlliance = "Emissary Jacques has come down from Dalaran to the town hall in Southshore, asking the Alliance for help. The Kirin Tor rarely ask anyone for anything, and their high council would rather this stayed quiet.",
            summaryHorde = "Magus Wordeen Voidglare came to Tarren Mill to study, but has more pressing work. Four Forsaken robbed the Undercity and fled to Dalaran, where the mages locked them in a camp by Lordamere Lake. Wordeen is curious about the city, too.",
            recapAlliance = "There's a Kirin Tor emissary in the town hall in Southshore, Jacques, with the look of a man sent to ask for something his betters would rather not ask for. Something had knocked Dalaran's ley lines loose, and the city's constructs had started breaking things instead of minding them. The high council wanted it kept quiet. Archmage Modera wanted help, and had sent Jacques to find some.\n\nSo I went up to Lordamere Lake and found Modera, or a shimmering image of her, waiting by the water outside the city. The Kirin Tor don't let outsiders in, she told me, but just now they couldn't afford to turn anyone away. The guards on the walls looked calm. Modera warned me not to read anything into that.",
            recapHorde = "Magus Wordeen came to Tarren Mill to study and ended up running the Dark Lady's errands. Four Forsaken had robbed a vault in the Undercity and fled to Dalaran, and the mages had locked them up in the Lordamere Internment Camp. So I broke into a prison to rob the prisoners. The last of them, Kegan Darkmar, was kept under guard in a house, and the warden's footlocker in there held a grimy key. \"A sewer key?\" said Wordeen, plainly glad he wouldn't be the one using it.\n\nOnce I'd thinned out the wizards patrolling the old ruins, Wordeen had news. Dalaran's barrier was down, and the sewers on the city's northern edge might not be warded. At the entrance stood an image of Archmage Modera, who told me to put my weapon away. She'd been counting on the Horde taking an interest, and she had a proposition.",
            quests = {
                { id = 92432, name = "An Alarming Request", npc = "Emissary Jacques", faction = "Alliance", breadcrumbFor = 92458, gameVersions = { forever = true } },
                { id = 544, name = "Prison Break In", npc = "Magus Wordeen Voidglare", faction = "Horde", gameVersions = { forever = true } },
                { id = 93680, name = "Key to the City", npc = "Magus Wordeen Voidglare", faction = "Horde", parallel = true, gameVersions = { forever = true } },
                { id = 545, name = "Dalaran Patrols", npc = "Magus Wordeen Voidglare", faction = "Horde", gameVersions = { forever = true } },
                { id = 92434, name = "Blood in the Streets", npc = "Magus Wordeen Voidglare", faction = "Horde", breadcrumbFor = 96984, gameVersions = { forever = true } },
            },
        },
        {
            chapter = "The City of Dalaran",
            summaryAlliance = "Archmage Modera's image, by Dalaran's sewers on Lordamere Lake, has a key for you and a quiet way into the city. In Stormwind, Shylamiir and High Sorcerer Andromath each have an errand in Dalaran as well.",
            summaryHorde = "Archmage Modera's image, waiting outside Dalaran's sewers, has a proposition for the Horde. Melisara in Tarren Mill has Forsaken business in the city, and Doctor Martin Felben in the Undercity would like some samples.",
            recapAlliance = "Modera's image handed me a sewer key and a plan. The trouble had started at the top of the Violet Citadel, the wards were barely holding, and the Kirin Tor were too busy propping them up to deal with anything else. I was to come in quietly through the sewers and meet her at the citadel.\n\nQuietly lasted as far as the sewers. The streets above were thick with loose magic and constructs that had forgotten whose side they were on. Modera herself, the real one, was waiting on the citadel steps, and she opened a portal up to the Violet Chamber for us.\n\nUp there the Shade of the Archmage was holding the Arcane Mote, and it took some persuading to let go. I carried the mote back out to the lake for her image to look over. It seemed pleased, as far as you can tell with an image.",
            recapHorde = "Modera's proposition was plain enough. She doubted the Horde had Dalaran's best interests at heart, and she'd take our help anyway, since if Dalaran fell the Undercity would go with it. She enchanted my sewer key to get past her wards and told me to meet her at the Violet Citadel. The Kirin Tor would be far too busy to stop me. I could help myself to what I found on the way, as long as I remembered what I'd come for.\n\nUnder the streets and up through the city we went, with every construct in Dalaran trying to tidy us away. Modera opened a portal from the citadel steps, and at the top the Shade of the Archmage gave up the Arcane Mote. I didn't hand it to Modera. I took it home to Wordeen in Tarren Mill.",
            quests = {
                { id = 92458, name = "Heart of Disruption", npc = "Image of Archmage Modera", faction = "Alliance", instance = "dungeon", gameVersions = { forever = true } },
                { id = 96984, name = "Heart of Disruption", npc = "Image of Archmage Modera", faction = "Horde", instance = "dungeon", gameVersions = { forever = true } },
                { id = 92457, name = "Starving Arcane", npc = "Image of Archmage Modera", faction = "Alliance", instance = "dungeon", optional = true, parallel = true, gameVersions = { forever = true }, recap = "The breach had scrambled the enchantments and factotums all over Dalaran, the ones keeping up its defenses included, and all that loose magic drew in rogue elementals looking for a free meal. Modera, busy with the wards, asked me to thin out what she called the elemental throng. I worked through the remnants and the mana echoes until the throng was a good deal thinner." },
                { id = 92456, name = "A Green Sample", npc = "Shylamiir", faction = "Alliance", instance = "dungeon", optional = true, parallel = true, gameVersions = { forever = true }, recap = "Shylamiir, the herbalism trainer in Stormwind's park, was annoyed to be disturbed and decided I might as well be useful. Dalaran's mages had taken up botany, the Kirin Tor keep to themselves, and Shylamiir wanted a sample from the city's central garden. The garden had gone fel, with a fel ancient rooted in the middle of it. I came back with one Fel Infused Blossom and a low opinion of Dalaran's gardeners." },
                { id = 92489, name = "Power Overwhelming", npc = "High Sorcerer Andromath", faction = "Alliance", instance = "dungeon", optional = true, parallel = true, gameVersions = { forever = true }, recap = "High Sorcerer Andromath in Stormwind was worried about the Kirin Tor. They had kept to themselves since Archimonde flattened their city, and now they were rebuilding it with arcane energy leaking out everywhere. If the Alliance didn't help, it could lose one of its strongest allies. So I went after the worst of the leaks, a mana elemental called the Arcanic Enigma, and dispersed it." },
                { id = 96986, name = "The Grave Knight", npc = "Melisara", faction = "Horde", instance = "dungeon", optional = true, parallel = true, gameVersions = { forever = true }, recap = "Melisara in Tarren Mill didn't care what became of Dalaran. What she cared about was Atrexis, a traitor to the Forsaken and a frighteningly good necromancer, raising an army of the dead in the city's underbelly under the Kirin Tor's noses. She wanted it understood that the Dark Lady's reach goes everywhere. I found Atrexis down in the sewers and passed the message on." },
                { id = 96987, name = "Opportunistic Education", npc = "Rexxie Copperclutch", location = "just inside the Dalaran sewers", faction = "Horde", instance = "dungeon", optional = true, parallel = true, gameVersions = { forever = true }, recap = "Just inside the sewers I met Rexxie Copperclutch, a goblin who took one look at me and decided we were in the same line of work. Rexxie's plan was to lift a secret arcane tome from the mages' libraries and split the profits. I brought back The Founding of Dalaran. Rexxie said it would barely sell at a tourist stall and asked whether I'd just grabbed the first book on the shelf. I had. It's being gilded and sold as an archmage's anyway." },
                { id = 96988, name = "Source of Power", npc = "Doctor Martin Felben", faction = "Horde", instance = "dungeon", optional = true, parallel = true, gameVersions = { forever = true }, recap = "Doctor Martin Felben in the Apothecarium heard that Dalaran's own constructs were attacking it and saw an opportunity. An army of arcane-powered abominations, he reasoned, would impress the Dark Lady and might get him the Royal Apothecary Society to run. The constructs weren't going to hand over their cores, so I took six cracked ones without asking. Felben was delighted, which is never a good sign." },
            },
        },
        {
            chapter = "The Arcane Mote",
            summaryAlliance = "Archmage Modera thinks it only fair that you carry the good word, and the mote, to Archmage Celindra in the Violet Citadel. The Council of Six may not like how Modera went about things.",
            summaryHorde = "Magus Wordeen Voidglare in Tarren Mill thinks the Kirin Tor will pay anything to get the mote back, and he knows what he wants for it. Take it to Archmage Modera's image outside Dalaran and see what the mages offer.",
            recapAlliance = "Modera admitted the Council of Six wouldn't be pleased to hear what she'd been doing behind their backs. She also didn't think they could argue with the results. The city had settled enough for the wards to come down, and she thought it only fair that I be the one to deliver the good word, so this time I went in through the front with the mote in my pack.\n\nArchmage Celindra greeted me in the Violet Citadel with \"Yes? I am quite busy.\" The mote got her attention. I left the citadel a friend of the Kirin Tor, which is more than most people get for going in through the sewers.",
            recapHorde = "Wordeen had been thinking while I was away. Sneaking into the city of mages was all very well, he said, but it was time to negotiate. The Kirin Tor knew things that made his own research look thin, and he wanted the Horde let into their order. The mote was his price, and he was sure they would pay anything to get it back.\n\nSo I carried it back out to Modera's image by the lake, under orders to drive a hard bargain with an archmage whose city I'd just helped save. The mote went back to its owners. The Horde got a promise that there might be room for it in Dalaran one day, and Wordeen will have to make that last.",
            quests = {
                { id = 92459, name = "Friend of the Kirin Tor", npc = "Image of Archmage Modera", faction = "Alliance", gameVersions = { forever = true } },
                { id = 97287, name = "Shrewd Negotiations", npc = "Magus Wordeen Voidglare", faction = "Horde", gameVersions = { forever = true } },
            },
        },
    },
}
