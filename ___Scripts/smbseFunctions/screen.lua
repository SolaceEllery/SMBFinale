local smbseFunctionsScreen = {}

function smbseFunctionsScreen.setResolution(width, height)
    -- Make sure it changes as soon as the game actually starta
    if lunatime.drawtick() >= 0 then
        -- Set the framebuffer
        Graphics.setMainFramebufferSize(width, height)

        -- Set the camera (Required to extend/reduce the level dimensions)
        camera.width = width
        camera.height = height

        -- Set the global variables
        SMBSE.Resolutions.Screen.Width = width
        SMBSE.Resolutions.Screen.Height = height

        -- Return true
        return true
    else
        -- Return false, since 
        return false
    end
end

return smbseFunctionsScreen