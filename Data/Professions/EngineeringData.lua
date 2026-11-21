local addonName, SM = ...

-- =============================================================================
-- Classic engineering: The Pledge of Secrecy
-- An engineering trainer's manual, then the pledge and the samples that make
-- a gnome engineer or a goblin engineer.
-- =============================================================================
--
-- Gnome and goblin engineering are a choice, not a faction split: an engineer
-- joins one school for good (the game puts every school's first quest in one
-- exclusive group). The gnome lines hide once any goblin quest is done; the
-- goblin lines hide once any gnome quest is done. Before the choice both show.
--
-- The trainers in Stormwind, Ironforge, the Undercity and Ratchet give the
-- same first quest under different IDs. Each school has one line per faction,
-- named for the main city's trainer, with the other trainers' IDs in altIds:
-- Springspindle Fizzlegear in Ironforge (3632 gnome, 3629 goblin) and
-- Tinkerwiz in Ratchet (3634 gnome for the Alliance, 3637 gnome for the Horde,
-- 3633 goblin for both). Alliance gnomes go to Tinkmaster Overspark in
-- Ironforge, Horde gnomes to Oglethorpe Obnoticus in Booty Bay, and every
-- goblin to Nixx Sprocketspring in Gadgetzan.
--
-- The chapter's recap names neither school. Each branch quest has its own
-- recap, set after the paragraph it continues (recapAfter), so the journal
-- tells only the school the player joined. Membership Card Renewal
-- (3644-3647) is left out: renewals, and not on WoW Forever.

