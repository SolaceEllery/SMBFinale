local smbseFollowerSystem = {}

local playerManager = require("playerManager")

function smbseFollowerSystem.onInitAPI()
    registerEvent(smbseFollowerSystem,"onDraw")
end

smbseFollowerSystem.Enabled = true --True if we should draw Spencer or not
smbseFollowerSystem.Sprites = Graphics.loadImageResolved("scripts/_smbseScripts/smbseFollowerSystem/followerSprites.png")
smbseFollowerSystem.Dimensions = {
    width = 16,
    height = 32,
    totalFrames = 32,
}
smbseFollowerSystem.Frame = 1
smbseFollowerSystem.FrameSpeed = 8
smbseFollowerSystem.Animations = {
    standing = {1},
    walking = {1,2,3,2},
    jumping = {4},
    falling = {5},
    skidding = {6},
    ducking = {7},
    spinJump = {1,8,32,9},
    slide = {10},
    climb = {11,12},
    grabbing = {13,14},
    holding = {15},
    holdWalking = {15,16,17,16},
    yoshiRide = {18},
    idleSwim = {19,20,21,20},
    swimming = {20,22,23,22},
    yoshiRideDuck = {24},
    fireball = {25,26,25},
    running = {27,28,29,28},
    runJump = {30},
    flagpole = {31},
    front = {8},
    back = {9},
}

-- Will be nil until the 2nd player is active
smbseFollowerSystem.ChosenPlayer = nil

function smbseFollowerSystem.NoMovementPlayerDetection()
    return (player:mem(0x50,FIELD_BOOL)
        and player.forcedState == FORCEDSTATE_PIPE
    )
end

local followerAnimationStates = table.map{
    smbseFollowerSystem.Animations.standing,

    smbseFollowerSystem.Animations.walking,

    smbseFollowerSystem.Animations.jumping,
    smbseFollowerSystem.Animations.falling,

    smbseFollowerSystem.Animations.ducking,
    smbseFollowerSystem.Animations.ducking,

    smbseFollowerSystem.Animations.standing,
    smbseFollowerSystem.Animations.walking,

    smbseFollowerSystem.Animations.front,
    smbseFollowerSystem.Animations.back,

    smbseFollowerSystem.Animations.spinJump,

    smbseFollowerSystem.Animations.grabbing,
    smbseFollowerSystem.Animations.slide,
    smbseFollowerSystem.Animations.climb,

    smbseFollowerSystem.Animations.yoshiRide,
    smbseFollowerSystem.Animations.yoshiRideDuck,

    smbseFollowerSystem.Animations.idleSwim,
    smbseFollowerSystem.Animations.swimming,

    smbseFollowerSystem.Animations.fireball,

    smbseFollowerSystem.Animations.spinJump,
    smbseFollowerSystem.Animations.spinJump,

    smbseFollowerSystem.Animations.running,
    smbseFollowerSystem.Animations.runJump,

    smbseFollowerSystem.Animations.front,

    smbseFollowerSystem.Animations.ducking,

    smbseFollowerSystem.Animations.front,
    smbseFollowerSystem.Animations.back,
    smbseFollowerSystem.Animations.walking,
    smbseFollowerSystem.Animations.walking,

    smbseFollowerSystem.Animations.back,
    smbseFollowerSystem.Animations.yoshiRideDuck,

    smbseFollowerSystem.Animations.swimming,

    smbseFollowerSystem.Animations.skidding,

    smbseFollowerSystem.Animations.standing,
    smbseFollowerSystem.Animations.standing,

    smbseFollowerSystem.Animations.swimming,

    smbseFollowerSystem.Animations.running,
    smbseFollowerSystem.Animations.running,
}

function smbseFollowerSystem.getAnimation()
    if SMBSE.Functions.Player.Animation.State(player) ~= nil and SMBSE.Functions.Player.Animation.State(player) >= 1 then
        return followerAnimationStates[SMBSE.Functions.Player.Animation.State(player)]
    else
        return smbseFollowerSystem.Animations.standing
    end
