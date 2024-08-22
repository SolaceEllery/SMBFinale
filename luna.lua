--[[
    Super Mario Bros. Spencer
    -- A separate-episode port of the original game from "Super Mario All-Stars++"
    By Spencer Everly
]]

-- Require the globals first and foremost: They'll be used for the very important core features for the episode.
local smbseScriptDir = "___Scripts/"
local smbseGlobals = require(smbseScriptDir.."smbseGlobals")

if SMBSE == nil then
    error("Something very wrong happened when loading smbseGlobals...\r\nContact the creator and tell them you seen this message.")
    Misc.exitEngine()
end

-- Now, let's do the most important libraries!
SMBSE.SaveData = require(smbseScriptDir.."smbseSaveData")
SMBSE.Functions = require(smbseScriptDir.."smbseFunctions")
SMBSE.Transitions = require(smbseScriptDir.."smbseTransitions")
SMBSE.Requirements = require(smbseScriptDir.."smbseRequirements")
SMBSE.FollowerSystem = require(smbseScriptDir.."smbseFollowerSystem")
SMBSE.Hud = require(smbseScriptDir.."smbseHud")

_G.extraSounds = require(smbseScriptDir.."extraSounds")

function onStart()
    if Level.filename() == "SMBSE - Map.lvlx" and not SaveData.SMBSE.progression.openingComplete then
        Level.load("SMBSE - Opening.lvlx")
    end
end

function onDrawEnd()
    -- Fix blinking when starting the level/changing sections
    mem(0x00B250D4, FIELD_BOOL, false)
end