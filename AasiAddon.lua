print("AasiAddon loaded!");

-- Create a new settings slash command
SLASH_TESTADDON1= "/aasiaddon";
SlashCmdList["AASIADDON"] = AasiAddon_SlashCommand;

-- Settings window button callback
function buttonCallBack()
    print("+ button pressed.")
end

-- Settings window
function showWindow()
    local frame = AceGUI:Create("Frame")
    frame:SetTitle("Example Frame")
    frame:SetStatusText("AceGUI-3.0 Example Container Frame")
    frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
    frame:SetLayout("Flow")
    
    local editbox = AceGUI:Create("EditBox")
    editbox:SetLabel("Insert text:")
    editbox:SetWidth(200)
    frame:AddChild(editbox)
    
    local button = AceGUI:Create("Button")
    button:SetText("+")
    button:SetWidth(200)
    button:SetCallback("OnClick", buttonCallBack)
    frame:AddChild(button)
    
end

-- Settings slash command handler
function AasiAddon_SlashCommand()
    showWindow();
end