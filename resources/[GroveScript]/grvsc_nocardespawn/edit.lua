ESX = exports['es_extended']:getSharedObject()

function SpawnVehicle(mode,vec,h,prop, locked,spawnati)
    ESX.OneSync.SpawnVehicle(mode,vec,h,prop, function(NetworkId)
        Wait(100)
        local Vehicle =
            NetworkGetEntityFromNetworkId(NetworkId)
        local Exists = DoesEntityExist(Vehicle)
        local trovato = false
        for k, v in pairs(spawnati) do
            if spawnati[k].plate == prop.plate then
                spawnati[k].id = Vehicle
                trovato = true
            end
        end
        if not trovato then
            TriggerEvent("nocardespawn:newSpawn", Vehicle, prop.plate)
        end
        Wait(1000)
        SetVehicleDoorsLocked(Vehicle, locked)
    end)
end