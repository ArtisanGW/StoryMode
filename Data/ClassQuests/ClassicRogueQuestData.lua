local addonName, SM = ...

-- =============================================================================
-- Classic rogue quests
-- Curated identity chains: iconic abilities, tools, weapons, and mounts.
-- =============================================================================

SM.ClassicRogueQuestData = {
    id = "poisons",  -- from its earlier title, "Poisons": saved progress and share links use it
    title = "The Road to Ravenholdt",
    description = "Master Mathias Shaw and Shenthul do not teach by lecture. They send rogues into guarded places, locked boxes, and situations where an antidote matters as much as a blade.\n\nBegin with your faction's poison work, then follow the hints that lead beyond city trainers into a wider trade of signals and reputation.",
    zone = "Westfall / The Barrens / Hillsbrad Foothills / Ravenholdt",
    zoneByFaction = {
        Alliance = "Westfall / Ravenholdt",
        Horde = "The Barrens / Hillsbrad Foothills / Ravenholdt",
    },
    expansion = "Classic",
    class = "ROGUE",
    gameVersions = { classicEra = true, tbc = true },
    color = { 1.00, 0.96, 0.41 },
    icon = 132320,
    adventureCoverTexture = 131833, -- Deadmines: the Defias hideout, where SI:7 first sends its rogues
    adventureCoverIsLoadingScreen = true,
    -- WoW Forever's Ruins of Lordaeron: an iron gate in the hills, like the way into Ravenholdt Manor.
    foreverCover = { texture = 7963782, texCoords = { 0, 1, 0.1592, 0.8408 } },

    startQuest = { id = 2360, name = "Mathias and the Defias", npc = "Master Mathias Shaw", location = "SI:7, Old Town, Stormwind", faction = "Alliance", mapID = 84, x = 0.7578, y = 0.5984, location = "Master Mathias Shaw, Stormwind" },
    startMapID = 84,
    startX = 0.7620,
    startY = 0.6010,

    npcLocations = {
        ["Master Mathias Shaw"] = { mapID = 84, x = 0.7620, y = 0.6010, location = "SI:7, Old Town, Stormwind" },
        ["Shenthul"] = { mapID = 85, x = 0.4300, y = 0.5360, location = "Cleft of Shadow, Orgrimmar" },
    },

    -- Quest givers' creature display IDs, from WoW Forever's creature cache
    -- (build 70938). Givers missing here show the chapter's icon.
    npcDisplayIDs = {
        ["Shenthul"] = 4360,
        ["Serge Hinott"] = 3678,
        ["Gest"] = 1327,
        ["Myrokos Silentform"] = 13150,
        ["Anastasia Miller"] = 144897,
        -- Quest givers' models from the cmangos Classic database.
        ["Master Mathias Shaw"] = 1736,
        ["Agent Kearnen"] = 5783,
        ["Doc Mixilpixil"] = 6446,
        ["Taskmaster Fizzule"] = 5986,
        ["Osborne the Night Man"] = 1507,
    },

    chapterIcons = {
        ["The Touch of Zanzil"] = 132273,
        ["Ravenholdt"] = 132331,
    },

    chapters = {
        {
            chapter = "The Touch of Zanzil",  -- both factions' poison work turns on Zanzil's mixture
            requiredLevel = 20,
            summary = "Follow your faction's rogue trainer into guarded ground, locked boxes, and the antidote work needed for poisons.",
            recap = "Your poison training taught the trade plainly: enter unseen, open what is locked, and survive the danger you mean to wield.",
            quests = {
                { id = 2360, name = "Mathias and the Defias", npc = "Master Mathias Shaw", faction = "Alliance", mapID = 84, x = 0.7578, y = 0.5984, location = "Master Mathias Shaw, Stormwind" },
                { id = 2359, name = "Klaven's Tower", npc = "Agent Kearnen", faction = "Alliance", mapID = 52, x = 0.6849, y = 0.7008, location = "Agent Kearnen, Westfall" },
                { id = 2607, name = "The Touch of Zanzil", npc = "Master Mathias Shaw", faction = "Alliance", mapID = 84, x = 0.7578, y = 0.5984, location = "Master Mathias Shaw, Stormwind" },
                { id = 2608, name = "The Touch of Zanzil", npc = "Doc Mixilpixil", faction = "Alliance", mapID = 84, x = 0.7804, y = 0.5876, location = "Doc Mixilpixil, Stormwind" },
                { id = 2609, name = "The Touch of Zanzil", npc = "Doc Mixilpixil", faction = "Alliance", mapID = 84, x = 0.7804, y = 0.5876, location = "Doc Mixilpixil, Stormwind" },
                { id = 2460, name = "The Shattered Salute", npc = "Shenthul", faction = "Horde", mapID = 85, x = 0.4305, y = 0.5374, location = "Shenthul, Orgrimmar" },
                { id = 2458, name = "Deep Cover", npc = "Shenthul", faction = "Horde", mapID = 85, x = 0.4305, y = 0.5374, location = "Shenthul, Orgrimmar" },
                { id = 2478, name = "Mission: Possible But Not Probable", npc = "Taskmaster Fizzule", faction = "Horde", mapID = 10, x = 0.5544, y = 0.0556, location = "Taskmaster Fizzule, The Barrens" },
                { id = 2479, name = "Hinott's Assistance", npc = "Shenthul", faction = "Horde", mapID = 85, x = 0.4305, y = 0.5374, location = "Shenthul, Orgrimmar" },
                { id = 2480, name = "Hinott's Assistance", npc = "Serge Hinott", faction = "Horde", mapID = 25, x = 0.6163, y = 0.1919, location = "Serge Hinott, Tarren Mill, Hillsbrad Foothills" },
            },
        },
        {
            chapter = "Ravenholdt",
            requiredLevel = 24,
            summary = "Find Ravenholdt Manor and present yourself to the rogues who keep their own company in the hills.",
            recap = "Ravenholdt opened a door beyond ordinary city training. There were signals to learn, reputations to mind, and thieves who knew the craft by its older rules.",
            -- On WoW Forever the manor's work goes on: Myrokos Silentform's war on the Syndicate.
            foreverText = {
                summary = "Find Ravenholdt Manor and present yourself to the rogues who keep their own company in the hills. Myrokos Silentform has work for Ravenholdt's agents. The Syndicate has grown bold in the hills of Alterac and Arathi, and someone must cut it where it will bleed the most.",
                recap = "Ravenholdt opened a door beyond ordinary city training. There were signals to learn, reputations to mind, and thieves who knew the craft by its older rules. You began by removing Lord Tomas from Durnholde Keep. Later, Myrokos had you lift a scouting report from a Syndicate pocket and beat its searchers to the heirlooms of House Perenolde in the ruins of Alterac. In a stolen uniform you walked into Stromgarde Keep, found the leverage to make Anastasia talk, and broke up the secret handoff at Thoradin's Wall, carrying the prize back to Ravenholdt.",
            },
            quests = {
                { id = 6681, name = "The Manor, Ravenholdt", npc = "Osborne the Night Man", faction = "Alliance", mapID = 84, x = 0.7400, y = 0.5200, location = "SI:7, Old Town, Stormwind, then Ravenholdt Manor" },
                { id = 6681, name = "The Manor, Ravenholdt", npc = "Gest", faction = "Horde", mapID = 85, x = 0.4300, y = 0.5360, location = "Cleft of Shadow, Orgrimmar, then Ravenholdt Manor" },
                { id = 96779, name = "Syndicate Sabotage", npc = "Myrokos Silentform", mapID = 1416, x = 0.8500, y = 0.8040, location = "Myrokos Silentform, Ravenholdt Manor, Alterac Mountains", gameVersions = { forever = true } },
                { id = 96781, name = "What's the Big Idea?", npc = "Myrokos Silentform", mapID = 1416, x = 0.8500, y = 0.8040, location = "Myrokos Silentform, Ravenholdt Manor, Alterac Mountains", gameVersions = { forever = true } },
                { id = 96782, name = "Covert Extraction", npc = "Myrokos Silentform", mapID = 1416, x = 0.8500, y = 0.8040, location = "Myrokos Silentform, Ravenholdt Manor, Alterac Mountains", gameVersions = { forever = true } },
                { id = 96783, name = "A Way In", npc = "Myrokos Silentform", mapID = 1416, x = 0.8500, y = 0.8040, location = "Myrokos Silentform, Ravenholdt Manor, Alterac Mountains", gameVersions = { forever = true } },
                { id = 96784, name = "Master of Disguise", location = "Stromgarde Keep, Arathi Highlands", gameVersions = { forever = true } },
                { id = 96785, name = "Ain't No Telling", npc = "Anastasia Miller", mapID = 1417, x = 0.2640, y = 0.6320, location = "Anastasia Miller, Stromgarde Keep, Arathi Highlands", gameVersions = { forever = true } },
                { id = 96786, name = "The Syndicate Sting", npc = "Anastasia Miller", mapID = 1417, x = 0.2640, y = 0.6320, location = "Anastasia Miller, Stromgarde Keep, Arathi Highlands", gameVersions = { forever = true } },
            },
        },
    },
}
