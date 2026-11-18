local addonName, SM = ...

-- =============================================================================
-- Dustwallow: The Shady Rest Inn
-- A burned-inn mystery with faction-specific investigations.
-- =============================================================================

SM.ShadyRestInnData = {
    title = "The Shady Rest Inn",
    description = "On the road between Dustwallow Marsh and the Barrens, the Shady Rest Inn is nothing but ash, hoofprints, a scorched shield, and a guard badge that should not be there.\n\nFollow the clues before faction blame buries the truth.",
    zone = "Dustwallow Marsh",
    expansion = "World of Warcraft",
    recommendedLevel = { min = 30, max = 39 },
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.66, 0.52, 0.34 },
    icon = "Interface\\Icons\\INV_Misc_Note_01",
    adventureCoverTexture = 131871, -- Stratholme loading screen: burned-city mood for the Shady Rest investigation
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 1284, name = "Suspicious Hoofprints", npc = "Hoofprints", location = "the ruins of the Shady Rest Inn, Dustwallow Marsh", mapID = 70, x = 0.2970, y = 0.4770 },
    startMapID = 70,
    startX = 0.2970,
    startY = 0.4770,

    npcLocations = {
        ["Adjutant Tesoran"] = { mapID = 70, x = 0.6810, y = 0.4820, location = "Foothold Citadel, Theramore Isle" },
        ["Balos Jacken"] = { mapID = 70, x = 0.3540, y = 0.5400, location = "Lost Point, Dustwallow Marsh" },
        ["Black Shield"] = { mapID = 70, x = 0.2960, y = 0.4860, location = "the ruins of the Shady Rest Inn, Dustwallow Marsh" },
        ["Captain Darill"] = { mapID = 70, x = 0.4700, y = 0.2400, location = "North Point Tower, Dustwallow Marsh" },
        ["Captain Garran Vimes"] = { mapID = 70, x = 0.6820, y = 0.4860, location = "Foothold Citadel, Theramore Isle" },
        ["Caz Twosprocket"] = { mapID = 70, x = 0.6450, y = 0.5040, location = "the Theramore blacksmith, Dustwallow Marsh" },
        ["Grunt Logmar"] = { mapID = 10, x = 0.4460, y = 0.5920, location = "Camp Taurajo, The Barrens" },
        ["Do'gol"] = { mapID = 70, x = 0.3600, y = 0.3100, location = "Brackenwall Village, Dustwallow Marsh" },
        ["Guard Byron"] = { mapID = 70, x = 0.6620, y = 0.4560, location = "Theramore Isle, Dustwallow Marsh" },
        ["Hoofprints"] = { mapID = 70, x = 0.2970, y = 0.4770, location = "outside the ruins of the Shady Rest Inn, Dustwallow Marsh" },
        ["Krog"] = { mapID = 70, x = 0.3640, y = 0.3180, location = "Brackenwall Village, Dustwallow Marsh" },
        ["Mosarn"] = { mapID = 88, x = 0.5560, y = 0.7960, location = "Thunder Bluff" },
        ["Ogron"] = { mapID = 70, x = 0.4000, y = 0.3600, location = "Brackenwall Village, Dustwallow Marsh" },
        ["Tabetha"] = { mapID = 70, x = 0.4600, y = 0.5710, location = "Tabetha's Farm, Dustwallow Marsh" },
        ["Theramore Guard Badge"] = { mapID = 70, x = 0.2980, y = 0.4820, location = "inside the ruins of the Shady Rest Inn, Dustwallow Marsh" },
    },

    chapterIcons = {
        ["The Ruins"] = "Interface\\Icons\\Ability_Tracking",
        ["The Black Shield"] = "Interface\\Icons\\INV_Shield_09",
        ["Paval Reethe"] = "Interface\\Icons\\INV_Misc_Note_01",
        ["The Hidden Hand"] = "Interface\\Icons\\Spell_Nature_EarthBindTotem",
    },

    npcDisplayIDs = {
        -- Quest givers' models from the cmangos Classic database.
        ["Guard Byron"] = 2910,
        ["Captain Garran Vimes"] = 2952,
        ["Caz Twosprocket"] = 2950,
        ["Adjutant Tesoran"] = 2953,
        ["Balos Jacken"] = 3017,
        ["Grunt Logmar"] = 4547,
        ["Do'gol"] = 655,
        ["Ogron"] = 10704,
    },

    chapters = {
        {
            chapter = "The Ruins",
            faction = "Alliance",
            summary = "The Shady Rest Inn, on the road between the Barrens and Dustwallow Marsh, has burned to the ground. Everyone has a theory about who did it. Captain Garran Vimes in Theramore would rather have evidence. Start at the ruins.",
            recap = "The Shady Rest was an inn on the road between the Barrens and Dustwallow Marsh, and by the time I saw it, it was a black heap. Captain Garran Vimes in Theramore wanted to know who'd done it. So did everyone else, and everyone else already had a theory.\n\nIn the mud outside were hoofprints. Not a horse's. Bring that back to Theramore and you can hear the room decide what happened before you've finished the sentence.\n\nVimes listened, though, and didn't decide anything. Good instinct, as it turned out. There was a lot more in that ash than hoofprints, and none of it agreed with the rest.",
            quests = {
                { id = 11123, name = "Inspecting the Ruins", npc = "Captain Garran Vimes", gameVersions = { tbc = true } },
                { id = 1284, name = "Suspicious Hoofprints", npc = "Hoofprints" },
                { id = 1282, name = "They Call Him Smiling Jim", npc = "Guard Byron", optional = true },
            },
        },
        {
            chapter = "The Black Shield",
            faction = "Alliance",
            summary = "In what's left of the Shady Rest's fireplace lies a shield: black iron, scorched, and far too big for a human arm. Theramore will jump to conclusions. Captain Vimes would rather know where it was made.",
            recap = "In what was left of the fireplace sat a shield. Black iron, scorched through, and far too big for a human arm. You can imagine how that went down in Theramore.\n\nVimes didn't jump at it. Instead I was sent across town to Caz Twosprocket at the smithy, to see what the metal had to say for itself. Caz turned it over and over, gave it the long look smiths save for other people's work, and the verdict was: not made here. Not in Theramore. Past that, nobody would swear to anything.\n\nI carried the verdict back to Vimes. It looked bad for the Horde, and that was what bothered me. A shield that big, left lying right where the first person to poke the ashes would find it. It felt like somebody wanted it found.",
            quests = {
                { id = 1253, name = "The Black Shield", npc = "Black Shield" },
                { id = 1319, name = "The Black Shield", displayName = "The Black Shield: Caz Twosprocket", npc = "Captain Garran Vimes" },
                { id = 1320, name = "The Black Shield", displayName = "The Black Shield: Vimes' Report", npc = "Caz Twosprocket" },
            },
        },
        {
            chapter = "Paval Reethe",
            faction = "Alliance",
            summary = "There's a badge in the ashes as well, Theramore Guard, with a name on it: Lieutenant Paval Reethe. A Theramore officer's badge has no business at a burned inn. Captain Vimes will want to check the records.",
            recap = "The badge in the ashes belonged to Lieutenant Paval Reethe of the Theramore Guard. The records said Reethe had been one of Daelin's men. Admiral Proudmoore's, that is, from before his daughter made peace with the orcs. Plenty of those fellows never forgave her for it, and Reethe had walked off the job.\n\nWhere do deserters go in Dustwallow? Lost Point, it turns out, to a crew of former Theramore soldiers with no love left for their old command. Their leader gave me Reethe's story in the end.\n\nI brought it back to Vimes. Reethe had reasons to hate the Horde, and Reethe's badge had been at the inn. On paper, that's a case. In person it was too neat. Nobody makes lieutenant by dropping a badge at the scene.",
            quests = {
                { id = 1252, name = "Lieutenant Paval Reethe", npc = "Theramore Guard Badge" },
                { id = 1259, name = "Lieutenant Paval Reethe", displayName = "Lieutenant Paval Reethe: Records", npc = "Captain Garran Vimes" },
                { id = 1285, name = "Daelin's Men", npc = "Adjutant Tesoran" },
                { id = 1286, name = "The Deserters", displayName = "The Deserters: Lost Point", npc = "Captain Garran Vimes" },
                { id = 1287, name = "The Deserters", displayName = "The Deserters: Balos' Account", npc = "Balos Jacken" },
            },
        },
        {
            chapter = "The Hidden Hand",
            faction = "Alliance",
            gameVersions = { tbc = true },
            summary = "Captain Vimes isn't satisfied yet. One more lead goes north, to Captain Darill at North Point Tower, who has a suspicion about the fire at the Shady Rest and needs someone to go and test it.",
            recap = "Vimes had one more lead, and it went north to the captain at North Point Tower, who had a nasty suspicion about the Grimtotem. That's the tauren clan that hates everybody. A battle plan, a note and an armful of armaments out of Blackhoof Village later, the suspicion had teeth. The Grimtotem had burned the Shady Rest and dressed it up to look like the Horde, then sat back to watch Theramore and the Horde go for each other.\n\nTabetha, out at her farm, knew where to hit back: Direhorn Post. I burned three tents there and slept fine that night.\n\nAfterwards Vimes gave me a wreath, and I laid it at the Hyal family monument. Quiet spot. I stayed a minute.",
            quests = {
                { id = 11143, name = "A Grim Connection", npc = "Captain Garran Vimes" },
                { id = 11144, name = "Confirming the Suspicion", npc = "Captain Darill" },
                { id = 11148, name = "Arms of the Grimtotems", npc = "Captain Darill", parallel = true },
                { id = 11149, name = "Tabetha's Assistance", npc = "Captain Darill" },
                { id = 11150, name = "Raze Direhorn Post!", npc = "Tabetha" },
                { id = 11151, name = "Justice for the Hyals", npc = "Tabetha" },
                { id = 11152, name = "Peace at Last", npc = "Captain Garran Vimes" },
            },
        },
        {
            chapter = "The Ruins",
            faction = "Horde",
            summary = "The Shady Rest Inn, on the road between the Barrens and Dustwallow Marsh, has burned down, and the talk is that the Horde did it. Krog in Brackenwall Village would like the truth first. Start at the ruins.",
            -- On WoW Forever the news reaches the Barrens first, with the Alliance soldiers it brought.
            foreverText = {
                summary = "Word of a burned inn has reached Camp Taurajo, and with it Alliance soldiers who blame the Horde. Grunt Logmar wants them seen off. The inn, the Shady Rest, is just over the border in Dustwallow Marsh.",
            },
            recap = "Word travels fast when an inn burns down and somebody says the Horde did it. The Shady Rest sat on the road between the Barrens and Dustwallow, and when I got there it was ash and a few black beams.\n\nIn the mud outside were hoofprints. Tauren-sized. Exactly what you'd want to find, if you wanted Theramore to blame the Horde. I took that to Krog in Brackenwall Village, who had orders to look into the fire and no intention of letting Theramore tell the story first.\n\nThere was more in those ashes, too. A blackened shield. A Theramore guard's badge. Every clue pointed somewhere different, and every one of them pointed somewhere awfully convenient.",
            quests = {
                { id = 97250, name = "Wrongly Blamed, Justly Corrected", npc = "Grunt Logmar", gameVersions = { forever = true } },
                { id = 11124, name = "Inspecting the Ruins", npc = "Krog", gameVersions = { tbc = true } },
                { id = 1268, name = "Suspicious Hoofprints", npc = "Hoofprints" },
            },
        },
        {
            chapter = "The Black Shield",
            faction = "Horde",
            summary = "A blackened iron shield sits in the Shady Rest's fireplace, heavy enough to stop a charging kodo. Krog in Brackenwall Village will want to see it before anyone starts drawing conclusions.",
            recap = "Black iron, scorched, heavy enough to stop a charging kodo: that was the shield in the fireplace. Krog sent me to Do'gol with it, and Do'gol wanted six acidic venom sacs before anything else happened. I fetched them. Do'gol did whatever you do to a shield with acid, and I carried the thing back to Krog.\n\nKrog wanted another opinion and sent me all the way to Thunder Bluff to show it to Mosarn. That's a long way to carry a shield. You get attached.\n\nMosarn knew the craft, and that should have settled it. It didn't, for me. A shield can be carried into an inn by anybody. It can be left behind by anybody, too, right where somebody's bound to find it.",
            quests = {
                { id = 1251, name = "The Black Shield", npc = "Black Shield" },
                { id = 1321, name = "The Black Shield", displayName = "The Black Shield: Do'gol", npc = "Krog" },
                { id = 1322, name = "The Black Shield", displayName = "The Black Shield: Do'gol's Findings", npc = "Do'gol" },
                { id = 1323, name = "The Black Shield", displayName = "The Black Shield: Return to Krog", npc = "Do'gol" },
                { id = 1276, name = "The Black Shield", displayName = "The Black Shield: Mosarn", npc = "Krog" },
            },
        },
        {
            chapter = "Paval Reethe",
            faction = "Horde",
            summary = "A Theramore Guard badge turns up in the ashes, with a name on it: Lieutenant Paval Reethe. Krog in Brackenwall Village will want to know what a Theramore badge was doing at the Shady Rest.",
            recap = "There was a badge in the ashes as well, Theramore Guard, belonging to a Lieutenant Paval Reethe. I brought it to Krog, and the next thing I knew I was out in the marsh with Ogron, going to ask Reethe a few questions.\n\nOgron did the asking, after a fashion. Reethe was cornered and jumpy and in no mood to chat, and it went the way these things go when everybody in the conversation is armed. Reethe didn't walk away from it.\n\nSo that was our suspect: dead, and quickly. Very tidy. A bit too tidy for my liking. If you wanted a case closed before anyone asked the next question, you couldn't have arranged it better.",
            quests = {
                { id = 1269, name = "Lieutenant Paval Reethe", npc = "Theramore Guard Badge" },
                { id = 1273, name = "Questioning Reethe", npc = "Ogron" },
            },
        },
        {
            chapter = "The Hidden Hand",
            faction = "Horde",
            gameVersions = { tbc = true },
            summary = "Mosarn, in Thunder Bluff, has remembered something about that black shield, and Krog ought to hear it. Back to Brackenwall Village, then. It's a long way to carry a thought.",
            recap = "Mosarn remembered something about that shield and sent me back to Krog with it. Krog had me fetch Blackhoof armaments and a Grimtotem battle plan, and laid side by side, it all came together. The Grimtotem had burned the Shady Rest and left the Horde holding the torch, so that Theramore and Brackenwall would go for each other while the Grimtotem sat back and watched.\n\nTabetha, of all people, knew where the attack had come from: Direhorn Post. A human mage pointing me at a tauren camp. Strange times. I burned the north tent, the east tent and the northeast tent, and walked off with the smoke at my back.\n\nKrog called it justice. I called it a long week.",
            quests = {
                { id = 11204, name = "Return to Krog", npc = "Mosarn" },
                { id = 11200, name = "More than Coincidence", npc = "Krog" },
                { id = 11201, name = "The Grimtotem Plot", npc = "Krog", parallel = true },
                { id = 11203, name = "Seek Out Tabetha", npc = "Krog" },
                { id = 11205, name = "Raze Direhorn Post!", npc = "Tabetha" },
                { id = 11206, name = "Justice Dispensed", npc = "Tabetha" },
            },
        },
    },
}
