local smbseFunctionsPlayer = {}

-- Powerup state ID lists
smbseFunctionsPlayer.ShootStates = table.map{3,6,7}
smbseFunctionsPlayer.LeafStates = table.map{4,5}

-- Priority drawing values
smbseFunctionsPlayer.DrawingPriority = {}
smbseFunctionsPlayer.DrawingPriority.Normal = {}
smbseFunctionsPlayer.DrawingPriority.Pipe = {}
smbseFunctionsPlayer.DrawingPriority.ClownCar = {}

smbseFunctionsPlayer.DrawingPriority.Custom = {}
smbseFunctionsPlayer.DrawingPriority.Custom.Player = {}
smbseFunctionsPlayer.DrawingPriority.Custom.Enabled = {}

for i = 1,200 do
    -- Normal values
    smbseFunctionsPlayer.DrawingPriority.Normal[i] = -25
    smbseFunctionsPlayer.DrawingPriority.Pipe[i] = -70
    smbseFunctionsPlayer.DrawingPriority.ClownCar[i] = -35

    -- Custom values (For other events), and a toggle for enabling custom priority for players
    smbseFunctionsPlayer.DrawingPriority.Custom.Player[i] = 0
    smbseFunctionsPlayer.DrawingPriority.Custom.Enabled[i] = false
end

-- Reserve dropping settings
smbseFunctionsPlayer.Reserve = {}

-- Reserve timer variables

-- Timer for keeping on top of the player before moving down to the player
smbseFunctionsPlayer.Reserve.TimerUntilMovingDownwards = lunatime.toTicks(2)
-- Timer for holding down "drop item" until the reserve is dropped to the player who held it
smbseFunctionsPlayer.Reserve.TimerUntilDropped = lunatime.toTicks(3)

-- ID variables for finding the player state
local defaultStateVariables = {
    PLAYER_STAND_NORMAL = 1,

    PLAYER_WALK_NORMAL = 2,

    PLAYER_JUMP_NORMAL = 3,
    PLAYER_FALL_NORMAL = 4,

    PLAYER_DUCK_NORMAL = 5,
    PLAYER_DUCK_HOLD = 6,

    PLAYER_STAND_HOLD = 7,
    PLAYER_WALK_HOLD = 8,

    PLAYER_STAND_FRONT_NORMAL = 9,
    PLAYER_STAND_BACK_NORMAL = 10,

    PLAYER_SPINJUMP_NORMAL = 11,

    PLAYER_GRABFROMTOP_NORMAL = 12,
    PLAYER_SLIDE_NORMAL = 13,
    PLAYER_CLIMB_NORMAL = 14,

    PLAYER_RIDE_NORMAL = 15,
    PLAYER_RIDE_DUCK = 16,

    PLAYER_SWIM_NORMAL = 17,
    PLAYER_SWIM_SWIMUP = 18,

    PLAYER_SHOOT_NORMAL = 19,

    PLAYER_TAIL_SWIPE = 20,
    PLAYER_FALL_SLOW = 21,

    PLAYER_PWING_RUN = 22,
    PLAYER_PWING_FLY = 23,

    PLAYER_TANOOKI_STATUE = 24,

    PLAYER_DIED = 25,

    PLAYER_WARP_UP = 26,
    PLAYER_WARP_DOWN = 27,
    PLAYER_WARP_LEFT = 28,
    PLAYER_WARP_RIGHT = 29,

    PLAYER_ENTER_DOOR = 30,
    PLAYER_SURFING_SHELL = 31,

    PLAYER_SHOOT_MIDAIR = 32,

    PLAYER_SKID_NORMAL = 33,

    PLAYER_STAND_NORMAL_LOOKUP = 34,
    PLAYER_STAND_HOLD_LOOKUP = 35,

    PLAYER_SHOOT_UNDERWATER = 36,

    PLAYER_RUN_NORMAL = 37,
    PLAYER_RUN_HOLD = 38,
}

-- All player state variables, separated by powerup state
smbseFunctionsPlayer.Animation.StateVariables = {
    [1] = defaultStateVariables,
    [2] = defaultStateVariables,
    [3] = defaultStateVariables,
    [4] = defaultStateVariables,
    [5] = defaultStateVariables,
    [6] = defaultStateVariables,
    [7] = defaultStateVariables,
}

-- Local table for reserve drop-related states
local reserveDroppedStates = {}
for i = 1,2 do
    reserveDroppedStates[i] = {}
end

-- Function tables
smbseFunctionsPlayer.State = {}
smbseFunctionsPlayer.SpeedCounters = {}
smbseFunctionsPlayer.Actions = {}
smbseFunctionsPlayer.Animation = {}

