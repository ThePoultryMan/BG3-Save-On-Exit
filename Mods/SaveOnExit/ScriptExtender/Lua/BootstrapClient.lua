-- Adapted from https://github.com/AtilioA/BG3-MCM/blob/eab5994/Mod%20Configuration%20Menu/Mods/BG3MCM/ScriptExtender/Lua/Client/Helpers/Noesis.lua#L4
local function getQuitButton()
    if not Ext.UI.GetRoot() then
        return nil
    end
end

-- Run when exit button is clicked
local function handleButtonPress(button)
    button:Subscribe("PreviewMouseDown", function (a, b)
        _P("Saving game...")
    end)
end

-- Run when escape key is pressed
---@diagnostic disable-next-line: unused-function
local function onEscapeKey()
    Ext.Timer.WaitFor(200, function ()
        local exitButton = getQuitButton()
        if not exitButton then
            _P("Exit button not found")
            return
        end
        handleButtonPress(exitButton)
    end)
end

-- Listens for Escape key input
Ext.Events.KeyInput:Subscribe(function (event)
    if event.Event == "KeyUp" and event.Repeat == false and event.Key == "ESCAPE" then
        _P("Escape key pressed")
        onEscapeKey()
    end
end)
