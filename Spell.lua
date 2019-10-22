
-- Globals
defaultFrameStrata      = "BACKGROUND";
defaultIconSize         = 30;
defaultRowPadding       = 30;
defaultFontSize         = 13;
defaultTextFont         = "Fonts\\ARIALN.ttf";
defaultUseBackground    = true;
defaultTextIconPadding  = 10;

Spell = {
    row                 = nil;
    spellView           = nil;
    rowIcon             = nil;
    rowText             = nil;
    useBackground       = defaultUseBackground;
    padding             = defaultRowPadding;
    textIconPadding     = defaultTextIconPadding;
}

function Spell:new(o, spellView, index, iconTexture, spellName, fontSize, iconSize)
    o = o or {};
    setmetatable(o, self);
    self.__index = self;
    self.spellView = spellView;
    self.spellIndex = index;
    self.iconTexture = iconTexture;
    self.spellName = spellName;
    self.iconSize = iconSize or defaultIconSize;
    self.fontSize = fontSize or defaultFontSize;
    self.row = CreateFrame("Frame", self.spellView, UIParent);
    
    self:createRow();
    return o;
end

function Spell:createIcon()
    -- Create a new frame for the icon
    self.rowIcon = CreateFrame("Frame", self.row, UIParent);
    self.rowIcon:SetFrameStrata(defaultFrameStrata)
    self.rowIcon:SetWidth(self.iconSize) 
    self.rowIcon:SetHeight(self.iconSize)

    -- Add texture for the icon
    local t = self.rowIcon:CreateTexture(nil, defaultFrameStrata)
    t:SetTexture(self.iconTexture)
    t:SetAllPoints(self.rowIcon)
    self.rowIcon.texture = t
    self.rowIcon:SetParent(self.row)
end

function Spell:createText()
    self.rowText = CreateFrame("Frame",self.row,UIParent)
    self.rowText:SetFrameStrata("BACKGROUND")
    self.rowText:SetWidth(10) 
    self.rowText:SetHeight(10)
    self.rowText:SetPoint("CENTER", 0, 0)
    self.rowText:SetParent(self.row)

    self.rowText.text = self.rowText:CreateFontString(nil, "ARTWORK");
    self.rowText.text:SetFont(defaultTextFont, self.fontSize, "OUTLINE");
    self.rowText.text:SetPoint("CENTER", 0, 0);
    self.rowText.text:SetText(self.spellName);
end

function Spell:setBackground()
    if self.useBackground then
        self.row:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
            tile = true, tileSize = 1, edgeSize = 1, 
            insets = { left = 0, right = 0, top = 0, bottom = 0 }
        });
        self.row:SetBackdropColor(0,0,0,.5);
    end
end

function Spell:getRowPoint()
    local x = (self.row:GetWidth()) / 2;
    local y = (self.spellIndex * -60) + ((self.row:GetHeight() / 2) * -1);

    return x, y;
end

function Spell:setRowPoint()
    local x, y = self:getRowPoint();
    self.row:SetPoint("CENTER" , 
        self.spellView.frame, 
        "TOPLEFT",
        x,
        y
    );
end

function Spell:setRowDimensions()
    local width = 
    self.rowText.text:GetWidth() + 
    self.iconSize + 
    (self.padding);
    
    self.row:SetFrameStrata("BACKGROUND")
    self.row:SetWidth(width + (self.spellView.frame:GetWidth() - width)); 
    self.row:SetHeight(
        self.iconSize + 
        (self.padding / 2)
    );
    self:setRowPoint();
    self.row:SetParent(self.spellView.frame);
end

function Spell:setRowIconPoint()
    self.rowIcon:SetPoint(
        "CENTER",
        self.row,
        "TOPLEFT",
        self.iconSize,
        ((self.iconSize) * -1) + ((self.iconSize / 2) / 2)
    );
end

function Spell:getIconRightPos()
    return SpellView:getNormalizedXCoords(self.rowIcon:GetLeft()) + self.iconSize;
end

function Spell:getTextPoint()
    local x = 0;
    local y = 0;

    local textLength = self.rowText.text:GetWidth();
    local iconRight = self:getIconRightPos();

    x = iconRight + (textLength / 2) + self.textIconPadding;
    y = ((self.row:GetHeight() * -1) / 2);

    return x, y;
end

function Spell:setRowTextPoint()
    local x, y = self:getTextPoint();
    self.rowText:SetPoint(
        "CENTER",
        self.row,
        "TOPLEFT",
        x,
        y
    );
end

function Spell:addItemsToRow()
    self:setRowDimensions();
    self:setBackground();
    self:setRowIconPoint();
    self:setRowTextPoint();
end

function Spell:createRow()
    self:createIcon();
    self:createText();
    self:addItemsToRow();
end

function Spell:update()
    self:addItemsToRow();
    print("updated row: " .. self.spellIndex)
end