SM.ClassicEngineeringData = {
    title = "The Pledge of Secrecy",
    description = "Past a certain point, engineering splits into two schools. Gnome engineers build devices meant to make life easier, and goblin engineers build explosives and the guns to go with them. Each school guards its schemata from the other, so you can learn one and never the other.\n\nYour engineering trainer has a manual on the subject and strong views on which school a sensible engineer would join. Read it and make up your own mind. Then take the manual to the master of the school you want.",
    zone = "Stormwind / Ironforge / Undercity / Stranglethorn Vale / Tanaris",
    zoneByFaction = {
        Alliance = "Stormwind / Ironforge / Tanaris",
        Horde = "Undercity / Stranglethorn Vale / Tanaris",
    },
    expansion = "Classic",
    profession = 202,  -- Engineering: shown only to characters who know it
    recommendedLevel = { min = 30, max = 47 },
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.80, 0.60, 0.26 },
    icon = "Interface\\Icons\\Trade_Engineering",
    portraitDisplayID = 7073,  -- Tinkerwiz, Ratchet: the one trainer who offers both schools to both factions
    adventureCoverTexture = 131841, -- Gnomeregan loading screen: gnomish machinery, the closest Classic cover for engineering
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 3630, name = "Gnome Engineering", npc = "Lilliam Sparkspindle", location = "the Dwarven District, Stormwind", faction = "Alliance" },
    startMapID = 84,
    startX = 0.5480,
    startY = 0.0780,

    npcLocations = {
        -- Positions from Wowhead's tooltips, Classic and WoW Forever agreeing,
        -- but for Stormwind, where Forever's map is drawn differently (Forever
        -- puts Lilliam Sparkspindle at 0.6200, 0.3060): Stormwind takes the
        -- Classic position, as the other stories' Stormwind NPCs do.
        ["Lilliam Sparkspindle"] = { mapID = 84, x = 0.5480, y = 0.0780, location = "the Dwarven District, Stormwind" },
        ["Graham Van Talen"] = { mapID = 90, x = 0.7520, y = 0.7240, location = "the Rogues' Quarter, Undercity" },
        ["Tinkmaster Overspark"] = { mapID = 87, x = 0.6940, y = 0.5040, location = "Tinker Town, Ironforge" },
        ["Oglethorpe Obnoticus"] = { mapID = 50, x = 0.2820, y = 0.7620, location = "Booty Bay, Stranglethorn Vale" },
        ["Nixx Sprocketspring"] = { mapID = 71, x = 0.5240, y = 0.2720, location = "Gadgetzan, Tanaris" },
    },

    npcDisplayIDs = {
        -- Quest givers' models from the cmangos Classic database.
        ["Lilliam Sparkspindle"] = 3314,
        ["Springspindle Fizzlegear"] = 3117,
        ["Tinkerwiz"] = 7073,
        ["Graham Van Talen"] = 2630,
        ["Tinkmaster Overspark"] = 7028,
        ["Oglethorpe Obnoticus"] = 6710,
        ["Nixx Sprocketspring"] = 7340,
    },

    chapters = {
        {
            chapter = "Show Your Work",
            requiredLevel = 30,
            summary = "Your engineering trainer has a manual for you, and an opinion to go with it. From here the craft splits into a gnome school and a goblin school, and you can only join one. Read the manual before you choose.",
            recap = "Engineering only goes so far before it splits in two, gnome and goblin, and you have to pick. My trainer gave me a manual on it and made plain which school I ought to join. Gnomes build things to make life easier, says the manual, and some of them even work. Goblins build bombs and guns, which have the opposite problem. Join one school and the other keeps its schemata from you for good. The manual says so twice.\n\nBefore I learned a single schematic there was a pledge of lifelong secrecy to sign. I was told to think it over carefully. I read every line and signed.\n\nLast came the samples, because a master wants to see your work before handing over the good schemata. I spent a few long evenings at the bench. Mine passed, and I was given a membership card.",
            quests = {
                -- Gnome engineering. Hides once any goblin quest is done.
                { id = 3630, altIds = { 3632, 3634 }, name = "Gnome Engineering", npc = "Lilliam Sparkspindle", faction = "Alliance", parallel = true, hideIf = { 4181, 3629, 3526, 3633, 3638, 3639 }, recapAfter = 1, recap = "I took the manual to Tinkmaster Overspark in Tinker Town, who said he had all the time in the world, since all he does now is stand about while Gnomeregan sits in its cloud of radiation. Then he begged my pardon for the melodrama." },
                { id = 3635, altIds = { 3637 }, name = "Gnome Engineering", npc = "Graham Van Talen", faction = "Horde", parallel = true, hideIf = { 4181, 3629, 3526, 3633, 3638, 3639 }, recapAfter = 1, recap = "My trainer said that if I wanted to learn to make metal paperweights, Oglethorpe Obnoticus in Booty Bay was the one to see. Oglethorpe opened by referring me to his barrister, in case I'd come about a homing robot through my wall. Gnomeregan, he told me, lost one of its greatest engineers the day he left." },
                { id = 3640, name = "The Pledge of Secrecy", npc = "Tinkmaster Overspark", faction = "Alliance", hideIf = { 4181, 3629, 3526, 3633, 3638, 3639 }, recapAfter = 2, recap = "Overspark had signed the same pledge once, like every gnome engineer before me, and was delighted to have me in the fold." },
                { id = 3641, name = "Show Your Work", npc = "Tinkmaster Overspark", faction = "Alliance", hideIf = { 4181, 3629, 3526, 3633, 3638, 3639 }, recap = "Overspark's list ran to six mithril tubes and two advanced target dummies, among other things, so he could see where my work might be more gnomish. My card says I'm a member in good standing of the Mechanical Engineering Guild, Associated. I'd spell out the initials, but I signed a pledge." },
                { id = 3642, name = "The Pledge of Secrecy", npc = "Oglethorpe Obnoticus", faction = "Horde", hideIf = { 4181, 3629, 3526, 3633, 3638, 3639 }, recapAfter = 2, recap = "Oglethorpe has no love for Gnomeregan's politics, or for one of its tinkmasters in particular, but he holds the pledge above all of that." },
                { id = 3643, name = "Show Your Work", npc = "Oglethorpe Obnoticus", faction = "Horde", hideIf = { 4181, 3629, 3526, 3633, 3638, 3639 }, recap = "Oglethorpe went over my mithril tubes and target dummies for gnomish technique. The card he gave me says I'm a member in good standing of the Mechanical Engineering Guild, Associated. I'd spell out the initials, but I signed a pledge." },
                -- Goblin engineering. Hides once any gnome quest is done.
                { id = 4181, altIds = { 3629, 3633 }, name = "Goblin Engineering", npc = "Lilliam Sparkspindle", faction = "Alliance", parallel = true, hideIf = { 3630, 3632, 3634, 3635, 3637, 3640, 3641, 3642, 3643 }, recapAfter = 1, recap = "I took the manual all the way to Gadgetzan, to Nixx Sprocketspring, who said he can smell a fresh recruit a mile off, like good blasting powder. Any fool can learn the basics, says Nixx, and Gnomeregan proves it. Goblin work takes a steady hand, and he leaned hard on the steady." },
                { id = 3526, altIds = { 3633 }, name = "Goblin Engineering", npc = "Graham Van Talen", faction = "Horde", parallel = true, hideIf = { 3630, 3632, 3634, 3635, 3637, 3640, 3641, 3642, 3643 }, recapAfter = 1, recap = "My trainer called goblin engineering the choice of every brilliant engineer, and I don't argue with compliments. Nixx Sprocketspring in Gadgetzan said he'd smelled me coming a mile off, like good blasting powder, and that goblin work takes a steady hand. He said steady louder than the rest." },
                { id = 3638, name = "The Pledge of Secrecy", npc = "Nixx Sprocketspring", hideIf = { 3630, 3632, 3634, 3635, 3637, 3640, 3641, 3642, 3643 }, recapAfter = 2, recap = "Nixx kept it simple. It was a one-way trip, he said, and if I was ready, I should hop aboard." },
                { id = 3639, name = "Show Your Work", npc = "Nixx Sprocketspring", hideIf = { 3630, 3632, 3634, 3635, 3637, 3640, 3641, 3642, 3643 }, recap = "Nixx asked for forty assorted explosives and five explosive sheep, and told me to keep the safeties armed. My card says I'm a member in good standing of the Goblin Experimental Engineering Korporation, with a K. I suspect the initials came first." },
            },
        },
    },
}