-- Detects if the player is on the ground, the redigit way. Sometimes more reliable than just p:isOnGround().
function smbseFunctionsPlayer.isOnGround(p)
    return (
        p.speedY == 0 -- "on a block"
        or p:mem(0x176, FIELD_WORD) ~= 0 -- on an NPC
        or p:mem(0x48, FIELD_WORD) ~= 0 -- on a slope
    )
end

function smbseFunctionsPlayer.State.Shooting(p)
    return (p:mem(0x118, FIELD_FLOAT) >= 100 and p:mem(0x118, FIELD_FLOAT) <= 118 and smbseFunctionsPlayer.ShootStates[p.powerup])
end

function smbseFunctionsPlayer.State.SlidingOnIce(p)
    return (p:mem(0x0A, FIELD_BOOL) and (not p.keys.left and not p.keys.right))
end

function smbseFunctionsPlayer.State.SlowFalling(p)
    return (smbseFunctionsPlayer.LeafStates[p.powerup] and p.speedY > 0 and (p.keys.jump or p.keys.altJump))
end

function smbseFunctionsPlayer.SpeedCounters.Walking(p)
    return math.max(0.35, math.abs(p.speedX) / Defines.player_walkspeed)
end

function smbseFunctionsPlayer.Priority(p)
    if smbseFunctionsPlayer.DrawingPriority.Custom.Enabled[p.idx] then
        return smbseFunctionsPlayer.DrawingPriority.Custom.Player[p.idx]
    else
        if p.forcedState == FORCEDSTATE_PIPE then
            return smbseFunctionsPlayer.DrawingPriority.Pipe[p.idx]
        elseif p.mount == MOUNT_CLOWNCAR then
            return smbseFunctionsPlayer.DrawingPriority.ClownCar[p.idx]
        else
            return smbseFunctionsPlayer.DrawingPriority.Normal[p.idx]
        end
    end
end

-- Drops a player's reserve item to the player.
function smbseFunctionsPlayer.Actions.DropReserve(p)
    if p.reservePowerup >= 1 and (p.idx == 1 or p.idx == 2) then
        -- Disable the player reserve drop
        p:mem(0x130, FIELD_BOOL, false)

        -- Play the reserve drop SFX
        SMBSE.Functions.Sound.SFX.Play(11)

        -- Spawn the reserve NPC
        local reserveNPC = NPC.spawn(p.reservePowerup, camera.x, camera.y, p.section, false, true)

        -- Set the reserve state variables for the state table
        reserveDroppedStates[p.idx].reserveNPC = reserveNPC
        reserveDroppedStates[p.idx].airTimer = 0
        reserveDroppedStates[p.idx].dropMovement = 60
        reserveDroppedStates[p.idx].active = true

        -- Set the reserve NPC to the reserve state
        reserveNPC:mem(0x138, FIELD_WORD, 2)

        -- Finally, set the player's reserve to 0
        p.reservePowerup = 0
    end
end

