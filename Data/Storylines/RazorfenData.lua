local addonName, SM = ...

-- =============================================================================
-- Classic: Thorns of the Razorfen
-- The quilboar of the Razorfen: Charlga Razorflank in Razorfen Kraul, then
-- Ambassador Malcin, Belnistrasz's idol and Amnennar the Coldbringer in
-- Razorfen Downs. The Small Scroll (An Unholy Alliance) drops from Charlga.
-- =============================================================================

SM.RazorfenData = {
    title = "Thorns of the Razorfen",
    description = "In the far south of the Barrens, the quilboar of the Razorfen live in warrens of giant thorns. In Razorfen Kraul their crone, Charlga Razorflank, is raising an army, and she has made enemies a long way from the Barrens.\n\nStart in the Kraul. When it's done with, follow the thorns further south to Razorfen Downs, where the quilboar have been keeping strange company.",
    descriptionAlliance = "In the far south of the Barrens, the quilboar of the Razorfen live in warrens of giant thorns, and in Razorfen Kraul their crone, Charlga Razorflank, is raising an army. Mebok Mizzyrix in Ratchet has a job in there, and you'll find other reasons once you're inside.\n\nWhen the Kraul is done with, follow the thorns further south to Razorfen Downs, where the quilboar have been keeping strange company.",
    descriptionHorde = "In the far south of the Barrens, the quilboar of the Razorfen live in warrens of giant thorns, and in Razorfen Kraul their crone, Charlga Razorflank, is raising an army. Auld Stonespire, in Thunder Bluff, would like her heart.\n\nWhen the Kraul is done with, follow the thorns further south to Razorfen Downs, where the quilboar have been keeping strange company.",
    zone = "The Barrens / Feralas / Thunder Bluff / Undercity / Stormwind / Razorfen Kraul / Razorfen Downs",
    zoneByFaction = {
        Alliance = "The Barrens / Feralas / Darnassus / Stormwind / Razorfen Kraul / Razorfen Downs",
        Horde = "The Barrens / Thunder Bluff / Undercity / Razorfen Kraul / Razorfen Downs",
    },
    expansion = "Classic",
    recommendedLevel = { min = 20, max = 42 },
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.56, 0.40, 0.24 },
    icon = 136104, -- spell_nature_thorns
    portraitDisplayID = 4642, -- Charlga Razorflank
    -- A story names one instance and one cover, so the Downs chapters share
    -- the Kraul's. Razorfen Downs' own loading screen is 131864.
    adventureGuideInstanceName = "Razorfen Kraul",
    adventureCoverTexture = 131865, -- Razorfen Kraul loading screen
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 1221, name = "Blueleaf Tubers", npc = "Mebok Mizzyrix", location = "Ratchet, The Barrens" },
    startMapID = 10,
    startX = 0.6240,
    startY = 0.3760,

    npcLocations = {
        ["Mebok Mizzyrix"] = { mapID = 10, x = 0.6240, y = 0.3760, location = "Ratchet, The Barrens" },
        ["Auld Stonespire"] = { mapID = 88, x = 0.3620, y = 0.5980, location = "the Lower Rise, Thunder Bluff" },
        ["Treshala Fallowbrook"] = { mapID = 89, x = 0.6920, y = 0.6640, location = "the Tradesmen's Terrace, Darnassus" },
        ["Falfindel Waywarder"] = { mapID = 69, x = 0.8940, y = 0.4580, location = "Thalanaar, southeastern Feralas" },
        ["Varimathras"] = { mapID = 90, x = 0.5620, y = 0.9240, location = "the Royal Quarter, Undercity" },
        ["Myriam Moonsinger"] = { mapID = 10, x = 0.4900, y = 0.9480, location = "a hill outside Razorfen Downs, The Barrens" },
        ["Archbishop Benedictus"] = { mapID = 84, x = 0.3940, y = 0.2740, location = "the Cathedral of Light, Stormwind" },
        ["Andrew Brownell"] = { mapID = 90, x = 0.7400, y = 0.3240, location = "the Magic Quarter, Undercity" },
        -- WoW Forever only; where Wowhead's Forever data places them.
        ["Archmage Lan'dalock"] = { mapID = 1416, x = 0.1540, y = 0.7380, location = "Dalaran, Alterac Mountains" },
        ["Sutara Plainstalker"] = { mapID = 7, x = 0.3440, y = 0.2280, location = "Mulgore" },
    },

    npcDisplayIDs = {
        -- Quest givers' models from the cmangos Classic database.
        ["Mebok Mizzyrix"] = 7034,
        ["Willix the Importer"] = 7155,
        ["Heralath Fallowbrook"] = 2596,
        ["Treshala Fallowbrook"] = 9055,
        ["Falfindel Waywarder"] = 4201,
        ["Auld Stonespire"] = 4568,
        ["Varimathras"] = 11658,
        ["Myriam Moonsinger"] = 12964,
        ["Belnistrasz"] = 7851,
        ["Archbishop Benedictus"] = 5072,
        ["Andrew Brownell"] = 1585,
        -- Quest givers' models from Wowhead's WoW Forever data.
        ["Archmage Lan'dalock"] = 19744,
        ["Sutara Plainstalker"] = 143985,
    },

    chapterDisplayIDs = {
        ["The Crone of the Kraul"] = 4642, -- Charlga Razorflank
        ["A Host of Evil"] = 12964, -- Myriam Moonsinger
        ["Extinguishing the Idol"] = 7851, -- Belnistrasz
        ["The Coldbringer"] = 7971, -- Amnennar the Coldbringer
    },

    chapterIcons = {
        ["The Crone of the Kraul"] = 134172, -- inv_misc_head_quillboar_01
        ["A Host of Evil"] = 134939, -- inv_scroll_03 (Small Scroll)
        ["Extinguishing the Idol"] = 135829, -- spell_fire_totemofwrath
        ["The Coldbringer"] = 135848, -- spell_frost_frostnova
    },

    chapters = {
        {
            chapter = "The Crone of the Kraul",
            requiredLevel = 20,
            summaryAlliance = "The quilboar of the Razorfen have grown a warren of giant thorns in the southern Barrens, Razorfen Kraul, and they don't welcome visitors. Mebok Mizzyrix in Ratchet wants some tubers dug up in there all the same, and has a gopher to lend for it.",
            summaryHorde = "Auld Stonespire, on the Lower Rise in Thunder Bluff, remembers when the tauren lived in the southern Barrens, and holds a grudge against the crone who rules Razorfen Kraul there now. In Ratchet, Mebok Mizzyrix has a smaller job in the same thorns.",
            recapAlliance = "Somewhere in Razorfen Kraul I picked up the journal of a dwarf named Henrig Lonebrow, who had no further use for it. I took it to Falfindel Waywarder at Thalanaar, on the Feralas border. Falfindel mourned a brave soul and then got down to business.\n\nThe crone who rules the Kraul, Charlga Razorflank, was raising an army in there, and there wasn't time to send to Darnassus for help. Falfindel wanted her medallion as proof she was finished.\n\nSo back into the thorns I went. Charlga kept a great many quilboar between herself and the door, and the medallion came away with me in the end. Falfindel was glad the Alliance could get on with its work there, and started wondering aloud whether treachery had a hand in the rot in that ground. I left Falfindel to it.",
            recapHorde = "Auld Stonespire in Thunder Bluff has a long memory. The tauren lived on holy land in the southern Barrens for decades before they were driven out, and Auld has never forgiven it. These days the crone Charlga Razorflank rules down there from Razorfen Kraul and is raising an army. Auld wanted her heart, and said it would be enough to die in peace.\n\nThe Kraul is a maze of thorns as thick as tree trunks, full of quilboar who seemed to know what I'd come for, and Charlga was at the far end of it.\n\nI carried the heart back to Thunder Bluff. Auld was satisfied that the Razorfen finally knew what the tauren had felt. Driving a people from holy ground, Auld told me, is a sin that earns its vengeance. Then came the thanks, very solemn, with the heart still in Auld's hand.",
            quests = {
                { id = 1221, name = "Blueleaf Tubers", npc = "Mebok Mizzyrix", optional = true, recap = "Mebok Mizzyrix in Ratchet sent me into Razorfen Kraul with a crate full of holes and an owner's manual I was told to read first, so I read it. Out of the crate came a snufflenose gopher, and a poke with the command stick set it rooting for blueleaf tubers while I kept the quilboar off it. Mebok wanted the crate and the stick back along with the six tubers, and got all of it." },
                { id = 1102, name = "A Vengeful Fate", npc = "Auld Stonespire", faction = "Horde" },
                { id = 1144, name = "Willix the Importer", npc = "Willix the Importer", location = "near Charlga Razorflank, Razorfen Kraul", optional = true, parallel = true, recap = "Willix the Importer, a goblin, had gone into Razorfen Kraul after blueleaf tubers for Mebok Mizzyrix and ended up held in a tent not far from Charlga Razorflank. I walked Willix out. The whole way there was a running complaint about the quilboar and the smell, and warnings about trouble that tended to arrive at the same moment as the trouble. Outside, Willix thanked me and announced a good long rest before the trip back to Ratchet." },
                { id = 1142, name = "Mortality Wanes", npc = "Heralath Fallowbrook", location = "near Charlga Razorflank, Razorfen Kraul", faction = "Alliance", optional = true, parallel = true, recap = "Heralath Fallowbrook lay in the Kraul not far from Charlga Razorflank and didn't have long. A quilboar had taken the pendant Heralath shared with Treshala, Heralath's wife in Darnassus, and Heralath wanted it found and taken home to her with word of the death. I found it on one of the quilboar and carried both to the Tradesmen's Terrace. Treshala wouldn't believe it at first, then said the grief would be carried and Heralath's work would go on, and asked to be left alone to mourn. I went." },
                { id = 1100, name = "Lonebrow's Journal", npc = "Lonebrow's Journal", location = "Razorfen Kraul", faction = "Alliance" },
                { id = 1101, name = "The Crone of the Kraul", npc = "Falfindel Waywarder", faction = "Alliance" },
            },
        },
        {
            chapter = "A Host of Evil",
            requiredLevel = 28,
            summaryAlliance = "Myriam Moonsinger keeps watch from a hill near the entrance to Razorfen Downs, at the bottom of the Barrens. A diplomat has set up outside the Downs and is drawing a crowd, and Myriam would like the crowd smaller.",
            summaryHorde = "Charlga Razorflank was carrying a small scroll under an insignia you don't recognize. Varimathras, in the Royal Quarter of the Undercity, may know it. Near the entrance to Razorfen Downs, Myriam Moonsinger could use a hand with the crowd gathering there.",
            recapAlliance = "Myriam Moonsinger had been sitting on a hill outside Razorfen Downs, keeping an eye on a diplomat. Ambassador Malcin, Myriam suspected, was Scourge, and handed out undeath to anyone who came asking for it. Plenty came. Every day more of them crept out of the briars to stand near the ambassador, quilboar and Death's Head cultists both, and Myriam was in no position to fight that many alone.\n\nI took eight of each kind off the crowd. Myriam thanked me and said that seeing the diplomat's power up close only proved the Scourge were among the worst threats Azeroth had ever faced. Then it was back to watching and studying, and I was pointed at the cave below the hill, the one shaped like a boar's mouth, with the suggestion that I take friends.",
            recapHorde = "The crone had been carrying a small scroll under an insignia I didn't recognize. Varimathras did. Down in the Royal Quarter, the dreadlord asked whether it had come off Charlga, who rules the Kraul.\n\nIt was a letter from Ambassador Malcin, a diplomat to Lordaeron before things changed and a servant of the Scourge since. The letter called Charlga My Lady and offered her the Barrens and more if the Scourge could do as it liked there, and Malcin would wait outside Razorfen Downs to talk it over. If the Scourge wanted a foothold in Kalimdor, Varimathras said, it fell to the Horde to answer.\n\nMalcin was waiting where the letter said, among quilboar and cultists hungry for the bargain. A watcher on the hill above wanted that crowd thinner, so I thinned it on the way through, and Malcin's head went back to the Undercity with me.",
            quests = {
                { id = 6522, name = "An Unholy Alliance", npc = "Small Scroll", location = "Razorfen Kraul", faction = "Horde" },
                { id = 6521, name = "An Unholy Alliance", npc = "Varimathras", faction = "Horde" },
                { id = 6626, name = "A Host of Evil", npc = "Myriam Moonsinger", parallel = true },
            },
        },
        {
            chapter = "Extinguishing the Idol",
            requiredLevel = 32,
            summary = "Somewhere in Razorfen Downs, in a cage the Scourge haven't got round to emptying, a stranger named Belnistrasz is still alive and has a proposal for whoever reaches the cage first.",
            recap = "Deep in Razorfen Downs, in a cage, I found Belnistrasz. The stranger had fully expected to die in there or end up as a meal for the Scourge, and was very glad to see me, as people in cages generally are. Home, I gathered, was a long way from the Barrens.\n\nBefore anything else, Belnistrasz handed me an oathstone. Among Belnistrasz's kind an agreement made over one of those is a serious bond, and to take the job I had to give it back. I gave it back.\n\nThe job was the quilboar idol. Belnistrasz meant to shut it down with a ritual, and a ritual means standing in one place for a long while as the whole of the Downs comes to object. I stood in front and objected back. When the ritual was done the idol was finished, and we wound things up at Belnistrasz's brazier.",
            quests = {
                { id = 3523, name = "Scourge of the Downs", npc = "Belnistrasz", location = "a cage in Razorfen Downs" },
                { id = 3525, name = "Extinguishing the Idol", npc = "Belnistrasz", location = "a cage in Razorfen Downs" },
            },
        },
        {
            chapter = "The Coldbringer",
            requiredLevel = 37,
            summaryAlliance = "Archbishop Benedictus, in the Cathedral of Light in Stormwind, has had grim reports out of Razorfen Downs and wants the power behind them put down. The archbishop is asking for volunteers willing to go all the way to the bottom.",
            summaryHorde = "Andrew Brownell, in the Magic Quarter of the Undercity, has studied the master of Razorfen Downs closely enough to want the skull, and would like it fetched up from the very bottom of the Downs.",
            recapAlliance = "Archbishop Benedictus had heard enough about Razorfen Downs. The quilboar there had made a pact with the Scourge, and the pact had bred things worse than either of them. Over all of it sat a lich called Amnennar the Coldbringer, and the archbishop wanted the union ended along with him.\n\nSo down I went, to the very bottom of the Downs, where Amnennar waited in a cold he seems to carry with him. It was a long fight and I did most of it with numb fingers. He went down in the end.\n\nBack at the Cathedral of Light, Benedictus thanked me and said the Scourge would think twice before trying to swell its ranks that way again. I left with the archbishop's blessing of the Light, which was warm, at least.",
            recapHorde = "Andrew Brownell, in the Magic Quarter of the Undercity, laid out Razorfen Downs for me like a lecture. The quilboar there had thrown in with the Scourge, and the lich who ruled them, Amnennar the Coldbringer, moved them about with his mind. He also had a line straight to Ner'zhul. Brownell wanted that line cut, and the skull brought back to show for it.\n\nThe bottom of the Downs was colder than anything in the Barrens has a right to be, and Amnennar did his best to keep it that way for a long, long fight. The skull came home with me.\n\nBrownell's view was that a lich's loyalty never wavers, and that loyalty of that sort only ever leads to its own destruction.",
            quests = {
                { id = 3636, name = "Bring the Light", npc = "Archbishop Benedictus", faction = "Alliance" },
                { id = 3341, name = "Bring the End", npc = "Andrew Brownell", faction = "Horde" },
                { id = 96773, name = "The Coldbringer's Eye", npc = "Archmage Lan'dalock", faction = "Alliance", optional = true, parallel = true, gameVersions = { forever = true }, recap = "Archmage Lan'dalock in Dalaran wanted the Coldbringer's Eye brought out of Razorfen Downs. It sat in a blue orb behind Amnennar, which made Amnennar the first step of the errand. Once he was out of the way the orb gave it up, and I carried it all the way to the Alterac Mountains for the archmage." },
                { id = 97196, name = "The Coldbringer's Eye", npc = "Sutara Plainstalker", faction = "Horde", optional = true, parallel = true, gameVersions = { forever = true }, recap = "Sutara Plainstalker, an Earthen Ring quartermaster in Mulgore, wanted the Coldbringer's Eye fetched from Razorfen Downs. It sat in a blue orb behind Amnennar, so Amnennar had to be dealt with first, and I was headed that way regardless. With the lich gone the orb let go of it, and I took it back across the Barrens to Sutara." },
            },
        },
    },
}
