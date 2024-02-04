local action = false

function CarLocking(plate, bool)
            
                MySQL.Sync.execute(
                    "UPDATE restorev SET locked = @locked WHERE plate = @plate",
                    {['@locked'] = bool, ['@plate'] = plate})

end

RegisterServerEvent("savev")
AddEventHandler("savev", function(source, vehicle, coords)
    action = true



                MySQL.Async.fetchAll(
                    'SELECT plate FROM restorev WHERE plate = @plate',
                    {['@plate'] = vehicle.plate}, function(result)

                        if #result == 1 then

                            MySQL.Sync.execute(
                                "UPDATE restorev SET prop = @prop, ine = @ine, plate = @plate,coords=@coords WHERE plate = @plate",
                                {
                                    ['@prop'] = json.encode(vehicle),
                                    ['@coords'] = json.encode(coords),
                                    ['@ine'] = 0,
                                    ['@plate'] = vehicle.plate
                                })

                        else
                            MySQL.Async.execute(
                                'INSERT INTO restorev (prop,coords,ine,plate) VALUES (@prop,@coords,@ine,@plate)',
                                {

                                    ['@prop'] = json.encode(vehicle),
                                    ['@coords'] = json.encode(coords),
                                    ['@ine'] = 0,
                                    ['@plate'] = vehicle.plate

                                }, function() end)

                        end
                    end)
end)
RegisterServerEvent("spawnati")
AddEventHandler("spawnati", function(spawnati)
    action = true
    for _, playerId in ipairs(GetPlayers()) do
        TriggerClientEvent("updatespawnati", playerId, spawnati)
    end
    Wait(4000)

end)
function GetClosestPlayer(vec,dist) 
   
    for t,v in pairs(GetPlayers()) do
        getcoords = GetEntityCoords(GetPlayerPed(v))
        distance = #(getcoords - vec)
       
        if distance < dist then
            
            return true
        end
    end
return false
end
local spawnati = {}
local people = false
Citizen.CreateThread(function()
    while true do

     
        Wait(1000)
      
     

            MySQL.Async.fetchAll("SELECT * FROM restorev", {}, function(result)

                for k, v in pairs(result) do
                    local coords = json.decode(result[k].coords)
                    local prop = json.decode(result[k].prop)
                    local ine = json.decode(result[k].ine)
                    local locked = json.decode(result[k].locked)
                    local xPlayer = GetClosestPlayer(vector3(
                                                                     coords.coords["x"],
                                                                     coords.coords["y"],
                                                                     coords.coords["z"]),
                                                                 300)
                                                            
                                                             
                    if not xPlayer then
                        people = false
                    else
                        people = true
                    end
                    local check = true
                    for k, v in pairs(spawnati) do

                        if spawnati[k].plate == prop.plate then
                            if not DoesEntityExist(spawnati[k].id) then
                                check = true
                            else
                                check = false
                            end
                        end
                    end
                    if ine == 0 and check and people then

                        SpawnVehicle(prop.model,
                                    vector3(
                                        coords.coords["x"],
                                        coords.coords["y"],
                                        coords.coords["z"]
                                    ),
                                    coords.h, 
                                    prop,
                                    locked, 
                                    spawnati
                                )

                    end
                end
            end)
       
    end

end)

RegisterServerEvent("nocardespawn:newSpawn")
AddEventHandler('nocardespawn:newSpawn', function(vehicle, plate)
    table.insert(spawnati,
    {id = vehicle, plate = plate})
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        for k, v in pairs(spawnati) do DeleteEntity(spawnati[k].id) end
        return
    end

end)

RegisterServerEvent("addvvc")
AddEventHandler("addvvc", function(vehicle, prop)
    local trovato = false
    for k, v in pairs(spawnati) do

        if spawnati[k].plate == prop.plate then
            spawnati[k].id = NetworkGetEntityFromNetworkId(vehicle)
            trovato = true
        end
    end
    if not trovato then
        table.insert(spawnati, {
            id = NetworkGetEntityFromNetworkId(vehicle),
            plate = prop.plate
        })
    end

end)
AddEventHandler('playerDropped', function(reason)
    action = true
    local player = GetPlayerPed(source)
    local vehicle = GetVehiclePedIsIn(player, false)
    if vehicle then
        if GetPedInVehicleSeat(vehicle, -2) == 0 or GetEntityModel(vehicle) == 0 then
            local vehiclecoords = GetEntityCoords(vehicle)
            local heading = GetEntityHeading(vehicle)
            coords = {coords = vehiclecoords, h = heading}

            TriggerEvent("saveexit", source, GetVehicleNumberPlateText(vehicle),
                         coords)

        end
    end
end)

RegisterServerEvent("saveexit")
AddEventHandler("saveexit", function(source, targa, coords)
    action = true
    
                MySQL.Async.fetchAll(
                    'SELECT plate FROM restorev WHERE plate = @plate',
                    {['@plate'] = targa}, function(result)

                        if #result == 1 then

                            MySQL.Sync.execute(
                                "UPDATE restorev SET ine = @ine WHERE plate = @plate",
                                {['@ine'] = 0, ['@plate'] = targa})
                            MySQL.Sync.execute(
                                "UPDATE restorev SET coords = @coords WHERE plate = @plate",
                                {
                                    ['@coords'] = json.encode(coords),
                                    ['@plate'] = targa
                                })
                        else

                        end
                    end)
end)

RegisterServerEvent("saveenter")
AddEventHandler("saveenter", function(source, vehicle)
    action = true


                MySQL.Async.fetchAll(
                    'SELECT plate FROM restorev WHERE plate = @plate',
                    {['@plate'] = vehicle.plate}, function(result)

                        if #result == 1 then

                            MySQL.Sync.execute(
                                "UPDATE restorev SET ine = @ine WHERE plate = @plate",
                                {['@ine'] = 1, ['@plate'] = vehicle.plate})
                            MySQL.Sync.execute(
                                "UPDATE restorev SET prop = @prop WHERE plate = @plate",
                                {
                                    ['@prop'] = json.encode(vehicle),
                                    ['@plate'] = vehicle.plate
                                })
                        else
                        end
                    end)
        Wait(2000)
end)

AddEventHandler('onServerResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= 'df_nocardespawn' then
        print(
            "You cannot change the resource name! The name of this resource must be df_nocardespawn")
        Wait(5000)
        os.exit()
    end
end)
