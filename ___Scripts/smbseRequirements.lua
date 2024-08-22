local smbseRequirements = {}

function smbseRequirements.onInitAPI()
    registerEvent(smbseRequirements, "onStart")
    registerEvent(smbseRequirements, "onDraw")
    registerEvent(smbseRequirements, "onTick")
end

-- [---------------------]
-- |REQUIREMENT FUNCTIONS|
-- [---------------------]

function smbseRequirements.SetResolution()
    -- Fullscreen
    if SaveData.SMBSE.Settings.resolution == SMBSE.Resolutions.Types.Fullscreen then
        SMBSE.Functions.Screen.setResolution(800, 600)
    -- Steam Deck
    elseif SaveData.SMBSE.Settings.resolution == SMBSE.Resolutions.Types.SteamDeck then
        SMBSE.Functions.Screen.setResolution(960, 600)
    -- Widescreen
    elseif SaveData.SMBSE.Settings.resolution == SMBSE.Resolutions.Types.Widescreen then
        SMBSE.Functions.Screen.setResolution(1066, 600)
    -- UltraWide
    elseif SaveData.SMBSE.Settings.resolution == SMBSE.Resolutions.Types.UltraWide then
        SMBSE.Functions.Screen.setResolution(1424, 600)
    -- SuperWide
    elseif SaveData.SMBSE.Settings.resolution == SMBSE.Resolutions.Types.SuperWide then
        SMBSE.Functions.Screen.setResolution(2133, 600)
    -- Custom width by the user
    elseif SaveData.SMBSE.Settings.resolution == SMBSE.Resolutions.Types.CustomWidth then
        SMBSE.Functions.Screen.setResolution(SaveData.SMBSE.Settings.ResolutionCustomWidth, 600)
    end
end

-- [------------------]
-- |REQUIREMENT EVENTS|
-- [------------------]

function smbseRequirements.onStart()
    -- If anything needs to be done on the VERY first official tick of a level, then write things down below
    if lunatime.drawtick() == 0 and SMBSE.Functions.Tables.mapped.levels.allLevels[Level.filename()] then
        -- Get SMBSE's levels, and then start a transition if entering one of them
        if SaveData.SMBSE.Settings.EnableLevelStartTransition then
            SMBSE.Transitions.startTransition(1)
        else
            SMBSE.Transitions.startTransition(2)
        end

        -- Set the resolution for the game
        smbseRequirements.SetResolution()
    end
end

-- Min/max resolution custom width limits
function smbseRequirements.onDraw()
    -- Prevent going larger than the maximum width value for custom width settings
    if SaveData.SMBSE.Settings.ResolutionCustomWidth >= SMBSE.Resolutions.Counters.MaximumWidth then
        SaveData.SMBSE.Settings.ResolutionCustomWidth = SMBSE.Resolutions.Counters.MaximumWidth
    end
    -- Prevent going smaller than the minimum width value for custom width settings
    if SaveData.SMBSE.Settings.ResolutionCustomWidth <= SMBSE.Resolutions.Counters.MinimumWidth then
        SaveData.SMBSE.Settings.ResolutionCustomWidth = SMBSE.Resolutions.Counters.MinimumWidth
    end
end

-- Reserve replacement events
function smbseRequirements.onTick()
    for _,p in ipairs(Player.get()) do
        if p:mem(0x130, FIELD_BOOL) and p.keys.dropItem and p.reservePowerup >= 1 then
            SMBSE.Functions.Player.dropReserve(p)
        end
    end
end

-- Thing to update the resolution size before exiting to the loadscreen
function smbseRequirements.onExit()
    local frameBufferWidth, frameBufferHeight = Graphics.getMainFramebufferSize()
    -- Write current framebuffer values to a txt file, for the loadscreen to read
    SMBSE.Functions.File.write.line("loadscreen-config.txt", 10, tostring(frameBufferWidth))
    SMBSE.Functions.File.write.line("loadscreen-config.txt", 13, tostring(frameBufferHeight))
end

return smbseRequirements