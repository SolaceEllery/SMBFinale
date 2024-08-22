--[[
    extraSounds.lua
    Created by Spencer Everly (v0.5.0)

    To use this everywhere, you can simply put this under luna.lua:
        _G.extraSounds = require("extraSounds")

    And to replace vanilla SFX slots that are taken by extraSounds, require this library from above, then replace the sound slot IDs 1,4,7,8,10,14,15,18,33,39,42,43,59 to any sound you want to change it to.
    
    Example:

    Using the internal "Audio" LunaLua library: 
        Audio.sounds[14].sfx = Audio.SfxOpen(Misc.resolveSoundFile("costumes/(character)/(costume)/coin.ogg"))
    Using extraSounds for IDs that were overhauled:
        extraSounds.sounds[14].sfx = Audio.SfxOpen(Misc.resolveSoundFile("costumes/(character)/(costume)/coin.ogg"))

    For settings/options and tweaks, scroll down below.
]]

local extraSounds = {}

--Below are variables for categorizing settings and other values that will be used below.
extraSounds.settings = extraSounds.settings or {}

extraSounds.options = extraSounds.options or {}
extraSounds.options.delay = extraSounds.options.delay or {}
extraSounds.options.toggle = extraSounds.options.toggle or {}
extraSounds.options.classicToggle = extraSounds.options.classicToggle or {}

--------------------------------------------

-- [-------------]
-- |MAIN SETTINGS|
-- [-------------]

-- [-- MANDATORY SETTINGS --]

-- (TOGGLES)

--Is extraSounds enabled? If true (Default setting), the library goes ahead and executes the code for this liobrary. If false, the library will not execute most of its code, and will revert to the stock sound system. Toggling this variable within a Lua event or vanilla event (With onEvent) is supported since the library checks the variable before reenabling the vanilla sounds and vice-versa
extraSounds.settings.enabled = true

-- (DEFAULT SOUND PLAY SETTINGS)

--What is the default volume count that extraSounds should use? playSound will automatically play in this specified count if nothing is specified.
extraSounds.settings.defaultVolumeCount = 1
--What is the default loop count that extraSounds should use? playSound will automatically play in this specified count if nothing is specified.
extraSounds.settings.defaultLoopCount = 1
--What is the default delay count (In ticks) that extraSounds should use? playSound will automatically play in this specified count if nothing is specified.
extraSounds.settings.defaultDelayCount = 4

-- [--------------]
-- |DELAY SETTINGS|
-- [--------------]

-- [-- P-SWITCH/STOPWATCH DELAY SETTINGS --]

--Set this to any number to change how much the P-Switch/Stopwatch Timer should delay to. Default is 50.
extraSounds.options.delay.pSwitchAndStopwatchTimer = 50
--Set this to any number to change how much the P-Switch/Stopwatch Timer should delay to when the timer has almost run out. Default is 15.
extraSounds.options.delay.pSwitchAndStopwatchHurryTimer = 15

-- [-- PLAYER-RELATED DELAY SETTINGS --]

--Set this to any number to change how much the player sliding should delay to. Default is 8.
extraSounds.options.delay.playerSkid = 8
--Set this to any number to change how much the P-Wing sound should delay to. Default is 7.
extraSounds.options.delay.pWing = 7

-- [-- ENEMY-RELATED DELAY SETTINGS --]

--Set this to any number to change how much the boomerang sound should delay to. Default is 12.
extraSounds.options.delay.boomerang = 12

-- [-- BLOCK-RELATED DELAY SETTINGS --]

--Set this to any number to change how much the brick breaking sound should delay to. Default is 4.
extraSounds.options.delay.brickBreak = 4

-- [-----------------------]
-- |VANILLA TOGGLE SETTINGS|
-- [-----------------------]

-- [-- FLOWER/SUIT SHOOTING SETTINGS --]

--Whether to revert to the fireball sound when using an ice flower and throwing an iceball instead of the new sound.
extraSounds.options.classicToggle.revertIceballSFXs = false
--Whether to revert to the fireball sound when using a hammer suit and throwing a hammer instead of the new sound.
extraSounds.options.classicToggle.revertHammerThrowSFXs = false

-- [-- JUMPING SETTINGS --]

--Whether to use the original jump sound instead of the separate new sounds.
extraSounds.options.classicToggle.revertSeparateJumpSFXs = false
--Whether to use the jump sound instead of the new sound.
extraSounds.options.classicToggle.revertDoubleJumpSFXs = false
--Whether to use the jump sound when unmounting a Yoshi instead of the new sound.
extraSounds.options.classicToggle.revertYoshiUnmountSFXs = false

-- [-- 1UP SETTINGS --]

--Whether to use the original 1UP sound instead of the new sounds.
extraSounds.options.classicToggle.revert1UPSeparateSFXs = false

-- [-- EXPLOSION SETTINGS --]

--Whether to use the original explosion sound instead of the new sounds.
extraSounds.options.classicToggle.revertFireworkSFXs = false

-- [-- BLOCK SETTINGS --]

--Whether to use the original sprout sound instead of the new sound.
extraSounds.options.classicToggle.revertVineBlockSproutSFXs = false

-- [-- NPC SETTINGS --]

--Whether to use the original NPC fireball sound instead of the new sound.
extraSounds.options.classicToggle.revertBowserFireballSFXs = false
--Whether to use the original spinjumping SFX for big enemies instead of the new sounds.
extraSounds.options.classicToggle.revertBigEnemySpinjumpSmashSFXs = false

-- [-- COIN SETTINGS --]

--Whether to use the original dragon coin sounds instead of the new sounds.
extraSounds.options.classicToggle.revertDragonCoinSFXs = false
--Whether to use the original cherry SFXs instead of the new sound.
extraSounds.options.classicToggle.revertCherrySFXs = false

-- [----------------------------]
-- |SOUND EFFECT TOGGLE SETTINGS|
-- [----------------------------]

-- [-- FIRE/ICE/HAMMER SETTINGS --]

-- (SHOOTING)

--Whether to enable the Fire Flower shooting sound.
extraSounds.options.toggle.fireFlowerShootSFX = true
--Whether to enable the Ice Flower shooting sound.
extraSounds.options.toggle.iceFlowerShootSFX = true
--Whether to enable the Hammer Suit shooting sound.
extraSounds.options.toggle.hammerSuitShootSFX = true

-- (BLOCK HITING)

--Whether to enable fireball block sound hitting.
extraSounds.options.toggle.fireballBlockHitSFX = false

-- [-- PROJECTILE SETTINGS --]

--Whether to enable the boomerang SFX for Toad.
extraSounds.options.toggle.toadBoomerangSFX = true
--Whether to enable the boomerang SFX for the Boomerang Bros.
extraSounds.options.toggle.boomerangBroBoomerangSFX = true

-- [-- PLAYER SETTINGS --]

-- (JUMPING)

--Whether to enable the jumping SFX used by players.
extraSounds.options.toggle.jumpingSFX = true
--Whether to enable the double jumping SFX used by players (Usually played when Raccoon/Tanooki Toad jumps twice, or when any other double jump happens).
extraSounds.options.toggle.doubleJumpSFX = true
--Whether to enable the spinjumping SFX used by players.
extraSounds.options.toggle.spinJumpSFX = true

-- (ATTACKING)

--Whether to enable the tail attack SFX used by players.
extraSounds.options.toggle.tailAttackSFX = true

-- (LINK ATTACKS)

--Whether to enable the Link slashing used by Link characters.
extraSounds.options.toggle.linkSlashSFX = true

-- (LINK SHOOTING SLASHES)

--Whether to enable the Link fireball slashing used by Link characters.
extraSounds.options.toggle.linkSlashFireballSFX = true
--Whether to enable the Link iceball slashing used by Link characters.
extraSounds.options.toggle.linkSlashIceballSFX = true

-- (MOVEMENT)

--Whether to enable the skidding SFX used by players.
extraSounds.options.toggle.skiddingSFX = true
--Whether to enable the Yoshi unmount SFX used by players.
extraSounds.options.toggle.yoshiUnmountSFX = true
--Whether to enable the P-Wing SFX.
extraSounds.options.toggle.pWingSFX = true

-- (PLAYER EVENTS)

--Whether to enable the shell grabbing SFX.
extraSounds.options.toggle.shellGrabSFX = true
--Whether to enable the HP get SFXs.
extraSounds.options.toggle.HPCollectSFX = true
--Whether to enable the death sound used by players.
extraSounds.options.toggle.playerDeadSFX = true

-- (OTHER TOGGLES)

--Whether to enable the sound that plays when a fireball hits the top of a player's hammer suit shell when ducked.
extraSounds.options.toggle.hammerSuitFireShieldHitSFX = true


-- [-- EXPLOSION SETTINGS --]

--Whether to enable the fireworks SFX.
extraSounds.options.toggle.fireworkSFX = true
--Whether to enable the SMB2 explosion SFX.
extraSounds.options.toggle.SMB2ExplosionSFX = true

-- [-- BLOCK SETTINGS --]

-- (EVENTS)

--Whether to enable all normal brick smashing SFXs.
extraSounds.options.toggle.brickSmashSFX = true
--Whether to enable coin SFXs when hitting brick blocks from the bottom if you're small (State 1).
extraSounds.options.toggle.smallPlayerBottomBrickHitCoinCollectSFX = true

-- [-- NPC SETTINGS --]

-- (ICE BLOCK NPCs)

