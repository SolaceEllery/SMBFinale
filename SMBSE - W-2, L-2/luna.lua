local flipperino = require("flipperino")

local function doUTNoise()
    SFX.play("_OST/_Sound Effects/Other/Undertale/noise.ogg")
end

function onEvent(eventName)
    if eventName == "flip" then
        SFX.play("ender_portal.ogg")
    end
    if eventName == "flipNormal" then
        SFX.play("ender_portal.ogg")
    end
    if eventName == "Cutscene 1" then
        
    end
    if eventName == "Cutscene 2 - 5" then
        SFX.play("_OST/_Sound Effects/Other/Undertale/rimshot.ogg")
    end
    if eventName == "Cutscene 2 - 9" then
        SFX.play("_OST/_Sound Effects/Other/Undertale/noise.ogg")
    end
    if eventName == "Cutscene 2 - 10" then
        SFX.play("_OST/_Sound Effects/Other/Undertale/noise.ogg")
    end
    if eventName == "Cutscene 2 - 13" then
        if not SaveData.SMASPlusPlus.game.onePointThreeModeActivated then
            if SaveData.SMASPlusPlus.accessibility.enableAdditionalInventory then
                smasBooleans.toggleOffInventory = false
            end
        end
        pauseplus.canPause = true
    end
end