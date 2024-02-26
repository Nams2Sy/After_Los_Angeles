local datav = {}
local spawnati = {}
RegisterNetEvent("vehicletospawn")
AddEventHandler("vehicletospawn", function(data)
    datav = data
end)
local vehicle = nil
local  coords =nil
local prop = nil
local una= false
Citizen.CreateThread(function()
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId())
        local source = GetPlayerServerId(PlayerId())
        TriggerServerEvent("getdat", source)
        Wait(500)
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local player = GetPlayerPed(-1)
            vehicle = GetVehiclePedIsIn(player, false)
            local vehiclecoords = GetEntityCoords(vehicle)
            local heading = GetEntityHeading(vehicle)
            coords = {
                coords = vehiclecoords,
                h= heading,
            }
            prop = GetVehicleProperties(vehicle)
            TriggerServerEvent("saveenter", source,prop)
                TriggerServerEvent("addvvc", NetworkGetNetworkIdFromEntity(vehicle),prop)
        elseif vehicle ~= nil and not IsPedInAnyVehicle(PlayerPedId(), false) then
            una = false
            if GetPedInVehicleSeat(GetPedInVehicleSeat(vehicle, -2)) == 0 or GetEntityModel(vehicle) == 0 then
            TriggerServerEvent("savev", source,prop,coords)
            end
            vehicle = nil
            prop = nil
            coords =nil
        end
    end
end)

local menuOpen = false
local function menu()    
    menuOpen = not menuOpen
    SetNuiFocus(menuOpen, menuOpen)
end

RegisterCommand("prova", function()
    menu()
    SendNUIMessage({
        type = "menu",
        action = "open"
    })
end)

RegisterNUICallback('closeMenu', function(data, cb)
    menu()
    cb({ok = true})
end)