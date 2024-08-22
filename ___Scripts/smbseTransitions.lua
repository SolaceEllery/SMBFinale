local smbseTransitions = {}

-- Is transitions enabled?
smbseTransitions.enabled = true

-- Transition states
smbseTransitions.transitionStates = {
    STATE_NONE = 0,
    STATE_LEVEL_ENTRANCE = 1,
    STATE_FADE_IN = 2,
}

-- Local variables
local inTransition = false

local transitionEffectTimer = 0
local transitionEffectTimerAlt = 0
local transitionEffectSpeed = 14
local transitionEffectOpacity = 1

local transitionState = 0
local transitionTimer = 0

local doorIDs = table.map{88,87,107,141}

local mainBuffer = Graphics.CaptureBuffer()
local irisOutShader = Shader()
irisOutShader:compileFromFile(nil, Misc.resolveFile("fragments/irisOut.frag"))

function smbseTransitions.applyShader(priority, shader, uniforms)
    mainBuffer:captureAt(7.5)
    Graphics.drawScreen{texture = mainBuffer, priority = 7.5, shader = shader, uniforms = uniforms}
end



local transitionInfo = {
    [smbseTransitions.transitionStates.STATE_LEVEL_ENTRANCE] = {
        startFunction = (function()
            -- Prevent the long wait when starting from a warp
            local currentWarp = Warp(player:mem(0x15E,FIELD_WORD)-1)

            if currentWarp and currentWarp.isValid then
                for _,p in ipairs(Player.get()) do
                    if currentWarp.warpType == 1 then
                        -- Pipes
                        p.forcedTimer = 901
                    else
                        -- Doors
                        p.forcedState = 0
                        p.forcedTimer = 0

                        -- Play the door close SFX
                        SMBSE.Functions.Sound.SFX.Play(148)

                        -- Also spawn a door close effect if the ID is valid (wip)
                        for k,v in BGO.getIntersecting(p.x, p.y, p.x + p.width, p.y + p.height) do
                            if doorIDs[v.id] then
                                
                            end
                        end
                    end
                end
            end
        end),
        muteMusic = true,
        playSound = true,
        soundFile = "_Cues/Start Level",
        soundVolume = 0.55,
        pause = true,
        timerUntilEnd = lunatime.toTicks(1.58),
        effect = (function()
            if transitionTimer >= 1 and transitionTimer < lunatime.toTicks(0.481) then
                Graphics.drawScreen{color = Color.black, priority = 7.5}
            elseif transitionTimer >= lunatime.toTicks(0.481) then
                transitionEffectTimer = transitionEffectTimer + 1.4
                local startRadius = math.max(camera.width, camera.height)

                local radius = math.max(0, startRadius - (transitionEffectTimer * transitionEffectSpeed))
                local middle = math.floor((startRadius + 100) / transitionEffectSpeed)

                middle = 0

                if transitionEffectTimer > middle then
                    radius = (transitionEffectTimer - middle) * transitionEffectSpeed
                end

                if transitionTimer <= lunatime.toTicks(1.272) then
                    if radius <= startRadius then
                        smbseTransitions.applyShader(6, irisOutShader, {center = vector(player.x + (player.width / 2) - camera.x, player.y + (player.height / 2) - camera.y), radius = radius})
                    end
                end
            end
        end),
    },
    [smbseTransitions.transitionStates.STATE_FADE_IN] = {
        muteMusic = false,
        playSound = false,
        pause = false,
        timerUntilEnd = lunatime.toTicks(0.500),
        effect = (function()
            transitionEffectOpacity = 1 - math.min(1, transitionTimer / 32)
            Graphics.drawScreen{color = Color.black..transitionEffectOpacity, priority = 7.5}
        end),
    },
}

function smbseTransitions.onInitAPI()
    registerEvent(smbseTransitions, "onDraw")
end

-- Gets if we're in a transition
function smbseTransitions.inTransition()
    return inTransition
end

function smbseTransitions.currentTransitionID()
    return transitionState
end

local function transitionStartInternal(id, transitionTable)
    if transitionTable.startFunction ~= nil then
        transitionTable.startFunction()
    end
    if transitionTable.muteMusic then
        SMBSE.Functions.Sound.Music.Mute(0)
    end
    if transitionTable.playSound then
        if transitionTable.soundVolume ~= nil then
            SMBSE.Functions.Sound.SFX.Play(transitionTable.soundFile, transitionTable.soundVolume)
        else
            SMBSE.Functions.Sound.SFX.Play(transitionTable.soundFile)
        end
    end
    if transitionTable.pause then
        Misc.pause()
    end
    transitionState = id
end

function smbseTransitions.startTransition(id, customTransitionInfoTable)
    if transitionInfo[id] == nil then
        return
    end
    if customTransitionInfoTable == nil and id >= 1 then
        transitionStartInternal(id, transitionInfo[id])
    elseif customTransitionInfoTable ~= nil and id >= 1 then
        transitionStartInternal(id, customTransitionInfoTable)
    end
end

function smbseTransitions.onDraw()
    if smbseTransitions.enabled then
        if transitionState >= 1 then
            transitionTimer = transitionTimer + 1

            if transitionInfo[transitionState].effect ~= nil then
                transitionInfo[transitionState].effect()
            end

            if transitionTimer == 1 then
                inTransition = true
            end

            if transitionTimer >= transitionInfo[transitionState].timerUntilEnd then
                inTransition = false
                if transitionInfo[transitionState].muteMusic then
                    SMBSE.Functions.Sound.Music.Unmute(0)
                end
                Misc.unpause()
                transitionState = 0
            end
        else
            transitionTimer = 0
            transitionEffectTimer = 0
        end
    end
end

return smbseTransitions