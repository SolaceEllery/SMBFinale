function onEvent(eventName)
    if eventName == "Boss Start" then
        Sound.changeMusic("_OST/Super Mario Bros Spencer/Boss Battle.ogg|m1;c2;r2", 1)
    end
    if eventName == "Boss End" then
        Sound.changeMusic("_OST/Super Mario Bros Spencer/Another World.ogg|m1;c2;r2", 1)
    end
end