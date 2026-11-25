-- A window of ours, used with the controller, without joining the game's
-- controller window list: a snippet to copy as is into an addon
-- (devAddons/luaSnippets; README.md there says how to use it).
--
-- Joining that list (GamepadMode.FrameControlsManager:FrameShown) from addon
-- code taints the game's controller state: "Interface action failed", then
-- ADDON_ACTION_FORBIDDEN SetPreferredGamepadInteractTarget, a tainted map
-- opened from the radial menu (AuctionVendorSniper 2026-11-22, StoryMode
-- 2026-11-25). So the window has its own focus instead:
--   • it's focused when it opens with the controller UI on, and by Select (the
--     game's "Focus UI" key) when Select leaves the game's own windows
--     unfocused; a click outside it, Select or Start unfocus it;
--   • focused, it takes the controller's buttons (EnableGamePadButton on the
--     window only; an OnGamePadButtonDown frame takes every button while
--     enabled, so it's off whenever the window isn't focused):
--       D-pad   moves to the nearest control that way (and scrolls a scroll
--               frame when there's none that way)
--       A       presses it (OnClick, or OnMouseDown/OnMouseUp for controls
--               that act on those, such as the game's side tabs)
--       B       closes the window (options.onBack instead, if given)
--   • the focused control gets the mouse's hover (its OnEnter: highlight,
--     tooltip) and a gold frame, and a hint under the window lists the keys.
-- Nothing of the game's is replaced: a post-hook (hooksecurefunc) on its
-- ToggleUIFocus reads its state.
--
-- Use: addonTable.ControllerFocus.New(window, options), once, after the window
-- exists. options (all optional):
--   onBack()            B; default: window:Hide()
--   hintText            the hint's text, with {move} {press} {back} {select}
--                       replaced by the controller's icons
local _, addonTable = ...

local ControllerFocus = {}
addonTable.ControllerFocus = ControllerFocus

local KEYS = {
    up = GAMEPAD_DPAD_TOP or "PADDUP",
    down = GAMEPAD_DPAD_BOTTOM or "PADDDOWN",
    left = GAMEPAD_DPAD_LEFT or "PADDLEFT",
    right = GAMEPAD_DPAD_RIGHT or "PADDRIGHT",
    press = GAMEPAD_FACE_BOTTOM or "PAD1",
    back = GAMEPAD_FACE_RIGHT or "PAD2",
    select = GAMEPAD_MENU_LEFT or "PADBACK",
    start = GAMEPAD_MENU_RIGHT or "PADFORWARD",
}
local DIRECTIONS = {
    [KEYS.up] = { x = 0, y = 1 },
    [KEYS.down] = { x = 0, y = -1 },
    [KEYS.left] = { x = -1, y = 0 },
    [KEYS.right] = { x = 1, y = 0 },
}
local SCROLL_STEP = 60          -- pixels the D-pad scrolls when no control is that way
local SIDEWAYS_WEIGHT = 3       -- how much being off to the side counts against a control
local BORDER_COLOR = { 1, 0.82, 0, 1 }
local BORDER_SIZE = 2
local BORDER_OUTSET = 3
local HINT_ICON_SIZE = 20
local DEFAULT_HINT = "{move} Move   {press} Select   {back} Close   {select} Back to game"

local function ControllerUIOn()
    return type(InputUtil) == "table" and type(InputUtil.IsGamepadUIEnabled) == "function"
        and InputUtil.IsGamepadUIEnabled() == true
end

local function IconMarkup(key, fallback)
    local iconUtility = _G.InputIconTextureSetUtility
    if type(iconUtility) == "table" and type(iconUtility.GetNormalActiveInputIconButtonTexture) == "function" then
        local ok, atlas = pcall(iconUtility.GetNormalActiveInputIconButtonTexture, key)
        if ok and type(atlas) == "string" then
            return ("|A:%s:%d:%d|a"):format(atlas, HINT_ICON_SIZE, HINT_ICON_SIZE)
        end
    end
    return fallback
end

local function Center(frame)
    local x, y = frame:GetCenter()
    if not x then return nil end
    local scale = frame:GetEffectiveScale()
    return x * scale, y * scale
end

-- A control the player could click: shown, takes the mouse, enabled, and acts
-- on a click or a mouse press.
local function IsControl(frame)
    if frame:IsForbidden() or not frame:IsVisible() or not frame:IsMouseEnabled() then return false end
    if (frame:GetWidth() or 0) < 4 or (frame:GetHeight() or 0) < 4 then return false end
    if frame:IsObjectType("Button") then
        return frame:IsEnabled() and frame:GetScript("OnClick") ~= nil
    end
    return frame:GetScript("OnMouseUp") ~= nil or frame:GetScript("OnMouseDown") ~= nil
end

local function CollectControls(parent, controls)
    for _, child in ipairs({ parent:GetChildren() }) do
        if child:IsVisible() and not child:IsForbidden() then
            if IsControl(child) then controls[#controls + 1] = child end
            CollectControls(child, controls)
        end
    end
    return controls
end

-- The nearest control from (x, y) in direction, or nil.
local function NearestControl(controls, fromX, fromY, direction, exclude)
    local best, bestScore
    for _, control in ipairs(controls) do
        local x, y = Center(control)
        if x and control ~= exclude then
            local ahead = (x - fromX) * direction.x + (y - fromY) * direction.y
            local sideways = math.abs((x - fromX) * direction.y) + math.abs((y - fromY) * direction.x)
            -- Within 45 degrees of the direction: right never picks what's below.
            if ahead > 1 and ahead >= sideways then
                local score = ahead + sideways * SIDEWAYS_WEIGHT
                if not bestScore or score < bestScore then best, bestScore = control, score end
            end
        end
    end
    return best
end

local function ScrollFramesAround(frame)
    local scrollFrames = {}
    local parent = frame:GetParent()
    while parent do
        if parent:IsObjectType("ScrollFrame") then scrollFrames[#scrollFrames + 1] = parent end
        parent = parent:GetParent()
    end
    return scrollFrames
end

-- Scrolls each scroll frame around control so all of it shows.
local function ScrollIntoView(control)
    for _, scrollFrame in ipairs(ScrollFramesAround(control)) do
        local top, bottom = scrollFrame:GetTop(), scrollFrame:GetBottom()
        local controlTop, controlBottom = control:GetTop(), control:GetBottom()
        if top and controlTop then
            local scroll = scrollFrame:GetVerticalScroll()
            if controlTop > top then
                scroll = scroll - (controlTop - top)
            elseif controlBottom < bottom then
                scroll = scroll + (bottom - controlBottom)
            end
            scrollFrame:SetVerticalScroll(math.max(0, math.min(scroll, scrollFrame:GetVerticalScrollRange())))
        end
    end
end

-- Scrolls the first scroll frame under the window that can move that way.
local function ScrollWindow(window, direction)
    if direction.y == 0 then return end
    local function Search(parent)
        for _, child in ipairs({ parent:GetChildren() }) do
            if child:IsVisible() and not child:IsForbidden() then
                if child:IsObjectType("ScrollFrame") and child:GetVerticalScrollRange() > 0 then
                    local scroll = child:GetVerticalScroll()
                    local wanted = math.max(0, math.min(scroll - direction.y * SCROLL_STEP, child:GetVerticalScrollRange()))
                    if wanted ~= scroll then child:SetVerticalScroll(wanted) return true end
                end
                if Search(child) then return true end
            end
        end
    end
    return Search(window)
end

local function CreateBorder(window)
    local border = CreateFrame("Frame", nil, window)
    border:SetFrameStrata("TOOLTIP")
    border:Hide()
    local edges = {
        { "TOPLEFT", "TOPRIGHT", nil, BORDER_SIZE },
        { "BOTTOMLEFT", "BOTTOMRIGHT", nil, BORDER_SIZE },
        { "TOPLEFT", "BOTTOMLEFT", BORDER_SIZE, nil },
        { "TOPRIGHT", "BOTTOMRIGHT", BORDER_SIZE, nil },
    }
    for _, edge in ipairs(edges) do
        local texture = border:CreateTexture(nil, "OVERLAY")
        texture:SetColorTexture(unpack(BORDER_COLOR))
        texture:SetPoint(edge[1])
        texture:SetPoint(edge[2])
        if edge[3] then texture:SetWidth(edge[3]) else texture:SetHeight(edge[4]) end
    end
    return border
end

local function Press(control)
    if control:IsObjectType("Button") then
        control:Click("LeftButton")
        return
    end
    local mouseDown, mouseUp = control:GetScript("OnMouseDown"), control:GetScript("OnMouseUp")
    if mouseDown then mouseDown(control, "LeftButton") end
    if mouseUp then mouseUp(control, "LeftButton", true) end
end

function ControllerFocus.New(window, options)
    options = options or {}
    local focus = { focused = false }
    local current, lastX, lastY
    local border = CreateBorder(window)

    local hint = window:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    hint:SetPoint("TOP", window, "BOTTOM", 0, -6)
    hint:Hide()

    local function Leave()
        if current and current:IsVisible() then
            local onLeave = current:GetScript("OnLeave")
            if onLeave then pcall(onLeave, current) end
        end
        current = nil
        border:Hide()
    end

    local function Enter(control)
        Leave()
        current = control
        if not control then return end
        ScrollIntoView(control)
        lastX, lastY = Center(control)
        border:ClearAllPoints()
        border:SetPoint("TOPLEFT", control, "TOPLEFT", -BORDER_OUTSET, BORDER_OUTSET)
        border:SetPoint("BOTTOMRIGHT", control, "BOTTOMRIGHT", BORDER_OUTSET, -BORDER_OUTSET)
        border:Show()
        local onEnter = control:GetScript("OnEnter")
        if onEnter then pcall(onEnter, control) end
    end

    -- The top-left control, or the one nearest to where the focus last was.
    local function FirstControl()
        local controls = CollectControls(window, {})
        local best, bestScore
        for _, control in ipairs(controls) do
            local x, y = Center(control)
            if x then
                local score
                if lastX then
                    score = math.abs(x - lastX) + math.abs(y - lastY)
                else
                    score = x - y   -- left and high first
                end
                if not bestScore or score < bestScore then best, bestScore = control, score end
            end
        end
        return best
    end

    local function CurrentControl()
        if current and IsControl(current) then return current end
        Enter(FirstControl())
        return current
    end

    function focus.SetFocused(focused)
        focus.focused = focused and ControllerUIOn() and window:IsShown()
        window:EnableGamePadButton(focus.focused)
        if focus.focused then
            local text = (options.hintText or DEFAULT_HINT)
                :gsub("{move}", IconMarkup(GAMEPAD_DPAD_VERTICAL or "DIRPADVERTICAL", "D-pad"))
                :gsub("{press}", IconMarkup(KEYS.press, "A"))
                :gsub("{back}", IconMarkup(KEYS.back, "B"))
                :gsub("{select}", IconMarkup(KEYS.select, "Select"))
            hint:SetText(text)
            hint:Show()
            Enter(FirstControl())
        else
            hint:Hide()
            Leave()
        end
    end

    local function OnButton(_, key)
        if not focus.focused then return end
        if key == KEYS.select or key == KEYS.start then return focus.SetFocused(false) end
        if key == KEYS.back then
            if options.onBack then options.onBack() else window:Hide() end
            return
        end
        local direction = DIRECTIONS[key]
        if direction then
            local from = CurrentControl()
            local fromX, fromY = lastX, lastY
            if from then fromX, fromY = Center(from) end
            if not fromX then return end
            local nextControl = NearestControl(CollectControls(window, {}), fromX, fromY, direction, from)
            if nextControl then
                Enter(nextControl)
            elseif ScrollWindow(window, direction) and current then
                Enter(current)   -- the frame moves with the scroll
            end
            return
        end
        if key == KEYS.press then
            local control = CurrentControl()
            if not control then return end
            Press(control)
            -- What it opened may have moved or hidden it: show the focus where it is now.
            C_Timer.After(0, function()
                if not focus.focused then return end
                if current and IsControl(current) then Enter(current) else Enter(FirstControl()) end
            end)
        end
    end

    window:SetScript("OnGamePadButtonDown", OnButton)
    window:EnableGamePadButton(false)
    window:HookScript("OnShow", function()
        lastX, lastY = nil, nil
        -- A frame later: the window lays itself out on show.
        C_Timer.After(0, function() focus.SetFocused(window:IsShown()) end)
    end)
    window:HookScript("OnHide", function() focus.SetFocused(false) end)

    local events = CreateFrame("Frame")
    events:RegisterEvent("GLOBAL_MOUSE_DOWN")
    events:RegisterEvent("PLAYER_LOGIN")
    events:RegisterEvent("ADDON_LOADED")
    local hooked = false
    -- Select: the game focuses its own window first; when it leaves them all
    -- unfocused, this window takes the focus.
    local function HookSelect()
        local gamepadMode = _G.GamepadMode
        if hooked or type(gamepadMode) ~= "table" or type(rawget(gamepadMode, "ToggleUIFocus")) ~= "function" then return end
        hooksecurefunc(gamepadMode, "ToggleUIFocus", function()
            local manager = gamepadMode.FrameControlsManager
            local gameFocused = type(manager) ~= "table" or manager.isUIFocused == true
            if gameFocused or focus.focused or not window:IsShown() then return end
            focus.SetFocused(true)
            if UIErrorsFrame then UIErrorsFrame:Clear() end   -- the game's "no window to focus"
        end)
        hooked = true
    end
    events:SetScript("OnEvent", function(_, event, name)
        if event == "GLOBAL_MOUSE_DOWN" then
            if focus.focused and not window:IsMouseOver() then focus.SetFocused(false) end
        elseif event == "PLAYER_LOGIN" or name == "Blizzard_Gamepad" then
            HookSelect()
        end
    end)
    HookSelect()

    return focus
end
