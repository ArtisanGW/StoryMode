local addonName, SM = ...

-- =============================================================================
-- WoW Forever: Azshara Reclaimed
-- Sentinels, a betrayed Horde camp and the exiled Blackmaw furbolgs fight over Azshara.
-- =============================================================================

SM.ForeverAzsharaData = {
    title = "Azshara Reclaimed",
    description = "Azshara's broken towers still hold the secrets of the highborne, and everyone has come to dig for them. Night elf sentinels at Talrendis Point fight the Spitelash naga for the ruins of Eldarath, while at Valormok the Horde has paid in blood for trusting a blood elf mage.\n\nTo the north, the Blackmaw furbolgs shelter in the camps of Ursolan, driven from their home by the Legashi satyr and sickening from the corruption the demons spread. Their gatekeeper is looking for allies.",
    zone = "Azshara",
    expansion = "Classic",
    recommendedLevel = { min = 47, max = 60 },
    requiredLevel = 44,
    gameVersions = { forever = true },
    achievements = {},
    color = { 0.76, 0.38, 0.26 },
    icon = "Interface\\Icons\\Ability_Racial_BearForm",
    adventureCoverTexture = 7963784,  -- Blackmaw Hold's loading screen, in Azshara
    adventureCoverTexCoords = { 0, 1, 0.1592, 0.8408 },  -- the picture, between its transparent bands
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 98096, name = "Sisters In Duty", npc = "Sentinel Dalia Sunblade", location = "Darnassus, Teldrassil", faction = "Alliance" },
    startMapID = 1457, startX = 0.3980, startY = 0.8920,

    npcLocations = {
        -- Alliance
        ["Sentinel Dalia Sunblade"] = { mapID = 1457, x = 0.3980, y = 0.8920, location = "Darnassus, Teldrassil" },
        ["Commander Truesong"] = { mapID = 1447, x = 0.1180, y = 0.7820, location = "Talrendis Point, Azshara" },
        ["Saria Fairmoon"] = { mapID = 1447, x = 0.5040, y = 0.4260, location = "the Shattered Strand, Azshara" },
        -- Horde
        ["Ag'tor Bloodfist"] = { mapID = 1447, x = 0.2220, y = 0.5140, location = "Valormok, Azshara" },
        ["Jediga"] = { mapID = 1447, x = 0.2240, y = 0.5140, location = "Valormok, Azshara" },
        ["Zevrost"] = { mapID = 1454, x = 0.4820, y = 0.4540, location = "the Cleft of Shadow, Orgrimmar" },
        -- Blackmaw
        ["Ekkal"] = { mapID = 1447, x = 0.4200, y = 0.3880, location = "the Ruins of Eldarath, Azshara" },
        ["Gatekeeper Rageroar"] = { mapID = 1447, x = 0.4240, y = 0.2020, location = "Ursolan, Azshara" },
        ["Korsa"] = { mapID = 1447, x = 0.6300, y = 0.2140, location = "outside the Legashi Stronghold, Azshara" },
        ["Graal"] = { mapID = 1447, x = 0.6440, y = 0.1670, location = "the Legashi Stronghold, Azshara" },
        ["Furze"] = { mapID = 1447, x = 0.4520, y = 0.2220, location = "Ursolan, Azshara" },
        ["Elder Bramblesnap"] = { mapID = 1447, x = 0.4160, y = 0.1960, location = "Ursolan, Azshara" },
        ["Legashi Cauldron"] = { mapID = 1447, x = 0.5770, y = 0.2100, location = "the Legashi Encampment, Azshara" },
        ["Gorn One Eye"] = { mapID = 1448, x = 0.6520, y = 0.0260, location = "Timbermaw Hold, Felwood" },
    },

    chapters = {
        {
            chapter = "Talrendis Point",
            faction = "Alliance",
            requiredLevel = 45,
            summary = "A young sentinel in Darnassus has heard nothing from her sister Keldara, posted to Talrendis Point in Azshara. Follow the chain of command to Commander Truesong and find out what has become of Keldara Sunblade.",
            recap = "Keldara Sunblade was a captive of the satyr in the Haldarr Encampment, though only pretending to be hurt while she waited for her captors to drop their guard. Your arrival was the moment she needed, and together you got her back to Talrendis Point. Commander Truesong then turned you on the Spitelash naga in the ruins of Eldarath. You carried out what relics of the old kaldorei city you could and took Lord Sarthiss' head, then climbed to the Ravencrest Monument and nullified the enchantresses' power stones. Last came Warlord Krellian, hiding behind his guards in the Temple of Zin-Malor. With his head in her hands, Truesong could believe that Azshara might belong to the kaldorei again.",
            quests = {
                { id = 98096, name = "Sisters In Duty", npc = "Sentinel Dalia Sunblade", faction = "Alliance", gameVersions = { forever = true } },
                { id = 88857, name = "Saving a Sentinel", npc = "Keldara Sunblade", faction = "Alliance", location = "the Haldarr Encampment, Azshara", gameVersions = { forever = true } },
                { id = 88809, name = "Preserving Eldarath", npc = "Commander Truesong", faction = "Alliance", gameVersions = { forever = true } },
                { id = 88812, name = "Reclaiming Ravencrest", npc = "Commander Truesong", faction = "Alliance", gameVersions = { forever = true } },
                { id = 88813, name = "The Head of the Serpent", npc = "Commander Truesong", faction = "Alliance", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "The Archaeologist",
            faction = "Alliance",
            requiredLevel = 47,
            summary = "One of Truesong's sentinels spotted a kaldorei woman alone on the Shattered Strand, plainly no fighter. Find her, learn why she has come to so hostile a shore, and see whether her interests and the sentinels' are aligned.",
            recap = "The woman was Saria Fairmoon, an archaeologist of sorts, hunting highborne artifacts while the naga looted the ruins around her, and she was glad to find an assistant who could fight. For her you took the staff of Archmage Selwyn from Lady Sesspira, carried highborne tablets out of the naga-guarded pagodas of Southridge Beach, wrested a memory crystal from the murloc Razorgill near the Tower of Eldara and searched the Ravencrest Monument for the Mark of the Queen, Azshara's own gift to a loyal house. Then Saria wanted to show you what all that work had been for, and her true intentions came to light. You went back to Commander Truesong with her knapsack of powerful artifacts and ill tidings to report.",
            quests = {
                { id = 88821, name = "Making Contact", npc = "Commander Truesong", faction = "Alliance", gameVersions = { forever = true } },
                { id = 88917, name = "Slithering Looters", npc = "Saria Fairmoon", faction = "Alliance", gameVersions = { forever = true } },
                { id = 88884, name = "Highborne Tablets", npc = "Saria Fairmoon", faction = "Alliance", gameVersions = { forever = true } },
                { id = 89037, name = "Murloc Thieves", npc = "Saria Fairmoon", faction = "Alliance", gameVersions = { forever = true } },
                { id = 89038, name = "A Monumental Task", npc = "Saria Fairmoon", faction = "Alliance", gameVersions = { forever = true } },
                { id = 89053, name = "Your Final Reward", npc = "Saria Fairmoon", faction = "Alliance", gameVersions = { forever = true } },
                { id = 89470, name = "Ill Tidings", faction = "Alliance", location = "the Shattered Strand, Azshara", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "Rimtori's Betrayal",
            faction = "Horde",
            requiredLevel = 44,
            summary = "Belgrom Rockmaul sent warriors to Azshara to guard Magus Rimtori, a blood elf mage who promised him the riches of the highborne. Go to the Horde camp at Valormok and learn what that bargain has cost.",
            recap = "The warriors Belgrom had sent to protect Rimtori were dead, a dozen of them, cut down by the mage they guarded. She had played Belgrom like a lute with her talk of riches and powerful relics. You hunted her reclaimers and surveyors along the bluffs of the northern peninsula and found her camp, where three sealed crystals fed a summoning spell. Her officers carried the seals. You took them and broke them, the crystals erupted, and you struck Rimtori down while she reeled, then carried her head to Belgrom in Orgrimmar. Her tome went to Jediga, then to the warlock Zevrost, who found in its diagrams a ritual to call the demon Vek'zol. You performed it at the Altar of Storms in the Blasted Lands and brought the demon's heart back to the Cleft of Shadow.",
            quests = {
                { id = 3505, name = "Betrayed", faction = "Horde", location = "Valormok, Azshara", gameVersions = { forever = true } },
                { id = 91497, name = "Seals of the Sin'dorei", faction = "Horde", location = "Magus Rimtori's camp, Azshara", gameVersions = { forever = true } },
                { id = 91500, name = "An Explosive Gambit", faction = "Horde", location = "Magus Rimtori's camp, Azshara", gameVersions = { forever = true } },
                { id = 91531, name = "Revenge Exacted", npc = "Ag'tor Bloodfist", faction = "Horde", gameVersions = { forever = true } },
                { id = 91538, name = "Sin'dorei Tome of Summoning", faction = "Horde", location = "Magus Rimtori's camp, Azshara", gameVersions = { forever = true } },
                { id = 91547, name = "Sin'dorei Tome of Summoning", npc = "Jediga", faction = "Horde", gameVersions = { forever = true } },
                { id = 91548, name = "Vek'zol", npc = "Zevrost", faction = "Horde", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "The Exiles of Ursolan",
            requiredLevel = 47,
            summary = "Ekkal of the Blackmaw asks for help against the Legashi satyr, who drove the tribe from its den. Then go north to Gatekeeper Rageroar at Ursolan, whose scouts have not come back from the satyr camps.",
            recap = "The Blackmaw were a tribe in exile, huddled in makeshift camps while the Legashi spread their corruption across the land. Rageroar had sent scouts east to spy on the Legashi stronghold and to look for the tribe's lost chieftain. You found Korsa alone outside the stronghold: one scout slain, another taken, and Korsa unwilling to face Rageroar in shame. Together you killed Master Feardred, a servant of the satyr lord Varrox Bleakhoof, thinned the stronghold's ranks and broke Graal out of his cage. The scouts could return to Ursolan with their heads held high.",
            quests = {
                { id = 86746, name = "The Legashi Threat", npc = "Ekkal", gameVersions = { forever = true } },
                { id = 86752, name = "Report to Rageroar", npc = "Ekkal", gameVersions = { forever = true } },
                { id = 86791, name = "Missing Blackmaw Scouts", npc = "Gatekeeper Rageroar", gameVersions = { forever = true } },
                { id = 86777, name = "Master Feardred", npc = "Korsa", gameVersions = { forever = true } },
                { id = 86792, name = "Thinning Their Forces", npc = "Korsa", gameVersions = { forever = true } },
                { id = 86796, name = "Later, Satyr", npc = "Graal", gameVersions = { forever = true } },
                { id = 86797, name = "Return to Rageroar", npc = "Korsa", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "Satyrweed and Firewater",
            requiredLevel = 47,
            summary = "A Blackmaw named Furze burns with a sickness that seems to unmake him from the inside. Fetch Elder Bramblesnap, and help her search for a cure in the last place anyone would think to look.",
            recap = "Furze was not the first. Bramblesnap had watched one Blackmaw after another fall to the same fever and then to corruption, and her studies pointed to an unlikely source for a cure: the Legashi's own firewater. In the Legashi Encampment you found a cauldron, took the recipe from the satyr and brewed a foul batch from satyrweed and a mote of fel power. Bramblesnap transmuted it into a tincture, and you tried it on the corrupted coursers and skystormers east of Ursolan. What you saw gave her more hope than she had felt in a long time, and you carried the first dose of her panacea to Furze, who had suffered long enough.",
            quests = {
                { id = 86799, name = "Encroaching Corruption", npc = "Furze", gameVersions = { forever = true } },
                { id = 86804, name = "An Unlikely Source", npc = "Elder Bramblesnap", gameVersions = { forever = true } },
                { id = 86925, name = "Toil and Trouble", npc = "Legashi Cauldron", gameVersions = { forever = true } },
                { id = 86926, name = "Felfire Burn, Cauldron Bubble", npc = "Legashi Cauldron", gameVersions = { forever = true } },
                { id = 86927, name = "Running Firewater", npc = "Legashi Cauldron", gameVersions = { forever = true } },
                { id = 86812, name = "Transmuted Tincture", npc = "Elder Bramblesnap", gameVersions = { forever = true } },
                { id = 86813, name = "Potential Panacea", npc = "Elder Bramblesnap", gameVersions = { forever = true } },
            },
        },
        {
            chapter = "The Timbermaw Banner",
            requiredLevel = 47,
            summary = "With the Legashi stronghold weakened, Rageroar means to strike at its commander, Prince Halanox, but the Blackmaw lack the numbers. Go to Timbermaw Hold as their emissary and ask Gorn One Eye for warriors.",
            recap = "When the Legashi overran the Blackmaw, the rest of the Timbermaw sealed their passage against the satyr, never knowing their kin lived on as refugees. Gorn One Eye would gladly help, but his own people were at war with the Deadwood, so you killed Chieftain Bloodmaw in Felpaw Village to free his warriors. You planted the Timbermaw War Banner in Halanox's summoning circle, the reinforcements answered, and the prince fell. One enemy remained: Varrox Bleakhoof, the demon who had taken Blackmaw Hold itself. You found him in the hold and brought his head back to Rageroar, and for the first time since the Legashi came, the Blackmaw had a future to think about.",
            quests = {
                { id = 86798, name = "Timbermaw Reinforcements", npc = "Gatekeeper Rageroar", gameVersions = { forever = true } },
                { id = 87346, name = "Chieftain Bloodmaw", npc = "Gorn One Eye", gameVersions = { forever = true } },
                { id = 86814, name = "Blackmaw Counter-Offensive", npc = "Gorn One Eye", gameVersions = { forever = true } },
                { id = 92065, name = "Blackmaw Reclamation", npc = "Gatekeeper Rageroar", gameVersions = { forever = true } },
            },
        },
    },
}
