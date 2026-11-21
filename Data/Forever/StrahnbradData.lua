local addonName, SM = ...

-- =============================================================================
-- WoW Forever: Strahnbrad Mystery
-- The Syndicate's ruined town in the Alterac Mountains, the price Southshore
-- and Tarren Mill put on its nobles, and a ghost story about the town's old
-- forge. Both factions, level 30 to 40. A short story.
-- =============================================================================
--
-- Chain, from the cmangos Classic database and Wowhead's WoW Forever pages:
--   Alliance, Magistrate Henry Maleb in Southshore: Syndicate Assassins (505).
--   Foreboding Plans (510) starts from the Syndicate Documents on a table at
--   the Syndicate camp at Sofera's Naze and doesn't need 505, so it is
--   `parallel`; it leads to Noble Deaths (512, rings from Strahnbrad).
--   Assassin's Contract (522) starts from an item the Shadowy Assassins drop
--   in and around Southshore > Baron's Demise (523).
--   Horde: WANTED: Baron Vardus (566), a poster in Tarren Mill, to High
--   Executor Darthalia.
--   Both: Strahnbrad Mystery (95534, WoW Forever's own) starts from the Singed
--   Note, which Syndicate Wizards and Argus Shadow Mages drop in Strahnbrad.
--   Fire damage on both bellows of the town's forge (Alterac Mountains 60.96,
--   46.91) calls down an ancient fire elemental. It is turned in to Kundric
--   Zanden in Southshore (Alliance) or Shara Blazen in Tarren Mill (Horde).
--   The Encrypted Letter chain (511 > 514 > 525 > 537) is left out.
-- Levels the game asks for: 505, 510 and 512 need 26, 522 and 523 need 30,
-- 566 needs 35 and 95534 needs 25. A chapter can't lock by faction, so the
-- Vardus chapter asks for the Alliance's 30.

