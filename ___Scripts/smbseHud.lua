local smbseHud = {}

local textplus = require("textplus")

-- Is the hud enabled?
smbseHud.enabled = true

-- Graphics for the Hud
smbseHud.hudGraphics = {}
smbseHud.hudGraphics.heads = {
    mario = Graphics.loadImageResolved(SMBSE.Directories.Scripts.."smbseHud/hud-mario-head.png"),
    spencerly = Graphics.loadImageResolved(SMBSE.Directories.Scripts.."smbseHud/hud-spencerly-head.png")
}

-- Hud settings
smbseHud.hudOpacity = 1
smbseHud.hudPriority = 5

-- Fonts used in the Hud
smbseHud.hudFonts = {}
smbseHud.hudFonts.pressStart = textplus.loadFont(SMBSE.Directories.Fonts.."press-start.ini")
smbseHud.hudFonts.verdana = textplus.loadFont(SMBSE.Directories.Fonts.."verdana.ini")
smbseHud.hudFonts.segoeUI = textplus.loadFont(SMBSE.Directories.Fonts.."segoeui.ini")
smbseHud.hudFonts.nsmbWii = textplus.loadFont(SMBSE.Directories.Fonts.."nsmbwii-font.ini")
smbseHud.hudFonts.smbx13hud = textplus.loadFont(SMBSE.Directories.Fonts.."1.ini")

-- Miscellaneous options
smbseHud.hurryUpTimer = {}
smbseHud.hurryUpTimer.flashDelay = 1.5

local timerLessThan100Timer = 0

function smbseHud.onInitAPI()
    registerEvent(smbseHud, "onDraw")
end

function smbseHud.playerHudActive(isActive)
    if isActive then
        return smbseHud.hudOpacity
    else
        return smbseHud.hudOpacity - 0.25
    end
end

function smbseHud.drawHearts()
    local heartStartingXPos = 62
    local heartStartingYPos = 38
    local heartWidth = 28
    local heartHeight = 36

    -- Mario
    for i = 1,3 do
        Graphics.drawImageWP(Graphics.sprites.hardcoded["36-1"].img, heartStartingXPos + (i * heartWidth), heartStartingYPos, smbseHud.hudOpacity, smbseHud.hudPriority)
    end
    -- Spencerly
    for i = 1,2 do
        Graphics.drawImageWP(Graphics.sprites.hardcoded["36-1"].img, heartStartingXPos + (i * heartWidth), heartStartingYPos + heartHeight, smbseHud.hudOpacity, smbseHud.hudPriority)
    end
end

function smbseHud.drawLives()
    local livesText = "×"..tostring(SaveData.smbseHud.LifeCount)
    local livesTextCenter = 0
    local livesTextCount = #livesText

    if livesTextCount == 3 then
        livesTextCenter = 24
    elseif livesTextCount == 4 then
        livesTextCenter = 16
    elseif livesTextCount >= 5 then
        livesTextCenter = 10
    else
        livesTextCenter = 10
    end

    -- Lives
    textplus.print{
        x = 50 + livesTextCenter,
        y = 100,
        text = livesText,
        font = smbseHud.hudFonts.smbx13hud,
        xscale = 2,
        yscale = 2,
    }
end

function smbseHud.drawCoinCounters()
    local coinCenterX = camera.width / 2 - 50

    -- Coins (Modern & Classic)
    textplus.print{
        x = coinCenterX,
        y = 26,
        text = SMBSE.Symbols.MoneyBag.."×"..tostring(SaveData.smbseHud.CoinCountModern),
        font = smbseHud.hudFonts.smbx13hud,
        xscale = 2,
        yscale = 2,
        color = Color.yellow,
    }
    textplus.print{
        x = coinCenterX,
        y = 42,
        text = SMBSE.Symbols.Coin.."×"..tostring(SaveData.smbseHud.CoinCountClassic),
        font = smbseHud.hudFonts.smbx13hud,
        xscale = 2,
        yscale = 2,
    }
end

function smbseHud.drawTimer()
    --Timer
    if Timer.isActive() then
        -- If less than 100 seconds, turn the timer color into red
        local timeColor
        if Timer.getValue() > 100 then
            timerLessThan100Timer = 0
            timeColor = Color.white
        else
            if smbseHud.hurryUpTimer.flashDelay > 0 then
                timerLessThan100Timer = timerLessThan100Timer + 1
                if timerLessThan100Timer < lunatime.toTicks(smbseHud.hurryUpTimer.flashDelay) then
                    timeColor = Color.red
                elseif timerLessThan100Timer >= lunatime.toTicks(smbseHud.hurryUpTimer.flashDelay) then
                    timeColor = Color.darkred
                end
                if timerLessThan100Timer >= lunatime.toTicks(smbseHud.hurryUpTimer.flashDelay * 2) then
                    timerLessThan100Timer = 0
                end
            else
                timeColor = Color.red
            end
        end

        textplus.print{
            x = camera.width - 134,
            y = 26,
            text = SMBSE.Symbols.Clock.."×"..tostring(Timer.getValue()),
            font = smbseHud.hudFonts.smbx13hud,
            xscale = 2,
            yscale = 2,
            color = timeColor,
        }
    end
end

local function drawReserveItem(p, corner, opacityItem)
    local reserveBoxX = 40

    if p.idx == 1 then
        reserveBoxX = 40
    else
        reserveBoxX = 100
    end

    Graphics.drawImageWP(Graphics.sprites.npc[p.reservePowerup].img, reserveBoxX + corner, camera.height - 80 + corner, 0, 0, NPC.config[p.reservePowerup].width, NPC.config[p.reservePowerup].height, smbseHud.hudOpacity - opacityItem, smbseHud.hudPriority)
end

function smbseHud.drawReserve()
    local reserveBoxItemCorner = 12
    local opacityForReserveBox = 0.25
    local opacityForReserveItem = 0.30

    Graphics.drawImageWP(Graphics.sprites.hardcoded["48-0"].img, 40, camera.height - 80, smbseHud.hudOpacity - opacityForReserveBox, smbseHud.hudPriority)

    if player.reservePowerup >= 1 then
        drawReserveItem(player, reserveBoxItemCorner, opacityForReserveItem)
    end

    if Player.count() >= 2 then
        Graphics.drawImageWP(Graphics.sprites.hardcoded["48-1"].img, 100, camera.height - 80, smbseHud.hudOpacity - opacityForReserveBox, smbseHud.hudPriority)

        if player2.reservePowerup >= 1 then
            drawReserveItem(player2, reserveBoxItemCorner, opacityForReserveItem)
        end
    end
end

function smbseHud.drawHud(camIndex, priority, isSplit)
    Graphics.drawImageWP(smbseHud.hudGraphics.heads.mario, 40, 40, smbseHud.playerHudActive((player.character == 1)), smbseHud.hudPriority)
    Graphics.drawImageWP(smbseHud.hudGraphics.heads.spencerly, 40, 70, smbseHud.playerHudActive((player.character == 2)), smbseHud.hudPriority)

    -- Draw everything if needed
    smbseHud.drawHearts()
    smbseHud.drawLives()
    smbseHud.drawCoinCounters()
    smbseHud.drawTimer()
    smbseHud.drawReserve()
end

function smbseHud.onDraw()
    if smbseHud.enabled then
        Graphics.overrideHUD(smbseHud.drawHud)
    end
end

return smbseHud