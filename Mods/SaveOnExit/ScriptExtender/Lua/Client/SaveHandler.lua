-- Run when exit button is clicked
local function handleButtonPress(button)
    button:Subscribe("PreviewMouseDown", function (a, b)
        _P("Saving game...")
        Ext.Net.PostMessageToServer("SaveOnExit", "save")
    end)
end

-- Run when escape key is pressed
---@diagnostic disable-next-line: unused-function
local function onEscapeKey()
    Ext.Timer.WaitFor(200, function ()
        local exitButton = Noesis:findNoesisElementByName(Ext.UI.GetRoot(), "QuitButton")
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
