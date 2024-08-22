local smbseFunctionsSound = {}

-- If enabled, EventManager will call certain events
local enableLunaLuaEvents = false

-- Resolve path root directories, used for acquiring where the music & SFXs are located at
smbseFunctionsSound.ResolvePaths = {}
smbseFunctionsSound.ResolvePaths.Root = {}

smbseFunctionsSound.ResolvePaths.Root.Main = "___Sounds"
smbseFunctionsSound.ResolvePaths.Root.Music = "__Music"
smbseFunctionsSound.ResolvePaths.Root.SFX = "_Sound Effects"

-- Resolve paths for both music and SFXs
smbseFunctionsSound.ResolvePaths.List = {
    Misc.levelPath(),
    Misc.episodePath(),
    getSMBXPath().."\\sound\\",
    getSMBXPath().."\\",
    Misc.episodePath().."\\"..smbseFunctionsSound.ResolvePaths.Root.Main.."\\",
    Misc.episodePath().."\\"..smbseFunctionsSound.ResolvePaths.Root.Main.."\\"..smbseFunctionsSound.ResolvePaths.Root.Music.."\\",
    Misc.episodePath().."\\"..smbseFunctionsSound.ResolvePaths.Root.Main.."\\"..smbseFunctionsSound.ResolvePaths.Root.SFX.."\\",
}

-- Music/SFX function organizing
smbseFunctionsSound.Music = {}
smbseFunctionsSound.SFX = {}

-- Used for storing music before muting/after unmuting music
smbseFunctionsSound.Music.InfoStorage = {}
for i = 1,21 do
    smbseFunctionsSound.Music.InfoStorage[i] = Section(i - 1).music
end

-- Boolean for knowing if the music is muted or not
smbseFunctionsSound.Music.IsMuted = {}
for i = 1,21 do
    smbseFunctionsSound.Music.IsMuted[i] = false
end

-- Duplicate of Misc.multiResolveFile, except it also has support for the episode music & SFX folders
function smbseFunctionsSound.MultiResolveFile(...)
	local t = {...}
	
	--If passed a complete path, just return it as-is (as long as the file exists)
	for _,v in ipairs(t) do
		if string.match(v, "^%a:[\\/]") and io.exists(v) then
			return v
		end
	end
    for _,p in ipairs(smbseFunctionsSound.ResolvePaths.List) do
        for _,v in ipairs(t) do
            if io.exists(p..v) then
                return p..v
            end
        end
    end
	return nil
end

local validSFXFiles = {".ogg", ".mp3", ".wav", ".voc", ".flac", ".spc"}

-- table.map can be used instead, but if this library is loaded at low-level, this is needed instead
local validSFXFilesMap = {};
for _,v in ipairs(validSFXFiles) do
    validSFXFilesMap[v] = true;
end

