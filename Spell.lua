
-- Globals
defaultFrameStrata = "BACKGROUND";
defaultIconSize = 30;
defaultFontSize = 13;
defaultTextFont = "Fonts\\ARIALN.ttf";

Spell = {
    row = nil;
    spellView = nil;
    rowIcon = nil;
    rowText = nil;
    
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
    
    self:init();

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

function Spell:addItemsToRow()
    local padding = 30;
    self.row:SetFrameStrata("BACKGROUND")
    self.row:SetWidth(self.rowText.text:GetWidth() + self.iconSize + (padding * 1.5)) 
    self.row:SetHeight(self.iconSize + (padding / 2))
    self.row:SetPoint("CENTER" , self.spellView.frame, "TOPLEFT", 0, 0)
    
    self.row:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                                            edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                                            tile = true, tileSize = 3, edgeSize = 3, 
                                            insets = { left = 1, right = 1, top = 1, bottom = 1 }});
                                            self.row:SetBackdropColor(0,0,0,.5);

    
    --print("ff: " .. self.spellView:getNormalizedXCoords(self.row:GetLeft()) + self.iconSize)
    self.rowIcon:SetPoint("CENTER", self.row, "TOPLEFT", self.iconSize, ((self.iconSize) * -1) + ((self.iconSize / 2) / 2))
    self.rowText:SetPoint("CENTER", self.row, "TOPLEFT", 0, (self.row:GetHeight() * -1) / 2)
    
    self.row:SetPoint("CENTER" , self.spellView.frame, "TOPLEFT", (self.row:GetWidth()) / 2, (self.spellIndex + 1))
    
    self.row:SetParent(self.spellView.frame);
    

end

function Spell:init()
    self:createIcon();
    self:createText();
    self:addItemsToRow();
end