--Whether to enable the ice melting sound used for throw blocks.
extraSounds.options.toggle.iceBlockMeltSFX = true
--Whether to enable the ice block freezing sound.
extraSounds.options.toggle.iceBlockFreezingSFX = true
--Whether to enable the ice block breaking sound.
extraSounds.options.toggle.iceBlockBreakSFX = true

-- (SMB2 ENEMY NPCs)

--Whether to enable the SMB2 enemy kill sounds.
extraSounds.options.toggle.SMB2EnemyKillSFXs = true

-- (NORMAL NPCs)

--Whether to enable the enemy stomping SFX.
extraSounds.options.toggle.enemyStompSFX = true
--Whether to enable Venus Fire Trap fireballs.
extraSounds.options.toggle.venusFireTrapShootSFX = true
--Whether to enable star collecting sounds.
extraSounds.options.toggle.starCollectSFX = true

-- [-- COIN SETTINGS --]

-- (COLLECTING)

--Whether to enable the coin collecting SFX.
extraSounds.options.toggle.coinCollectSFX = true
--Whether to enable the cherry collecting SFX.
extraSounds.options.toggle.cherryCollectSFX = true
--Whether to enable the rupee collecting SFX.
extraSounds.options.toggle.rupeeCollectSFX = true

-- (EVENTS)

--Whether to enable the NPC to Coin SFX.
extraSounds.options.toggle.NPCtoCoinSFX = true

-- [-- P-SWITCH/STOPWATCH SETTINGS --]

-- (TIMERS)

--Whether to play the P-Switch/Stopwatch timer when a P-Switch/Stopwatch is active.
extraSounds.options.toggle.pSwitchTimerSFX = true
--Whether to use the time out sound for the P-Switch/Stopwatch or not.
extraSounds.options.toggle.pSwitchAndStopwatchTimeOutSFX = true

--------------------------------------------

local smbseScriptDir = "___Scripts/"
local smbseGlobals = require(smbseScriptDir.."smbseGlobals")

if SMBSE.Functions == nil then
    SMBSE.Functions = require("scripts/smbseFunctions")
end

local blockManager = require("blockManager") --Used to detect brick breaks when spinjumping
local inspect = require("ext/inspect")
local rng = require("base/rng")
local bettereffects = require("base/game/bettereffects")

local npcToCoinTimer = 0 --This is used for the NPC to Coin sound.

local holdingTimer = {} --Player shell holding timers for all players
for i = 1,200 do
    holdingTimer[i] = 0
end

local comboMuteTimer = 0 --Combo sound mute timer, usually used for playing shell hit combo SFXs

local harmableComboTypes = {
    HARM_TYPE_JUMP,
    HARM_TYPE_NPC,
    HARM_TYPE_PROJECTILE_USED,
    HARM_TYPE_TAIL,
    HARM_TYPE_HELD,
}

extraSounds.sounds = {}

local disableSoundMarker = false

for k,v in ipairs(SMBSE.Functions.Tables.regular.sounds.soundFileList) do
    if not SMBSE.Functions.Tables.mapped.sounds.unusedVanillaSoundIDs[k] then --Will decrease sound RAM since we're only using what's replaceable via extraSounds
        extraSounds.sounds[k] = {}
        extraSounds.sounds[k].sfx = Audio.SfxOpen(Misc.resolveSoundFile(v)) --Sound effect file
        extraSounds.sounds[k].muted = false --SFX muting, will replace the variables that mute SFX
    end
end

