local smbseTitleScreen = {}

function smbseTitleScreen.onInitAPI()
    
end

function smbseTitleScreen.loadWorldMap()
    -- Change the Hub level to the world map until the game is closed
    if (mem(0x00B25724, FIELD_STRING) == "SMBSE - Title Screen.lvlx") then
        mem(0x00B25724, FIELD_STRING, "SMBSE - World Map.lvlx")
    end

    -- Load the map!
    Level.load("SMBSE - World Map.lvlx")
end

return smbseTitleScreen