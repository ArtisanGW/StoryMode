local _, SM = ...
local L = SM.L

-- A chapter's journal entry. An optional quest keeps its own lines (recap),
-- which join the entry only once the player has done it, after the paragraph
-- its recapAfter names (or at the end), so the journal never tells an optional
-- quest that wasn't played.
local function GetJournalRecap(ch)
    local recap = SM.GetChapterText(ch, "recap")
    if not recap then return nil end
    local extras
    for _, q in ipairs(ch.quests or {}) do
        if q.recap and SM.IsQuestForPlayer(q) and not SM.ShouldHideQuest(q) and SM.IsQuestEntryComplete(q) then
            extras = extras or {}
            extras[#extras + 1] = q
        end
    end
    if not extras then return recap end

    local paragraphs = {}
    for paragraph in (recap .. "\n\n"):gmatch("(.-)\n\n") do
        paragraphs[#paragraphs + 1] = paragraph
    end
    local out = {}
    for p = 0, #paragraphs do
        if p > 0 then out[#out + 1] = paragraphs[p] end
        for _, q in ipairs(extras) do
            if math.min(q.recapAfter or #paragraphs, #paragraphs) == p then
                out[#out + 1] = SM.ApplyGenderTokens(q.recap)
            end
        end
    end
    return table.concat(out, "\n\n")
end

function SM.LayoutJournalTab(data, w, contentW, visibleContentW)
    local ui = SM.DetailUI
    local detailChild = ui.detailChild
    local detailScroll = ui.detailScroll
    local CP = ui.CP
    local sJournalHeader = ui.sJournalHeader
    local sJournalSubline = ui.sJournalSubline
    local sJournalEmptyTitle = ui.sJournalEmptyTitle
    local sJournalEmptyText = ui.sJournalEmptyText
    local sFactionHeader = ui.sFactionHeader
    local sJournalEntries = ui.sJournalEntries
    local FactionUI = SM.FactionUI
    -- On WoW Forever the journal is a spellbook page (ForeverWindow.lua): its
    -- text is the spellbook's ink, and each chapter title sits on the left
    -- above the spellbook's divider.
    local foreverWindow = SM.ForeverWindow
    local ink = foreverWindow and foreverWindow.JournalInk
    if ink then
        for _, text in ipairs({ sJournalHeader, sJournalSubline, sJournalEmptyTitle, sJournalEmptyText }) do
            text:SetTextColor(ink[1], ink[2], ink[3])
        end
    end
        -- ── JOURNAL TAB layout ──────────────────────────────────────────
        -- Show recap for each completed chapter (no spoilers for future ones)
        local chapters = SM.GetAllChapters(data)
        local journalIdx = 0
        local hasAnyRecap = false
        local quest = SM.FindNextQuest(data)
        local done = SM.GetCampaignProgress(data)
        local lastAnchor = sJournalHeader

        -- Factions live in the contextual left panel on the Journal tab.
        FactionUI:HideAll()
        sFactionHeader:Hide()

        sJournalHeader:SetText(quest and L["Journal Header"] or L["Journal Header Complete"])
        sJournalHeader:ClearAllPoints()
        sJournalHeader:SetPoint("TOP", detailChild, "TOP", 0, -18)
        sJournalHeader:Show()

        sJournalSubline:ClearAllPoints()
        sJournalSubline:SetPoint("TOP", sJournalHeader, "BOTTOM", 0, -4)
        sJournalSubline:SetPoint("LEFT", detailChild, "LEFT", CP, 0)
        sJournalSubline:SetPoint("RIGHT", detailChild, "RIGHT", -CP, 0)
        if contentW > 20 then sJournalSubline:SetWidth(contentW) end
        sJournalSubline:Show()

        for ci, ch in ipairs(chapters) do
            local cd, ct = SM.GetChapterProgress(ch)
            local chComplete = cd == ct and ct > 0
            local recap = GetJournalRecap(ch)
            if chComplete and recap then
                journalIdx = journalIdx + 1
                hasAnyRecap = true
                local entry = SM.GetJournalEntry(journalIdx)

                -- Chapter title
                entry.title:ClearAllPoints()
                if journalIdx == 1 then
                    entry.title:SetPoint("TOP", sJournalSubline, "BOTTOM", 0, -18)
                else
                    local prev = sJournalEntries[journalIdx - 1]
                    entry.title:SetPoint("TOP", prev.body, "BOTTOM", 0, -20)
                end
                entry.title:SetPoint("LEFT", detailChild, "LEFT", CP, 0)
                entry.title:SetPoint("RIGHT", detailChild, "RIGHT", -CP, 0)
                entry.title:SetText(ch.chapter)
                entry.title:Show()
                if ink then
                    entry.title:SetJustifyH("LEFT")
                    entry.title:SetTextColor(ink[1], ink[2], ink[3])
                    entry.body:SetTextColor(ink[1], ink[2], ink[3])
                end
                local divider = ink and foreverWindow.PlaceJournalDivider(journalIdx, entry.title, contentW)

                -- Recap body
                entry.body:ClearAllPoints()
                if divider then
                    entry.body:SetPoint("TOP", divider, "BOTTOM", 0, -8)
                else
                    entry.body:SetPoint("TOP", entry.title, "BOTTOM", 0, -6)
                end
                entry.body:SetPoint("LEFT", detailChild, "LEFT", CP, 0)
                entry.body:SetPoint("RIGHT", detailChild, "RIGHT", -CP, 0)
                entry.body:SetText(recap)
                entry.body:Show()

                lastAnchor = entry.body
            end
        end
        if ink then foreverWindow.HideJournalDividers(journalIdx + 1) end

        if not hasAnyRecap then
            sJournalHeader:Hide()
            sJournalSubline:Hide()
            local emptyTop = -math.max(150, math.floor((detailScroll:GetHeight() or 420) * 0.42))
            sJournalEmptyTitle:ClearAllPoints()
            sJournalEmptyTitle:SetPoint("TOP", detailChild, "TOP", 0, emptyTop)
            sJournalEmptyTitle:SetPoint("LEFT", detailChild, "LEFT", CP, 0)
            sJournalEmptyTitle:SetPoint("RIGHT", detailChild, "RIGHT", -CP, 0)
            if done > 0 then
                sJournalEmptyTitle:SetText(L["Journal No Recaps Title"])
                sJournalEmptyText:SetText(L["Journal No Recaps Text"])
            else
                sJournalEmptyTitle:SetText(L["Journal Empty Title"])
                sJournalEmptyText:SetText(L["Journal Empty Text"])
            end
            sJournalEmptyTitle:Show()
            sJournalEmptyText:ClearAllPoints()
            sJournalEmptyText:SetPoint("TOPLEFT", sJournalEmptyTitle, "BOTTOMLEFT", 0, -8)
            sJournalEmptyText:SetPoint("TOPRIGHT", sJournalEmptyTitle, "BOTTOMRIGHT", 0, -8)
            if contentW > 20 then sJournalEmptyText:SetWidth(contentW) end
            sJournalEmptyText:Show()
            lastAnchor = sJournalEmptyText
        else
            sJournalHeader:Show()
            sJournalSubline:Show()
            sJournalEmptyTitle:Hide()
            sJournalEmptyText:Hide()
        end

        -- Hide unused journal entries
        for i = journalIdx + 1, #sJournalEntries do
            sJournalEntries[i].title:Hide()
            sJournalEntries[i].body:Hide()
        end

        local journalBottomEl = lastAnchor
        -- Set scroll height
        C_Timer.After(0, function()
            local bot = journalBottomEl:GetBottom()
            local top = detailChild:GetTop()
            if bot and top then
                detailChild:SetHeight(math.max(top - bot + 40, 400))
            else
                detailChild:SetHeight(500)
            end
        end)
end

