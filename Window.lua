
-- Globals
mainWindowMovable = true;
mainWindowResizable = true;
mainWindowEnableMouse = true;
mainWindowMinResizeWidth = 128;
mainWindowMinResizeHeight = 128;
mainWindowMaxResizeWidth = 400;
mainWindowMaxResizeHeight = 400;
mainWindowDefaultWidth = 128;
mainWindowDefaultHeight = 128;
mainWindowDefaultAlpha = 0.4;
mainWindowDefaultTextureR = 0;
mainWindowDefaultTextureG = 0;
mainWindowDefaultTextureB = 0;
mainWindowDefaultPoint = "CENTER";
mainWindowDefaultTexture = "ARTWORK";
mainWindowResizeRangeX = 15;
mainWindowResizeRangeY = 15;

Window = {
    frame = nil;
    width = mainWindowDefaultWidth;
    height = mainWindowDefaultHeight;
    movable = mainWindowMovable;
    resizable = mainWindowResizable;
    mouseEnabled = mainWindowEnableMouse;
    texR = mainWindowDefaultTextureR;
    texG = mainWindowDefaultTextureG;
    texB = mainWindowDefaultTextureB;
    alpha = mainWindowDefaultAlpha;
    resizeRangeX = mainWindowResizeRangeX;
    resizeRangeY = mainWindowResizeRangeY;
}

function Window:new(o, width, height, movable, resizable, mouseEnabled)
    o = o or {};
    setmetatable(o, self);
    self.__index = self;
    self.width = width or mainWindowDefaultWidth;
    self.height = height or mainWindowDefaultHeight;
    self.oldFrameWidth = 0;
    self.oldFrameHeight = 0;
    self.movable = movable or mainWindowMovable;
    self.resizable = resizable or mainWindowResizable;
    self.mouseEnabled = mouseEnabled or mainWindowEnableMouse;
    self.frame = CreateFrame("Frame", "DragFrame1", UIParent);
    self:createMainWindow();

    return o;
end

function Window:createMainWindow()
    -- Frame settings
    self.frame:SetMovable(mainWindowMovable)
    self.frame:SetResizable(mainWindowResizable)
    self.frame:EnableMouse(mainWindowEnableMouse)
    self.frame:SetMinResize(mainWindowMinResizeWidth, mainWindowMinResizeHeight)
    self.frame:SetMaxResize(mainWindowMaxResizeWidth, mainWindowMaxResizeHeight)

    self.frame:SetPoint(mainWindowDefaultPoint);
    self.frame:SetWidth(self.width);
    self.frame:SetHeight(self.height);
    self:setFunctionality();

    -- Set texture
    local tex = self.frame:CreateTexture(mainWindowDefaultTexture);
    tex:SetAllPoints();
    tex:SetColorTexture(self.texR, self.texG, self.texB);
    tex:SetAlpha(self.alpha);
end

function Window:getMousePos()
    local uiScale = UIParent:GetEffectiveScale();
    local x, y = GetCursorPosition();
    local bottom = self.frame:GetBottom();
    local left = self.frame:GetLeft();
    local fWidth = self.frame:GetWidth();
    local fHeight = self.frame:GetHeight();
    
    local ly = (fHeight - ((y / uiScale) - (bottom )));
    local lx = (fWidth - ((x / uiScale) - (left)));

    return ((lx - fWidth) * -1), ly;
end

function Window:saveOldPos()
    self.oldFrameWidth = self.frame:GetWidth();
    self.oldFrameHeight = self.frame:GetHeight();
end

function Window:updatePos()
    self.width = self.frame:GetWidth();
    self.height = self.frame:GetHeight();
end

function Window:setResizableFunctionality()
    if self.resizable then
        self.frame:SetMinResize(mainWindowMinResizeWidth, mainWindowMinResizeHeight)
        self.frame:SetMaxResize(mainWindowMaxResizeWidth, mainWindowMaxResizeHeight)
        self.frame:RegisterForDrag("LeftButton")
        self.frame:SetScript("OnDragStart", self.frame.StartMoving)
        self.frame:SetScript("OnDragStop", self.frame.StopMovingOrSizing)
    end
end

function Window:setMovableFunctionality()
    if self.movable then
        self.frame:SetScript("OnMouseDown", function(self, button)
            local mouseX, mouseY = Window:getMousePos();

            if mouseX > (Window.width - Window.resizeRangeX) and 
                mouseY > (Window.height - Window.resizeRangeY) then
                    Window.frame:StartSizing("BOTTOMRIGHT");
            end
            Window.frame:SetUserPlaced(true)
        end)

        self.frame:SetScript("OnMouseUp", function(self, button)
            Window.frame:StopMovingOrSizing()
        end)
    end
end

function Window:setUpdateFunctionality()
    self.frame:SetScript('OnUpdate', function()
        if Window.frame:GetWidth() ~= Window.oldFrameWidth or 
            Window.frame:GetHeight() ~= Window.oldFrameHeight then
            print("Update");
            Window:updatePos();
            Window:saveOldPos();
        end
    end)
end

function Window:setFunctionality()
    self:setResizableFunctionality();
    self:setMovableFunctionality();
    self:setUpdateFunctionality();
end

function Window:hideWindow()
    self.frame:Hide();
end

function Window:showWindow()
    self.frame:Show();
end

function Window:setMovable(val)
    self.movable = val;
end

function Window:setResizable(val)
    self.resizable = val;
end

function Window:setMouseEnabled(val)
    self.mouseEnabled = val;
end

function Window:setWidth(width)
    self.width = width;
end

function Window:setWidth(height)
    self.height = height;
end