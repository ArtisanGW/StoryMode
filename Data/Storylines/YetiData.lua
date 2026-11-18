local addonName, SM = ...

-- =============================================================================
-- Classic: Are We There, Yeti?
-- Umi Rumplesnicker of Everlook builds a mechanical yeti and sends it on tour.
-- =============================================================================

SM.YetiData = {
    title = "Are We There, Yeti?",
    description = "Everlook sits at the cold end of Winterspring, a goblin trading town where travelers come in out of the snow. Umi Rumplesnicker has been drawing up plans there, and she'll let you in on them if you promise not to tell.\n\nUmi's friends always seem to have the great ideas. This time she has one of her own. It needs a few things from the snowfields outside town, and someone who can keep a straight face.",
    zone = "Winterspring / Tanaris / Un'Goro Crater",
    expansion = "Classic",
    recommendedLevel = { min = 52, max = 58 },
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.60, 0.80, 0.95 },
    icon = "Interface\\Icons\\Ability_Hunter_Pet_Gorilla",
    portraitDisplayID = 9780,
    adventureCoverTexture = 131861, -- Alterac Valley loading screen: the snowiest Classic loading screen
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 3783, name = "Are We There, Yeti?", npc = "Umi Rumplesnicker", location = "Everlook, Winterspring" },
    startMapID = 83,
    startX = 0.6080,
    startY = 0.3760,

    npcLocations = {
        ["Umi Rumplesnicker"] = { mapID = 83, x = 0.6080, y = 0.3760, location = "Everlook, Winterspring" },
        ["Legacki"] = { mapID = 83, x = 0.6150, y = 0.3850, location = "Everlook, Winterspring" },
        ["Sprinkle"] = { mapID = 71, x = 0.5100, y = 0.2680, location = "Gadgetzan, Tanaris" },
        ["Quixxil"] = { mapID = 78, x = 0.4350, y = 0.0950, location = "Marshal's Refuge, Un'Goro Crater" },
    },

    npcDisplayIDs = {
        -- Models from the cmangos Classic database.
        ["Umi Rumplesnicker"] = 9780,
        ["Legacki"] = 10651,
        ["Sprinkle"] = 7175,
        ["Quixxil"] = 10650,
        ["Umi's Mechanical Yeti"] = 10269,
    },

    chapterDisplayIDs = {
        ["Umi's Secret"] = 9780,
        ["Are We There, Yeti?"] = 10269,
    },

    chapterIcons = {
        ["Umi's Secret"] = "Interface\\Icons\\INV_Misc_Pelt_03",
        ["Are We There, Yeti?"] = "Interface\\Icons\\INV_Gizmo_09",
    },

    chapters = {
        {
            chapter = "Umi's Secret",
            summary = "Umi Rumplesnicker, in Everlook in Winterspring, has plans for something great and is bursting to tell someone. Promise to keep it quiet and she'll let you in on the secret, and on the shopping list that comes with it.",
            recap = "So there's a tinkerer in Everlook called Umi Rumplesnicker, and she had a secret. She'd let me in on it if I promised not to tell. I promised, and I've kept my word right up until now.\n\nHer friends, she said, always had the great ideas. Well, now she had one. A mechanical yeti. They'd be frightened out of their wits, and then, once they'd stopped shaking, terribly impressed.\n\nA yeti needs a coat, so I went southeast and collected ten thick furs from the ice thistle yetis, who were still wearing them. Then it needed horns, the big ones off the patriarchs and matriarchs in their cave. Only the best-looking ones, Umi said. No beat up or broken horns, please.\n\nTry asking a yeti patriarch to hold still so you don't scuff the goods.",
            quests = {
                { id = 3783, name = "Are We There, Yeti?", displayName = "Thick Yeti Fur", npc = "Umi Rumplesnicker" },
                { id = 977, name = "Are We There, Yeti?", displayName = "Pristine Yeti Horns", npc = "Umi Rumplesnicker" },
            },
        },
        {
            chapter = "Are We There, Yeti?",
            summary = "Umi Rumplesnicker's project is finished, and she has already written to her friends in Everlook, Gadgetzan and Un'Goro Crater to say a surprise is coming. Somebody has to deliver it. Umi, in Everlook, is looking at you.",
            recap = "Umi had written ahead to tell her friends a surprise was coming. The surprise was me, with her mechanical yeti in my pack.\n\nFirst stop, right there in Everlook: Legacki. I switched the yeti on, it went stomping over roaring its head off, and Legacki jumped a foot in the air, called me a big meanie and guessed who'd put me up to it in one try. Umi, it turns out, is always playing jokes on Legacki.\n\nThen the long road south. In Gadgetzan the next friend also guessed Umi. At Marshal's Refuge in Un'Goro, Quixxil didn't guess anything. Quixxil ran. The yeti followed. Quixxil asked it why. It roared, which I suppose is an answer.\n\nBack in Everlook, Umi was thrilled. That would teach them to make fun of her ideas, she said. I didn't mention what Legacki had told me. Some secrets you keep.",
            quests = {
                { id = 5163, name = "Are We There, Yeti?", displayName = "Umi's Friends", npc = "Umi Rumplesnicker" },
            },
        },
    },
}
