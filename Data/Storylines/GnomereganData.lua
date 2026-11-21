local addonName, SM = ...

-- =============================================================================
-- Classic: The Mad King
-- Gnomeregan: Ozzie Togglevolt's cure, the Tinker Town exiles, Nogg's rig
-- blueprints, and Mekgineer Thermaplugg at the bottom of the city.
-- =============================================================================

SM.GnomereganData = {
    title = "The Mad King",
    description = "Gnomeregan, the gnomes' city under Dun Morogh, was lost to a trogg invasion and a radiation leak, and its people fled to Tinker Town in Ironforge. The machines they left behind are still running down there.\n\nThe exiles want a cure, and their belongings back. In Orgrimmar, the goblins have heard about a new gnomish rig and want its blueprints. Either errand takes you all the way to the bottom of the city.",
    descriptionAlliance = "Gnomeregan, the gnomes' city under Dun Morogh, was lost to troggs and a radiation leak, and its people now live as exiles in Tinker Town, in Ironforge. Gnoarn, one of them, lost a splendid head of hair in the leak and wants the city back.\n\nStart with Gnoarn, and follow the exiles' requests down into Gnomeregan, where High Tinker Mekkatorque has business of his own.",
    descriptionHorde = "Two years ago, gnome engineering was mostly good for a punch line. Now the gnomes have built a rig better than any goblin shredder, and Nogg, in Orgrimmar's Valley of Honor, wants the blueprints.\n\nThe blueprints are in Gnomeregan, under the mountains of Dun Morogh, a long way from home. Sovik, beside Nogg, knows a faster way in than walking.",
    zone = "Ironforge / Dun Morogh / Orgrimmar / Stranglethorn Vale / Gnomeregan",
    zoneByFaction = {
        Alliance = "Ironforge / Dun Morogh / Gnomeregan",
        Horde = "Orgrimmar / Stranglethorn Vale / Gnomeregan",
    },
    expansion = "Classic",
    recommendedLevel = { min = 20, max = 40 },
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.46, 0.66, 0.28 },
    icon = 134063, -- inv_misc_gear_01
    portraitDisplayID = 6980, -- Mekgineer Thermaplugg
    adventureGuideInstanceName = "Gnomeregan",
    adventureCoverTexture = 131841, -- Gnomeregan loading screen
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 2927, name = "The Day After", npc = "Gnoarn", location = "Tinker Town, Ironforge", faction = "Alliance" },
    startMapID = 87,
    startX = 0.6918,
    startY = 0.5055,

    npcLocations = {
        -- Classic positions (Wowhead Classic tooltips, Questie's spawn points).
        ["Gnoarn"] = { mapID = 87, x = 0.6918, y = 0.5055, location = "Tinker Town, Ironforge" },
        ["Ozzie Togglevolt"] = { mapID = 27, x = 0.4589, y = 0.4939, location = "Kharanos, Dun Morogh" },
        ["Brother Sarno"] = { mapID = 84, x = 0.4055, y = 0.3096, location = "the Cathedral of Light, Stormwind" },
        ["Tinkmaster Overspark"] = { mapID = 87, x = 0.6955, y = 0.5033, location = "Tinker Town, Ironforge" },
        ["Mathiel"] = { mapID = 89, x = 0.5951, y = 0.4538, location = "Darnassus" },
        ["Klockmort Spannerspan"] = { mapID = 87, x = 0.6792, y = 0.4610, location = "Tinker Town, Ironforge" },
        ["Shoni the Shilent"] = { mapID = 84, x = 0.5551, y = 0.1251, location = "the Dwarven District, Stormwind" },
        ["Gaxim Rustfizzle"] = { mapID = 65, x = 0.5952, y = 0.6715, location = "Windshear Crag, Stonetalon Mountains" },
        ["Master Mechanic Castpipe"] = { mapID = 87, x = 0.6983, y = 0.4810, location = "Tinker Town, Ironforge" },
        ["High Tinker Mekkatorque"] = { mapID = 87, x = 0.6875, y = 0.4897, location = "Tinker Town, Ironforge" },
        ["Talvash del Kissel"] = { mapID = 87, x = 0.3638, y = 0.0361, location = "the Mystic Ward, Ironforge" },
        ["Nogg"] = { mapID = 85, x = 0.7599, y = 0.2541, location = "the Valley of Honor, Orgrimmar" },
        ["Sovik"] = { mapID = 85, x = 0.7549, y = 0.2536, location = "the Valley of Honor, Orgrimmar" },
        ["Scooty"] = { mapID = 50, x = 0.2760, y = 0.7748, location = "Booty Bay, Stranglethorn Vale" },
    },

    npcDisplayIDs = {
        -- Quest givers' models from the cmangos Classic database.
        ["Gnoarn"] = 5377,
        ["Ozzie Togglevolt"] = 3441,
        ["Brother Sarno"] = 7008,
        ["Tinkmaster Overspark"] = 7028,
        ["Mathiel"] = 5083,
        ["Klockmort Spannerspan"] = 4999,
        ["Shoni the Shilent"] = 5378,
        ["Gaxim Rustfizzle"] = 2180,
        ["Master Mechanic Castpipe"] = 7041,
        ["High Tinker Mekkatorque"] = 7006,
        ["Talvash del Kissel"] = 5647,
        ["Nogg"] = 7135,
        ["Sovik"] = 7136,
        ["Scooty"] = 7036,
        ["Kernobee"] = 7132,
    },

    chapterDisplayIDs = {
        ["The Day After"] = 5377, -- Gnoarn
        ["The Transpolyporter"] = 7036, -- Scooty
        ["The King of Nothing"] = 6980, -- Mekgineer Thermaplugg
    },

    chapterIcons = {
        ["The Day After"] = 134164, -- inv_misc_head_gnome_01
        ["The Transpolyporter"] = 134520, -- inv_misc_wrench_01
        ["The King of Nothing"] = 132767, -- inv_crown_01
    },

    chapters = {
        {
            chapter = "The Day After",
            faction = "Alliance",
            requiredLevel = 20,
            summary = "Gnoarn, in Tinker Town in Ironforge, lost a magnificent head of hair to the radiation leak in Gnomeregan and blames the troggs for all of it. He thinks the city can still be saved, and Ozzie Togglevolt in Kharanos is working on how.",
            recap = "There's a gnome in Tinker Town called Gnoarn, bald as an egg, who will tell you that before the radiation leak in Gnomeregan he had the only gnomefro in all of Azeroth. Then he shakes his fist and curses the troggs.\n\nHe sent me to Ozzie Togglevolt in Kharanos, who stood right beside him when the bolt hit and remembers the hair coming out in clumps. Ozzie and a partner called Razzle were close to some kind of cure, or else the recipe for a very strong rum, and couldn't say which until they'd tested it.\n\nThe test needed fallout off the irradiated troggs around Gnomeregan, so I filled a leaden phial with the green glow. Ozzie had a captured leper gnome lined up to be cured, and was expecting a full head of hair on the side. I was told to stand back, and I stood well back.",
            quests = {
                { id = 2927, name = "The Day After", npc = "Gnoarn" },
                { id = 2926, name = "Gnogaine", npc = "Ozzie Togglevolt" },
            },
        },
        {
            chapter = "The Transpolyporter",
            faction = "Horde",
            requiredLevel = 25,
            summary = "Gnomes have built a rig better than any goblin shredder, and Nogg, in Orgrimmar's Valley of Honor, wants the blueprints out of Gnomeregan. Gnomeregan is a long walk through dwarf country. Sovik, beside Nogg, has a quicker way to send you.",
            recap = "Nogg was sore about gnomes. Two years ago their engineering was mostly good for a punch line, and now they'd built a rig better than every goblin shredder. Nogg wanted the blueprints, which were locked in a safe deep in Gnomeregan, and only the mekgineer sitting beside it knew the combination.\n\nSovik, next to Nogg, had the travel sorted. Sovik and a partner in Booty Bay had built the Transpolyporter 6000 for the trip.\n\nThe partner was Scooty, who showed the machine off like a new boat and said it had only exploded a dozen or so times. If it went up with me on it, I was promised, it would be quick and painless. Scooty tuned a goblin transponder to my size and weight and mentioned a few side effects, none of them permanent anymore. After that, all I had to do was step on the pad.",
            -- Sovik offers Chief Engineer Scooty only while Rig Wars is in the
            -- quest log; Rig Wars itself is finished in Gnomeregan.
            prerequisites = {
                { id = 2841, name = "Rig Wars", npc = "Nogg" },
            },
            quests = {
                { id = 2842, name = "Chief Engineer Scooty", npc = "Sovik" },
                { id = 2843, name = "Gnomer-gooooone!", npc = "Scooty" },
            },
        },
        {
            chapter = "The King of Nothing",
            requiredLevel = 25,
            summaryAlliance = "Ozzie Togglevolt in Kharanos isn't finished with Gnomeregan's fallout, and the exiles in Tinker Town have a long list of things left behind in the city. High Tinker Mekkatorque, in Tinker Town, has a harder job, at the very bottom of it.",
            summaryHorde = "Nogg's blueprints are in a safe at the bottom of Gnomeregan, and the only one with the combination is the mekgineer who sits beside it. Between you and the safe lies a whole city of troggs and machines that never got switched off.",
            recapAlliance = "Ozzie's verdict on my first phial was that there wasn't enough in it and what there was had gone impure. The troggs weren't glowing hard enough. I was to get it straight from the tap, off the slimes and horrors deep in Gnomeregan, and that stuff falls apart if you look at it wrong. It took more than one try to bottle. Ozzie looked me over afterwards, impressed that I still had all my limbs.\n\nHigh Tinker Mekkatorque had trusted Mekgineer Thermaplugg, and Thermaplugg had betrayed him and every gnome with him and taken the city. King of nothing, the High Tinker called him. The job was to kill him.\n\nI went all the way down and did it. Mekkatorque likes to think the last thing through Thermaplugg's head was my foot, and I've seen no reason to correct that.",
            recapHorde = "The gnomes are gone from Gnomeregan, but their machines kept running, and getting through the place took a while.\n\nThe mekgineer with Nogg's combination was Thermaplugg, at the very bottom, and he wasn't taking callers. I took the combination off him the hard way and opened the safe beside him. The rig blueprints were inside.\n\nNogg had known all along I could do it, and wanted me to know that Sovik had had doubts. Then Nogg cleared his throat and got to the point. Every gnomish innovation in that rig would be pulled apart and studied until it was a goblin innovation, and the next shredders would carry the lot.",
            -- On WoW Forever, Thermaplugg's Engineering Notes add a last turn-in.
            foreverText = {
                recapAlliance = "Ozzie's verdict on my first phial was that there wasn't enough in it and what there was had gone impure. The troggs weren't glowing hard enough. I was to get it straight from the tap, off the slimes and horrors deep in Gnomeregan, and that stuff falls apart if you look at it wrong. It took more than one try to bottle. Ozzie looked me over afterwards, impressed that I still had all my limbs.\n\nHigh Tinker Mekkatorque had trusted Mekgineer Thermaplugg, and Thermaplugg had betrayed him and every gnome with him and taken the city. King of nothing, the High Tinker called him. The job was to kill him.\n\nI went all the way down and did it, and brought his engineering notes back for the High Tinker. Mekkatorque likes to think the last thing through Thermaplugg's head was my foot, and I've seen no reason to correct that.",
                recapHorde = "The gnomes are gone from Gnomeregan, but their machines kept running, and getting through the place took a while.\n\nThe mekgineer with Nogg's combination was Thermaplugg, at the very bottom, and he wasn't taking callers. I took the combination off him the hard way and opened the safe beside him. The rig blueprints were inside. Thermaplugg's engineering notes came out with me too, and those went to Nogg as well.\n\nNogg had known all along I could do it, and wanted me to know that Sovik had had doubts. Then Nogg cleared his throat and got to the point. Every gnomish innovation in that rig would be pulled apart and studied until it was a goblin innovation, and the next shredders would carry the lot.",
            },
            quests = {
                { id = 2962, name = "The Only Cure is More Green Glow", npc = "Ozzie Togglevolt", faction = "Alliance" },
                { id = 2929, name = "The Grand Betrayal", npc = "High Tinker Mekkatorque", faction = "Alliance", parallel = true },
                { id = 80324, name = "The Mad King", npc = "Thermaplugg's Engineering Notes", location = "Gnomeregan", faction = "Alliance", parallel = true, gameVersions = { forever = true } },
                { id = 2841, name = "Rig Wars", npc = "Nogg", faction = "Horde" },
                { id = 80325, name = "The Mad King", npc = "Thermaplugg's Engineering Notes", location = "Gnomeregan", faction = "Horde", parallel = true, gameVersions = { forever = true } },
                { id = 2923, name = "Tinkmaster Overspark", npc = "Brother Sarno", faction = "Alliance", optional = true, parallel = true, breadcrumbFor = 2922 },
                { id = 2922, name = "Save Techbot's Brain!", npc = "Tinkmaster Overspark", faction = "Alliance", optional = true, parallel = true, recap = "Tinkmaster Overspark built Techbot to help out around Gnomeregan, and when the city fell a stray spark flipped its positronic brain to negatronic, so every kind habit it had now runs backwards. I brought Overspark its memory core. Overspark told the core not to feel bad, promised to have it fixed, and went looking for the plug to a hydro-jack swivel spanner." },
                { id = 2925, name = "Klockmort's Essentials", npc = "Mathiel", faction = "Alliance", optional = true, parallel = true, breadcrumbFor = 2924 },
                { id = 2924, name = "Essential Artificials", npc = "Klockmort Spannerspan", faction = "Alliance", optional = true, parallel = true, recap = "In the rush out of Gnomeregan, the gnomes left behind every last essential artificial, a little part their tinkers and smiths used in nearly everything. Klockmort Spannerspan in Tinker Town needed a dozen for some new experiments, and they were deep in the city, shut up in things called artificial extrapolators. I opened enough of them. Klockmort said my bravery had moved gnomish research forward by a leap and a bound." },
                { id = 2928, name = "Gyrodrillmatic Excavationators", npc = "Shoni the Shilent", faction = "Alliance", optional = true, parallel = true, recap = "Shoni the Shilent in Stormwind had a whole fleet of gyrodrillmatic excavationators to get to Dun Morogh and nowhere near enough parts. By Shoni's account the robots in Gnomeregan roam about like cattle on an open range, so I went and rounded up two dozen sets of robo-mechanical guts. Shoni was pleased. That was one excavationator fixed, with 398 to go." },
                { id = 2931, name = "Castpipe's Task", npc = "Gaxim Rustfizzle", faction = "Alliance", optional = true, parallel = true, breadcrumbFor = 2930, recap = "Gaxim Rustfizzle in Stonetalon, a proud member of the Enlightened Assembly of Arcanology, Alchemy and Engineering Sciences, sent me to Ironforge to help Master Mechanic Castpipe. Castpipe wasn't in the Assembly, Gaxim conceded, but was smart enough that the job had an eighty-four percent chance of being important. Good odds, by Gaxim's reckoning." },
                { id = 2930, name = "Data Rescue", npc = "Master Mechanic Castpipe", faction = "Alliance", optional = true, parallel = true, recap = "Master Mechanic Castpipe had left a great deal of data behind in Gnomeregan and wanted one piece of it back, on a prismatic punch card from a Matrix Punchograph 3005-D deep in the city. Getting into that terminal meant clearance from the lesser ones, and each of those wanted a punch card the gnomes had also left behind. I worked my way up from white to prismatic. Castpipe called the data immeasurably important and said my service would be long remembered. I couldn't tell you what was on it." },
                { id = 2904, name = "A Fine Mess", npc = "Kernobee", location = "Gnomeregan", optional = true, parallel = true, recap = "Kernobee woke up among the troggs, where some Dark Iron dwarves had thrown the poor wretch after a beating, and wanted out. I led the way to the Clockwerk Run exit, and from there Kernobee made for Ratchet with word that the Dark Irons had a hand in that super rig. Telling Scooty in Booty Bay was my part. Scooty rewarded me, a touch grudgingly, with gear meant to help against that good-for-nothing backstabber Thermaplugg." },
                { id = 2945, name = "Grime-Encrusted Ring", npc = "Grime-Encrusted Ring", location = "Gnomeregan", optional = true, parallel = true, recap = "One of the Dark Iron dwarves in Gnomeregan was carrying a ring so caked in grime that I couldn't tell what it was made of, though something under there had a gleam. The gnomes holding out in the city have a machine for exactly that, the Sparklematic 5200. I put the ring in and paid. It ground and jerked about so violently I worried for it, then stopped with a cheerful ding and opened to show a small box tied with a red bow. It gift wraps, too." },
                { id = 2951, altIds = { 4601, 4602 }, name = "The Sparklematic 5200!", npc = "The Sparklematic 5200", location = "the Clean Zone, Gnomeregan", optional = true, parallel = true, recap = "The plaque on the Sparklematic 5200 promises to put the shine back in shine-tastic, for three silver a go. I had a grime-encrusted find of my own from the city, so in it went with the coins. The machine surged to life, and its frame groaned as it lurched from side to side, as if it meant to wander off with my valuables." },
                { id = 2947, name = "Return of the Ring", npc = "The Sparklematic 5200", location = "the Clean Zone, Gnomeregan", faction = "Alliance", optional = true, parallel = true, recap = "Inside the band of the cleaned ring were the seal of Ironforge and the initials TdK, which led me to Talvash del Kissel in the Mystic Ward. He knew it at once. He'd made several like it in a little shop in Gnomeregan before the city went up, and this one might have belonged to someone who never got out. When I said a Dark Iron had been carrying it, Talvash reckoned that put a new layer of conspiracy on the nine already floating about, and that the authorities ought to hear." },
                { id = 2948, name = "Gnome Improvement", npc = "Talvash del Kissel", faction = "Alliance", optional = true, parallel = true, recap = "Talvash offered to improve the ring for thirty silver, which became thirty silver plus a silver bar and a moss agate, since his own stock had dried up. I brought them. He added a silver and agate lattice and swore he'd normally charge ten times as much. One day, once he's out of the hole he's unjustly in, he means to make the finest trinkets in Azeroth for everyone." },
                { id = 2949, name = "Return of the Ring", npc = "The Sparklematic 5200", location = "the Clean Zone, Gnomeregan", faction = "Horde", optional = true, parallel = true, recap = "Inside the band of the cleaned ring were the seal of Orgrimmar and three letters still legible, NOG. I knew a Nogg in the Valley of Honor. It wasn't Nogg's ring, as it happened, but the Dark Iron part interested Nogg a great deal. Maybe, Nogg reckoned, the gnomes had stolen the Dark Irons' crazy golem plans to build that rig, and the Dark Irons would be wanting payback." },
                { id = 2950, name = "Nogg's Ring Redo", npc = "Nogg", faction = "Horde", optional = true, parallel = true, recap = "For the tip about the Dark Irons, Nogg offered to improve the ring, which was probably the simple work of some gnome. I brought the silver bar and moss agate Nogg asked for, plus thirty silver for the trouble, and got the ring back with a silver and agate lattice and more magic in it than before. Nogg reckoned the Dark Irons were a fair lead on how the gnomes had suddenly come down with goblin-like inspiration." },
            },
        },
    },
}
