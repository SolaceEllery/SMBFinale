local smbseFunctions = {}

-- Console string sender
function smbseFunctions.SendToConsole(data)
    return console:println(tostring(data))
end

smbseFunctions.SendToConsole("Loading SMBSEFunctions...")

-- Only on SEE Mod
if SMBX_VERSION == VER_SEE_MOD then
    smbseFunctions.SendToConsole("SEE MOD DETECTED! Loading LunaDLL.dll...")
    _G.LunaDLL = ffi.load("LunaDll.dll")
end

-- All "smbseFunctions" libraries that'll be used
smbseFunctions.Tables = require("scripts/_smbseScripts/smbseFunctions/tables")
smbseFunctions.File = require("scripts/_smbseScripts/smbseFunctions/file")
smbseFunctions.Screen = require("scripts/_smbseScripts/smbseFunctions/screen")
smbseFunctions.Sound = require("scripts/_smbseScripts/smbseFunctions/sound")
smbseFunctions.Player = require("scripts/_smbseScripts/smbseFunctions/player")

-- Loaded successfully
smbseFunctions.SendToConsole("Loaded SMBSEFunctions.")

-- Execute this function if you need to know what function does which
--[[function smbseFunctions.help()
    Misc.richDialog("SMASFunctions Help Dialog Box", smbseFunctions.file.readFile("smasFunctions_help.txt"), true)
end]]

return smbseFunctions