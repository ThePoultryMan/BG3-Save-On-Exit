Ext.RegisterNetListener("SaveOnExit", function (channel, payload, user)
    if payload == "save" then
        Osi.AutoSave()
    end
end)
