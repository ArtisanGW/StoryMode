local addonName, SM = ...

-- =============================================================================
-- WoW Forever: The Dying God
-- A dying Wild God, a corrupted branch of Nordrassil and the druid who stole a god's power.
-- =============================================================================

SM.ForeverMountHyjalData = {
    title = "The Dying God",
    description = "Years after Archimonde fell, Mount Hyjal is still scarred. Fel ash poisons its slopes, warlocks pick through the ruins of the war, and the Wild Gods who watch over the mountain have begun to falter.\n\nWhen a dying god presses a corrupted branch of the World Tree into your hands, a hermit druid, a meddling crow and the wild spirits of the mountain set you on the trail of a druid who has learned to steal divine power, and of the Pact he serves.",
    zone = "Mount Hyjal / Moonglade",
    expansion = "Classic",
    recommendedLevel = { min = 55, max = 60 },
    requiredLevel = 55,
    gameVersions = { forever = true },
    achievements = {},
    color = { 0.38, 0.60, 0.36 },
    icon = "Interface\\Icons\\Spell_Nature_Tranquility",
    adventureCoverTexture = 7963779,  -- Kalimdor's loading screen: Hyjal has none of its own
    adventureCoverTexCoords = { 0, 1, 0.1592, 0.8408 },  -- the picture, between its transparent bands
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 91952, name = "The Source of the Corruption", npc = "Greta Mosshoof", location = "Emerald Sanctuary, Felwood" },
    startMapID = 1448, startX = 0.5120, startY = 0.8220,

    npcLocations = {
        ["Greta Mosshoof"] = { mapID = 1448, x = 0.5120, y = 0.8220, location = "Emerald Sanctuary, Felwood" },
        ["Ketharas"] = { mapID = 2482, x = 0.7320, y = 0.8180, location = "the hermit's cave, Mount Hyjal" },
        ["Fraxinus"] = { mapID = 2482, x = 0.5360, y = 0.8440, location = "the ancients' outpost, Mount Hyjal" },
        ["Curious Crow"] = { mapID = 2482, x = 0.4820, y = 0.8580, location = "the road below the Felblood Scar, Mount Hyjal" },
        ["Felflick"] = { mapID = 2482, x = 0.4940, y = 0.7720, location = "the entrance to the Felblood Scar, Mount Hyjal" },
        ["Velician"] = { mapID = 2482, x = 0.3660, y = 0.7820, location = "west of the Felblood Scar, Mount Hyjal" },
        ["Dendrite Starblaze"] = { mapID = 1450, x = 0.5620, y = 0.3040, location = "Nighthaven, Moonglade" },
        ["Orokai"] = { mapID = 1450, x = 0.4100, y = 0.4360, location = "southwest of Nighthaven, Moonglade" },
        ["Jereman"] = { mapID = 2482, x = 0.4160, y = 0.4560, location = "Cradle of Tranquility, Mount Hyjal" },
        ["Renalard"] = { mapID = 2482, x = 0.6000, y = 0.4920, location = "Dae'gun, Mount Hyjal" },
        ["Marrosis"] = { mapID = 2482, x = 0.2700, y = 0.5020, location = "Mourning's Rest, Mount Hyjal" },
        ["Skylord Omnuron"] = { mapID = 2482, x = 0.5420, y = 0.6380, location = "Shrine of Aviana, Mount Hyjal" },
        ["Tiala Whitemane"] = { mapID = 2482, x = 0.6880, y = 0.5040, location = "Summit of Eternity, Mount Hyjal" },
    },

    chapters = {
        {
            chapter = "The Hermit of the Foothills",
            summary = "Fel taint still washes down from Hyjal into Felwood. Climb to the mountain's lower slopes, find the hermit druid Ketharas, and lend a hand to the old caretakers of the mountain.",
            recap = "Greta Mosshoof's hunch led you to Ketharas, a hermit druid living alone in a cave on the lower slopes. He set you to small mendings first: untainted seeds for a new season, abandoned owl eggs carried to safety. Then he sent you west to an outpost of ancients and dryads still nursing their wounds from the war. There the hardest task waited: Sunderbark, an ancient broken by the corruption, had to be put down, and a seed planted in what remained of him. With renewal finally begun, Fraxinus sent you west again, into the ashen lands, to find a small bird with great power.",
            quests = {
                { id = 91952, name = "The Source of the Corruption", npc = "Greta Mosshoof", gameVersions = { forever = true } },
                { id = 95568, name = "Seeds for a New Season", npc = "Ketharas", gameVersions = { forever = true } },
                { id = 95569, name = "Hope for Hatchlings", npc = "Ketharas", gameVersions = { forever = true } },
                { id = 90487, name = "Ancient Allies", location = "the hermit's cave, Mount Hyjal", mapID = 2482, x = 0.7320, y = 0.8180, gameVersions = { forever = true } },
                { id = 92959, name = "The Dying Ancients", location = "the ancients' outpost, Mount Hyjal", mapID = 2482, x = 0.5360, y = 0.8440, gameVersions = { forever = true } },
                { id = 95766, name = "Fine Feathered Friend", npc = "Fraxinus", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "The Curious Crow",
            summary = "A crow with a mischievous streak keeps watch below the Felblood Scar, where the warlocks of the Ashen Reign experiment with fel ash. Help her undo their work, even if it means bargaining with the demon they keep caged.",
            recap = "The Curious Crow's schemes began with pinecones and fel slime and ended with the Ashen Reign's workstations in ruins. Her boldest move was a deal with Felflick, a demon the warlocks kept caged, with an iron key as the bait. For the promise of freedom, Felflick pointed you at the coven's leaders one by one, and at Brashann Grimdark, the Master of Vessels, whose soul-anchoring crystals had caught the eye of the Blackthorne. Their bones went onto the warlocks' own heap of failed experiments, and something foul crawled back out. When Felflick finally demanded his end of the bargain, the question of his freedom went back to the crow.",
            quests = {
                { id = 96262, name = "Prickly Pinecones", npc = "Curious Crow", gameVersions = { forever = true } },
                { id = 95317, name = "Notation, Notation, Notation", npc = "Curious Crow", gameVersions = { forever = true } },
                { id = 95380, name = "A Prolific Source", npc = "Curious Crow", gameVersions = { forever = true } },
                { id = 95316, name = "The Experimental Method", npc = "Curious Crow", gameVersions = { forever = true } },
                { id = 95320, name = "A Curious Question", npc = "Curious Crow", gameVersions = { forever = true } },
                { id = 95318, name = "Taste of Ash", npc = "Felflick", gameVersions = { forever = true } },
                { id = 95319, name = "Crystalline Collection", npc = "Felflick", gameVersions = { forever = true } },
                { id = 95378, name = "The Hydra's Head", npc = "Felflick", gameVersions = { forever = true } },
                { id = 95379, name = "A Revenge So Sweet", npc = "Felflick", gameVersions = { forever = true } },
                { id = 96435, name = "A Fitting End", npc = "Felflick", gameVersions = { forever = true } },
                { id = 96255, name = "Amalgamated Marrow", location = "the bone pile west of the Felblood Scar, Mount Hyjal", mapID = 2482, x = 0.4070, y = 0.8020, gameVersions = { forever = true } },
                { id = 96322, name = "A Revenge Now Bitter", npc = "Felflick", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "A Branch of the World Tree",
            summary = "In the ashen lands west of the warlock camp, a Wild God lies dying with a strange branch at his side. Carry his last burden to someone who can understand it.",
            recap = "The dying Wild God Velician pressed a branch of the World Tree into your hands, corrupted and crowned with a sickly green crystal, and begged that it reach the crow. The Curious Crow trusted few mortals with something so grave, and sent you to Ketharas with the branch and one of her feathers. The hermit could sense its power but not read it, so the trail led to Dendrite Starblaze in Nighthaven and to the ancient Orokai beyond the town. Orokai communed with the branch and showed you what it remembered: a druid named Ve'han Talongrasp had stolen part of a Wild God's power, and spoke of a Pact. Dendrite sent you back up the mountain with the news.",
            quests = {
                { id = 96321, name = "The Dying God", npc = "Velician", gameVersions = { forever = true } },
                { id = 96131, name = "An Oldstone But An Old Friend", npc = "Curious Crow", gameVersions = { forever = true } },
                { id = 92612, name = "Aid from Moonglade", npc = "Ketharas", gameVersions = { forever = true } },
                { id = 96209, name = "The Ancient, Orokai", npc = "Dendrite Starblaze", gameVersions = { forever = true } },
                { id = 95006, name = "Stolen Power", npc = "Orokai", gameVersions = { forever = true } },
                { id = 93773, name = "The Pact", npc = "Dendrite Starblaze", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "Gifts of the Wild Gods",
            summary = "Ketharas has a gamble in mind to turn Ve'han's stolen magic against him, but a hermit's power is not enough. Seek out the gods of the mountain and gather what his spell will need.",
            recap = "Ketharas sent you back to the Curious Crow, who called on someone grander than herself: Jereman, cleverest of the Wild Gods, nesting above the Cradle of Tranquility. Jereman sent you to the fox Renalard in Dae'gun, who knew that the ashes of Archimonde's lieutenant Azgalor could feed the spell without burning out, and to Marrosis in Mourning's Rest, who offered a drop of the life the Scourge had stolen to balance it. Ketharas wanted a touch of the sky as well, and Skylord Omnuron at the Shrine of Aviana sent you after the Jewel of the Horizon in the Wormwing harpies' nests. One by one, the gifts of the mountain came back to the hermit's cave.",
            quests = {
                { id = 96930, name = "The Capricious Corvid", npc = "Ketharas", gameVersions = { forever = true } },
                { id = 96931, name = "Heading Up the Mountain", npc = "Curious Crow", gameVersions = { forever = true } },
                { id = 96964, name = "A Clever Creature", npc = "Jereman", gameVersions = { forever = true } },
                { id = 92335, name = "Ashes of the Legion Ascent", npc = "Renalard", gameVersions = { forever = true } },
                { id = 96939, name = "The Balance of Life and Death", npc = "Jereman", gameVersions = { forever = true } },
                { id = 92317, name = "Stolen Life", npc = "Marrosis", gameVersions = { forever = true } },
                { id = 92171, name = "Taking to New Heights", npc = "Ketharas", gameVersions = { forever = true } },
                { id = 92500, name = "A Bit of the Sky", npc = "Skylord Omnuron", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "Ve'han's Fall",
            summary = "From the gifts of the Wild Gods, Ketharas has remade the branch. Carry it to the druids at the Summit of Eternity and turn it against the Pact and against Ve'han Talongrasp himself.",
            recap = "Ketharas bound the gifts into the branch, and Tiala Whitemane at the Summit of Eternity, the first to test the Staff of the Mountain, named the enemy: the Blackthorne Pact, apostate druids who blamed Malfurion for the immortality they had lost and swore to take that power back. The staff stripped their wards one by one, and then Ve'han's own, in the Nordrassil Lodge beneath the boughs of the great tree. His notes showed he had been trying to devour Jereman's essence for his master, the Wild King, and the freed Wild God fled back to her nest. Tiala sent you down the mountain with the thanks of the Guardians of Hyjal and the Cenarion Circle, and an open door for the hermit whose magic had made the victory possible.",
            quests = {
                { id = 90647, name = "The Staff of the Mountain", npc = "Ketharas", gameVersions = { forever = true } },
                { id = 92169, name = "Paying Back the Pact", npc = "Tiala Whitemane", gameVersions = { forever = true } },
                { id = 92833, name = "Ve'han's Fall", npc = "Tiala Whitemane", gameVersions = { forever = true } },
                { id = 93521, name = "Challenger of the Gods", location = "Nordrassil Lodge, Mount Hyjal", mapID = 2482, x = 0.7690, y = 0.3540, gameVersions = { forever = true } },
                { id = 99670, name = "Return to Jereman", npc = "Tiala Whitemane", gameVersions = { forever = true } },
                { id = 93848, name = "Work Well Done", npc = "Tiala Whitemane", gameVersions = { forever = true } },
            },
        },
    },
}
