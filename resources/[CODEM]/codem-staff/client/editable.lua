
allMoneyData = {}

RegisterNetEvent('staff:client:spawnCar',function (modelname)
  
    if response and #playerList > 0 and myData  then
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then 

        local hash = GetHashKey(modelname)
        if not IsModelValid(hash) then     
            return
        end
        local coords = GetEntityCoords(PlayerPedId())
        local heading = GetEntityHeading(PlayerPedId())
    
        Core.Game.SpawnVehicle(hash, coords, heading, function(callback_vehicle)
            local plate = GetVehicleNumberPlateText(callback_vehicle)
            -- TriggerEvent("yourevent:GiveVehicleKeys", plate or vehicle)
            TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
        end, true)

    else
        if not IsModelValid(GetHashKey(modelname)) then 
            return
        end
        local coords = GetEntityCoords(PlayerPedId())
        local heading = GetEntityHeading(PlayerPedId())
        local vehiclename = GetHashKey(modelname)
        Core.Functions.SpawnVehicle(vehiclename, function(callback_vehicle)
            TriggerEvent("vehiclekeys:client:SetOwner", Core.Functions.GetPlate(callback_vehicle))
            TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
        end, vector4(coords.x,coords.y,coords.z,heading), true)
    end
    end

end)


RegisterNetEvent('staff:client:takePicture',function (url)
    exports['screenshot-basic']:requestScreenshotUpload(tostring(url), 'files[]', function(data)
     
        local resp = json.decode(data)
        cb(resp.attachments[1].proxy_url)
       
    end)

end)

RegisterNetEvent('staff:client:changeWeather')
AddEventHandler('staff:client:changeWeather', function(weather)
    ClearOverrideWeather()
    ClearWeatherTypePersist()
    SetWeatherTypePersist(weather)
    SetWeatherTypeNow(weather)
    SetWeatherTypeNowPersist(weather)
end)

RegisterNetEvent('staff:client:changeTime')
AddEventHandler('staff:client:changeTime', function(time)
    NetworkOverrideClockTime(time, 0, 0)
end)




RegisterNetEvent('staff:client:OpenMenu')
AddEventHandler('staff:client:OpenMenu', function ()
    WaitNui()
   
    if response and #playerList > 0 and myData  then
        if not adminMenuOpen then 
            SetNuiFocus(true, true)
            SendNUIMessage(
                {
                    action = "openAdminMenu",
                    players = playerList,
                    myId = GetPlayerServerId(PlayerId()),
                    onlineAdmin = onlineAdminNumber
                }
            )
            SendNUIMessage(
                {
                    action = "adminchat",
                    adminChat = adminChat
                }
            )
        end
    end
end)
    
RegisterNetEvent('staff:client:OpenQuickPanel')
AddEventHandler('staff:client:OpenQuickPanel', function ()
    WaitNui()

    if response and #playerList > 0 and myData  then
    SetNuiFocus(true, true)
    SendNUIMessage(
        {
            action = "openFastPanel",
            players = playerList,
            myId = GetPlayerServerId(PlayerId())
        })
    end
end)


function DisableControlActions()
    DisableControlAction(0, 1, true)
    DisableControlAction(0, 2, true) 
    DisableControlAction(0, 3, true)
    DisableControlAction(0, 4, true) 
    DisableControlAction(0, 5, true) 
    DisableControlAction(0, 6, true) 
    DisableControlAction(0, 24, true)
    DisableControlAction(0, 25, true)
    DisableControlAction(0, 68, true)
    DisableControlAction(0, 69, true)
    DisableControlAction(0, 70, true)
    DisableControlAction(0, 263, true) 
    DisableControlAction(0, 264, true) 
    DisableControlAction(0, 257, true) 
    DisableControlAction(0, 140, true) 
    DisableControlAction(0, 141, true) 
    DisableControlAction(0, 142, true) 
    DisableControlAction(0, 143, true) 
    DisableControlAction(0, 177, true) 
    DisableControlAction(0, 200, true) 
    DisableControlAction(0, 202, true) 
    DisableControlAction(0, 322, true) 
    DisableControlAction(0, 245, true) 
end

RegisterNetEvent('staff:client:refreshAllMoneyData',function (data)
    allMoneyData = data
    Citizen.Wait(200)
    SendNUIMessage(
        {
            action = "playermoneyData",
            moneyData = allMoneyData
          
        })

end)


RegisterNetEvent('staff:removeTableIndexMoney',function (index)

    if not allMoneyData[index] then return end

    allMoneyData[index] = nil
    Citizen.Wait(200)
    SendNUIMessage(
        {
            action = "deleteMoneyData",
            identifier = index
          
        })

end)



RegisterNetEvent("staff:client:heal",function()
    SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
end)