SM.ForeverStrahnbradData = {
    title = "Strahnbrad Mystery",
    description = "Strahnbrad is a ruined town in the Alterac Mountains, and the Syndicate runs its business from there. The Syndicate is a gang of thieves led by Alterac's old nobility. Southshore wants them gone, and Tarren Mill has put a price on one of their barons.\n\nThe gang has a mystery of its own. The casters in Strahnbrad pass around a singed note about the old bellows at the town forge, which are said to come to life when no one is watching.",
    descriptionAlliance = "Southshore's last magistrate was murdered, and the killers were never found. Magistrate Henry Maleb, the new one, is almost certain they were hired by the Syndicate, a gang of thieves led by the old nobles of fallen Alterac.\n\nThe Syndicate keeps a camp in the mountains north of Tarren Mill and its headquarters in the ruins of Strahnbrad. Maleb would like to begin with the camp.",
    descriptionHorde = "A wanted poster in Tarren Mill names Baron Vardus, one of the old Alterac nobles who lead the Syndicate, a gang of thieves in the mountains to the north. High Executor Darthalia wants his head.\n\nThe Syndicate's headquarters is the ruined town of Strahnbrad. The casters there pass around a singed note about the old bellows at the town forge, which are said to come to life when no one is watching.",
    zone = "Alterac Mountains / Hillsbrad Foothills",
    expansion = "Classic",
    recommendedLevel = { min = 30, max = 40 },
    requiredLevel = 25,
    gameVersions = { forever = true },
    achievements = {},
    color = { 0.72, 0.34, 0.20 },
    icon = "Interface\\Icons\\INV_Misc_Note_03",  -- the Singed Note's icon
    adventureCoverTexture = 7963775,  -- WoW Forever's City of Dalaran loading screen: Dalaran stands in the Alterac Mountains too
    adventureCoverTexCoords = { 0, 1, 0.1592, 0.8408 },  -- the picture, between its transparent bands
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 505, name = "Syndicate Assassins", npc = "Magistrate Henry Maleb", location = "the town hall, Southshore, Hillsbrad Foothills", faction = "Alliance", gameVersions = { forever = true } },
    startMapID = 1424,
    startX = 0.4820,
    startY = 0.5920,

    npcLocations = {
        -- Alliance
        ["Magistrate Henry Maleb"] = { mapID = 1424, x = 0.4820, y = 0.5920, location = "the town hall, Southshore, Hillsbrad Foothills" },
        ["Syndicate Documents"] = { mapID = 1416, x = 0.5820, y = 0.6790, location = "the Syndicate camp at Sofera's Naze, Alterac Mountains" },
        ["Kundric Zanden"] = { mapID = 1424, x = 0.4860, y = 0.5900, location = "Southshore, Hillsbrad Foothills" },
        -- Horde
        ["WANTED"] = { mapID = 1424, x = 0.6240, y = 0.2040, location = "the wanted poster in Tarren Mill, Hillsbrad Foothills" },
        ["High Executor Darthalia"] = { mapID = 1424, x = 0.6220, y = 0.2020, location = "Tarren Mill, Hillsbrad Foothills" },
        ["Shara Blazen"] = { mapID = 1424, x = 0.6340, y = 0.2080, location = "Tarren Mill, Hillsbrad Foothills" },
    },

    npcDisplayIDs = {
        -- Quest givers' and turn-ins' models from the cmangos Classic database.
        ["Magistrate Henry Maleb"] = 3665,
        ["Kundric Zanden"] = 3660,
        ["High Executor Darthalia"] = 1645,
        ["Shara Blazen"] = 3657,
    },

    chapterDisplayIDs = {
        -- Baron Vardus, from the cmangos Classic database: the face on the
        -- Horde's wanted poster, which has no model of its own.
        ["Baron Vardus"] = 1827,
    },

    chapterIcons = {
        ["Baron Vardus"] = "Interface\\Icons\\INV_Scroll_03",  -- the Assassin's Contract's icon
        ["Strahnbrad Mystery"] = "Interface\\Icons\\INV_Misc_Note_03",  -- the Singed Note's icon
    },

    chapters = {
        {
            chapter = "Syndicate Assassins",
            faction = "Alliance",
            requiredLevel = 26,
            summary = "Southshore's new magistrate, Henry Maleb, has the job because the last one was murdered. The killers were never found, but Maleb's clues point to a Syndicate camp in the mountains north of Tarren Mill. Find him in the town hall.",
            recap = "Southshore's new magistrate has the job because the last one was murdered, and Henry Maleb is almost certain the Syndicate paid for it. His clues led to a Syndicate camp in the mountains north of Tarren Mill, so I went up and started on their footpads and thieves.\n\nOn a table in the camp at Sofera's Naze lay a list of supplies, everything from food to masks and poison, wanted in a hurry for what it called an important mission against Southshore. Maleb found it very troubling and decided the Syndicate had declared war on his town.\n\nThe gang is run by Alterac's old nobles, who hide among the common members. You tell them apart by the signet ring, Maleb said. I brought seven back from the ruins of Strahnbrad, and the magistrate said the Syndicate was now just a gang of thugs. I'd thought of them that way from the start.",
            quests = {
                { id = 505, name = "Syndicate Assassins", npc = "Magistrate Henry Maleb", faction = "Alliance", gameVersions = { forever = true } },
                { id = 510, name = "Foreboding Plans", npc = "Syndicate Documents", faction = "Alliance", parallel = true, gameVersions = { forever = true } },
                { id = 512, name = "Noble Deaths", npc = "Magistrate Henry Maleb", faction = "Alliance", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "Baron Vardus",
            requiredLevel = 30,
            summaryAlliance = "Shadowy Assassins still slip into Southshore now and then, and one of them carries a contract. Take it and bring it to Magistrate Maleb in the town hall, who will want to know whose name is on it.",
            summaryHorde = "A wanted poster in Tarren Mill names Baron Vardus, one of the old Alterac nobles who lead the Syndicate up in the mountains. High Executor Darthalia will pay for his head.",
            recapAlliance = "The Syndicate hadn't given up on Southshore. Their assassins still slipped into town now and then, and one I killed was carrying a contract, which seems careless for someone in that trade. I took it to Maleb.\n\nAfter reading it, the magistrate wanted the head of Baron Vardus, one of the nobles who lead the Syndicate. Vardus moves around the Alterac Mountains, so finding him took some walking, and getting the head off him took less time than that. I brought it back down to Southshore and handed it over.",
            recapHorde = "There's a wanted poster up in Tarren Mill for Baron Vardus. The Syndicate is a gang of thieves led by what's left of Alterac's nobility, and Vardus is one of those nobles. The poster still calls him Baron, which is more courtesy than most wanted men get.\n\nHigh Executor Darthalia wanted his head. Vardus moves around the Alterac Mountains, so finding him took some walking, and getting the head off him took less time than that. I carried it back down to Tarren Mill and collected the bounty from Darthalia.",
            quests = {
                -- Starts from the Assassin's Contract, which the Shadowy
                -- Assassins drop in and around Southshore.
                { id = 522, name = "Assassin's Contract", faction = "Alliance", mapID = 1424, x = 0.4820, y = 0.5930, location = "the Shadowy Assassins, Southshore, Hillsbrad Foothills", gameVersions = { forever = true } },
                { id = 523, name = "Baron's Demise", npc = "Magistrate Henry Maleb", faction = "Alliance", gameVersions = { forever = true } },
                { id = 566, name = "WANTED: Baron Vardus", npc = "WANTED", faction = "Horde", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "Strahnbrad Mystery",
            summary = "The Syndicate's casters in Strahnbrad carry a singed note. Rumor has it the old bellows at the town forge come to life when no one is watching. The note is scorched as if by fire magic, and the forge might want a taste of the same.",
            recapAlliance = "One of the Syndicate's casters in Strahnbrad had a singed note on them. According to the note, the old bellows at the town forge had a mind of their own and came to life when no one was watching. Whoever wrote it wanted the matter cleared up before coming back, ghost story or not.\n\nSo I went and watched the bellows. They did nothing, which to be fair is what the rumor said they'd do. Then I gave each of them some fire. A flare went up over my head both times, and after the second an ancient fire elemental came out of the top of the forge and landed between them.\n\nIt was made of fire and didn't mind more of it, so I put it out the hard way. Afterward I took my findings down to Kundric Zanden, the town historian in Southshore.",
            recapHorde = "One of the Syndicate's casters in Strahnbrad had a singed note on them. According to the note, the old bellows at the town forge had a mind of their own and came to life when no one was watching. Whoever wrote it wanted the matter cleared up before coming back, ghost story or not.\n\nSo I went and watched the bellows. They did nothing, which to be fair is what the rumor said they'd do. Then I gave each of them some fire. A flare went up over my head both times, and after the second an ancient fire elemental came out of the top of the forge and landed between them.\n\nIt was made of fire and didn't mind more of it, so I put it out the hard way. Afterward I took my findings down to Shara Blazen in Tarren Mill.",
            quests = {
                -- Starts from the Singed Note, which Syndicate Wizards and Argus
                -- Shadow Mages drop in Strahnbrad.
                { id = 95534, name = "Strahnbrad Mystery", mapID = 1416, x = 0.6140, y = 0.4540, location = "the Syndicate Wizards and Argus Shadow Mages, Strahnbrad, Alterac Mountains", gameVersions = { forever = true } },
            },
        },
    },
}
