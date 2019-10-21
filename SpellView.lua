

SpellView = {
    window = nil;
}

function SpellView:new(o)
    o = o or {};
    setmetatable(o, self);
    self.__index = self;

    -- Create default window for spell view.
    -- (128px * 128px, movable, resizable, mouse enabled)
    self.window = Window:new(nil, 128, 128, true, true, true)
    return o;
end

function SpellView:init()
    
end

-- Show / Hide spellview window
function SpellView:show(val)
    if val then
        self.window:showWindow();
    else
        self.window:hideWindow();
    end
end