local addonName, SM = ...

-- =============================================================================
-- Classic: Hidden Enemies
-- Thrall's hunt for the Burning Blade: Skull Rock, the warlock in the Cleft of
-- Shadow, and the Searing Blade down in Ragefire Chasm.
-- =============================================================================

SM.HiddenEnemiesData = {
    title = "Hidden Enemies",
    description = "Thrall will not tolerate traitors in Orgrimmar, and he is sure there are some. The Burning Blade, an old demon-worshipping cult of the orcs, still keeps a cave in Durotar, and the Warchief suspects its reach goes much further into his city.\n\nHis own agents would be recognized, so he wants a new face for the work. Start in Grommash Hold, and follow the trail out to Skull Rock and down beneath the city into Ragefire Chasm.",
    zone = "Orgrimmar / Durotar / Thunder Bluff / Undercity / Ragefire Chasm",
    expansion = "Classic",
    recommendedLevel = { min = 9, max = 16 },
    faction = "Horde",
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.66, 0.26, 0.16 },
    icon = 134417, -- inv_misc_rune_04 (Lieutenant's Insignia)
    portraitDisplayID = 61727, -- Thrall
    adventureGuideInstanceName = "Ragefire Chasm",
    adventureCoverTexture = 131862, -- Ragefire Chasm loading screen
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 5726, name = "Hidden Enemies", npc = "Thrall", location = "Grommash Hold, Orgrimmar" },
    startMapID = 85,
    startX = 0.3200,
    startY = 0.3780,

    npcLocations = {
        ["Thrall"] = { mapID = 85, x = 0.3200, y = 0.3780, location = "Grommash Hold, Orgrimmar" },
        ["Neeru Fireblade"] = { mapID = 85, x = 0.4960, y = 0.5040, location = "the Cleft of Shadow, Orgrimmar" },
        ["Rahauro"] = { mapID = 88, x = 0.7040, y = 0.2960, location = "Elder Rise, Thunder Bluff" },
        ["Varimathras"] = { mapID = 90, x = 0.5640, y = 0.9240, location = "the Royal Quarter, Undercity" },
        -- Maur Grimtotem's corpse lies inside Ragefire Chasm; Wowhead has no
        -- coordinates for it, so its quest carries a location instead.
    },

    npcDisplayIDs = {
        ["Thrall"] = 61727, -- as in the other Classic stories (cmangos has 4527)
        -- Quest givers' models from the cmangos Classic database.
        ["Neeru Fireblade"] = 3754,
        ["Rahauro"] = 11754,
        ["Maur Grimtotem"] = 11755,
        ["Varimathras"] = 11658,
    },

    chapterDisplayIDs = {
        ["Skull Rock"] = 61727, -- Thrall
        ["Ragefire Chasm"] = 2007, -- Bazzalan
        ["Hidden Enemies"] = 3754, -- Neeru Fireblade
    },

    chapterIcons = {
        ["Skull Rock"] = 134417, -- inv_misc_rune_04 (Lieutenant's Insignia)
        ["Ragefire Chasm"] = 135805, -- spell_fire_fire
        ["Hidden Enemies"] = 132320, -- ability_stealth
    },

    chapters = {
        {
            chapter = "Skull Rock",
            requiredLevel = 9,
            summary = "Thrall suspects there are traitors in Orgrimmar, and he'd rather not show his hand by sending agents they already know. He wants a new face for the job. Find the Warchief in Grommash Hold, where he has an errand for you at Skull Rock.",
            recap = "Thrall knows there are traitors in Orgrimmar, and he wanted a face the cult had never seen. I was young and unknown, which for once counted in my favor.\n\nThe Burning Blade keep a cave at Skull Rock, where one of them carried a small rune that marks a lieutenant. I brought it to Thrall, who said I reminded him of himself when he was younger.\n\nNext the rune went to Neeru Fireblade, a warlock in the Cleft of Shadow. Thrall knows Neeru leads the cult and leaves him in place on purpose. Neeru welcomed me in, his ranks growing too fast for him to remember faces, and called Thrall a fool. He sends Thrall's people into the chasm under the city against the Searing Blade, he said, which kills off Thrall's followers and tests the cultists. Two of the Searing Blade's leaders were the ones he valued.\n\nThrall wanted every word of it.",
            quests = {
                { id = 5726, name = "Hidden Enemies", displayName = "The Lieutenant's Insignia", npc = "Thrall" },
                { id = 5727, name = "Hidden Enemies", displayName = "Neeru's Reaction", npc = "Thrall" },
            },
        },
        {
            chapter = "Ragefire Chasm",
            requiredLevel = 9,
            summary = "Thrall, in Grommash Hold, wants two leaders of the Searing Blade killed in Ragefire Chasm, under the Cleft of Shadow, without anyone in the Cleft finding out who did it. Rahauro in Thunder Bluff and Varimathras in the Undercity have business in the chasm too.",
            recap = "Neeru had let slip which two of the Searing Blade he valued, and Thrall decided they would go first. One was a satyr. The other was Jergosh, and Thrall had to stop and think what Jergosh was. A warlock, he believed. In Ragefire Chasm that narrows it down very little.\n\nThe way into the chasm is in the Cleft of Shadow, a short walk from Neeru's door, and Neeru was not to learn who had done it. So I strolled past his door on my way to kill his two favorites, doing my best impression of a lieutenant on cult business.\n\nBoth died down there. Back in Grommash Hold, Thrall's people had already told him the caverns were in disarray and Neeru was more than agitated. Thrall allowed that he wasn't displeased, and called it a dent in Neeru's armor.",
            quests = {
                { id = 5728, name = "Hidden Enemies", displayName = "Bazzalan and Jergosh", npc = "Thrall" },
                { id = 5761, name = "Slaying the Beast", npc = "Neeru Fireblade", optional = true, parallel = true, recap = "Neeru Fireblade had a job of his own for me in the chasm. The Warchief, he explained, had charged him with rooting out the demonic influence in Orgrimmar, and the Burning Blade was only one of the threats. He kept a straight face the whole time. The Searing Blade answered to a felguard called Taragaman the Hungerer, and Neeru wanted the heart. I brought it, and Neeru promised to tell Thrall of my success himself." },
                { id = 5723, name = "Testing an Enemy's Strength", npc = "Rahauro", optional = true, parallel = true, recap = "Rahauro, on Elder Rise in Thunder Bluff, speaks for Magatha Grimtotem. Troggs had been coming up out of the lava tunnels under Orgrimmar, and Magatha, ever benevolent, had sent diplomats to make peace. The troggs killed them. The next envoy was me, and there are sixteen fewer troggs now, half of them shamans. Rahauro said it might be worth finding out someday what the troggs actually want." },
                { id = 5722, name = "Searching for the Lost Satchel", npc = "Rahauro", optional = true, parallel = true, recap = "Magatha had also lost one of her own in the chasm. Maur Grimtotem had found something peculiar down there while trying to talk to the troggs, and never came back up to show her what. I found what was left of him. Clubs or fists, by the look of it. The troggs hadn't taken a thing he carried, having no interest in property that I could see." },
                { id = 5724, name = "Returning the Lost Satchel", npc = "Maur Grimtotem", location = "Ragefire Chasm", optional = true, parallel = true, recap = "Maur still had a satchel gripped tight in both arms, as if he'd spent the whole beating protecting it. I got it loose and carried it up to Rahauro in Thunder Bluff. Magatha had left word that whoever found her clansman should be rewarded, and Rahauro saw to it." },
                { id = 5725, name = "The Power to Destroy...", npc = "Varimathras", optional = true, parallel = true, recap = "Varimathras, in the Undercity's Royal Quarter, explained that the Legion likes to give its followers gifts, and that the Dark Lady feels some of them would be better off in her hands. The Searing Blade had two spellbooks she wished to borrow. Varimathras made the quotation marks around borrow quite audible. I brought back Spells of Shadow and Incantations from the Nether, and the Searing Blade shouldn't expect either one back." },
            },
        },
        {
            chapter = "Hidden Enemies",
            requiredLevel = 9,
            summary = "Word from Ragefire Chasm has reached the Cleft of Shadow, and Neeru Fireblade is said to be in a foul temper. Thrall, in Grommash Hold, sees a chance to put you closer to Neeru while the warlock is rattled.",
            recap = "Thrall wanted me closer to Neeru while Neeru was rattled. With two of his leaders dead he might be short of help, and Thrall hoped he'd ask me for some. I was to go back to the Cleft and not be too obvious about it.\n\nNeeru snapped at me before he saw who it was, then apologized. His anger, he said, rivaled a rabid kodo bull's. Some of Thrall's do-gooders had caught his leaders unaware, and he blamed himself for sending travelers down there at all. I kept my face very still.\n\nThen he named me one of his lieutenants. The chasm was mostly a loss now, but his agents in the Barrens and Ashenvale would start on something new. Thrall hadn't heard of the Shadow Council in Ashenvale and put his spies on it.\n\nBoth of them said they'd call on me soon. I'm hoping they don't pick the same day.",
            quests = {
                { id = 5729, name = "Hidden Enemies", displayName = "Return to Neeru", npc = "Thrall" },
                { id = 5730, name = "Hidden Enemies", displayName = "Report to Thrall", npc = "Neeru Fireblade" },
            },
        },
    },
}
