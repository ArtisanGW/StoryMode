local addonName, SM = ...

-- =============================================================================
-- Classic: Cortello's Riddle
-- A pirate-ship scroll that turns into a three-zone treasure hunt.
-- =============================================================================

SM.CortellosRiddleData = {
    title = "Cortello's Riddle",
    description = "A small scroll waits aboard a Bloodsail ship south of Booty Bay. It bears no proper patron, only a riddle and enough direction to make you wonder what was hidden.\n\nTake Cortello's words seriously and follow the clues wherever they send you. The treasure is not marked for anyone who wants a straight road.",
    zone = "Stranglethorn Vale / Swamp of Sorrows / Dustwallow Marsh / The Hinterlands",
    expansion = "Classic",
    recommendedLevel = { min = 43, max = 51 },
    gameVersions = { classicEra = true, tbc = true },
    achievements = {},
    color = { 0.29, 0.54, 0.63 },
    icon = 134331,
    adventureCoverTexture = 131886, -- Zul'Gurub loading screen: shared Classic/TBC jungle cover
    adventureCoverIsLoadingScreen = true,

    startQuest = { id = 624, name = "Cortello's Riddle", npc = "Cortello's Riddle", location = "the Bloodsail ships off the Wild Shore, Stranglethorn Vale" },
    startMapID = 50,
    startX = 0.3000,
    startY = 0.8900,

    npcLocations = {
        ["Cortello's Riddle"] = { mapID = 50, x = 0.3000, y = 0.8900, location = "the Bloodsail ships off the Wild Shore, Stranglethorn Vale" },
        ["A Soggy Scroll"] = { mapID = 51, x = 0.2200, y = 0.4800, location = "under the first wooden bridge west of Stonard, Swamp of Sorrows" },
        ["Cortello's Treasure"] = { mapID = 26, x = 0.8100, y = 0.4700, location = "under the great eastern waterfall, The Hinterlands" },
    },

    chapterIcons = {
        ["The Soggy Scroll"] = 134331,
        ["Bloodfen Burrow"] = 134939,
        ["Under the Great Falls"] = 133634,
    },

    chapters = {
        {
            chapter = "The Soggy Scroll",
            summary = "Aboard one of the Bloodsail ships off Stranglethorn's Wild Shore lies a small scroll with a riddle on it, signed Cortello. Nobody seems to know who Cortello was. Nobody writes a riddle about nothing, either.",
            recap = "You'd be amazed what pirates leave lying around. Aboard one of the Bloodsail ships off Stranglethorn's Wild Shore, I came across a little scroll with a riddle on it. Cortello's, it said. No idea who Cortello was. Still haven't.\n\nNow, I know better than to trust verse I find on a pirate ship. But nobody writes a riddle about nothing. There's always something at the bottom of it worth hiding, and I had time on my hands.\n\nI worked it out, more or less, and it sent me all the way to the Swamp of Sorrows, to the first wooden bridge west of Stonard. Under the bridge, in the muck, another scroll. Soggy, of course. It had been living under a bridge in a swamp. I'd be soggy too.",
            quests = {
                { id = 624, name = "Cortello's Riddle", npc = "Cortello's Riddle" },
            },
        },
        {
            chapter = "Bloodfen Burrow",
            summary = "Under a bridge west of Stonard, in the Swamp of Sorrows, Cortello left another scroll. The swamp has not been kind to it. The verse is still readable, just about, and it has somewhere new in mind.",
            recap = "The soggy scroll had another riddle on it, which by then I'd come to expect, and this one wanted me in Dustwallow Marsh. Over the sea. For a bit of paper. I did wonder on the boat what I was doing with myself.\n\nBloodfen Burrow is raptor country, and the Bloodfen raptors are not shy. They treat anybody poking around their home as dinner that's had the decency to walk in. I'll give Cortello this much: nobody was going to stumble on that hiding place by accident.\n\nDown among the raptors, sure enough, there was another scrap. Musty, this one, like it had been waiting a long time for somebody stubborn enough to turn up. I'm very stubborn about treasure.",
            quests = {
                { id = 625, name = "Cortello's Riddle", npc = "A Soggy Scroll" },
            },
        },
        {
            chapter = "Under the Great Falls",
            summary = "The musty scroll from Bloodfen Burrow has another verse on it. By now you've boarded a pirate ship, crawled under a bridge and walked into a raptor den on Cortello's say-so. Why stop now?",
            recap = "The musty scroll was the last of them, and it pointed at the Hinterlands, at the great waterfall on the eastern coast. By then I'd boarded a pirate ship, crawled under a bridge and walked into a raptor den on the strength of a stranger's handwriting. You'd think I'd have learned something. I had not.\n\nUnder the falls, there it was: Cortello's treasure. An actual chest, the kind you hope for as a child and stop believing in once you're grown.\n\nI won't tell you what was in it. Not because it was disappointing. Because I've told this story enough times to know that once you say what's in the chest, everyone stops listening. Cortello paid well for the trouble. Leave it at that.",
            quests = {
                { id = 626, name = "Cortello's Riddle", npc = "Musty Scroll", mapID = 70, x = 0.3100, y = 0.6600, location = "Bloodfen Burrow, southwestern Dustwallow Marsh" },
            },
        },
    },
}
