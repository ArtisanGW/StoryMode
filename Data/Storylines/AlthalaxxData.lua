local addonName, SM = ...

-- =============================================================================
-- Classic: The Tower of Althalaxx
-- Darkshore and Ashenvale's Cult of the Dark Strand chain.
-- =============================================================================

SM.AlthalaxxData = {
    title = "The Tower of Althalaxx",
    description = "Auberdine's watchers have seen trouble near the Tower of Althalaxx. Speak with Balthule Shadowstrike and learn what the Cult of the Dark Strand is doing on the northern coast.\n\nWhat begins as a report from Darkshore pulls you toward Ashenvale, where parchments, gems, and old corruption point to a threat still gathering strength.",
    zone = "Darkshore / Ashenvale",
    expansion = "Classic",
    recommendedLevel = { min = 13, max = 31 },
    faction = "Alliance",
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.38, 0.50, 0.64 },
    icon = 136145,
    portraitDisplayID = 4413,
    adventureCoverTexture = 131823, -- Blackfathom Deeps loading screen; closest dark Night Elf ruin art
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 965, name = "The Tower of Althalaxx", npc = "Sentinel Elissa Starbreeze", location = "Auberdine, Darkshore" },
    startMapID = 62,
    startX = 0.3700,
    startY = 0.4400,

    npcLocations = {
        ["Sentinel Elissa Starbreeze"] = { mapID = 62, x = 0.3700, y = 0.4400, location = "Auberdine, Darkshore" },
        ["Balthule Shadowstrike"] = { mapID = 62, x = 0.5500, y = 0.2400, location = "near the Tower of Althalaxx, Darkshore" },
        ["Delgren the Purifier"] = { mapID = 63, x = 0.2660, y = 0.3830, location = "Maestra's Post, Ashenvale" },
        ["Ordil'Aran"] = { mapID = 63, x = 0.3100, y = 0.3100, location = "Ordil'Aran, Ashenvale" },
        ["Fire Scar Shrine"] = { mapID = 63, x = 0.2500, y = 0.6100, location = "Fire Scar Shrine, Ashenvale" },
        ["Night Run"] = { mapID = 63, x = 0.6600, y = 0.5600, location = "Night Run, Ashenvale" },
        ["Satyrnaar"] = { mapID = 63, x = 0.8100, y = 0.4900, location = "Satyrnaar, Ashenvale" },
        ["Athrikus Narassin"] = { mapID = 62, x = 0.5500, y = 0.2400, location = "the Tower of Althalaxx, Darkshore" },
    },

    npcDisplayIDs = {
        ["Sentinel Elissa Starbreeze"] = 2529,
        ["Balthule Shadowstrike"] = 2530,
        ["Delgren the Purifier"] = 2531,
        ["Athrikus Narassin"] = 4413,
    },

    chapterDisplayIDs = {
        ["The Dark Strand"] = 2530,
        ["Ashenvale Soul Gems"] = 2531,
        ["Athrikus Narassin"] = 4413,
    },

    chapterIcons = {
        ["The Dark Strand"] = 136145,
        ["Ashenvale Soul Gems"] = 136157,
        ["Athrikus Narassin"] = 136163,
    },

    chapters = {
        {
            chapter = "The Dark Strand",
            summary = "Sentinel Elissa Starbreeze in Auberdine sent a scout, Balthule Shadowstrike, to watch some strange goings-on at the Tower of Althalaxx to the northeast. Balthule should have been back by now. Elissa would like someone to go and look.",
            recap = "Sentinel Elissa Starbreeze in Auberdine had a scout who'd gone quiet up the coast, near an old tower called Althalaxx. Would I go and look? I went and looked.\n\nThe scout, Balthule Shadowstrike, was fine. Keeping an eye on the tower from a safe distance, which was wise, because the tower was full of warlocks. The Cult of the Dark Strand, they call themselves. Anyone who picks a name like that is hoping you'll ask about it, so I didn't. I took their papers instead. Four worn parchments, which their owners had no more use for.\n\nBalthule didn't like what was written on them. Not one bit. A letter went off to Delgren the Purifier in Ashenvale, and I went with it. Whatever the cult was up to, the tower was only the part you could see from the beach.",
            quests = {
                { id = 965, name = "The Tower of Althalaxx", displayName = "Find Balthule", npc = "Sentinel Elissa Starbreeze" },
                { id = 966, name = "The Tower of Althalaxx", displayName = "Worn Parchments", npc = "Balthule Shadowstrike" },
                { id = 967, name = "The Tower of Althalaxx", displayName = "Letter to Delgren", npc = "Balthule Shadowstrike" },
            },
        },
        {
            chapter = "Ashenvale Soul Gems",
            summary = "Delgren the Purifier, at Maestra's Post in Ashenvale, has read Balthule's letter and calls it dire. The Dark Strand has cultists at Ordil'Aran, and one of them carries a soul gem Delgren would very much like to study.",
            recap = "Delgren the Purifier keeps watch at Maestra's Post in Ashenvale, and Delgren read the letter and handed me a list. Soul gems, a tome somebody didn't want to part with, the usual cult leftovers.\n\nThe odd one out was the Highborne. There were souls trapped in Night Run and in Satyrnaar, bound up and waiting for somebody to come along and cut them loose. So I cut them loose. I can't tell you what a Highborne soul does with its freedom, but they didn't hang about to discuss it.\n\nEvery piece I brought back, Delgren said, weakened whatever was holding court at the top of Althalaxx. When there was nothing left to bring, it was back up to Darkshore to tell the scout the time had come.",
            quests = {
                { id = 970, name = "The Tower of Althalaxx", displayName = "Glowing Soul Gem", npc = "Delgren the Purifier" },
                { id = 973, name = "The Tower of Althalaxx", displayName = "Ilkrud Magthrull's Tome", npc = "Delgren the Purifier" },
                { id = 1140, name = "The Tower of Althalaxx", displayName = "Highborne Souls", npc = "Delgren the Purifier" },
                { id = 1167, name = "The Tower of Althalaxx", displayName = "Return to Balthule", npc = "Delgren the Purifier" },
            },
        },
        {
            chapter = "Athrikus Narassin",
            summary = "Balthule Shadowstrike, back at the Tower of Althalaxx, says the time to strike is now. Athrikus Narassin is at the top of the tower, and the warlocks around him are deadlier than any you've met so far.",
            recap = "The Tower of Althalaxx has a great many stairs and a warlock on most of them. Balthule's orders were short: Athrikus Narassin, top of the tower, bring back the head.\n\nSo I took the stairs one at a time and the warlocks the same way. At the top was Narassin, the one who'd gathered the whole Dark Strand there in the first place. All my running about in Ashenvale had taken the edge off whatever power was behind him. There was enough edge left to keep things lively.\n\nI came down with the head and gave it to Balthule, and Balthule sent me straight back to Ashenvale to tell Delgren. That's how it works in those woods, I've learned. Nothing is really finished until somebody in another forest has heard about it.",
            quests = {
                { id = 1143, name = "The Tower of Althalaxx", displayName = "Athrikus Narassin", npc = "Balthule Shadowstrike" },
                { id = 981, name = "The Tower of Althalaxx", displayName = "Report to Delgren", npc = "Balthule Shadowstrike" },
            },
        },
    },
}