end

smbseFollowerSystem.animateFramed = 1
local animationTable = {}
smbseFollowerSystem.playerYActualWidth = 0
smbseFollowerSystem.playerXActualWidth = 0
smbseFollowerSystem.spencerCoordinateX = 0
smbseFollowerSystem.spencerDistance = 35

function smbseFollowerSystem.onDraw()
    if SMBSE.Functions.Tables.mapped.levels.allLevels[Level.filename()] and smbseFollowerSystem.Enabled then
        -- Make sure player2 is always chosen
        if Player.count() >= 2 then
            smbseFollowerSystem.ChosenPlayer = player2
        else
            smbseFollowerSystem.ChosenPlayer = nil
        end

        -- Get the animation table for animating the follower
        animationTable = smbseFollowerSystem.getAnimation()

        if animationTable ~= nil and smbseFollowerSystem.ChosenPlayer ~= nil then
            smbseFollowerSystem.animateFramed = math.floor((lunatime.tick() / smbseFollowerSystem.FrameSpeed) % #smbseFollowerSystem.getAnimation()) + 1
            
            smbseFollowerSystem.playerYActualWidth = (smbseFollowerSystem.ChosenPlayer.screen.bottom + camera.y) - smbseFollowerSystem.Dimensions.height
            
            smbseFollowerSystem.playerXActualWidth = smbseFollowerSystem.ChosenPlayer.x + (smbseFollowerSystem.ChosenPlayer.width / 2) - smbseFollowerSystem.spencerCoordinateX
            
            if not smbseFollowerSystem.NoMovementPlayerDetection() then
                if smbseFollowerSystem.ChosenPlayer.direction == 1 then
                    if smbseFollowerSystem.ChosenPlayer.x - smbseFollowerSystem.spencerCoordinateX > smbseFollowerSystem.ChosenPlayer.x - smbseFollowerSystem.spencerDistance then
                        smbseFollowerSystem.spencerCoordinateX = smbseFollowerSystem.spencerCoordinateX + 2
                    end
                else
                    if smbseFollowerSystem.ChosenPlayer.x - smbseFollowerSystem.spencerCoordinateX < smbseFollowerSystem.ChosenPlayer.x + smbseFollowerSystem.spencerDistance then
                        smbseFollowerSystem.spencerCoordinateX = smbseFollowerSystem.spencerCoordinateX - 2
                    end
                end
            end
            if smbseFollowerSystem.ChosenPlayer.forcedState == FORCEDSTATE_PIPE then
                local warp = Warp(player:mem(0x15E,FIELD_WORD) - 1)
                local direction
                if smbseFollowerSystem.ChosenPlayer.forcedTimer == 0 then
                    direction = warp.entranceDirection
                else
                    direction = warp.exitDirection
                end
                if direction == 1 or direction == 3 then
                    smbseFollowerSystem.spencerCoordinateX = 0
                end
            end

            Graphics.drawBox{
                texture      = smbseFollowerSystem.Sprites,
                sceneCoords  = true,
                x            = smbseFollowerSystem.playerXActualWidth,
                y            = smbseFollowerSystem.playerYActualWidth,
                width        = smbseFollowerSystem.Dimensions.width * smbseFollowerSystem.ChosenPlayer.direction * 2,
                height       = smbseFollowerSystem.Dimensions.height * 2,
                sourceX      = 0,
                sourceY      = smbseFollowerSystem.Dimensions.height * smbseFollowerSystem.getAnimation()[smbseFollowerSystem.animateFramed] - smbseFollowerSystem.Dimensions.height,
                sourceWidth  = smbseFollowerSystem.Dimensions.width,
                sourceHeight = smbseFollowerSystem.Dimensions.height,
                centered     = true,
                priority     = SMBSE.Functions.Player.Priority(smbseFollowerSystem.ChosenPlayer),
            }
        end
    end
end

return smbseFollowerSystem