debug = false

-- Run when exit button is clicked
local function handleButtonPress(button)
    button:Subscribe("PreviewMouseDown", function (_, _)
        Ext.Net.PostMessageToServer("SaveOnExit", "save")
    end)
end

-- Run when escape key is pressed
---@diagnostic disable-next-line: unused-function
local function onEscapeKey()
    local exitButton = Noesis:findNoesisElementByOrderAndOrName(Ext.UI.GetRoot(), {1, 1, 1, 18, 1, 4, 9}, "QuitButton")
    if not exitButton then
        if debug then _P("[WARN] (SaveOnExit) Exit button not found.") end
        return
    end
    handleButtonPress(exitButton)
end

-- Listens for Escape key input while in game
Ext.Events.GameStateChanged:Subscribe(function (gameStateEvent)
    local handler
    if gameStateEvent.ToState == "PrepareRunning" then
        handler = Ext.Events.KeyInput:Subscribe(function (keyInputEvent)
            if keyInputEvent.Event == "KeyUp" and keyInputEvent.Repeat == false and keyInputEvent.Key == "ESCAPE" then
                onEscapeKey()
            end
        end)
    elseif gameStateEvent.ToState == "Menu" and handler ~= nil then
        Ext.Events.KeyInput:Unsubscribe(handler)
    end
end)