--Non-Changable Sounds (Specific to SMAS++, which doesn't necessarily use any character utilizing to use these sounds)
extraSounds.sounds[1000] = {}
extraSounds.sounds[1000].sfx = Audio.SfxOpen(Misc.resolveSoundFile("menu/dialog.ogg")) --Dialog Menu Picker
extraSounds.sounds[1000].muted = false
extraSounds.sounds[1001] = {}
extraSounds.sounds[1001].sfx = Audio.SfxOpen(Misc.resolveSoundFile("menu/dialog-confirm.ogg")) --Dialog Menu Choosing Confirmed
extraSounds.sounds[1001].muted = false

local normalCharacters = {
    [CHARACTER_MARIO] = true,
    [CHARACTER_LUIGI] = true,
    [CHARACTER_PEACH] = true,
    [CHARACTER_TOAD] = true,
    [CHARACTER_MEGAMAN] = true,
    [CHARACTER_WARIO] = true,
    [CHARACTER_BOWSER] = true,
    [CHARACTER_KLONOA] = true,
    [CHARACTER_NINJABOMBERMAN] = true,
    [CHARACTER_ROSALINA] = true,
    [CHARACTER_ZELDA] = true,
    [CHARACTER_ULTIMATERINKA] = true,
    [CHARACTER_UNCLEBROADSWORD] = true,
    [CHARACTER_SAMUS] = true
}

local normalCharactersToad = {
    [CHARACTER_PEACH] = true,
    [CHARACTER_TOAD] = true,
    [CHARACTER_MEGAMAN] = true,
    [CHARACTER_KLONOA] = true,
    [CHARACTER_NINJABOMBERMAN] = true,
    [CHARACTER_ROSALINA] = true,
    [CHARACTER_ULTIMATERINKA] = true,
}

local normalCharactersWithoutMegaman = {
    [CHARACTER_MARIO] = true,
    [CHARACTER_LUIGI] = true,
    [CHARACTER_PEACH] = true,
    [CHARACTER_TOAD] = true,
    [CHARACTER_WARIO] = true,
    [CHARACTER_BOWSER] = true,
    [CHARACTER_KLONOA] = true,
    [CHARACTER_NINJABOMBERMAN] = true,
    [CHARACTER_ROSALINA] = true,
    [CHARACTER_ZELDA] = true,
    [CHARACTER_ULTIMATERINKA] = true,
    [CHARACTER_UNCLEBROADSWORD] = true,
    [CHARACTER_SAMUS] = true
}

local linkCharacters = {
    [CHARACTER_LINK] = true,
    [CHARACTER_SNAKE] = true,
}

extraSounds.allVanillaSoundNumbersInOrder = table.map{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91}

extraSounds.allCoinNPCIDsTableMapped = table.map{10,33,88,103,138,152,251,252,253,258,411,528} --378 is a dash coin. Perhaps we should make it compatible with it soon...?
extraSounds.allRupeeNPCIDsTableMapped = table.map{251,252,253}
extraSounds.allBrickBlockIDsTableMapped = table.map{4,60,188,226,293,526}
extraSounds.allBrickBlockIDs = {4,60,188,226,293,526}

local extrasoundsBlock90 = {}
local extrasoundsBlock668 = {}

function extraSounds.onInitAPI()
    registerEvent(extraSounds, "onDraw")
    registerEvent(extraSounds, "onDrawEnd")
    registerEvent(extraSounds, "onTick")
    registerEvent(extraSounds, "onInputUpdate")
    registerEvent(extraSounds, "onPostNPCKill")
    registerEvent(extraSounds, "onNPCKill")
    registerEvent(extraSounds, "onPostNPCHarm")
    registerEvent(extraSounds, "onPostPlayerKill")
    registerEvent(extraSounds, "onPostBlockHit")
    registerEvent(extraSounds, "onEvent")

    -- Beta 5 support, let's gooooooo
    registerEvent(extraSounds, "onPostNPCCollect")
    
    blockManager.registerEvent(90, extrasoundsBlock90, "onCollideBlock")
    blockManager.registerEvent(668, extrasoundsBlock668, "onCollideBlock")
    
    local Routine = require("routine")
    
    --[[if SMBX_VERSION == VER_SEE_MOD then
        registerEvent(extraSounds, "onSFXStart")
    end]]
end

local function harmNPC(npc,...) -- npc:harm but it returns if it actually did anything
    local oldKilled     = npc:mem(0x122,FIELD_WORD)
    local oldProjectile = npc:mem(0x136,FIELD_BOOL)
    local oldHitCount   = npc:mem(0x148,FIELD_FLOAT)
    local oldImmune     = npc:mem(0x156,FIELD_WORD)
    local oldID         = npc.id
    local oldSpeedX     = npc.speedX
    local oldSpeedY     = npc.speedY

    npc:harm(...)

    return (
           oldKilled     ~= npc:mem(0x122,FIELD_WORD)
        or oldProjectile ~= npc:mem(0x136,FIELD_BOOL)
        or oldHitCount   ~= npc:mem(0x148,FIELD_FLOAT)
        or oldImmune     ~= npc:mem(0x156,FIELD_WORD)
        or oldID         ~= npc.id
        or oldSpeedX     ~= npc.speedX
        or oldSpeedY     ~= npc.speedY
    )
end

local function isShooting(p)
    return (p:mem(0x160, FIELD_WORD) == 0
        and Level.endState() == 0
        and (
            not GameData.winStateActive
            or GameData.winStateActive == nil
        )
        and p.deathTimer == 0
        and p.forcedState == 0
        and p.holdingNPC == nil
        and not p.climbing
        and not p.keys.down
        and (
            p.mount == MOUNT_NONE
            or p.mount == MOUNT_BOOT
        )
        and not p:mem(0x50, FIELD_BOOL)
        and p.keys.run == KEYS_PRESSED or p.keys.altRun == KEYS_PRESSED
        and p:mem(0x172, FIELD_BOOL)
    )
end

local function isShootingLink(p)
    return (p:mem(0x160, FIELD_WORD) == 0
        and p:mem(0x162, FIELD_WORD) == 0
        and Level.endState() == 0
        and (
            not GameData.winStateActive
            or GameData.winStateActive == nil
        )
        and p.deathTimer == 0
        and p.forcedState == 0
        and p.holdingNPC == nil
        and not p.climbing
        and (
            p.mount == MOUNT_NONE
            or p.mount == MOUNT_BOOT
        )
        and p.keys.run == KEYS_PRESSED or p.keys.altRun == KEYS_PRESSED
        and p:mem(0x172, FIELD_BOOL)
    )
end

local function isTailSwiping(p)
    return (p.keys.run == KEYS_PRESSED
        and p:mem(0x172, FIELD_BOOL)
        and Level.endState() == 0
        and (
            not GameData.winStateActive
            or GameData.winStateActive == nil
        )
        and p.forcedState == FORCEDSTATE_NONE
        and not p.climbing
        and p.mount == 0
        and not p.keys.down
        and not p:mem(0x50, FIELD_BOOL)
        and p:mem(0x172, FIELD_BOOL)
        and p.deathTimer == 0
    )
end

local function isPlayerUnderwater(p) --Returns true if the specified player is underwater.
    return (
        p:mem(0x34,FIELD_WORD) > 0
        and p:mem(0x06,FIELD_WORD) == 0
    )
end

local function isInQuicksand(p) --Returns true if the specified player is in quicksand.
    return (
        p:mem(0x34, FIELD_WORD) == 2
        and p:mem(0x06, FIELD_WORD) > 0
    )
end

local function hasJumped(p, ahippinandahoppinactive)
    if ahippinandahoppinactive == nil then
        ahippinandahoppinactive = false
    end
    if not ahippinandahoppinactive then
        return (p.deathTimer == 0
            and Level.endState() == 0
            and (
                not GameData.winStateActive
                or GameData.winStateActive == nil
            )
            and p.forcedState == 0
            and not isPlayerUnderwater(p)
            and (
                p:isOnGround()
                or p:isClimbing()
                or isInQuicksand(p)
            )
            and (
                p:mem(0x11E, FIELD_BOOL)
                and p.keys.jump == KEYS_PRESSED
            )
        )
    elseif ahippinandahoppinactive then
        return (p.deathTimer == 0
            and Level.endState() == 0
            and (
                not GameData.winStateActive
                or GameData.winStateActive == nil
            )
            and p.forcedState == 0
            and not isPlayerUnderwater(p)
            and (
                p:mem(0x11E, FIELD_BOOL)
                and p.keys.jump == KEYS_PRESSED
            )
        )
    end
end

local function isOnScreen(npc)
    -- Get camera boundaries
    local left = camera.x;
    local right = left + camera.width;
    local top = camera.y;
    local bottom = top + camera.height;
    -- Check if offscreen
    if npc.x + npc.width < left or npc.x > right then
        return false
    elseif npc.y + npc.height < top or npc.y > bottom then
        return false
    else
        return true
    end
end

local leafPowerups = table.map{PLAYER_LEAF,PLAYER_TANOOKI}
local shootingPowerups = table.map{PLAYER_FIREFLOWER,PLAYER_ICE,PLAYER_HAMMER}

local starmans = table.map{293,559,994,996}
local coins = table.map{10,33,88,103,138,258,411,528}
local oneups = table.map{90,186,187}
local threeups = table.map{188}
local items = table.map{9,184,185,249,14,182,183,34,169,170,277,264,996,994}
local healitems = table.map{9,184,185,249,14,182,183,34,169,170,277,264}
local allenemies = table.map{1,2,3,4,5,6,7,8,12,15,17,18,19,20,23,24,25,27,28,29,36,37,38,39,42,43,44,47,48,51,52,53,54,55,59,61,63,65,71,72,73,74,76,77,89,93,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,135,137,161,162,163,164,165,166,167,168,172,173,174,175,176,177,180,189,199,200,201,203,204,205,206,207,209,210,229,230,231,232,233,234,235,236,242,243,244,245,247,261,262,267,268,270,271,272,275,280,281,284,285,286,294,295,296,298,299,301,302,303,304,305,307,309,311,312,313,314,315,316,317,318,321,323,324,333,345,346,347,350,351,352,357,360,365,368,369,371,372,373,374,375,377,379,380,382,383,386,388,389,392,393,395,401,406,407,408,409,413,415,431,437,446,447,448,449,459,460,461,463,464,466,467,469,470,471,472,485,486,487,490,491,492,493,509,510,512,513,514,515,516,517,418,519,520,521,522,523,524,529,530,539,562,563,564,572,578,579,580,586,587,588,589,590,610,611,612,613,614,616,618,619,624,666} --Every single X2 enemy.
local allsmallenemies = table.map{1,2,3,4,5,6,7,8,12,15,17,18,19,20,23,24,25,27,28,29,36,37,38,39,42,43,44,47,48,51,52,53,54,55,59,61,63,65,73,74,76,77,89,93,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,135,137,161,162,163,164,165,166,167,168,172,173,174,175,176,177,180,189,199,200,201,203,204,205,206,207,209,210,229,230,231,232,233,234,235,236,242,243,244,245,247,261,262,267,268,270,271,272,275,280,281,284,285,286,294,295,296,298,299,301,302,303,304,305,307,309,311,312,313,314,315,316,317,318,321,323,324,333,345,346,347,350,351,352,357,360,365,368,369,371,372,373,374,375,377,379,380,382,383,386,388,389,392,393,395,401,406,407,408,409,413,415,431,437,446,447,448,449,459,460,461,463,464,469,470,471,472,485,486,487,490,491,492,493,509,510,512,513,514,515,516,517,418,519,520,521,522,523,524,529,530,539,562,563,564,572,578,579,580,586,587,588,589,590,610,611,612,613,614,616,619,624,666} --Every single small X2 enemy.
local allbigenemies = table.map{71,72,466,467,618} --Every single big X2 enemy.
local enemyfireballs = table.map{85,87,246,276} --All enemy fireballs.

function extraSounds.onDraw()
    for k,v in ipairs(SMBSE.Functions.Tables.regular.sounds.soundFileList) do
        if not SMBSE.Functions.Tables.mapped.sounds.unusedVanillaSoundIDs[k] then
            if extraSounds.sounds[k].sfx == nil then --If nil, roll back to the original sound...
                extraSounds.sounds[k].sfx = Audio.SfxOpen(Misc.resolveSoundFile(v))
            end
        end
    end
end

local function startedLevelWith99LivesInEditor()
    if Misc.inEditor() and lunatime.drawtick() >= 2 then
        return true
    elseif Misc.inEditor() and lunatime.drawtick() <= 1 then
        return false
    elseif not Misc.inEditor() then
        --If not in the editor and in-game, this is always true
        return true
    end
end

function extraSounds.onDrawEnd()
    if comboMuteTimer > 0 then
        comboMuteTimer = comboMuteTimer - 1
        if comboMuteTimer == 0 then
            Audio.sounds[9].muted = false
        end
    end
end

function extraSounds.onTick() --This is a list of sounds that'll need to be replaced within each costume. They're muted here for obivious reasons.
    if extraSounds.settings.enabled then --Only mute when active
        disableSoundMarker = false --Make sure, when disabled, it only unmutes once when disabled

        Audio.sounds[1].muted = true --player-jump.ogg
        Audio.sounds[4].muted = true --block-smash.ogg
        Audio.sounds[7].muted = true --mushroom.ogg
        Audio.sounds[8].muted = true --player-dead.ogg
        Audio.sounds[10].muted = true --player-slide.ogg
        Audio.sounds[14].muted = true --coin.ogg
        Audio.sounds[15].muted = true --1up.ogg
        --Audio.sounds[17].muted = true --warp.ogg
        Audio.sounds[18].muted = true --fireball.ogg
        Audio.sounds[33].muted = true --tail.ogg
        Audio.sounds[36].muted = true --smash.ogg
        Audio.sounds[39].muted = true --birdo-hit.ogg
        Audio.sounds[42].muted = true --npc-fireball.ogg
        Audio.sounds[43].muted = true --fireworks.ogg
        Audio.sounds[59].muted = true --dragon-coin.ogg
        Audio.sounds[77].muted = true --zelda-stab.ogg
        Audio.sounds[81].muted = true --zelda-rupee.ogg





        for _,p in ipairs(Player.get()) do





            --**JUMPING**
            if hasJumped(p, Cheats.get("ahippinandahoppin").active) then
                if extraSounds.options.toggle.jumpingSFX then
                    SMBSE.Functions.Sound.SFX.Play(1)
                end
            end
            
            
            
            
            
            --**YOSHI UNMOUNT**
            if p.mount == 3 then
                if (p:mem(0x11E, FIELD_BOOL) and p.keys.altJump == KEYS_PRESSED) then
                    if not extraSounds.options.classicToggle.revertYoshiUnmountSFXs then
                        if extraSounds.options.toggle.yoshiUnmountSFX then
                            SMBSE.Functions.Sound.SFX.Play(35)
                        end
                    elseif extraSounds.options.classicToggle.revertYoshiUnmountSFXs then
                        if extraSounds.options.toggle.jumpingSFX then
                            SMBSE.Functions.Sound.SFX.Play(1)
                        end
                    end
                end
            end
            
            
            
            
            
            
            --**DOUBLE JUMPING**
            if (p:mem(0x00, FIELD_BOOL) and p:mem(0x174, FIELD_BOOL) and p.keys.jump == KEYS_PRESSED) then
                if extraSounds.options.toggle.doubleJumpSFX then
                    if extraSounds.options.classicToggle.revertDoubleJumpSFXs then
                        SMBSE.Functions.Sound.SFX.Play(1)
                    elseif not extraSounds.options.classicToggle.revertDoubleJumpSFXs then
                        SMBSE.Functions.Sound.SFX.Play(158)
                    end
                end
            end
            
            
            
            
            
            --**SKIDDING**
            if p:isOnGround() and ((p.speedX < 0 and p.rightKeyPressing) or (p.speedX > 0 and p.leftKeyPressing)) then --Is the player skidding and on the ground?
                if extraSounds.options.toggle.skiddingSFX then
                    SMBSE.Functions.Sound.SFX.Play(10, extraSounds.settings.defaultVolumeCount, 1, extraSounds.options.delay.playerSkid) --Sliding SFX
                end
            end
            
            
            
            
            --**TAIL ATTACK**
            if p.powerup == 4 or p.powerup == 5 then
                if isTailSwiping(p) then --Is the key pressed, and active, and the forced state is none, while not climbing and not on a mount and not ducking (And not dead)?
                    if extraSounds.options.toggle.tailAttackSFX then
                        SMBSE.Functions.Sound.SFX.Play(33)
                    end
                end
            end
            
            
            
            
            
            --**SPINJUMPING**
            if normalCharacters[p.character] then
                if (p:isOnGround() and not p.keys.down and p.mount == 0 and (not GameData.winStateActive or GameData.winStateActive == nil) and Level.endState() == 0) then --If on the ground, not holding down, and not on a mount...
                    if (p:mem(0x120, FIELD_BOOL) and p.keys.altJump == KEYS_PRESSED) then --If alt jump is pressed and jump has been activated...
                        if p:mem(0x50, FIELD_BOOL) == false then
                            if extraSounds.options.toggle.spinJumpSFX then
                                SMBSE.Functions.Sound.SFX.Play(33)
                            end
                        end
                    end
                end
            elseif linkCharacters[p.character] then
                if (p:isOnGround() and Level.endState() == 0) then --If on the ground...
                    if (p:mem(0x120, FIELD_BOOL) and p.keys.altJump == KEYS_PRESSED) then --If alt jump is pressed and jump has been activated...
                        if p:mem(0x50, FIELD_BOOL) == false then
                            if extraSounds.options.toggle.jumpingSFX then
                                SMBSE.Functions.Sound.SFX.Play(1)
                            end
                        end
                    end
                end
            end
            
            
            
            
            --**SPINJUMP FIRE/ICEBALLS**
            if p:mem(0x50, FIELD_BOOL) and p.holdingNPC == nil then --Is the player spinjumping while not holding an item?
                if p:mem(0x160, FIELD_WORD) == 0 then --Is the cooldown on this number?
                    if p.powerup == 3 then --Fireball sound
                        if extraSounds.options.toggle.fireFlowerShootSFX then
                            SMBSE.Functions.Sound.SFX.Play(18)
                        end
                    end
                    if p.powerup == 7 then --Iceball sound
                        if extraSounds.options.toggle.iceFlowerShootSFX then
                            if not extraSounds.options.classicToggle.revertIceballSFXs then
                                SMBSE.Functions.Sound.SFX.Play(93)
                            elseif extraSounds.options.classicToggle.revertIceballSFXs then
                                SMBSE.Functions.Sound.SFX.Play(18)
                            end
                        end
                    end
                end
            end
            if not p:mem(0x50, FIELD_BOOL) then --Is the player not spinjumping?
                
            end
        
        
            
            
            --**GRABBING SHELLS**
            if Player.count() == 1 then
                if p.holdingNPC ~= nil then
                    holdingTimer[p.idx] = holdingTimer[p.idx] + 1
                else
                    holdingTimer[p.idx] = 0
                end
                for k,v in ipairs(NPC.get({5,7,24,73,113,114,115,116,172,174,194})) do
                    if p.holdingNPC == v and p.keys.run then
                        if not normalCharactersToad[p.character] then
                            if holdingTimer[p.idx] == 1 then
                                if extraSounds.options.toggle.shellGrabSFX then
                                    SMBSE.Functions.Sound.SFX.Play(156)
                                end
                            end
                        end
                    end
                end
            end
            
            
            
            
            --**FIREBALL HAMMER SUIT SHIELD HIT (Block Hit Muting Detection)**
            if ((p.powerup == 6 and p:mem(0x12E,FIELD_BOOL) and p.mount == 0 and not linkCharacters[p.character]) or (p.mount == 1 and p.mountColor == 2)) then
                for k,v in ipairs(NPC.getIntersecting(p.x - 15, p.y - 15, p.x + p.width + 30, p.y + p.height + 30)) do
                    if enemyfireballs[v.id] then
                        if extraSounds.options.toggle.hammerSuitFireShieldHitSFX then
                            Audio.sounds[3].muted = true
                            Routine.run(extraSounds.tempMuteBlockHit)
                        end
                    end
                end
            end
            
            
            
        
            --**PSWITCH/STOPWATCH TIMER**
            if mem(0x00B2C62C, FIELD_WORD) >= 150 and mem(0x00B2C62C, FIELD_WORD) < mem(0x00B2C87C, FIELD_WORD) - 27 or mem(0x00B2C62E, FIELD_WORD) >= 150 and mem(0x00B2C62E, FIELD_WORD) < mem(0x00B2C87C, FIELD_WORD) - 27 then --Are the P-Switch/Stopwatch timers activate and on these number values?
                if Level.endState() <= 0 then --Make sure to not activate when the endState is greater than 1
                    if not GameData.winStateActive or GameData.winStateActive == nil then --SMAS++ episode specific, you don't need this for anything outside of SMAS++
                        if extraSounds.options.toggle.pSwitchTimerSFX then
                            SMBSE.Functions.Sound.SFX.Play(118, extraSounds.settings.defaultVolumeCount, 1, extraSounds.options.delay.pSwitchAndStopwatchTimer)
                        end
                    end
                end
            elseif mem(0x00B2C62C, FIELD_WORD) <= 150 and mem(0x00B2C62C, FIELD_WORD) >= 1 or mem(0x00B2C62E, FIELD_WORD) <= 150 and mem(0x00B2C62E, FIELD_WORD) >= 1 then --Are the P-Switch/Stopwatch timers activate and on these number values?
                if Level.endState() <= 0 then --Make sure to not activate when the endState is greater than 1
                    if not GameData.winStateActive or GameData.winStateActive == nil then --SMAS++ episode specific, you don't need this for anything outside of SMAS++
                        if extraSounds.options.toggle.pSwitchTimerSFX then
                            SMBSE.Functions.Sound.SFX.Play(118, extraSounds.settings.defaultVolumeCount, 1, extraSounds.options.delay.pSwitchAndStopwatchHurryTimer)
                        end
                    end
                end
            end
            
            
            
            --**PSWITCH/STOPWATCH TIMEOUT**
            if mem(0x00B2C62C, FIELD_WORD) == 150 or mem(0x00B2C62E, FIELD_WORD) == 150 then --Time out sound effect
                if Level.endState() <= 0 then --Make sure to not activate when the endState is greater than 1
                    if not GameData.winStateActive or GameData.winStateActive == nil then --SMAS++ episode specific, you don't need this for anything outside of SMAS++
                        if extraSounds.options.toggle.pSwitchAndStopwatchTimeOutSFX then
                            SMBSE.Functions.Sound.SFX.Play(165, extraSounds.settings.defaultVolumeCount, 1)
                        end
                    end
                end
            end
            
            
            
            --**P-WING**
            for k,p in ipairs(Player.get()) do
                if p:mem(0x66, FIELD_BOOL) == false and p.deathTimer <= 0 and p.forcedState == FORCEDSTATE_NONE and Level.endState() <= 0 then
                    if p:mem(0x16C, FIELD_BOOL) == true then
                        if extraSounds.options.toggle.pWingSFX then
                            SMBSE.Functions.Sound.SFX.Play(121, extraSounds.settings.defaultVolumeCount, 1, extraSounds.options.delay.pWing)
                        end
                    end
                    if p:mem(0x170, FIELD_WORD) >= 1 then
                        if extraSounds.options.toggle.pWingSFX then
                            SMBSE.Functions.Sound.SFX.Play(121, extraSounds.settings.defaultVolumeCount, 1, extraSounds.options.delay.pWing)
                        end
                    end
                end
            end
            
            
            
            
            --**NPCS**
            
            --ITEMS/PROJECTILES**
            for k,v in ipairs(NPC.get(45)) do --Throw blocks/ice blocks, used for when they melt
                if v.ai2 == 449 then
                    if extraSounds.options.toggle.iceBlockMeltSFX then
                        SMBSE.Functions.Sound.SFX.Play(157)
                    end
                end
            end
            
            --*ENEMIES*
            --
            --*Venus Fire Trap*
            for k,v in ipairs(NPC.get(245)) do
                if (v.ai2 == 2 and v.ai1 == 50) and isOnScreen(v) then
                    if extraSounds.options.toggle.venusFireTrapShootSFX then
                        SMBSE.Functions.Sound.SFX.Play(167)
                    end
                end
            end
            --*Fire Bros.*
            if SMBX_VERSION == VER_SEE_MOD then
                if npcGlobalVariables ~= nil then
                    if npcGlobalVariables[389].soundID == 18 then
                        npcGlobalVariables[389].soundID = extraSounds.sounds[168].sfx
                    end
                end
            end
            
            --*BOSSES*
            --
            --*SMB3 Bowser*
            for k,v in ipairs(NPC.get(86)) do --Make sure the seperate Bowser fire sound plays when SMB3 Bowser actually fires up a fireball
                if v.ai4 == 4 then
                    if v.ai3 == 25 then
                        if not extraSounds.options.classicToggle.revertBowserFireballSFXs then
                            SMBSE.Functions.Sound.SFX.Play(115)
                        elseif extraSounds.options.classicToggle.revertBowserFireballSFXs then
                            SMBSE.Functions.Sound.SFX.Play(42)
                        end
                    end
                end
            end
            --*SMB1 Bowser*
            for k,v in ipairs(NPC.get(200)) do --Make sure the seperate Bowser fire sound plays when SMB1 Bowser actually fires up a fireball
                if v.ai3 == 40 then
                    if not extraSounds.options.classicToggle.revertBowserFireballSFXs then
                        SMBSE.Functions.Sound.SFX.Play(115)
                    elseif extraSounds.options.classicToggle.revertBowserFireballSFXs then
                        SMBSE.Functions.Sound.SFX.Play(42)
                    end
                end
            end
            --*SMW Ludwig Koopa*
            for k,v in ipairs(NPC.get(280)) do --Make sure the actual fire sound plays when Ludwig Koopa actually fires up a fireball
                if v.ai1 == 2 then
                    SMBSE.Functions.Sound.SFX.Play(42, extraSounds.settings.defaultVolumeCount, 1, 35)
                end
            end
            --*SMB3 Boom Boom*
            for k,v in ipairs(NPC.get(15)) do --Adding a hurt sound for Boom Boom cause why not lol
                if v.ai1 == 4 and v.ai2 == 1 then
                    SMBSE.Functions.Sound.SFX.Play(39, extraSounds.settings.defaultVolumeCount)
                end
            end
            
            
            
            
            
            --**PROJECTILES**
            --*Toad's Boomerang*
            for k,v in ipairs(NPC.get(292)) do --Boomerang sounds! (Toad's Boomerang)
                if extraSounds.options.toggle.toadBoomerangSFX then
                    if isOnScreen(v) then
                        SMBSE.Functions.Sound.SFX.Play(116, extraSounds.settings.defaultVolumeCount, 1, extraSounds.options.delay.boomerang)
                    end
                end
            end
            --*Boomerang Bro. Projectile*
            for k,v in ipairs(NPC.get(615)) do --Boomerang sounds! (Boomerang Bros.)
                if extraSounds.options.toggle.boomerangBroBoomerangSFX then
                    if isOnScreen(v) then
                        SMBSE.Functions.Sound.SFX.Play(116, extraSounds.settings.defaultVolumeCount, 1, extraSounds.options.delay.boomerang)
                    end
                end
            end
            --*Toothy's Pipe*
            for k,v in ipairs(NPC.get(50)) do --Toothy brick break issue, fixed
                for i,j in ipairs(Block.get(extraSounds.allBrickBlockIDs)) do
                    if j.id ~= 526 and not j.isHidden then
                        if Colliders.collide(v, j) and (p.holdingNPC and p.holdingNPC.id == 49) then
                            SMBSE.Functions.Sound.SFX.Play(4, extraSounds.settings.defaultVolumeCount, 1, extraSounds.options.delay.brickBreak)
                        end
                    end
                end
            end
            
            
            
            --**1UPS**
            if not isOverworld then
                for index,scoreboard in ipairs(Animation.get(79)) do --Score values!
                    if scoreboard.animationFrame == 9 and scoreboard.speedY == -1.94 then --1UP
                        if SaveData.SMBSE.Settings.EnableLives then
                            SMBSE.Functions.Sound.SFX.Play(15)
                        else
                            SMBSE.Functions.Sound.SFX.Play(150)
                        end
                    end
                    if scoreboard.animationFrame == 10 and scoreboard.speedY == -1.94 then --2UP
                        if not extraSounds.options.classicToggle.revert1UPSeparateSFXs then
                            if SaveData.SMBSE.Settings.EnableLives then
                                SMBSE.Functions.Sound.SFX.Play(96)
                            else
                                SMBSE.Functions.Sound.SFX.Play(150)
                            end
                        elseif extraSounds.options.classicToggle.revert1UPSeparateSFXs then
                            if SaveData.SMBSE.Settings.EnableLives then
                                SMBSE.Functions.Sound.SFX.Play(15)
                            else
                                SMBSE.Functions.Sound.SFX.Play(150)
                            end
                        end
                    end
                    if scoreboard.animationFrame == 11 and scoreboard.speedY == -1.94 then --3UP
                        if not extraSounds.options.classicToggle.revert1UPSeparateSFXs then
                            if SaveData.SMBSE.Settings.EnableLives then
                                SMBSE.Functions.Sound.SFX.Play(97)
                            else
                                SMBSE.Functions.Sound.SFX.Play(150)
                            end
                        elseif extraSounds.options.classicToggle.revert1UPSeparateSFXs then
                            if SaveData.SMBSE.Settings.EnableLives then
                                SMBSE.Functions.Sound.SFX.Play(15)
                            else
                                SMBSE.Functions.Sound.SFX.Play(150)
                            end
                        end
                    end
                    if scoreboard.animationFrame == 12 and scoreboard.speedY == -1.94 then --5UP
                        if not extraSounds.options.classicToggle.revert1UPSeparateSFXs then
                            if SaveData.SMBSE.Settings.EnableLives then
                                SMBSE.Functions.Sound.SFX.Play(98)
                            else
                                SMBSE.Functions.Sound.SFX.Play(150)
                            end
                        elseif extraSounds.options.classicToggle.revert1UPSeparateSFXs then
                            if SaveData.SMBSE.Settings.EnableLives then
                                SMBSE.Functions.Sound.SFX.Play(15)
                            else
                                SMBSE.Functions.Sound.SFX.Play(150)
                            end
                        end
                    end
                end
                
                
                
                
            --**EXPLOSIONS**
                for index,explosion in ipairs(Effect.get(69)) do --Explosions!
                    if explosion.timer == 59 then
                        if not extraSounds.options.classicToggle.revertFireworkSFXs then
                            if extraSounds.options.toggle.SMB2ExplosionSFX then
                                SMBSE.Functions.Sound.SFX.Play(104, extraSounds.settings.defaultVolumeCount)
                            end
                        elseif extraSounds.options.classicToggle.revertFireworkSFXs then
                            if extraSounds.options.toggle.fireworkSFX then
                                SMBSE.Functions.Sound.SFX.Play(43, extraSounds.settings.defaultVolumeCount)
                            end
                        end
                    end
                end
                for index2,explosion2 in ipairs(Effect.get(71)) do
                    if explosion2.timer == 59 then
                        if extraSounds.options.toggle.fireworkSFX then
                            SMBSE.Functions.Sound.SFX.Play(43, extraSounds.settings.defaultVolumeCount, 1)
                        end
                    end
                end
                
                --**KOOAPLING SHELL FLY AWAY EFFECTS**
                --(Yes, bettereffects doesn't do proper for loops for a table, so it'll have to be duplicated until this probnlem is fixed for Beta 5)
                for index,shell in ipairs(Animation.get(140)) do
                    if shell.speedY == 0 then --Good enough
                        if extraSounds.options.toggle.boomerangBroBoomerangSFX then
                            SMBSE.Functions.Sound.SFX.Play(116, extraSounds.settings.defaultVolumeCount, 1, extraSounds.options.delay.boomerang)
                        end
                    end
                end
                if Misc.inSuperMarioAllStarsPlusPlus ~= nil and Misc.inSuperMarioAllStarsPlusPlus() then
                    for index2,shell2 in ipairs(bettereffects.getEffectObjects(988)) do
                        if shell2.speedY == 0 then
                            if extraSounds.options.toggle.boomerangBroBoomerangSFX then
                                SMBSE.Functions.Sound.SFX.Play(116, extraSounds.settings.defaultVolumeCount, 1, extraSounds.options.delay.boomerang)
                            end
                        end
                    end
                    for index2,shell2 in ipairs(bettereffects.getEffectObjects(986)) do
                        if shell2.speedY == 0 then
                            if extraSounds.options.toggle.boomerangBroBoomerangSFX then
                                SMBSE.Functions.Sound.SFX.Play(116, extraSounds.settings.defaultVolumeCount, 1, extraSounds.options.delay.boomerang)
                            end
                        end
                    end
                end
            end
            
            
            
            
            
            
            
            --**NPCTOCOIN**
            if mem(0x00A3C87F, FIELD_BYTE) == 14 and Level.endState() == 2 or Level.endState() == 4 then --This plays a coin sound when NpcToCoin happens
                npcToCoinTimer = npcToCoinTimer + 1
                if extraSounds.options.toggle.NPCtoCoinSFX then
                    if npcToCoinTimer == 1 then
                        SMBSE.Functions.Sound.SFX.Play(14)
                    end
                end
            end




            --**100 COIN 1UP SYSTEM**
            --The coin count in the HUD is graphically remade somewhere else, extraSounds doesn't remake the graphics side of things
            if mem(0x00B2C5A8, FIELD_WORD) > 0 then
                SaveData.SMBSE.Hud.Count.CoinClassic = SaveData.SMBSE.Hud.Count.CoinClassic + mem(0x00B2C5A8, FIELD_WORD)
                SaveData.SMBSE.Hud.Count.CoinModern = SaveData.SMBSE.Hud.Count.CoinModern + mem(0x00B2C5A8, FIELD_WORD)
                mem(0x00B2C5A8, FIELD_WORD, 0)
            end
            if SaveData.SMBSE.Hud.Count.CoinClassic > 99 then
                if SaveData.SMBSE.Settings.EnableLives then
                    SMBSE.Functions.Sound.SFX.Play(15)
                else
                    SMBSE.Functions.Sound.SFX.Play(150)
                end
                SaveData.SMBSE.Hud.Count.CoinClassic = 0
            end




            --**LIFE SYSTEM**
            --Same info about this is also at the coin count, see above
            if mem(0x00B2C5AC, FIELD_FLOAT) < 1 then --Prevents the SMBX2 Game Over system from happening, since we still need GameData afterwards
                mem(0x00B2C5AC, FIELD_FLOAT, 1)
            end
            if not startedLevelWith99LivesInEditor() then
                mem(0x00B2C5AC, FIELD_FLOAT, 1)
            end
            if mem(0x00B2C5AC, FIELD_FLOAT) ~= 1 and startedLevelWith99LivesInEditor() then
                SaveData.SMBSE.Hud.Count.Lives = SaveData.SMBSE.Hud.Count.Lives + (mem(0x00B2C5AC, FIELD_FLOAT) - 1)
                SMBSE.Functions.SendToConsole(tostring(mem(0x00B2C5AC, FIELD_FLOAT) - 1).." lives earned.")
                if (mem(0x00B2C5AC,FIELD_FLOAT) - 1) == 1 then
                    Misc.score(10000)
                elseif (mem(0x00B2C5AC,FIELD_FLOAT) - 1) == 2 then
                    Misc.score(20000)
                elseif (mem(0x00B2C5AC,FIELD_FLOAT) - 1) == 3 then
                    Misc.score(30000)
                elseif (mem(0x00B2C5AC,FIELD_FLOAT) - 1) == 4 then
                    Misc.score(40000)
                elseif (mem(0x00B2C5AC,FIELD_FLOAT) - 1) == 5 then
                    Misc.score(50000)
                end
                mem(0x00B2C5AC, FIELD_FLOAT, 1)
            end




        end
    end
    if not extraSounds.settings.enabled then --Unmute when not active
        if not disableSoundMarker then
            Audio.sounds[1].muted = false --player-jump.ogg
            Audio.sounds[4].muted = false --block-smash.ogg
            Audio.sounds[7].muted = false --mushroom.ogg
            Audio.sounds[8].muted = false --player-dead.ogg
            Audio.sounds[10].muted = false --player-slide.ogg
            Audio.sounds[14].muted = false --coin.ogg
            Audio.sounds[15].muted = false --1up.ogg
            --Audio.sounds[17].muted = false --warp.ogg
            Audio.sounds[18].muted = false --fireball.ogg
            Audio.sounds[33].muted = false --tail.ogg
            Audio.sounds[36].muted = false --smash.ogg
            Audio.sounds[39].muted = false --birdo-hit.ogg
            Audio.sounds[42].muted = false --npc-fireball.ogg
            Audio.sounds[43].muted = false --fireworks.ogg
            Audio.sounds[59].muted = false --dragon-coin.ogg
            Audio.sounds[77].muted = false --zelda-stab.ogg
            Audio.sounds[81].muted = false --zelda-rupee.ogg

            disableSoundMarker = true
        end
    end
end

--[[function extraSounds.onSFXStart(eventObj, soundID, soundPath)
    if extraSounds.settings.enabled then
        for k,p in ipairs(Player.get()) do
            
            
            --**JUMPING**
            if hasJumped(p, Cheats.get("ahippinandahoppin").active) and soundID == 1 then
                eventObj.cancelled = true
                if extraSounds.options.toggle.jumpingSFX then
                    if not extraSounds.options.classicToggle.revertSeparateJumpSFXs then
                        if p.powerup >= 2 then
                            SMBSE.Functions.Sound.SFX.Play(1)
                        else
                            SMBSE.Functions.Sound.SFX.Play(158)
                        end
                    else 
                        SMBSE.Functions.Sound.SFX.Play(1)
                    end
                end
            end
            
            
            
            --**DOUBLE JUMPING**
            if (p:mem(0x00, FIELD_BOOL) and p:mem(0x174, FIELD_BOOL) and p.keys.jump == KEYS_PRESSED) and soundID == 1 then
                eventObj.cancelled = true
                if extraSounds.options.toggle.doubleJumpSFX then
                    if extraSounds.options.classicToggle.revertDoubleJumpSFXs then
                        SMBSE.Functions.Sound.SFX.Play(1)
                    elseif not extraSounds.options.classicToggle.revertDoubleJumpSFXs then
                        SMBSE.Functions.Sound.SFX.Play(158)
                    end
                end
            end
            
            
            
            
        end
    end
end

function extraSounds.onDraw()
    if extraSounds.settings.enabled then
        
    end
end]]

local blockSmashTable = {
    [4] = 4,
    [60] = 4,
    [90] = 4,
    [186] = 43,
    [188] = 4,
    [226] = 4,
    [293] = 4,
    [668] = 4,
}

function bricksmashsound(block, fromUpper, playerornil) --This will smash bricks, as said from the source code.
    Routine.waitFrames(2, true)
    if block.isHidden and block.layerName == "Destroyed Blocks" then
        if extraSounds.options.toggle.brickSmashSFX then
            SMBSE.Functions.Sound.SFX.Play(blockSmashTable[block.id], extraSounds.settings.defaultVolumeCount, 1, extraSounds.options.delay.brickBreak)
        end
    end
end

function brickkillsound(block, hitter) --Alternative way to play the sound. Used with the SMW block, the Brinstar Block, and the Unstable Turn Block.
    Routine.waitFrames(2, true)
    if block.isHidden and block.layerName == "Destroyed Blocks" then
        if extraSounds.options.toggle.brickSmashSFX then
            SMBSE.Functions.Sound.SFX.Play(blockSmashTable[block.id], extraSounds.settings.defaultVolumeCount, 1, extraSounds.options.delay.brickBreak)
        end
    end
end

local otherCoinSoundsMap = {
    [251] = 81,
    [252] = 81,
    [253] = 81,
}

function brickcointopdetection(block, fromUpper, playerornil)
    if extraSounds.options.toggle.smallPlayerBottomBrickHitCoinCollectSFX and not fromUpper then
        for k,v in NPC.iterateIntersecting(block.x, block.y - 32, block.x + 32, block.y) do
            if NPC.config[v.id].iscoin and not v.isHidden and not v.isGenerator then
                SMBSE.Functions.Sound.SFX.Play(otherCoinSoundsMap[v.id] or 14)
            end
        end
    end
end

function extrasoundsBlock90.onCollideBlock(block, hitter) --SMW BLock
    if type(hitter) == "Player" then
        if (hitter.y+hitter.height) <= (block.y+4) then
            if (hitter:mem(0x50, FIELD_BOOL)) then --Is the player spinjumping?
                Routine.run(brickkillsound,block,hitter)
            end
        end
    end
end

function extrasoundsBlock668.onCollideBlock(block, hitter) --Unstable Turn Block
    if type(hitter) == "Player" then
        Routine.run(brickkillsound,block,hitter)
    end
end

function extraSounds.onPostBlockHit(block, fromUpper, playerornil) --Let's start off with block hitting.
    local bricks = table.map{4,60,90,188,226,293,526} --These are a list of breakable bricks
    local bricksnormal = table.map{4,60,90,188,226,293} --These are a list of breakable bricks, without the Super Metroid breakable.
    local questionblocks = table.map{5,88,193,224}
    if extraSounds.settings.enabled then --If it's true, play them
        if not Misc.isPaused() then --Making sure the sound only plays when not paused...
            for _,p in ipairs(Player.get()) do --This will get actions regarding all players
            
                
                
                
                
                --**CONTENT ID DETECTION**
                if block.contentID == nil then --For blocks that are already used
                    
                end
                if block.contentID == 1225 or block.contentID == 1226 or block.contentID == 1227 then --Add 1000 to get an actual content ID number. The first three are vine blocks.
                    if not extraSounds.options.classicToggle.revertVineBlockSproutSFXs then
                        SMBSE.Functions.Sound.SFX.Play(92)
                    elseif extraSounds.options.classicToggle.revertVineBlockSproutSFXs then
                        SMBSE.Functions.Sound.SFX.Play(7)
                    end
                elseif block.contentID == 1997 or block.contentID == 1425 then --Megashroom block, also compatible with SMAS++
                    if not extraSounds.options.classicToggle.revertVineBlockSproutSFXs then
                        SMBSE.Functions.Sound.SFX.Play(149)
                    elseif extraSounds.options.classicToggle.revertVineBlockSproutSFXs then
                        SMBSE.Functions.Sound.SFX.Play(7)
                    end
                elseif block.contentID == 0 then --This is to prevent a coin sound from playing when hitting an nonexistant block
                    
                elseif block.contentID == 1000 then --Same as last
                    
                elseif block.contentID >= 1001 then --Greater than blocks, exceptional to vine blocks, will play a mushroom spawn sound
                    SMBSE.Functions.Sound.SFX.Play(7)
                elseif block.contentID <= 99 then --Elseif, we'll play a coin sound with things less than 99, the coin block limit
                    if playerornil then
                        if normalCharacters[playerornil.character] then
                            if extraSounds.options.toggle.smallPlayerBottomBrickHitCoinCollectSFX then
                                SMBSE.Functions.Sound.SFX.Play(14)
                            end
                        elseif linkCharacters[playerornil.character] then
                            if extraSounds.options.toggle.smallPlayerBottomBrickHitCoinCollectSFX then
                                SMBSE.Functions.Sound.SFX.Play(81)
                            end
                        end
                    else
                        SMBSE.Functions.Sound.SFX.Play(14)
                    end
                end
                
                
                
                
                --**BOWSER BRICKS**
                if block.id == 186 then --SMB3 Bowser Brick detection, thanks to looking at the source code
                    SMBSE.Functions.Sound.SFX.Play(43)
                end
                
                
                
                
                --**BRICK SMASHING**
                if bricksnormal[block.id] or block.id == 186 then
                    Routine.run(bricksmashsound, block, fromUpper, playerornil)
                end
                
                
                
                
                --**COIN TOP DETECTION**
                if bricksnormal[block.id] or questionblocks[block.id] then
                    Routine.run(brickcointopdetection, block, fromUpper, playerornil)
                end
                
                
                
                
                
            end
        end
    end
end

function extraSounds.onPostPlayerKill()
    if extraSounds.settings.enabled then
        for _,p in ipairs(Player.get()) do --This will get actions regards to the player itself
    
    
    
    
            --**PLAYER DYING**
            if extraSounds.options.toggle.playerDeadSFX then
                if p.character ~= CHARACTER_LINK and p.character ~= CHARACTER_SNAKE then
                    SMBSE.Functions.Sound.SFX.Play(8)
                end
            end
        
        
        
        end
    end
end

function extraSounds.onInputUpdate() --Button pressing for such commands
    if not Misc.isPaused() then
        if extraSounds.settings.enabled then
            for _,p in ipairs(Player.get()) do --Get all players
            
            
            
                
                
                
                --**FIREBALLS/HAMMERS/ICEBALLS**
                if isShooting(p) then
                    if normalCharactersWithoutMegaman[p.character] then
                        if p.powerup == 3 then --Fireball sound
                            if extraSounds.options.toggle.fireFlowerShootSFX then
                                SMBSE.Functions.Sound.SFX.Play(18, extraSounds.settings.defaultVolumeCount)
                            end
                        end
                        if p.powerup == 6 then --Hammer throw sound
                            if extraSounds.options.toggle.hammerSuitShootSFX then
                                if not extraSounds.options.classicToggle.revertHammerThrowSFXs then
                                    SMBSE.Functions.Sound.SFX.Play(105, extraSounds.settings.defaultVolumeCount)
                                elseif extraSounds.options.classicToggle.revertHammerThrowSFXs then
                                    SMBSE.Functions.Sound.SFX.Play(18, extraSounds.settings.defaultVolumeCount)
                                end
                            end
                        end
                        if p.powerup == 7 then --Iceball sound
                            if extraSounds.options.toggle.iceFlowerShootSFX then
                                if not extraSounds.options.classicToggle.revertIceballSFXs then
                                    SMBSE.Functions.Sound.SFX.Play(93, extraSounds.settings.defaultVolumeCount)
                                elseif extraSounds.options.classicToggle.revertIceballSFXs then
                                    SMBSE.Functions.Sound.SFX.Play(18, extraSounds.settings.defaultVolumeCount)
                                end
                            end
                        end
                    end
                end
                
                
                
                
                --**LINK SLASHING**
                if isShootingLink(p) then
                    if linkCharacters[p.character] then
                        if p.powerup == 3 then --Fireball sound
                            if extraSounds.options.toggle.linkSlashFireballSFX then
                                SMBSE.Functions.Sound.SFX.Play(161, extraSounds.settings.defaultVolumeCount)
                            end
                        elseif p.powerup == 7 then --Iceball sound
                            if extraSounds.options.toggle.linkSlashIceballSFX then
                                SMBSE.Functions.Sound.SFX.Play(162, extraSounds.settings.defaultVolumeCount)
                            end
                        else
                            if extraSounds.options.toggle.linkSlashSFX then
                                SMBSE.Functions.Sound.SFX.Play(77, extraSounds.settings.defaultVolumeCount)
                            end
                        end
                    end
                end
                
                
                
                --*YOSHI FIRE SPITTING*
                if p:mem(0x68, FIELD_BOOL) == true then --If it's detected that Yoshi has the fire ability...
                    if p.keys.run == KEYS_PRESSED or p.keys.altRun == KEYS_PRESSED then --If it's spit out...
                        SMBSE.Functions.Sound.SFX.Play(42) --Play the sound
                    end
                end
                
                
                

                
                
                
            end
        end
    end
end


function extraSounds.comboSoundRoutine()
    Routine.waitFrames(1, true)
    for index,scoreboard in ipairs(Animation.get(79)) do --Score values!
        if scoreboard.animationFrame == 0 and scoreboard.speedY == -1.94 then --10 Points
            SMBSE.Functions.Sound.SFX.Play(9)
        end
        if scoreboard.animationFrame == 1 and scoreboard.speedY == -1.94 then --100 Points
            SMBSE.Functions.Sound.SFX.Play(9)
        end
        if scoreboard.animationFrame == 2 and scoreboard.speedY == -1.94 then --200 Points
            SMBSE.Functions.Sound.SFX.Play(106)
        end
        if scoreboard.animationFrame == 3 and scoreboard.speedY == -1.94 then --400 Points
            SMBSE.Functions.Sound.SFX.Play(107)
        end
        if scoreboard.animationFrame == 4 and scoreboard.speedY == -1.94 then --800 Points
            SMBSE.Functions.Sound.SFX.Play(108)
        end
        if scoreboard.animationFrame == 5 and scoreboard.speedY == -1.94 then --1000 Points
            SMBSE.Functions.Sound.SFX.Play(109)
        end
        if scoreboard.animationFrame == 6 and scoreboard.speedY == -1.94 then --2000 Points
            SMBSE.Functions.Sound.SFX.Play(110)
        end
        if scoreboard.animationFrame == 7 and scoreboard.speedY == -1.94 then --4000 Points
            SMBSE.Functions.Sound.SFX.Play(111)
        end
        if scoreboard.animationFrame == 8 and scoreboard.speedY == -1.94 then --8000 Points
            SMBSE.Functions.Sound.SFX.Play(112)
        end
        if scoreboard.animationFrame >= 9 and scoreboard.speedY == -1.94 then --1UP -> 5UP
            SMBSE.Functions.Sound.SFX.Play(112)
        end
    end
end


function extraSounds.onPostNPCHarm(npc, harmtype, player)
    if not Misc.isPaused() then
        if extraSounds.settings.enabled then
            for _,p in ipairs(Player.get()) do --This will get actions regards to the player itself
                
                
                
                --*BOSSES*
                --
                --*SMB1 Bowser*
                if harmtype ~= HARM_TYPE_VANISH then
                    if npc.id == 200 then --Play the hurt sound when hurting SMB1 Bowser
                        SMBSE.Functions.Sound.SFX.Play(39)
                    end
                    --*SMB3 Bowser*
                    if npc.id == 86 then --Play the hurt sound when hurting SMB3 Bowser
                        SMBSE.Functions.Sound.SFX.Play(39)
                    end
                    --*SMB3 Boom Boom*
                    if npc.id == 15 then --Play the hurt sound when hurting SMB3 Boom Boom
                        SMBSE.Functions.Sound.SFX.Play(39)
                    end
                    --*SMB3 Larry Koopa*
                    if npc.id == 267 or npc.id == 268 then --Play the hurt sound when hurting SMB3 Larry Koopa
                        SMBSE.Functions.Sound.SFX.Play(39)
                    end
                    --*SMB2 Birdo*
                    if npc.id == 39 then --Play the hurt sound when hurting SMB2 Birdo
                        SMBSE.Functions.Sound.SFX.Play(39)
                    end
                    --*SMB2 Mouser*
                    if npc.id == 262 then --Play the hurt sound when hurting SMB2 Mouser
                        SMBSE.Functions.Sound.SFX.Play(39)
                    end
                    --*SMB2 Wart*
                    if npc.id == 201 then --Play the hurt sound when hurting SMB2 Wart
                        SMBSE.Functions.Sound.SFX.Play(39)
                    end
                end
                
                
                
                
                --**COMBO SOUNDS**
                if not isOverworld then
                    if harmableComboTypes[harmtype] then
                        Audio.sounds[9].muted = true
                        comboMuteTimer = 2
                        Routine.run(extraSounds.comboSoundRoutine)
                    end
                end
                
                
                
            end
        end
    end
end

function extraSounds.tempMuteBlockHit()
    Routine.waitFrames(3)
    Audio.sounds[3].muted = false
end

function extraSounds.onNPCKill(eventToken, npc, harmtype)
    if not Misc.isPaused() then
        if extraSounds.settings.enabled then
            for _,p in ipairs(Player.get()) do --This will get actions regards to the player itself
                
                --Code goes here
                
            end
        end
    end
end

function extraSounds.playDragonCoinSFX(npc)
    if not extraSounds.options.classicToggle.revertDragonCoinSFXs then
        if NPC.config[npc.id].score == 7 then
            SMBSE.Functions.Sound.SFX.Play(59)
        elseif NPC.config[npc.id].score == 8 then
            SMBSE.Functions.Sound.SFX.Play(99)
        elseif NPC.config[npc.id].score == 9 then
            SMBSE.Functions.Sound.SFX.Play(100)
        elseif NPC.config[npc.id].score == 10 then
            SMBSE.Functions.Sound.SFX.Play(101)
        elseif NPC.config[npc.id].score == 11 then
            SMBSE.Functions.Sound.SFX.Play(102)
        end
    elseif extraSounds.options.classicToggle.revertDragonCoinSFXs then
        if NPC.config[npc.id].score == 7 then
            SMBSE.Functions.Sound.SFX.Play(59)
        elseif NPC.config[npc.id].score == 8 then
            SMBSE.Functions.Sound.SFX.Play(59)
        elseif NPC.config[npc.id].score == 9 then
            SMBSE.Functions.Sound.SFX.Play(59)
        elseif NPC.config[npc.id].score == 10 then
            SMBSE.Functions.Sound.SFX.Play(59)
        elseif NPC.config[npc.id].score == 11 then
            SMBSE.Functions.Sound.SFX.Play(59)
        end
    end
end

function extraSounds.onPostNPCKill(npc, harmtype) --NPC Kill stuff, for custom coin sounds and etc.
    if not Misc.isPaused() then
        if extraSounds.settings.enabled then
            for _,p in ipairs(Player.get()) do --This will get actions regards to the player itself
                
                
                
                
                --**STOMPING**
                --Dumb fix pertaining to Bullet Bills being stomped and the sound doesn't play at all
                if (npc.id == 17 or npc.id == 18) and harmtype == HARM_TYPE_JUMP then
                    if extraSounds.options.toggle.enemyStompSFX then
                        SMBSE.Functions.Sound.SFX.Play(2)
                    end
                end

                --Dumb fix pertaining to Swoopers being stomped and the sound doesn't play at all
                if (npc.id == 271) and harmtype == HARM_TYPE_JUMP then
                    if extraSounds.options.toggle.enemyStompSFX then
                        SMBSE.Functions.Sound.SFX.Play(2)
                    end
                end
                
                
                
                
                
                --**FIREBALL HIT**
                if npc.id == 13 and harmtype ~= HARM_TYPE_VANISH then
                    if extraSounds.options.toggle.fireballBlockHitSFX then
                        SMBSE.Functions.Sound.SFX.Play(155)
                    end
                end
                
                
                
                
                --**FIREBALL HAMMER SUIT SHIELD HIT (SFX)**
                for k,v in ipairs(NPC.getIntersecting(p.x - 15, p.y - 15, p.x + p.width + 30, p.y + p.height + 30)) do
                    if ((p.powerup == 6 and p:mem(0x12E,FIELD_BOOL) and p.mount == 0 and not linkCharacters[p.character]) or (p.mount == 1 and p.mountColor == 2) and enemyfireballs[v.id] and harmtype == HARM_TYPE_VANISH) then
                        if extraSounds.options.toggle.hammerSuitFireShieldHitSFX then
                            SMBSE.Functions.Sound.SFX.Play(169)
                        end
                    end
                end
                
                
                
                
                --**ICE BREAKING**
                if npc.id == 263 and harmtype ~= HARM_TYPE_VANISH then
                    if extraSounds.options.toggle.iceBlockBreakSFX then
                        SMBSE.Functions.Sound.SFX.Play(95)
                    end
                end
                
                
                
                
                
                --**HP COLLECTING**
                if healitems[npc.id] and Colliders.collide(p, npc) then
                    if p.character == CHARACTER_PEACH or p.character == CHARACTER_TOAD or p.character == CHARACTER_LINK or p.character == CHARACTER_KLONOA or p.character == CHARACTER_ROSALINA or p.character == CHARACTER_ULTIMATERINKA or p.character == CHARACTER_STEVE then
                        if p:mem(0x16, FIELD_WORD) <= 2 then
                            if extraSounds.options.toggle.HPCollectSFX then
                                SMBSE.Functions.Sound.SFX.Play(131)
                            end
                        elseif p:mem(0x16, FIELD_WORD) == 3 then
                            if extraSounds.options.toggle.HPCollectSFX then
                                SMBSE.Functions.Sound.SFX.Play(132)
                            end
                        end
                    end
                end
                
                
                
                --**PLAYER SMASHING**
                if allsmallenemies[npc.id] and harmtype == HARM_TYPE_SPINJUMP then
                    SMBSE.Functions.Sound.SFX.Play(36)
                end
                if npc.id >= 751 and harmtype == HARM_TYPE_SPINJUMP then
                    SMBSE.Functions.Sound.SFX.Play(36)
                end
                if allbigenemies[npc.id] and harmtype == HARM_TYPE_SPINJUMP then
                    if not extraSounds.options.classicToggle.revertBigEnemySpinjumpSmashSFXs then
                        SMBSE.Functions.Sound.SFX.Play(125)
                    elseif extraSounds.options.classicToggle.revertBigEnemySpinjumpSmashSFXs then
                        SMBSE.Functions.Sound.SFX.Play(36)
                    end
                end
                
                
                
                
                --**COIN COLLECTING**
                if extraSounds.allCoinNPCIDsTableMapped[npc.id] and Colliders.collide(p, npc) then --Any coin ID that was marked above will play this sound when collected
                    if extraSounds.options.toggle.coinCollectSFX then
                        SMBSE.Functions.Sound.SFX.Play(14)
                    end
                end
                if extraSounds.allRupeeNPCIDsTableMapped[npc.id] and Colliders.collide(p, npc) then --Any coin ID that was marked above will play this sound when collected
                    if extraSounds.options.toggle.rupeeCollectSFX then
                        SMBSE.Functions.Sound.SFX.Play(81)
                    end
                end
                
                
                
                
                --**CHERRY COLLECTING**
                if npc.id == 558 and Colliders.collide(p, npc) then --Cherry sound effect
                    if not extraSounds.options.classicToggle.revertCherrySFXs then
                        if extraSounds.options.toggle.cherryCollectSFX then
                            SMBSE.Functions.Sound.SFX.Play(103)
                        end
                    elseif extraSounds.options.classicToggle.revertCherrySFXs then
                        if extraSounds.options.toggle.cherryCollectSFX then
                            SMBSE.Functions.Sound.SFX.Play(14)
                        end
                    end
                end
                
                
                
                
                --**ICE BLOCKS (THROW BLOCKS)**
                if npc.id == 45 and npc.ai2 < 449 then
                    if extraSounds.options.toggle.brickSmashSFX then
                        SMBSE.Functions.Sound.SFX.Play(4, extraSounds.settings.defaultVolumeCount, 1, extraSounds.options.delay.brickBreak)
                    end
                end
                
                
                
                --**SMW POWER STARS**
                if npc.id == 196 then
                    if extraSounds.options.toggle.starCollectSFX then
                        SMBSE.Functions.Sound.SFX.Play(59)
                    end
                end
                
                
                
                
                --**DRAGON COINS**
                if npc.id == 274 and Colliders.collide(p, npc) then --Dragon coin counter sounds
                    extraSounds.playDragonCoinSFX(npc)
                end
                
                
                
                --**SMB2 ENEMY KILLS**
                for k,v in ipairs(NPC.get({19,20,25,130,131,132,470,471,129,345,346,347,371,372,373,272,350,530,374,247,206})) do --SMB2 Enemies
                    if (v.killFlag ~= 0) and not (v.killFlag == HARM_TYPE_VANISH) then
                        if extraSounds.options.toggle.SMB2EnemyKillSFXs then
                            SMBSE.Functions.Sound.SFX.Play(126)
                        end
                    end
                end
                
                
                
                --**SLIDING COMBO KILLS**
                if not isOverworld then
                    if p:mem(0x3C, FIELD_BOOL) and harmableComboTypes[harmtype] then
                        Audio.sounds[9].muted = true
                        comboMuteTimer = 2
                        Routine.run(extraSounds.comboSoundRoutine)
                    end
                end
                
                
            end
        end
    end
end

--New event stuff
local GM_NEWEVENT = mem(0x00B2D6E8, FIELD_DWORD)
local GM_NEWEVENTDELAY = mem(0x00B2D704, FIELD_DWORD)

--Event stuff
local GM_EVENT = mem(0x00B2C6CC, FIELD_DWORD)
local GM_EVENTNUM = 0x00B2D710

local EVENTS_STRUCT_SIZE = 0x588
local MAX_EVENTS = 255

function extraSounds.getSoundID(eventName)
    local idxNumber
    local name = {}
    for idx=0,MAX_EVENTS-1 do
        table.insert(name, mem(GM_EVENT+(idx*EVENTS_STRUCT_SIZE)+0x04,FIELD_STRING))
    end
    idxNumber = table.ifind(name, eventName)
    if idxNumber == nil then
        return 0
    elseif idxNumber ~= nil then
        return mem(GM_EVENT+((idxNumber-1)*EVENTS_STRUCT_SIZE)+0x02,FIELD_WORD)
    end
end

function extraSounds.onEvent(eventName)
    if eventName then --Fixes vanilla events from not playing extraSounds sounds
        if extraSounds.getSoundID(eventName) >= 1 and not SMBSE.Functions.Tables.mapped.sounds.unusedVanillaSoundIDs[extraSounds.getSoundID(eventName)] then
            SMBSE.Functions.Sound.SFX.Play(extraSounds.getSoundID(eventName))
        end
    end
end

return extraSounds --This ends the library