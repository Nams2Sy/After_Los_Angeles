
local open = false
local cam  = nil

local loadingScreenFinished = false
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




Citizen.CreateThread(function()
	-------- GET YTD Texure ----------
	if not HasStreamedTextureDictLoaded('toturial') then
        RequestStreamedTextureDict('toturial', true)
        while not HasStreamedTextureDictLoaded('toturial') do
            Wait(1)
        end
	end
	while true do
		
		local _sleep = true
    	Citizen.Wait(1)
		local ply = PlayerPedId()
		local plycoords = GetEntityCoords(ply)
		if #(plycoords - Config.startTutorial) < 3 then
			if IsControlJustReleased(0, 38) then  ----- press E for open Garage
				open = true
				firstPlayerSpawn()
			end
			DrawMarker(8,Config.startTutorial.x,Config.startTutorial.y,Config.startTutorial.z + 0.5, -90.0, 200.5, 0.0, 90.0, 0.0,0.0, 1.7, 1.7, 1.7, 255, 255, 255, 255,false, false, 1, false, 'toturial', 'logo', false)
		end
	end
end)




RegisterNetEvent('ataRegister:StartTutorial')
AddEventHandler('ataRegister:StartTutorial', function()
	firstPlayerSpawn()
end)

RegisterNetEvent('ataRegister:AlreadyRegistered')
AddEventHandler('ataRegister:AlreadyRegistered', function()
	if Config.LoadingScreenFixManualClose then
	while not loadingScreenFinished do Wait(100) end
    TriggerEvent('esx_skin:playerRegistered')
	end
	if Config.usingAtaSpawn then
		TriggerEvent('ataSpawn:ShowSpawnLocation')
	end
end)


AddEventHandler('esx:loadingScreenOff', function()
    loadingScreenFinished = true
end)




RegisterNetEvent('ataRegister:openFormRegister')
AddEventHandler('ataRegister:openFormRegister', function()
    while not loadingScreenFinished do Wait(100) end
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = "enableui",
        enable = true
	})
end)



RegisterNUICallback('ready', function()
	SendNUIMessage({
		action = "setConfig",
		config = Config
	})
end)

-- Register the player (call from javascript > send to server < callback from server)
RegisterNUICallback('register', function(data, cb)
	cb('ok')
	ESX.TriggerServerCallback('ataRegister:callBackServerSideForRegister', function(success)		
		if success then
			SetNuiFocus(false, false)
			SendNUIMessage({
				action = "loading"
			})
			if not Config.ifUsingAtaCharCreator then
				if Config.esxLegacy then
					if not ESX.GetConfig().Multichar then TriggerEvent('esx_skin:playerRegistered') end
				end
			else
				TriggerServerEvent('ataCharCreator:RequestMenuChar')
			end
			functionStartPlayer()
		end
	end, data)
end)



-- Freeze player movements
Citizen.CreateThread(function()

    while true do
		sleep = true
		Citizen.Wait(0)
      if open then
		sleep = false
		DisableAllControlActions(false)
      end
	  if sleep then Citizen.Wait(1000) end
    end
end)








showhelp = function(msg)
	AddTextEntry('ShowHelpForNewPlayer', msg)
	DisplayHelpTextThisFrame('ShowHelpForNewPlayer', true)
end

function firstPlayerSpawn()
	local playerped = PlayerPedId()
	TriggerServerEvent('atarevals:changeworld',false)
	DisplayHud(false)
    DisplayRadar(false)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(100)
	SetFollowPedCamViewMode(4)
	FreezeEntityPosition(playerped, true)
	DeleteCamera()
	local before = GetEntityCoords(playerped, true)
	for i = 1, #Config.Camera do
		SetEntityCoordsNoOffset(playerped, 141.39405822754,-747.41589355469,254.25531005859,true,true,true)
        SetGameplayCamRelativeHeading(0.0)
        SetEntityHeading(playerped, Config.Camera[i].campostion[4])
		FreezeEntityPosition(playerped, true)
		 for k,v in pairs(Config.Camera[i].help) do
			DoScreenFadeIn(1000)
			showhelp(v.text)	
			Citizen.Wait(v.time)
		 end
		 DoScreenFadeOut(1000)
		 Citizen.Wait(1000)
	end
	TriggerServerEvent('ataRegister:changeworld',true)
	Citizen.Wait(3000)
	DoScreenFadeIn(450)
	FreezeEntityPosition(playerped, false)
    SetEntityCoords(playerped, before.x, before.y, before.z)
	SetFollowPedCamViewMode(1)
	open = false
end

DeleteCamera = function()
	ClearFocus()
	DestroyAllCams(true)
	RenderScriptCams(false, true, 1, true, true)
end


functionStartPlayer = function()
	open = false
	-- TriggerEvent("qb-clothes:client:CreateFirstCharacter")
end