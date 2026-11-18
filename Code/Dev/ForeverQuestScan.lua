local addonName, SM = ...

-- =============================================================================
-- WoW Forever quest scan (proof of concept, Forever only)
--
-- Forever added quests to the original Classic chains, so the Classic story
-- data can't be trusted as is. /sm scan asks the server for every quest
-- Forever has (SM.ForeverQuestIDs, from the client's QuestV2 table) plus every
-- quest the stories use. Two things come out of it:
--
--   1. StoryModeDB.foreverScan: the title of every quest, and which story
--      quests are missing or renamed on Forever.
--   2. The client's quest cache, Cache/WDB/<locale>/questcache.wdb, now holds
--      the full record of every quest: zone, levels, text and the follow-up
--      quest. The client writes it when you log out.
--
-- _Dev/tools/forever-quest-scan.mjs report reads both and lists, per story,
-- what Forever changed and which new quests sit in or next to the chain.
-- =============================================================================

if not (SM.Client and SM.Client.isForever) then return end

local PREFIX = "|cffffd200Story Mode scan:|r "
local REQUESTS_PER_TICK = 20
local TICK_SECONDS = 0.25
local TIMEOUT_SECONDS = 6
local MAX_ATTEMPTS = 2

local scan
local ticker
local eventFrame

local function Print(text)
    print(PREFIX .. text)
end

local function ForEachStoryQuest(callback)
    if not SM.ForEachContentData then return end
    SM.ForEachContentData(function(data)
        if not SM.IsContentAvailableForClient(data) then return end
        for _, section in ipairs({ data.prereqs or {}, data.chapters or {}, data.insurrection or {} }) do
            for _, chapter in ipairs(section) do
                if SM.IsContentAvailableForClient(chapter) then
                    for _, quest in ipairs(chapter.quests or {}) do
                        if type(quest) == "table" and quest.id and SM.IsContentAvailableForClient(quest) then
                            callback(data, chapter, quest)
                        end
                    end
                end
            end
        end
    end)
end

local function BuildQueue()
    local queue, seen = {}, {}
    local function add(id)
        id = tonumber(id)
        if id and id > 0 and not seen[id] then
            seen[id] = true
            queue[#queue + 1] = id
        end
    end
    for first, last in (SM.ForeverQuestIDs or ""):gmatch("(%d+)%-?(%d*)") do
        first = tonumber(first)
        last = tonumber(last) or first
        for id = first, last do add(id) end
    end
    ForEachStoryQuest(function(_, _, quest)
        for _, id in ipairs(SM.GetQuestIDs(quest)) do add(id) end
    end)
    table.sort(queue)
    return queue
end

local function NormalizeTitle(title)
    return (title or ""):lower():gsub("[\226\128\152\226\128\153]", "'"):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
end

local function CheckStories()
    local results = scan.titles
    local stories = {}
    local missing, renamed = 0, 0
    local compareTitles = GetLocale() == "enUS"
    ForEachStoryQuest(function(data, chapter, quest)
        local title = results[quest.id]
        local story = stories[data.title]
        if not story then
            story = { missing = {}, renamed = {} }
            stories[data.title] = story
        end
        if title == false or title == nil then
            story.missing[#story.missing + 1] = quest.id
            missing = missing + 1
        elseif compareTitles and quest.name and NormalizeTitle(title) ~= NormalizeTitle(quest.name) then
            story.renamed[#story.renamed + 1] = { id = quest.id, data = quest.name, forever = title }
            renamed = renamed + 1
        end
    end)
    for title, story in pairs(stories) do
        if #story.missing == 0 and #story.renamed == 0 then stories[title] = nil end
    end
    return stories, missing, renamed
end

local function Finish()
    if ticker then ticker:Cancel() ticker = nil end
    if eventFrame then eventFrame:UnregisterEvent("QUEST_DATA_LOAD_RESULT") end

    local loaded, failed, recovered = 0, 0, 0
    for _, title in pairs(scan.titles) do
        if title then loaded = loaded + 1 else failed = failed + 1 end
    end
    if scan.retry then
        for _, id in ipairs(scan.queue) do
            if scan.titles[id] then recovered = recovered + 1 end
        end
    end

    local stories, missing, renamed = CheckStories()
    local version, build = GetBuildInfo()
    StoryModeDB = StoryModeDB or {}
    StoryModeDB.foreverScan = {
        build = (version or "?") .. "." .. (build or "?"),
        locale = GetLocale(),
        finished = time(),
        seconds = math.floor(GetTime() - scan.started),
        requested = #scan.queue,
        loaded = loaded,
        failed = failed,
        titles = scan.titles,
        stories = stories,
    }

    if scan.retry then
        Print(string.format("retry done in %ds. %d of %d refused quests loaded this time.", StoryModeDB.foreverScan.seconds, recovered, #scan.queue))
    end
    Print(string.format("done in %ds. %d quests loaded, %d not on this server.", StoryModeDB.foreverScan.seconds, loaded, failed))
    Print(string.format("Story quests: %d missing on Forever, %d with a different title.", missing, renamed))
    Print("Log out (not just /reload) so the game writes its quest cache, then run:")
    Print("node _Dev/tools/forever-quest-scan.mjs report .")
    scan.running = false
end

local function OnQuestDataLoaded(questID, success)
    local pending = scan and scan.pending[questID]
    if not pending then return end
    scan.pending[questID] = nil
    scan.pendingCount = scan.pendingCount - 1
    if success then
        scan.titles[questID] = C_QuestLog.GetTitleForQuestID(questID) or ""
    else
        scan.titles[questID] = false
    end
    scan.done = scan.done + 1
end

local function Tick()
    if not scan or not scan.running then return end
    local now = GetTime()

    for questID, pending in pairs(scan.pending) do
        if now - pending.sent > TIMEOUT_SECONDS then
            scan.pending[questID] = nil
            scan.pendingCount = scan.pendingCount - 1
            if pending.attempts < MAX_ATTEMPTS then
                table.insert(scan.retryQueue, { id = questID, attempts = pending.attempts })
            else
                -- The cache may already have it even though no event came back.
                local title = C_QuestLog.GetTitleForQuestID(questID)
                scan.titles[questID] = (title and title ~= "") and title or false
                scan.done = scan.done + 1
            end
        end
    end

    local budget = scan.perTick - scan.pendingCount
    while budget > 0 do
        local entry = table.remove(scan.retryQueue)
        if not entry and scan.nextIndex <= #scan.queue then
            entry = { id = scan.queue[scan.nextIndex], attempts = 0 }
            scan.nextIndex = scan.nextIndex + 1
        end
        if not entry then break end
        scan.pending[entry.id] = { sent = now, attempts = entry.attempts + 1 }
        scan.pendingCount = scan.pendingCount + 1
        C_QuestLog.RequestLoadQuestByID(entry.id)
        budget = budget - 1
    end

    local percent = math.floor(scan.done * 100 / #scan.queue)
    if percent >= scan.nextReport then
        Print(string.format("%d%% (%d of %d)", percent, scan.done, #scan.queue))
        scan.nextReport = (math.floor(percent / 10) + 1) * 10
    end

    if scan.done >= #scan.queue and scan.pendingCount == 0 and #scan.retryQueue == 0 then
        Finish()
    end
end

local function Start(retry)
    if scan and scan.running then
        Print("already running. /sm scan stop to cancel.")
        return
    end
    if not (C_QuestLog and C_QuestLog.RequestLoadQuestByID and C_QuestLog.GetTitleForQuestID) then
        Print("this client can't load quests by ID.")
        return
    end

    local queue = BuildQueue()
    local previous = StoryModeDB and StoryModeDB.foreverScan
    local titles = {}
    if retry then
        if not (previous and previous.titles) then
            Print("no scan to retry yet. /sm scan starts one.")
            return
        end
        -- Ask again, slowly, for every quest the last scan didn't get, so a
        -- quest the server holds back can be told from a dropped request.
        local failed = {}
        for _, id in ipairs(queue) do
            if not previous.titles[id] then failed[#failed + 1] = id end
        end
        for id, title in pairs(previous.titles) do titles[id] = title end
        queue = failed
        if #queue == 0 then
            Print("the last scan got every quest.")
            return
        end
    end
    scan = {
        running = true,
        retry = retry,
        perTick = retry and 4 or REQUESTS_PER_TICK,
        queue = queue,
        nextIndex = 1,
        pending = {},
        pendingCount = 0,
        retryQueue = {},
        titles = titles,
        done = 0,
        nextReport = 10,
        started = GetTime(),
    }

    if not eventFrame then
        eventFrame = CreateFrame("Frame")
        eventFrame:SetScript("OnEvent", function(_, _, questID, success)
            OnQuestDataLoaded(questID, success)
        end)
    end
    eventFrame:RegisterEvent("QUEST_DATA_LOAD_RESULT")

    local seconds = math.ceil(#queue / scan.perTick * TICK_SECONDS)
    Print(string.format("asking the server for %d %squests. This takes about %d min. /sm scan status shows progress.",
        #queue, retry and "refused " or "", math.ceil(seconds / 60)))
    ticker = C_Timer.NewTicker(TICK_SECONDS, Tick)
end

function SM.HandleScanCommand(msg)
    local arg = msg:match("^scan%s+(%S+)")
    if arg == "stop" then
        if scan and scan.running then
            if ticker then ticker:Cancel() ticker = nil end
            scan.running = false
            Print(string.format("stopped after %d of %d quests.", scan.done, #scan.queue))
        else
            Print("not running.")
        end
    elseif arg == "retry" then
        Start(true)
    elseif arg == "status" then
        if scan and scan.running then
            Print(string.format("%d of %d quests, %d waiting for the server.", scan.done, #scan.queue, scan.pendingCount))
        elseif StoryModeDB and StoryModeDB.foreverScan then
            local last = StoryModeDB.foreverScan
            Print(string.format("last scan: build %s, %d loaded, %d not on this server.", last.build, last.loaded, last.failed))
        else
            Print("no scan yet. /sm scan starts one.")
        end
    else
        Start()
    end
end
