
local playersInPlaces       = {}
local playerIdentity        = {}


Citizen.CreateThread(function()
    if not Config.ESX_1_9_0 then
        ESX = nil
        TriggerEvent(Config.GetSharedObject, function(obj) ESX = obj end)
    else
        ESX = exports["es_extended"]:getSharedObject()
    end
end)

RegisterServerEvent('ataCharCreator:saveSkin')
AddEventHandler('ataCharCreator:saveSkin', function(skin)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	MySQL.Async.execute('UPDATE users SET `skin` = @skin WHERE identifier = @identifier',
			{
				['@skin']       = json.encode(skin),
				['@identifier'] = xPlayer.identifier
			})

		log('Saved Function ataCharCreator:saveSkin')
		
end)



RegisterServerEvent('ataCharCreator:RequestMenuChar')
AddEventHandler('ataCharCreator:RequestMenuChar', function()

	log('Function ataCharCreator:RequestMenuChar')

	TriggerClientEvent('ataCharCreator:MenuChar', source)
end)



RegisterNetEvent("atarevals:changeworld")
AddEventHandler("atarevals:changeworld",function(funct)
    	local source = source
   
		if funct then
		SetPlayerRoutingBucket(source,source)
		log('World Change To :'..source)
		else
		SetPlayerRoutingBucket(source,0)
		log('World Change To 0')
		end
end)


function log(msg)
	if Config.Debug then
	print('^1 AtaCharMenuDebug :^7'..msg)
	end
end


