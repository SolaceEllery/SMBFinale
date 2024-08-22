function onEvent(eventName)
    if eventName == "Boss Start" then
        Audio.MusicChange(0, "_OST/Level Music/Boss Battle.ogg|m1;c2;r2")
    end
    if eventName == "Boss End" then
        Audio.MusicChange(0, "_OST/Level Music/Athletic.ogg|m1;c2;r2")
    end
end