-- Resolves a sound file like Misc.resolveSoundFile, but also includes additional episode directories
function smbseFunctionsSound.SFX.Resolve(path)
    local p,e = string.match(string.lower(path), "^(.+)(%..+)$")
    local t = {}
    local idx = 1
    local typeslist = validSFXFiles
    if e and validSFXFilesMap[e] then
        --Re-arrange type list to prioritise type that was provided to the resolve function
        if e ~= validSFXFiles[1] then
            typeslist = { e }
            for _,v in ipairs(validSFXFiles) do
                if v ~= e then
                    table.insert(typeslist, v)
                end
            end
        end
        path = p
    end
    for _,typ in ipairs(typeslist) do
        t[idx] = path..typ
        t[idx+#typeslist] = "sound/"..path..typ
        t[idx+2*#typeslist] = "sound/extended/"..path..typ
        idx = idx+1
    end
    
    return smbseFunctionsSound.MultiResolveFile(table.unpack(t))
end

-- Resolves a music file
function smbseFunctionsSound.Music.Resolve(path)
    local finalFilepathOutput
    local splitPath, splitArgs = string.find(path, "|")
    local pathWithNoArguments
    local pathWithSlashesResolved = string.gsub(path, "/", "\\")
 
    if splitPath ~= nil then
        pathWithNoArguments = path:sub(1, splitPath - 1)
    else
        pathWithNoArguments = path
    end
 
    for number,folder in ipairs(smbseFunctionsSound.ResolvePaths.List) do
        local dirToFileNoArgs = folder..pathWithNoArguments
        local dirToFileNoArgsCheck = string.gsub(dirToFileNoArgs, "/", "\\")
        if io.exists(dirToFileNoArgsCheck) then
            finalFilepathOutput = folder..pathWithSlashesResolved
        end
    end
 
    return finalFilepathOutput
end

local function noExtraSoundsPlaySFX(name, volume, loops, delay, pan)
    if name == 0 or name == nil then
        -- No sound was specified, so end the function
        return
    elseif SMBSE.Functions.Tables.mapped.sounds.vanillaSoundIDs[name] then
        SFX.play({sound = Audio.sounds[name].sfx, volume = volume, loops = loops, delay = delay, pan = pan})
    elseif type(name) == "string" then
        local file = smbseFunctionsSound.SFX.Resolve(name) --Common sound directories, see above for the entire list
        SFX.play({sound = file, volume = volume, loops = loops, delay = delay, pan = pan}) --Play it afterward
    end
end

-- Plays a SFX, including support for "extraSounds" and additional directories
function smbseFunctionsSound.SFX.Play(name, volume, loops, delay, pan)
    if name ~= nil then
        SMBSE.Functions.SendToConsole("Playing sound '"..name.."'...")
    else
        SMBSE.Functions.SendToConsole("Sound cannot be played, because no sound was specified.")
    end

    -- Volume, loops, delay, pan
    if extraSounds == nil then
        if volume == nil then
            volume = 1
        end
        if loops == nil then
            loops = 1
        end
        if delay == nil then
            delay = 4
        end
        if pan == nil then
            pan = 0
        end
    else
        if volume == nil then
            volume = extraSounds.settings.defaultVolumeCount or 1
        end
        if loops == nil then
            loops = extraSounds.settings.defaultLoopCount or 1
        end
        if delay == nil then
            delay = extraSounds.settings.defaultDelayCount or 4
        end
        if pan == nil then
            pan = extraSounds.settings.defaultPanValue or 0
        end
    end

    local eventObj = {cancelled = false}
    EventManager.callEvent("onPlaySFX_SMBSE", eventObj, name, volume, loops, delay, pan)

    if not eventObj.cancelled then
        if extraSounds ~= nil and extraSounds.settings.enabled then
            if type(name) == "number" then
                if not SMBSE.Functions.Tables.mapped.sounds.unusedVanillaSoundIDs[name] and extraSounds.sounds[name] then
                    if not extraSounds.sounds[name].muted then
                        SFX.play({sound = extraSounds.sounds[name].sfx, volume = volume, loops = loops, delay = delay, pan = pan})
                    end
                elseif SMBSE.Functions.Tables.mapped.sounds.unusedVanillaSoundIDs[name] then
                    SFX.play({sound = Audio.sounds[name].sfx, volume = volume, loops = loops, delay = delay, pan = pan})
                elseif name <= 0 then
                    -- No sound was specified, so end the function
                    return
                end
            elseif type(name) == "string" then
                local file = smbseFunctionsSound.SFX.Resolve(name) --Common sound directories, see above for the entire list
                SFX.play({sound = file, volume = volume, loops = loops, delay = delay, pan = pan}) --Play it afterward
            end
        elseif (extraSounds ~= nil and not extraSounds.settings.enabled) or (extraSounds == nil) then
            noExtraSoundsPlaySFX(name, volume, loops, delay, pan)
        end
        EventManager.callEvent("onPostPlaySFX_SMBSE", name, volume, loops, delay, pan)
    end
end

-- This is true if 4 channels (2 tracks) exist, otherwise it's false
function smbseFunctionsSound.Music.HasTwoStereoTracks()
    if Audio.MusicGetInstChannelCount() == 2 then
        return true
    else
        return false
    end
end

-- Local function that mutes music playing on a specified/all sections
local function handleMuteUnmuteMusic(sectionID, isMuting)
    if sectionID >= 22 then
        error("Invalid section ID for 'handleMuteUnmuteMusic'")
        return
    end

    -- Get the true section ID, as LunaLua indexes section IDs starting at 0
    local actualSectionID = sectionID - 1

    -- Now let's check for valid music info storage values. If anything is nonexistent, muting/unmuting will not happen for what is nil.
    local infoStorageValid = {}
    for i = 1,21 do
        infoStorageValid[i] = true
        if smbseFunctionsSound.Music.InfoStorage[i] == nil then
            infoStorageValid[i] = false
        else
            infoStorageValid[i] = true
        end
    end

    if isMuting then
        if sectionID <= 0 then
            for i = 0,20 do
                if infoStorageValid[i + 1] and not smbseFunctionsSound.Music.IsMuted[i + 1] then
                    smbseFunctionsSound.Music.InfoStorage[i + 1] = Section(i).music
                    Audio.MusicChange(i, 0)
                    smbseFunctionsSound.Music.IsMuted[i + 1] = true
                end
            end
        else
            if infoStorageValid[i + 1] and not smbseFunctionsSound.Music.IsMuted[i + 1] then
                smbseFunctionsSound.Music.InfoStorage[sectionID] = Section(actualSectionID).music
                Audio.MusicChange(actualSectionID, 0)
                smbseFunctionsSound.Music.IsMuted[sectionID] = true
            end
        end
    else
        if sectionID <= 0 then
            for i = 0,20 do
                if infoStorageValid[i + 1] and smbseFunctionsSound.Music.IsMuted[i + 1] then
                    Section(i).music = smbseFunctionsSound.Music.InfoStorage[i + 1]
                    smbseFunctionsSound.Music.IsMuted[i + 1] = false
                end
            end
        else
            if infoStorageValid[sectionID] and smbseFunctionsSound.Music.IsMuted[sectionID] then
                Section(actualSectionID).music = smbseFunctionsSound.Music.InfoStorage[sectionID]
                smbseFunctionsSound.Music.IsMuted[sectionID] = false
            end
        end
    end
end

-- Mutes music on a specified/all sections that are currently playing music.
function smbseFunctionsSound.Music.Mute(sectionID)
    if sectionID == nil or sectionID <= 0 and sectionID >= 22 then
        handleMuteUnmuteMusic(-1, true)
    else
        handleMuteUnmuteMusic(sectionID, true)
    end
end

-- Unmutes music on a specified/all sections that are muted.
function smbseFunctionsSound.Music.Unmute(sectionID)
    if sectionID == nil or sectionID <= 0 and sectionID >= 22 then
        handleMuteUnmuteMusic(-1, false)
    else
        handleMuteUnmuteMusic(sectionID, false)
    end
end

-- Is the specified section's music muted? If the section is 0 or below, it checks to see if all sections are muted.
function smbseFunctionsSound.Music.Muted(sectionID)
    if sectionID <= 0 then
        local allMuted = false
        for i = 1,21 do
            if smbseFunctionsSound.Music.IsMuted[i] then
                allMuted = true
            end
        end
        return allMuted
    else
        if smbseFunctionsSound.Music.IsMuted[sectionID] then
            return true
        else
            return false
        end
    end
end

return smbseFunctionsSound