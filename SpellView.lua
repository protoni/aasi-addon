
-- Globals
defaultSpellTextureName = "Lightning Bolt";
defaultSpellCount = 4;
defaultFontSize = 13;
defaultWidth = 128;
defaultHeight = 128;

SpellView = {
    window = nil;
    rows = {};
    width = defaultWidth;
    height = defaultHeight;
    rowCount = 1;
}

function SpellView:new(o)
    o = o or {};
    setmetatable(o, self);
    self.__index = self;

    -- Create default window for spell view.
    -- (128px * 128px, movable, resizable, mouse enabled)
    self.window = Window:new(nil, self, defaultWidth, defaultHeight, true, true, true)

    -- Init spell view by creating default amount of spell rows.
    self:addRows();
    return o;
end

function SpellView:addSpell(index)
    local spellRow = Spell:new(
        nil, 
        self.window,
        index,
        GetSpellTexture(defaultSpellTextureName),
        defaultSpellTextureName,
        defaultFontSize,
        defaultIconSize
    );
    print(spellRow)
    --table.insert(self.rows, {"row", spellRow});
    self.rows[self.rowCount] = spellRow;
    self.rowCount = self.rowCount + 1;

    return spellRow;
end

function SpellView:addRows()
    local spell1 = self:addSpell(0);
    spell1:update();
    local spell2 = self:addSpell(1);
    local spell3 = self:addSpell(2);

    
    spell2:update();
    spell3:update();
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
    local lx = (fWidth - ((point) - (left)));
    
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

function SpellView:updateSpellRows()
    --[[
    for i=1,table.getn(self.rows) do
        self.rows[i]:update();
        print(self.rows[i])
    end
    
    print("len: " .. table.getn(self.rows))
    print("len2: " .. #self.rows)
    for i, row in ipairs(self.rows) do
        row:update();
    end
    ]]--

    print("updating row: 1");
    self.rows[1]:update();
    print("updating row: 2");
    self.rows[2]:update();
    print("updating row: 3");
    self.rows[3]:update();
end

-- Call back function. Window updating will call this when resized / moved.
function SpellView:update()
    self:updateSpellRows();
end