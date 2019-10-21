
-- Globals
defaultSpellTextureName = "Lightning Bolt";
defaultSpellCount = 4;
defaultFontSize = 13;

SpellView = {
    window = nil;
    rows = {};
}

function SpellView:new(o)
    o = o or {};
    setmetatable(o, self);
    self.__index = self;

    -- Create default window for spell view.
    -- (128px * 128px, movable, resizable, mouse enabled)
    self.window = Window:new(nil, 128, 128, true, true, true)

    -- Init spell view by creating default amount of spell rows.
    self:init();
    return o;
end

function SpellView:addSpell(index)
    local spellRow = Spell:new(nil, 
        self.window,
        index,
        GetSpellTexture(defaultSpellTextureName),
        defaultSpellTextureName,
        defaultFontSize,
        defaultIconSize
    );
end

function SpellView:init()
    self:addSpell(0);
end

-- Show / Hide spellview window
function SpellView:show(val)
    if val then
        self.window:showWindow();
    else
        self.window:hideWindow();
    end
end

function SpellView:getMousePos()
    return self.window:getMousePos();
end

-- Get the X coordinate from a point in the Spell View window counted from 0.
function SpellView:getNormalizedXCoords(point)
    local left = self.window.frame:GetLeft();
    local uiScale = UIParent:GetEffectiveScale();
    local fWidth = self.window.frame:GetWidth();
    local lx = (fWidth - ((point / uiScale) - (left)));
    return (fWidth - lx);
end

-- Get the Y coordinate from a point in the Spell View window counted from 0.
function SpellView:getNormalizedYCoords(point)
    local bottom = self.window.frame:GetBottom();
    local uiScale = UIParent:GetEffectiveScale();
    local fHeight = self.window.frame:GetHeight();
    local ly = (fHeight - ((point / uiScale) - bottom));
    return ly;
end