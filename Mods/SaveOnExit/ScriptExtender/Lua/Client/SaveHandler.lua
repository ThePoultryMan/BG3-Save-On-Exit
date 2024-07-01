-- Run when exit button is clicked
local function handleButtonPress(button)
    button:Subscribe("PreviewMouseDown", function (_, _)
        Ext.Net.PostMessageToServer("SaveOnExit", "save")
    end)
end

-- Run when escape key is pressed
---@diagnostic disable-next-line: unused-function
local function onEscapeKey()
    Ext.Timer.WaitFor(200, function ()
        local exitButton = Noesis:findNoesisElementByOrderAndOrName(Ext.UI.GetRoot(), {1, 1, 1, 18, 1, 4, 9}, "QuitButton")
        if not exitButton then
            _P("[WARN] (SaveOnExit) Exit button not found.")
            return
        end
        handleButtonPress(exitButton)
    end)
end

-- Listens for Escape key input
Ext.Events.KeyInput:Subscribe(function (event)
    if event.Event == "KeyUp" and event.Repeat == false and event.Key == "ESCAPE" then
        onEscapeKey()
    end
end)
