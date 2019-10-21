print("Settings!")

function showSettings()
    print("Show settings!")
end

-- Settings slash command handler
function AasiAddon_SlashCommand()
    showSettings()
end

-- Create a new settings slash command
SLASH_AASIADDON1= "/aasiaddon";
SlashCmdList["AASIADDON"] = AasiAddon_SlashCommand;

print("AasiAddon loaded!");

