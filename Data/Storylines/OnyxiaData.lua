local addonName, SM = ...

-- =============================================================================
-- Classic: Onyxia and the Black Dragonflight
-- Alliance and Horde attunements to Onyxia's Lair.
-- =============================================================================

SM.OnyxiaData = {
    title = "The Drakefire Amulet",
    description = "In the Burning Steppes, Helendis Riverhorn has orders for the Alliance against black dragonkin gathering near Morgan's Vigil. In Kargath, Warlord Goretooth has a command for the Horde that points into Blackrock Spire.\n\nTake the first report and follow your faction's chain of summons, proofs, and dangerous names. The amulet at the end of the road is not given to anyone who has only heard rumors of dragons.",
    descriptionAlliance = "In the Burning Steppes, Helendis Riverhorn has orders against the black dragonkin gathering near Morgan's Vigil.\n\nTake the first report and follow the chain of summons, proofs, and dangerous names wherever it leads. The amulet at the end of the road is not given to anyone who has only heard rumors of dragons.",
    descriptionHorde = "In Kargath, Warlord Goretooth has a command that points into Blackrock Spire.\n\nTake the first order and follow the chain of summons, proofs, and dangerous names wherever it leads. The amulet at the end of the road is not given to anyone who has only heard rumors of dragons.",
    zone = "Burning Steppes / Blackrock Mountain / Stormwind / Dustwallow Marsh",
    expansion = "Classic",
    recommendedLevel = { min = 48, max = 60 },
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.78, 0.24, 0.08 },
    icon = 134153,
    adventureGuideInstanceName = "Onyxia's Lair",
    adventureCoverTexture = 131825, -- Blackrock Spire: closest Classic loading screen for the Rend/Drakkisath attunement path
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 4182, name = "Dragonkin Menace", npc = "Helendis Riverhorn", location = "Morgan's Vigil, Burning Steppes", faction = "Alliance" },
    startMapID = 36,
    startX = 0.8500,
    startY = 0.6900,

    npcLocations = {
        ["Helendis Riverhorn"] = { mapID = 36, x = 0.8500, y = 0.6900, location = "Morgan's Vigil, Burning Steppes" },
        ["Magistrate Solomon"] = { mapID = 49, x = 0.2900, y = 0.4400, location = "Lakeshire, Redridge Mountains" },
        ["Highlord Bolvar Fordragon"] = { mapID = 84, x = 0.7817, y = 0.1809, location = "Stormwind Keep" },
        ["Marshal Maxwell"] = { mapID = 36, x = 0.8400, y = 0.6900, location = "Morgan's Vigil, Burning Steppes" },
        ["Reginald Windsor"] = { mapID = 84, x = 0.6470, y = 0.7679, location = "Stormwind gates" },
        ["Ragged John"] = { mapID = 36, x = 0.6500, y = 0.2400, location = "north of the Ruins of Thaurissan, Burning Steppes" },
        ["Marshal Windsor"] = { mapID = 242, x = 0.4628, y = 0.9469, location = "the Detention Block, Blackrock Depths" },
        ["A Crumpled Up Note"] = { mapID = 242, x = 0.4800, y = 0.6200, location = "Blackrock Depths" },
        ["Squire Rowe"] = { mapID = 84, x = 0.6600, y = 0.3200, location = "Stormwind gates" },
        ["Haleh"] = { mapID = 83, x = 0.5400, y = 0.5100, location = "Mazthoril, Winterspring" },

        ["Warlord Goretooth"] = { mapID = 15, x = 0.0500, y = 0.4700, location = "Kargath, Badlands" },
        ["Eitrigg"] = { mapID = 85, x = 0.3200, y = 0.3800, location = "Grommash Hold, Orgrimmar" },
        ["Thrall"] = { mapID = 85, x = 0.3200, y = 0.3800, location = "Grommash Hold, Orgrimmar" },
        ["Rexxar"] = { mapID = 66, x = 0.2574, y = 0.7006, location = "the road through Desolace" },
        ["Myranda the Hag"] = { mapID = 22, x = 0.5100, y = 0.7800, location = "Sorrow Hill, Western Plaguelands" },
        ["Emberstrife"] = { mapID = 70, x = 0.5600, y = 0.8700, location = "Emberstrife's Den, Dustwallow Marsh" },
        ["Scryer"] = { mapID = 83, x = 0.5200, y = 0.5500, location = "southwest of Everlook, Winterspring" },
        ["Somnus"] = { mapID = 51, x = 0.7500, y = 0.6500, location = "southeastern Swamp of Sorrows" },
        ["Chronalis"] = { mapID = 71, x = 0.6500, y = 0.5000, location = "the Caverns of Time, Tanaris" },
        ["Axtroz"] = { mapID = 56, x = 0.8200, y = 0.4800, location = "the road to Grim Batol, Wetlands" },
        ["General Drakkisath"] = { mapID = 250, x = 0.6200, y = 0.3500, location = "Upper Blackrock Spire" },
    },

    npcDisplayIDs = {
        ["Highlord Bolvar Fordragon"] = 24879,
        ["Marshal Windsor"] = 8707,
        ["Reginald Windsor"] = 9052,
        ["Lady Katrana Prestor"] = 8769,
        ["Onyxia"] = 8570,
        ["Thrall"] = 61727,
        ["Rexxar"] = 60766,
        ["Emberstrife"] = 6374,
        ["General Drakkisath"] = 10115,
        -- Quest givers' models from the cmangos Classic database.
        ["Helendis Riverhorn"] = 8694,
        ["Magistrate Solomon"] = 1753,
        ["Marshal Maxwell"] = 8685,
        ["Haleh"] = 10199,
        ["Warlord Goretooth"] = 8331,
        ["Myranda the Hag"] = 11800,
    },

    chapterDisplayIDs = {
        ["The True Masters"] = 5566,
        ["Marshal Windsor"] = 8707,
        ["The Great Masquerade"] = 8769,
        ["The Drakefire Amulet"] = 8570,
        ["For the Horde"] = 4527,
        ["Rexxar's Testament"] = 10182,
        ["The Test of Skulls"] = 6374,
        ["Blood of the Black Dragon Champion"] = 10115,
    },

    chapterIcons = {
        ["The True Masters"] = 134327,
        ["Marshal Windsor"] = 134943,
        ["The Great Masquerade"] = 134328,
        ["The Drakefire Amulet"] = 134153,
        ["For the Horde"] = 132349,
        ["Rexxar's Testament"] = 132320,
        ["The Test of Skulls"] = 134157,
        ["Blood of the Black Dragon Champion"] = 134153,
    },

    chapters = {
        {
            chapter = "The True Masters",
            faction = "Alliance",
            summary = "Black dragonkin are gathering in the Burning Steppes, uncomfortably close to Morgan's Vigil. Helendis Riverhorn at the Vigil wants their numbers thinned, from the smallest broodling right up to a drake.",
            recap = "Morgan's Vigil had a dragonkin problem, and for about an afternoon I was the solution. Then the letters started. The Vigil wrote to the magistrate in Lakeshire, the magistrate wrote to Stormwind, and I carried every one of them up and down the kingdom like a well-armed pigeon.\n\nIn the keep, Lady Katrana Prestor had a little advice for me before the Highlord gave his answer. The answer was no. A very polite no, on very good paper. The magistrate read it twice and stopped being polite himself.\n\nWhich is how I ended up in a cave up north of the Ruins of Thaurissan, listening to a fellow called Ragged John tell me what had become of a marshal named Windsor. The ragged part, I'll say, was earned.",
            quests = {
                { id = 4182, name = "Dragonkin Menace", npc = "Helendis Riverhorn" },
                { id = 4183, name = "The True Masters", displayName = "To Lakeshire", npc = "Helendis Riverhorn" },
                { id = 4184, name = "The True Masters", displayName = "To Stormwind", npc = "Magistrate Solomon" },
                { id = 4185, name = "The True Masters", displayName = "Back to Lakeshire", npc = "Highlord Bolvar Fordragon" },
                { id = 4186, name = "The True Masters", displayName = "To Morgan's Vigil", npc = "Highlord Bolvar Fordragon" },
                { id = 4223, name = "The True Masters", displayName = "Ragged John's Tale", npc = "Magistrate Solomon" },
                { id = 4224, name = "The True Masters", displayName = "Return to Maxwell", npc = "Marshal Maxwell" },
            },
        },
        {
            chapter = "Marshal Windsor",
            faction = "Alliance",
            summary = "Ragged John's tale ended with Marshal Windsor dragged off to a prison. Marshal Maxwell at Morgan's Vigil wants to know what became of him, and the trail leads into Blackrock Depths, under Blackrock Mountain.",
            recap = "Ragged John's tale ended in a Dark Iron prison, so down into Blackrock Depths I went, and there was Marshal Windsor in a cell, finished. They'd taken his proof, and with it whatever had been holding him up. He sent me back to give Maxwell the bad news.\n\nHe'd have stayed finished, too, if a crumpled note hadn't turned up in the Depths. One look at it and the marshal was back. His papers were with a golem lord and a general down there, and neither of them wanted to give anything back. I didn't take it personally.\n\nOnce Windsor had his papers, he wanted his gear and his friends out of their cells, in that order. Blackrock Depths had opinions about that. We got both anyway.",
            quests = {
                { id = 4241, name = "Marshal Windsor", npc = "Marshal Maxwell" },
                { id = 4242, name = "Abandoned Hope", npc = "Marshal Windsor" },
                { id = 4264, name = "A Crumpled Up Note", npc = "A Crumpled Up Note" },
                { id = 4282, name = "A Shred of Hope", npc = "Marshal Windsor" },
                { id = 4322, name = "Jail Break!", npc = "Marshal Windsor" },
            },
        },
        {
            chapter = "The Great Masquerade",
            faction = "Alliance",
            summary = "Marshal Maxwell at Morgan's Vigil has word from Marshal Windsor: he's bound for Stormwind and wants you there when he arrives. Go to the city gates and find Squire Rowe, who will let Windsor know you've come.",
            recap = "A squire at the gates of Stormwind had one job that day: let Marshal Windsor know I'd come. Then Windsor arrived, and we walked into the city together, and I kept him alive all the way up to the keep. That took some doing.\n\nIn the throne room he faced Lady Katrana Prestor, the most trusted voice at court, and called her by her real name. Onyxia. The whole court got a good look at what had been whispering in the Highlord's ear all this time.\n\nShe killed him for it, right there. But the secret was out, and there's no spell in the world that puts that back.\n\nI never got to buy him a drink. So this one's his.",
            quests = {
                { id = 6402, name = "Stormwind Rendezvous", npc = "Marshal Maxwell" },
                { id = 6403, altIds = { 99435 }, name = "The Great Masquerade", npc = "Reginald Windsor" },
            },
        },
        {
            chapter = "The Drakefire Amulet",
            faction = "Alliance",
            summary = "Highlord Bolvar Fordragon in Stormwind Keep hands you a fragment of the Dragon's Eye. Someone out there can restore its power. That is the whole of what anyone knows about them, so the search may take a while.",
            recap = "Afterward the Highlord handed me a fragment of something called the Dragon's Eye and told me to find someone who could restore its power. Who? Nobody knew. Where? Nobody knew that either. All anyone could say for certain was that such a someone existed. I've had better directions from drunks.\n\nThe someone turned out to be Haleh, up at Mazthoril in Winterspring, and Haleh's price for the Drakefire Amulet was the blood of the black dragonflight's champion. General Drakkisath, on his throne at the top of Blackrock Spire.\n\nI went up with friends. Drakkisath had a great many guards and a bad temper, and by the end a lot less blood. Haleh made the amulet. Onyxia keeps a lair down in Dustwallow Marsh, and now I can let myself in.",
            quests = {
                { id = 6501, name = "The Dragon's Eye", npc = "Highlord Bolvar Fordragon" },
                { id = 6502, name = "Drakefire Amulet", npc = "Haleh" },
            },
        },
        {
            chapter = "For the Horde",
            faction = "Horde",
            summary = "Warlord Goretooth in Kargath, out in the Badlands, has three names in Lower Blackrock Spire and wants every one of them dead. Whatever papers they're keeping, the warlord wants those brought back too.",
            recap = "Warlord Goretooth in Kargath doesn't give orders so much as read out a list. Three names in Lower Blackrock Spire, all to be dead, and whatever papers they were sitting on brought back. What was in those papers got me sent straight to Orgrimmar.\n\nThe Warchief's answer was short. Go to Blackrock Spire. Kill Rend Blackhand. Bring back his head. Rend called himself a warchief, and Orgrimmar only has room for one.\n\nSo I went, and Rend's head came home with me. Then Thrall sat me down and told me what the wind had been carrying, and none of it was good. Dragons, mostly. Black ones.",
            quests = {
                { id = 4903, name = "Warlord's Command", npc = "Warlord Goretooth" },
                { id = 4941, name = "Eitrigg's Wisdom", npc = "Warlord Goretooth" },
                { id = 4974, name = "For The Horde!", npc = "Thrall" },
                { id = 6566, name = "What the Wind Carries", npc = "Thrall" },
            },
        },
        {
            chapter = "Rexxar's Testament",
            faction = "Horde",
            summary = "Thrall, in Grommash Hold, wants you to find Rexxar, the Champion of the Horde. Rexxar walks the paths of Desolace somewhere between Stonetalon and Feralas and doesn't wait for visitors. Expect to walk.",
            recap = "Finding Rexxar is a job in itself. He walks the roads of Desolace somewhere between Stonetalon and Feralas, which is a great deal of road. I walked most of it before I caught him walking the rest.\n\nHe sent me with his testament to Myranda the Hag in the Western Plaguelands. Myranda deals in deception, and deception has ingredients. This batch needed twenty eyes off the black dragonspawn in Blackrock Spire. I didn't ask why eyes. Myranda didn't say.\n\nWhat came back was an amulet. Wear it into Emberstrife's den in Dustwallow Marsh, and a black dragon looks at you and sees family. I stood there in somebody else's scales making polite conversation with a dragon. Still one of my better performances.",
            quests = {
                { id = 6567, name = "The Champion of the Horde", npc = "Thrall" },
                { id = 6568, name = "The Testament of Rexxar", displayName = "Mistress of Deception", npc = "Rexxar" },
                { id = 6569, name = "Oculus Illusions", npc = "Myranda the Hag" },
                { id = 6570, name = "Emberstrife", npc = "Myranda the Hag" },
            },
        },
        {
            chapter = "The Test of Skulls",
            faction = "Horde",
            summary = "Emberstrife, in a den deep in the Wyrmbog of Dustwallow Marsh, won't take you on faith. The test is skulls: one from a champion of each of the blue, green, bronze and red dragonflights.",
            recap = "Emberstrife wanted proof, and dragons keep their proof in skulls. Four of them, one from the champion of each of the other flights: blue up in Winterspring, green in the Swamp of Sorrows, red on the road to Grim Batol, and bronze guarding the Caverns of Time. That's a lot of map for one shopping list, and not one of them went down easy.\n\nI hauled the lot back to the Wyrmbog, still wearing my borrowed face, and came away with a dull old amulet and one large problem. The next step was inside Blackrock Spire, and the disguise wouldn't hold up in there.\n\nThe charade was over. So I went to find Rexxar again, which, as you'll remember, takes a while.",
            quests = {
                { id = 6582, name = "The Test of Skulls, Scryer", npc = "Emberstrife" },
                { id = 6583, name = "The Test of Skulls, Somnus", npc = "Emberstrife" },
                { id = 6584, name = "The Test of Skulls, Chronalis", npc = "Emberstrife" },
                { id = 6585, name = "The Test of Skulls, Axtroz", npc = "Emberstrife" },
                { id = 6601, name = "Ascension...", npc = "Emberstrife" },
            },
        },
        {
            chapter = "Blood of the Black Dragon Champion",
            faction = "Horde",
            summary = "Rexxar, back on the roads of Desolace, knows what the amulet still lacks: the blood of General Drakkisath, champion of the black dragonflight. The general keeps his throne at the top of Blackrock Spire, and a great many guards around it.",
            recap = "Rexxar took one look at the dull amulet and knew what it needed: blood. General Drakkisath's, to be exact, champion of the black dragonflight, who keeps his throne at the very top of Blackrock Spire.\n\nNo disguise this time. We went up the hard way, through everything the Spire had, and into the throne room behind the Halls of Ascension. Drakkisath did not want to part with any of his blood. By the end he'd parted with all of it.\n\nRexxar did the rest and handed me the Drakefire Amulet. Four skulls, twenty eyes, one borrowed face and a dead general went into that thing. If Onyxia ever wonders who's knocking, it's me.",
            quests = {
                { id = 6602, name = "Blood of the Black Dragon Champion", npc = "Rexxar" },
            },
        },
    },
}