-- The animation state that is used for a specified player.
function smbseFunctionsPlayer.Animation.State(p)
    -- What P-Speed values gets used is dependent on if the player has a leaf powerup
    local atPSpeed = (p.holdingNPC == nil)

    if atPSpeed then
        if smbseFunctionsPlayer.LeafStates[p.powerup] then
            atPSpeed = p:mem(0x16C,FIELD_BOOL) or p:mem(0x16E,FIELD_BOOL)
        else
            atPSpeed = (smbseFunctionsPlayer.SpeedCounters.Walking(p) >= 2)
        end
    end

    -- GROUND MOVEMENTS
    if smbseFunctionsPlayer.isOnGround(p) then
        -- Standing
        if p.speedX == 0 and p.speedY == 0 then
            if p.holdingNPC ~= nil then
                return smbseFunctionsPlayer.Animation.StateVariables[p.powerup].PLAYER_STAND_HOLD
            else
                return smbseFunctionsPlayer.Animation.StateVariables[p.powerup].PLAYER_STAND_NORMAL
            end
        end

        -- Shooting
        if smbseFunctionsPlayer.State.Shooting(p) then
            return smbseFunctionsPlayer.Animation.StateVariables[p.powerup].PLAYER_SHOOT_NORMAL
        end

        -- Skidding
        if (p.speedX < 0 and p.keys.right) or (p.speedX > 0 and p.keys.left) or p:mem(0x136,FIELD_BOOL) then
            return smbseFunctionsPlayer.Animation.StateVariables[p.powerup].PLAYER_SKID_NORMAL
        end

        -- Walking
        if p.speedX ~= 0 and not smbseFunctionsPlayer.State.SlidingOnIce(p) then
            local animationName

            if smbseFunctionsPlayer.SpeedCounters.Walking(p) >= 2 then
                animationName = smbseFunctionsPlayer.Animation.StateVariables[p.powerup].PLAYER_RUN_NORMAL
            else
                animationName = smbseFunctionsPlayer.Animation.StateVariables[p.powerup].PLAYER_WALK_NORMAL

                if p.holdingNPC ~= nil then
                    animationName = smbseFunctionsPlayer.Animation.StateVariables[p.powerup].PLAYER_WALK_HOLD
                end
            end

            return animationName
        end

        -- Looking up
        if p.keys.up then
            if p.holdingNPC == nil then
                return smbseFunctionsPlayer.Animation.StateVariables[p.powerup].PLAYER_STAND_NORMAL_LOOKUP
            else
                return smbseFunctionsPlayer.Animation.StateVariables[p.powerup].PLAYER_STAND_HOLD_LOOKUP
            end
        end

        return nil

    -- SWIMMING MOVEMENTS
    elseif (p:mem(0x34,FIELD_WORD) > 0 and p:mem(0x06,FIELD_WORD) == 0) and p.holdingNPC == nil then
        -- Shooting (Underwater)
        if smbseFunctionsPlayer.State.Shooting(p) then
            return smbseFunctionsPlayer.Animation.StateVariables[p.powerup].PLAYER_SHOOT_UNDERWATER
        end

        if p:mem(0x38,FIELD_WORD) == 15 then
            return smbseFunctionsPlayer.Animation.StateVariables[p.powerup].PLAYER_SWIM_SWIMUP
        end

        return smbseFunctionsPlayer.Animation.StateVariables[p.powerup].PLAYER_SWIM_NORMAL
    -- AIR MOVEMENTS
    else
        -- Shooting (Midair)
        if smbseFunctionsPlayer.State.Shooting(p) then
            return smbseFunctionsPlayer.Animation.StateVariables[p.powerup].PLAYER_SHOOT_MIDAIR
        end

        -- P-Wing (Leaf Flying)
        if p:mem(0x16E,FIELD_BOOL) then
            return smbseFunctionsPlayer.Animation.StateVariables[p.powerup].PLAYER_PWING_FLY
        end

        -- Jumping
        if atPSpeed then
            if smbseFunctionsPlayer.State.SlowFalling(p) then
                return smbseFunctionsPlayer.Animation.StateVariables[p.powerup].PLAYER_FALL_SLOW
            elseif smbseFunctionsPlayer.LeafStates[p.powerup] and p.speedY > 0 then
                return smbseFunctionsPlayer.Animation.StateVariables[p.powerup].PLAYER_PWING_FLY
            elseif smbseFunctionsPlayer.SpeedCounters.Walking(p) >= 2 then
                return smbseFunctionsPlayer.Animation.StateVariables[p.powerup].PLAYER_PWING_FLY
            elseif p.speedY > 0 then
                return smbseFunctionsPlayer.Animation.StateVariables[p.powerup].PLAYER_FALL_NORMAL
            else
                return smbseFunctionsPlayer.Animation.StateVariables[p.powerup].PLAYER_JUMP_NORMAL
            end
        end
    end

    return nil
end

function smbseFunctionsPlayer.onInitAPI()
    registerEvent(smbseFunctionsPlayer, "onTick")
end

-- Reserve drop state-related stuff
function smbseFunctionsPlayer.onTick()
    for i = 1,2 do
        if reserveDroppedStates[i].active then
            -- Make sure the NPC is valid
            reserveDroppedStates[i].airTimer = reserveDroppedStates[i].airTimer + 1

            if reserveDroppedStates[i].airTimer < smbseFunctionsPlayer.Reserve.TimerUntilMovingDownwards and (reserveDroppedStates[i].reserveNPC and reserveDroppedStates[i].reserveNPC.isValid) then
                reserveDroppedStates[i].reserveNPC.x = Player(i).x
                reserveDroppedStates[i].reserveNPC.y = Player(i).y - 60
            end

            if reserveDroppedStates[i].airTimer >= smbseFunctionsPlayer.Reserve.TimerUntilMovingDownwards and (reserveDroppedStates[i].reserveNPC and reserveDroppedStates[i].reserveNPC.isValid) then
                if reserveDroppedStates[i].dropMovement > 0 then
                    reserveDroppedStates[i].dropMovement = reserveDroppedStates[i].dropMovement - 2
                end
                reserveDroppedStates[i].reserveNPC.x = Player(i).x
                reserveDroppedStates[i].reserveNPC.y = Player(i).y - reserveDroppedStates[i].dropMovement
            end

            -- If the reserve NPC is gone, the state is finished, so clear off the other values
            if reserveDroppedStates[i].reserveNPC == nil then
                reserveDroppedStates[i].airTimer = nil
                reserveDroppedStates[i].dropMovement = nil
                reserveDroppedStates[i].active = nil
            end
        end
    end
end

return smbseFunctionsPlayer