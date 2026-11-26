-- Fakes of the game shared by the story quest mark tests.
local Fakes = {}

-- A texture or frame: records colour, grey, atlas, parent and anchor.
function Fakes.NewRegion()
    local region = { color = { 1, 1, 1 }, desaturated = false, shown = false, children = {} }
    function region:SetVertexColor(red, green, blue) self.color = { red, green, blue } end
    function region:SetDesaturated(desaturated) self.desaturated = desaturated end
    function region:SetAtlas(atlas) self.atlas = atlas end
    function region:SetTexture(texture) self.texture = texture end
    function region:SetAlpha(alpha) self.alpha = alpha end
    -- The game loads a texture's file a few frames after it is first drawn.
    function region:IsObjectLoaded() return self.loaded == true end
    function region:SetSize(width) self.size = width end
    function region:SetAllPoints() end
    function region:GetWidth() return 18 end
    function region:SetPoint(_, relativeTo, _, offsetX, offsetY)
        self.anchor, self.offsetX, self.offsetY = relativeTo, offsetX, offsetY
    end
    function region:ClearAllPoints() self.anchor = nil end
    function region:SetFrameLevel() end
    function region:GetFrameLevel() return 1 end
    function region:Show() self.shown = true end
    function region:Hide() self.shown = false end
    function region:IsForbidden() return false end
    function region:CreateTexture()
        local texture = Fakes.NewRegion()
        texture.shown = true
        self.children[#self.children + 1] = texture
        return texture
    end
    function region:SetParent(parent)
        if self.parent and self.parent.badge == self then self.parent.badge = nil end
        self.parent = parent
        parent.badge = self
    end
    return region
end

-- The game's frame pool: Acquire reuses released frames.
function Fakes.CreateFramePool(_, _, _, resetter)
    local pool = { free = {}, active = {} }
    function pool:Acquire()
        local frame = table.remove(self.free)
        local isNew = frame == nil
        frame = frame or Fakes.NewRegion()
        self.active[frame] = true
        return frame, isNew
    end
    function pool:Release(frame)
        resetter(self, frame)
        self.active[frame] = nil
        self.free[#self.free + 1] = frame
    end
    function pool:ReleaseAll()
        for frame in pairs(self.active) do self:Release(frame) end
    end
    return pool
end

-- Frames that keep their handlers so a test can fire events. Also returns
-- the frames.
function Fakes.EventFrames()
    local frames = {}
    CreateFrame = function()
        local frame = Fakes.NewRegion()
        frame.events, frame.scripts = {}, {}
        function frame:RegisterEvent(event) self.events[event] = true end
        function frame:SetScript(script, handler) self.scripts[script] = handler end
        frames[#frames + 1] = frame
        return frame
    end
    return function(event, ...)
        for _, frame in ipairs(frames) do
            if frame.events[event] then frame.scripts.OnEvent(frame, event, ...) end
        end
    end, frames
end

function Fakes.InstallGlobals()
    CreateFramePool = Fakes.CreateFramePool
    UIParent = Fakes.NewRegion()
    wipe = function(list)
        for key in pairs(list) do list[key] = nil end
        return list
    end
end

-- Story Mode's lookups: questStories maps a quest ID to its story ID.
function Fakes.NewStoryMode(questStories, followedStoryID, questNpcs)
    local SM = {}
    SM.followedStoryID = followedStoryID
    function SM.FindQuestStory(questID)
        local storyID = questStories[questID]
        if not storyID then return nil end
        return { id = storyID }, { npc = questNpcs and questNpcs[questID] }
    end
    function SM.GetFollowedStoryID() return SM.followedStoryID end
    return SM
end

function Fakes.IsColor(region, color)
    return region.desaturated and region.color[1] == color[1] and region.color[2] == color[2]
        and region.color[3] == color[3]
end

function Fakes.IsPlain(region)
    return not region.desaturated and region.color[1] == 1 and region.color[2] == 1 and region.color[3] == 1
end

return Fakes
