Noesis = {}

-- From https://github.com/AtilioA/BG3-MCM/blob/eab5994/Mod%20Configuration%20Menu/Mods/BG3MCM/ScriptExtender/Lua/Client/Helpers/Noesis.lua#L4
function Noesis:findNoesisElementByName(element, name)
    if not element then
        return nil
    end

    if element:GetProperty("Name") == name then
        return element
    end

    for i = 1, element.VisualChildrenCount do
        local foundElement = self:findNoesisElementByName(element:VisualChild(i), name)
        if foundElement then
            return foundElement
        end
    end

    return nil
end

-- Attempts to find specified Noesis element from a set of integers that explain how to navigate the UI tree.
-- If this fails, then it attempts to find the element with the recursive Noesis:findNoesisElementByName function.
function Noesis:findNoesisElementByOrderAndOrName(root, order, name)
    local currentElement = root
    for i = 1, #order do
        if currentElement.VisualChildrenCount >= order[i] then
            currentElement = currentElement:VisualChild(order[i])
            if currentElement:GetProperty("Name") == name then
                return currentElement
            end
        else
            break
        end
    end
    if debug then _P("[Info] (SaveOnExit) Searching for quit button recursively.") end
    return self:findNoesisElementByName(root, name)
end
