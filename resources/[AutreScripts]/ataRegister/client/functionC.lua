



-- ESX
Citizen.CreateThread(function()
    if not Config.ESX_1_9_0 then 
        ESX = nil
        while ESX == nil do
            TriggerEvent(Config.GetSharedObject, function(obj) ESX = obj end)
            Citizen.Wait(200)
        end
    else
        ESX = exports["es_extended"]:getSharedObject()
    end
end)


if Config.esxLegacy then
    RegisterNetEvent('esx_identity:showRegisterIdentity')
        AddEventHandler('esx_identity:showRegisterIdentity', function()
            TriggerEvent('esx_skin:resetFirstSpawn')
            if not ESX.GetPlayerData().dead then
            TriggerEvent('ataRegister:openFormRegister')
            end
    end)
end