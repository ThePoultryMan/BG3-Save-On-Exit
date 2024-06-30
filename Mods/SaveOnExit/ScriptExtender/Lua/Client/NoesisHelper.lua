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
