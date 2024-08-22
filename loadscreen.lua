local EP_LIST_PTR = mem(0x00B250FC, FIELD_DWORD)
local episodePath = mem(0x00B2C61C, FIELD_STRING)
local Player = {}

do
    -- The following code makes the loading screen slightly less restricted
    local function exists(path)
        local f = io.open(path,"r")
 
        if f ~= nil then
            f:close()
            return true
        else
            return false
        end
    end
    
    Misc.episodePath = (function()
        return Native.getEpisodePath()
    end)
    
    Misc.episodeName = (function()
        local idx = mem(0x00B2C628, FIELD_WORD) - 1
        if(idx < 0) then
            return "SMBX2"
        end
        return tostring(mem(EP_LIST_PTR + (idx * 0x18), FIELD_STRING))
    end)
    
    local resolvePaths = {
        Misc.episodePath(),
        getSMBXPath().."\\scripts\\",
        getSMBXPath().."\\"
    }
    
    Misc.multiResolveFile = (function(...)
        local t = {...}
        
        --If passed a complete path, just return it as-is (as long as the file exists)
        for _,v in ipairs(t) do
            if string.match(v, "^%a:[\\/]") and io.exists(v) then
                return v
            end
        end

        for _,p in ipairs(resolvePaths) do
            for _,v in ipairs(t) do
                if io.exists(p..v) then
                    return p..v
                end
            end
        end
        return nil
    end)
    
    Misc.resolveFile = (function(path)
        local inScriptPath = getSMBXPath().. "\\scripts\\".. path
        local inEpisodePath = episodePath.. path
 
        return (exists(path) and path) or (exists(inEpisodePath) and inEpisodePath) or (exists(inScriptPath) and inScriptPath) or nil
    end)
 
    Misc.resolveGraphicsFile = Misc.resolveFile -- good enough lol
    
    Player.count = (function()
        return mem(0x00B2595E, FIELD_WORD)
    end)
    
    Player.character = mem(mem(0x00B25A20,FIELD_DWORD) + (0x184 + 0xF0),FIELD_WORD) --Player character
    Player.powerup = mem(mem(0x00B25A20,FIELD_DWORD) + (0x184 + 0x112),FIELD_WORD) --Player powerup
    Player.frame = mem(mem(0x00B25A20,FIELD_DWORD) + (0x184 + 0x114),FIELD_WORD) --Player frame
    Player.direction = mem(mem(0x00B25A20,FIELD_DWORD) + (0x184 + 0x106),FIELD_WORD) --Player frame
    Player.x = mem(mem(0x00B25A20,FIELD_DWORD) + (0x184 + 0xC0),FIELD_DFLOAT) --Player x
    Player.y = mem(mem(0x00B25A20,FIELD_DWORD) + (0x184 + 0xC8),FIELD_DFLOAT) --Player y
    Player.width = mem(mem(0x00B25A20,FIELD_DWORD) + (0x184 + 0xD0),FIELD_DFLOAT) --Player width
    Player.height = mem(mem(0x00B25A20,FIELD_DWORD) + (0x184 + 0xD8),FIELD_DFLOAT) --Player height
    Player.mount = mem(mem(0x00B25A20,FIELD_DWORD) + (0x184 + 0x108),FIELD_WORD) --Player mount
    Player.mountColor = mem(mem(0x00B25A20,FIELD_DWORD) + (0x184 + 0x10A),FIELD_WORD) --Player mount color
    
    -- Make require work better
    local oldRequire = require
 
    function require(path)
        local inScriptPath = getSMBXPath().. "\\scripts\\".. path.. ".lua"
        local inScriptBasePath = getSMBXPath().. "\\scripts\\base\\".. path.. ".lua"
        local inEpisodePath = episodePath.. path.. ".lua"
 
        local path = (exists(inEpisodePath) and inEpisodePath) or (exists(inScriptPath) and inScriptPath) or (exists(inScriptBasePath) and inScriptBasePath)
        assert(path ~= nil,"module '".. path.. "' not found.")
 
        return oldRequire(path)
    end
 
    -- classexpender stuff
    function string.split(s, p, exclude, plain)
        if  exclude == nil  then  exclude = false; end;
        if  plain == nil  then  plain = true; end;
 
        local t = {};
        local i = 0;
    
        if(#s <= 1) then
            return {s};
        end
    
        while true do
            local ls,le = s:find(p, i, plain);  --find next split pattern
            if (ls ~= nil) then
                table.insert(t, string.sub(s, i,le-1));
                i = ls+1;
                if  exclude  then
                    i = le+1;
                end
            else
                table.insert(t, string.sub(s, i));
                break;
            end
        end
        
        return t;
    end
 
    function table.clone(t)
        local rt = {};
        for k,v in pairs(t) do
            rt[k] = v;
        end
        setmetatable(rt, getmetatable(t));
        return rt;
    end
 
    function table.ishuffle(t)
        for i=#t,2,-1 do 
            local j = RNG.randomInt(1,i)
            t[i], t[j] = t[j], t[i]
        end
        return t
    end
 
    function math.clamp(a,mi,ma)
        mi = mi or 0;
        ma = ma or 1;
        return math.min(ma,math.max(mi,a));
    end

    _G.lunatime = require("engine/lunatime")
    _G.Color = require("engine/color")
    _G.RNG = require("rng")
    _G.textplus = require("textplus")
end

package.path = package.path .. ";./scripts/?.lua"

local frameBufferLoadscreenWidth = 800
local frameBufferLoadscreenHeight = 600

-- smasFunctions.camera.centerDimensions doesn't exist yet
local function centerDimensions(value, isWidthOrHeight)
    if value == nil then
        return 0
    else
        if isWidthOrHeight == nil then
            return 0
        end
        local originalWidth = 800
        local originalHeight = 600
        
        local pixelDifferenceWidth = originalWidth / frameBufferLoadscreenWidth
        local pixelDifferenceHeight = originalHeight / frameBufferLoadscreenHeight
        
        local additionalWidth = frameBufferLoadscreenWidth - originalWidth
        local additionalHeight = frameBufferLoadscreenHeight - originalHeight
        
        local extendedWidth = additionalWidth / 2
        local extendedHeight = additionalHeight / 2
        
        if (isWidthOrHeight == "width" or isWidthOrHeight == 1) then
            return value + extendedWidth
        elseif (isWidthOrHeight == "height" or isWidthOrHeight == 2) then
            return value + extendedHeight
        else
            return 0
        end
    end
end

-- Local non-image variables
local loadScreenTicks = 0

local blackScreenFadeOutOpacity = 1
local blackScreenFadeOutAnimTimer = 0
local blackScreenFadeOutTime = 42

local loadIconFrameTimer = 0
local loadIconFrames = 4
local loadIconFrameSpeed = 5.8

local loadScreenLoadingFont = textplus.loadFont("fonts/sonicMania-bigFont.ini")
local loadScreenMainFont = textplus.loadFont("fonts/verdana.ini")
local loadScreenFadeInOpacity = 0

-- Local image variables
local loadIcon = Graphics.loadImage("loadscreen-loadIcon.png")

-- "Did you know?" stuff
local didYouKnowTexts = {
    "You can press 'down' and 'drop item' together to switch<break>between Mario and Spencerly anytime.",
    "Spencerly can punch enemies in one swoop! When walking,<break>press 'alt-run' to punch from a small distance.",
}
local didYouKnowSelection = RNG.randomInt(1, #didYouKnowTexts)

local function loadConfigTextFile()
    -- Open the config txt file for reading
    local file = io.open(Misc.episodePath().."loadscreen-config.txt", "r")

    -- Read every line in the txt file
    local fileLines = {}
    local fileLineCount = 0

    for line in file:lines() do
        fileLineCount = fileLineCount + 1
        fileLines[fileLineCount] = line
    end

    -- Go ahead and close the file
    file:close()

    -- Now go ahead and set the framebuffer size variables
    frameBufferLoadscreenWidth = tonumber(fileLines[10])
    frameBufferLoadscreenHeight = tonumber(fileLines[13])
end

loadConfigTextFile()

function onDraw()
    -- Get total tick time
    loadScreenTicks = loadScreenTicks + 1

    -- Fade out
    if blackScreenFadeOutOpacity > 0 then
        blackScreenFadeOutAnimTimer = blackScreenFadeOutAnimTimer + 1
        blackScreenFadeOutOpacity = math.min(1, blackScreenFadeOutAnimTimer / blackScreenFadeOutTime)
    end

    -- Draw load icon
    loadIconFrameTimer = math.floor(loadScreenTicks / loadIconFrameSpeed) % loadIconFrames
    Graphics.drawImage(loadIcon, frameBufferLoadscreenWidth - 128, frameBufferLoadscreenHeight - 65, 1, loadIconFrameTimer * 64, 128, 64, blackScreenFadeOutOpacity)

    -- Loading text
    textplus.print{
        x = 20,
        y = 20,
        text = "LOADING",
        font = loadScreenLoadingFont,
        xscale = 2,
        yscale = 2,
        color = Color.white..blackScreenFadeOutOpacity,
    }
    textplus.print{
        x = 218,
        y = 30,
        text = "...",
        font = loadScreenMainFont,
        xscale = 3,
        yscale = 3,
        color = Color.white..blackScreenFadeOutOpacity,
    }

    -- "Did you know?" Message
    textplus.print{
        x = 20,
        y = frameBufferLoadscreenHeight - 70,
        text = didYouKnowTexts[didYouKnowSelection],
        font = loadScreenMainFont,
        xscale = 2,
        yscale = 2,
        color = Color.white..blackScreenFadeOutOpacity,
    }
end