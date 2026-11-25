local _, SM = ...
local L = SM.L

-- The Story Mode window on a controller, with its own focus
-- (ControllerFocus.lua): it never joins the game's controller window list,
-- which tainted the game's controller state ("Interface action failed",
-- SetPreferredGamepadInteractTarget, the map from the radial menu).
SM.ControllerFocus.New(StoryModeFrame, {
    hintText = L["Controller Hint"],
})
