local playerNotVisible = false
local blackScreenOpacity = 1
local blackScreenFadeSpeed = 0

local rainOutsideSFX = SFX.open("_OST/_Sound Effects/Ambiences/rain_outside.ogg")
local rainInsideSFX = SFX.open("_OST/_Sound Effects/Ambiences/rain_inside.ogg")
local rainActivated = false

local function doRainWeather()
    if rainActivated then
        if Section(player.section).effects.weather == WEATHER_RAIN then
            rainState = true
            prevState = false
        else
            rainState = false
            prevState = true
        end
        if (rainState ~= prevRainState) or (prevSection ~= newSection) then
            if rainState then
                currentSfxOutRain = SFX.play(rainoutsidesfx, 1, 0)
                
                if currentSfxInRain then
                    currentSfxInRain:fadeout(50)
                    currentSfxInRain = nil
                end
            elseif prevState then
                currentSfxInRain = SFX.play(raininsidesfx, 1, 0)
                
                if currentSfxOutRain then
                    currentSfxOutRain:fadeout(50)
                    currentSfxOutRain = nil
                end
            end
            prevSection = player.section
            newSection = Section.getIdxFromCoords(player.x, player.y)
            prevRainState = rainState
            prevPreviousState = prevState
            prevInsideState = insideState
        end
    else
        if currentSfxInRain then
            currentSfxInRain:fadeout(50)
            currentSfxInRain = nil
        end
        if currentSfxOutRain then
            currentSfxOutRain:fadeout(50)
            currentSfxOutRain = nil
        end
    end
end

local function thunderLight()
    SFX.play(43)
end

local function openingCutsceneEvent1()
    rainActivated = true
    playerNotVisible = true
    SFX.play(43)
    Routine.wait(4, true)
    blackScreenFadeSpeed = 0.05
end

function onTick()
    if lunatime.tick() == 1 then
        Routine.run(openingCutsceneEvent1)
    end
    blackScreenOpacity = math.clamp(blackScreenOpacity + blackScreenFadeSpeed, 0, 1)
end

function onDraw()
    if playerNotVisible then
        player.forcedState = FORCEDSTATE_INVISIBLE
    end
    if opacity > 0 then
        Graphics.drawScreen{color = Color.black .. blackScreenOpacity, priority = 10}
    end
    doRainWeather()
end