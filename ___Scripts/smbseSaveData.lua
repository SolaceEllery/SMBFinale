local smbseSaveData = {}

SaveData.SMBSE = SaveData.SMBSE or {}

SaveData.SMBSE.Progression = SaveData.SMBSE.Progression or {}
SaveData.SMBSE.Audio = SaveData.SMBSE.Audio or {}

SaveData.SMBSE.Hud = SaveData.SMBSE.Hud or {}
SaveData.SMBSE.Hud.Count = SaveData.SMBSE.Hud.Count or {}
SaveData.SMBSE.Hud.HP = SaveData.SMBSE.Hud.HP or {}

SaveData.SMBSE.Settings = SaveData.SMBSE.Settings or {}

-- [---------------]
-- |SAVEDATA VALUES|
-- [---------------]

-- [-- PROGRESSION --]

--[[
    Is the opening complete? Usually true after the opening has already been completed.
]]
if SaveData.SMBSE.Progression.OpeningComplete == nil then
    SaveData.SMBSE.Progression.OpeningComplete = false
end

-- [-- HUD --]

--[[
    The coin count for the episode.

    SaveData.SMBSE.Hud.Count.CoinClassic = The coin count that, if over 99, will give the player an extra life, and 1 heart refill if a heart is empty (Only 1 heart refill will happen if lives are disabled). This coin count will reset to 0 if over 100
    SaveData.SMBSE.Hud.Count.CoinModern = The coin count which can go over 99, and is used for the shop. The max coin count overall on this variable is 999999 
]]
if SaveData.SMBSE.Hud.Count.CoinModern == nil then
    SaveData.SMBSE.Hud.Count.CoinModern = 0
end
if SaveData.SMBSE.Hud.Count.CoinClassic == nil then
    SaveData.SMBSE.Hud.Count.CoinClassic = 0
end

--[[
    The life count for the episode.
]]
if SaveData.SMBSE.Hud.Count.Lives == nil then
    SaveData.SMBSE.Hud.Count.Lives = 5
end

--[[
    The HP counters for the episode.
]]
if SaveData.SMBSE.Hud.HP.Mario == nil then
    SaveData.SMBSE.Hud.HP.Mario = 3
end
if SaveData.SMBSE.Hud.HP.Spencer == nil then
    SaveData.SMBSE.Hud.HP.Spencer = 3
end

-- [-- SETTINGS --]

--[[
    Life count for both Mario and Spencerly. If below 0, a game over animation will play (Unless lives are disabled). The max life count is 1110 (a.k.a. 3 crowns in NSMB2 and SM3DW)
]]
if SaveData.SMBSE.Settings.EnableLives == nil then
    SaveData.SMBSE.Settings.EnableLives = true
end

--[[
    By default, normal levels start with a iris out transition. If this is disabled, the level fades in without any pauses.
]]
if SaveData.SMBSE.Settings.EnableLevelStartTransition == nil then
    SaveData.SMBSE.Settings.EnableLevelStartTransition = true
end

--[[
    The resolution set for the game. There are 5 options the game can use:
    
    1. Fullscreen (800x600, the original SMBX game size for nostalgia-related experiences, as well as for monitors that display only 4:3 resolutions)
    2. Steam Deck (960x600, for Steam Deck users who play the game on Wine or Windows)
    3. Widescreen (1066x600, the default setting for this game, and also the most common resolution on monitors, TV Shows/Movies, video games, etc.)
    4. UltraWide (1424x600, for wide monitors bigger than the 16:9 widescreen usual, which also is a movie resolution format as well)
    5. SuperWide (2133x600, for even wider monitors i.e. curved monitors being sold everywhere)
    6. Custom width set by the user (Minimum is 800, and maximum is 2200)
]]
if SaveData.SMBSE.Settings.resolution == nil then
    SaveData.SMBSE.Settings.resolution = SMBSE.Resolutions.Types.Widescreen
end

--[[
    The custom width for the resolution settings menu. If set to specify a custom width, this variable is used to remember the custom width.
]]
if SaveData.SMBSE.Settings.ResolutionCustomWidth == nil then
    SaveData.SMBSE.Settings.ResolutionCustomWidth = 800
end

-- [------------------]
-- |SAVEDATA FUNCTIONS|
-- [------------------]

local indicatorList = {
    [1] = "Root",
    [2] = "Progression",
    [3] = "Audio",
    [4] = "Hud",
    [5] = "Hud - HP",
    [6] = "Settings",
}

function smbseSaveData.Read(indicatorType, variableToUse)
    -- Check if nil first, then return nil if so
    if indicatorList[indicatorType] == nil then
        return
    -- SaveData: Root
    elseif indicatorList[indicatorType] == "Root" then
        return SaveData.SMBSE[variableToUse]
    -- SaveData: Progression
    elseif indicatorList[indicatorType] == "Progression" then
        return SaveData.SMBSE.Progression[variableToUse]
    -- SaveData: Audio
    elseif indicatorList[indicatorType] == "Audio" then
        return SaveData.SMBSE.Audio[variableToUse]
    -- SaveData: Hud
    elseif indicatorList[indicatorType] == "Hud" then
        return SaveData.SMBSE.Hud[variableToUse]
    -- SaveData: Hud - HP
    elseif indicatorList[indicatorType] == "Hud - HP" then
        return SaveData.SMBSE.Hud.HP[variableToUse]
    -- SaveData: Settings
    elseif indicatorList[indicatorType] == "Settings" then
        return SaveData.SMBSE.Settings[variableToUse]
    -- Anything else below 1 or above the max count is nil
    else
        return
    end
end

function smbseSaveData.Write(indicatorType, variableToUse, valueToWrite)
    -- Check if nil first, then return nil if so
    if indicatorList[indicatorType] == nil then
        return
    -- SaveData: Root
    elseif indicatorList[indicatorType] == "Root" then
        SaveData.SMBSE[variableToUse] = valueToWrite
    -- SaveData: Progression
    elseif indicatorList[indicatorType] == "Progression" then
        SaveData.SMBSE.Progression[variableToUse] = valueToWrite
    -- SaveData: Audio
    elseif indicatorList[indicatorType] == "Audio" then
        SaveData.SMBSE.Audio[variableToUse] = valueToWrite
    -- SaveData: Hud
    elseif indicatorList[indicatorType] == "Hud" then
        SaveData.SMBSE.Hud[variableToUse] = valueToWrite
    -- SaveData: Hud - HP
    elseif indicatorList[indicatorType] == "Hud - HP" then
        SaveData.SMBSE.Hud.HP[variableToUse] = valueToWrite
    -- SaveData: Settings
    elseif indicatorList[indicatorType] == "Settings" then
        SaveData.SMBSE.Settings[variableToUse] = valueToWrite
    -- Anything else below 1 or above the max count is nil
    else
        return
    end
end

return smbseSaveData