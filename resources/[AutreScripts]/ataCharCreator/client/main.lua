

currentHeading             = nil
local inCharCreator        = false
local heading = 0
local cam                  = nil


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
    while true do
        Citizen.Wait(0)
         if inCharCreator then
            InvalidateIdleCam()
            SetPedCanPlayAmbientIdles(PlayerPedId(), true, false)
		 else
			Citizen.Wait(1000)
		 end
    end
end)




RegisterNUICallback('ReadyForGetSetup', function()
	SendNUIMessage({
		action = "setConfig",
		config = Config.Clothes
	})
end)


RegisterNUICallback('saveAndClose', function(data, cb)
	log('SaveAndClose RegisterNUICallback')
		openUI("CharacterCreator", false)
end)

RegisterNUICallback('character_rotation', function(data, cb)
	ata_changeChracterRotate(data.rotationType)
end)



RegisterNUICallback('changeCharacterValue', function(data, cb)
	log('changeCharacterValue Data Name : '..data.name..' Data Result: '..data.result)
	TriggerEvent("skinchanger:getSkin", function(skin)
		skin[data.name] = data.result
		TriggerEvent("skinchanger:loadSkin", skin)
	end)
	if data.name == 'dad' then
		for k,v in pairs(Config.fathername) do
            if data.result == v.id then
				SendNUIMessage({
				action = 'father',
				name = v.name
				})
			end
        end
		
	elseif data.name == 'mom' then
		for k,v in pairs(Config.mothername) do
            if data.result == v.id then
				SendNUIMessage({
				action = 'mother',
				name = v.name
				})
			end
        end
	end
end)


RegisterNUICallback('changeCam', function(data, cb)
	ChangeCameraRotation(data.type)
end)

RegisterNUICallback('updateCloth', function(data, cb)
	if data.type == 'tshirt' then
		TriggerEvent("skinchanger:getSkin", function(skin)
			skin['torso_1'] = tonumber(data.value.torso_1)
			skin['torso_2'] = tonumber(data.value.torso_2)
			skin['tshirt_1'] = tonumber(data.value.tshirt_1)
			skin['tshirt_2'] = tonumber(data.value.tshirt_2)
			skin['arms'] = tonumber(data.value.arms)
			TriggerEvent("skinchanger:loadSkin", skin)	
		end)
	elseif data.type == 'pants' then
		TriggerEvent("skinchanger:getSkin", function(skin)
			skin['pants_1'] = tonumber(data.value.pants_1)
			skin['pants_2'] = tonumber(data.value.pants_2)
			TriggerEvent("skinchanger:loadSkin", skin)	
		end)
	elseif data.type == 'shoes' then
		TriggerEvent("skinchanger:getSkin", function(skin)
			skin['shoes_1'] = tonumber(data.value.shoes_1)
			skin['shoes_2'] = tonumber(data.value.shoes_2)
			TriggerEvent("skinchanger:loadSkin", skin)	
		end)
	end
end)


RegisterNUICallback('selectSex' , function(data,cb)

		
			
			TriggerEvent('skinchanger:getSkin', function(skin)
				if data.sex == 'man' then
					TriggerEvent('skinchanger:loadSkin', {
						sex          = 0,
						face         = 0,
						skin         = 0,
						beard_1      = 0,
						beard_2      = 0,
						beard_3      = 0,
						beard_4      = 0,
						hair_1       = 0,
						hair_2       = 0,
						hair_color_1 = 0,
						hair_color_2 = 0,
						tshirt_1     = tonumber(Config.Clothes.man.tshirt[1].tshirt_1),
						tshirt_2     = tonumber(Config.Clothes.man.tshirt[1].tshirt_2),
						torso_1      = tonumber(Config.Clothes.man.tshirt[1].torso_1),
						torso_2      = tonumber(Config.Clothes.man.tshirt[1].torso_2),
						decals_1     = 0,
						decals_2     = 0,
						arms         = tonumber(Config.Clothes.man.tshirt[1].arms),
						pants_1      = tonumber(Config.Clothes.man.pants[1].pants_1),
						pants_2      = tonumber(Config.Clothes.man.pants[1].pants_2),
						shoes_1      = tonumber(Config.Clothes.man.shoes[1].shoes_1),
						shoes_2      = tonumber(Config.Clothes.man.shoes[1].shoes_2),
						mask_1       = 0,
						mask_2       = 0,
						bproof_1     = 0,
						bproof_2     = 0,
						chain_1      = 0,
						chain_2      = 0,
						helmet_1     = -1,
						helmet_2     = 0,
						glasses_1    = -1,
						glasses_2    = 0,
					})
				else
					TriggerEvent('skinchanger:loadSkin', {
						sex          = 1,
						face         = 0,
						skin         = 0,
						beard_1      = 0,
						beard_2      = 0,
						beard_3      = 0,
						beard_4      = 0,
						hair_1       = 0,
						hair_2       = 0,
						hair_color_1 = 0,
						hair_color_2 = 0,
						tshirt_1     = tonumber(Config.Clothes.woman.tshirt[1].tshirt_1),
						tshirt_2     = tonumber(Config.Clothes.woman.tshirt[1].tshirt_2),
						torso_1      = tonumber(Config.Clothes.woman.tshirt[1].torso_1),
						torso_2      = tonumber(Config.Clothes.woman.tshirt[1].torso_2),
						decals_1     = 0,
						decals_2     = 0,
						arms         = tonumber(Config.Clothes.woman.tshirt[1].arms),
						pants_1      = tonumber(Config.Clothes.woman.pants[1].pants_1),
						pants_2      = tonumber(Config.Clothes.woman.pants[1].pants_2),
						shoes_1      = tonumber(Config.Clothes.woman.shoes[1].shoes_1),
						shoes_2      = tonumber(Config.Clothes.woman.shoes[1].shoes_2),
						mask_1       = 0,
						mask_2       = 0,
						bproof_1     = 0,
						bproof_2     = 0,
						chain_1      = 0,
						chain_2      = 0,
						helmet_1     = -1,
						helmet_2     = 0,
						glasses_1    = -1,
						glasses_2    = 0,
					})
				end
			end)
end)




RegisterNetEvent('ataCharCreator:RequestMenuChar:client')
AddEventHandler('ataCharCreator:RequestMenuChar:client', function(type, funct)

	log(' ataCharCreator:RequestMenuChar:client')
	TriggerServerEvent('ataCharCreator:RequestMenuChar')
end)


function ata_changeChracterRotate(type)
	local heading   = currentHeading
	-- print(heading)
	if type == "left" then
		SetEntityHeading(PlayerPedId(), heading - 20)
		currentHeading = heading - 20
	elseif type == "right" then
		SetEntityHeading(PlayerPedId(), heading + 20)
		currentHeading = heading + 20
	end
end


RegisterNetEvent('ataCharCreator:MenuChar')
AddEventHandler('ataCharCreator:MenuChar', function(id)
	log('ataCharCreator:MenuChar Request')
	SetEntityCoords(PlayerPedId(), Config.PlayerCoords.x,Config.PlayerCoords.y,Config.PlayerCoords.z)
	SetEntityHeading(PlayerPedId(), Config.PlayerHeading)
	FreezeEntityPosition(PlayerPedId(), true)
	SetEntityInvincible(PlayerPedId(), true)
	openUI("CharacterCreator", true)
	currentHeading = GetEntityHeading(PlayerPedId())
	local coords    = GetEntityCoords(PlayerPedId())
	if not DoesCamExist(cam) then
		cam = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", vector3(coords.x-0.6, coords.y-0.15 , coords.z +0.65), 0.0, 0.0, 0.0, 80.0, false, false)
	end
    SetCamRot(cam, -10.0, 0.0, -77.0, true)
	SetCamActive(cam, true)
	RenderScriptCams(true)
	log('ataCharCreator:MenuChar done')
end)





function openUI(type, funct)
	if type == "CharacterCreator" then
		SendNUIMessage({
			flap_open = funct
		})
		SetNuiFocus(funct, funct)
		inCharCreator = funct
		TriggerServerEvent('atarevals:changeworld',funct)
		if funct == false then
			uiClose()
		end
	end
end


function SaveSkin()
	TriggerEvent('skinchanger:getSkin', function(skin)
		TriggerServerEvent('ataCharCreator:saveSkin', skin)
	end)
	
end



function uiClose()
	for k,v in pairs(Config.SpawnLocation) do
		DoScreenFadeOut(500)
		Citizen.Wait(1000)
		ESX.Game.Teleport(PlayerPedId(), {x = v.coords.x, y = v.coords.y, z = v.coords.z, heading = v.heading}, function()
			SetEntityInvincible(PlayerPedId(), false)
			FreezeEntityPosition(PlayerPedId(), false)
			SaveSkin()
			SetCamActive(cam, false)
			RenderScriptCams(false, true, 500, true, true)
			cam = nil
		end)
		Citizen.Wait(500)
		DoScreenFadeIn(500)
	end
	TriggerEvent('ataCharCreator:PlayerSuccessSpawn')
end

function ChangeCameraRotation(type)
	if DoesCamExist(cam) then
		local coords    = GetEntityCoords(PlayerPedId())
		SetCamActive(cam, false)
		RenderScriptCams(false, true, 500, true, true)
		cam = nil
		if type == "gofamily" then
			cam = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", vector3(coords.x-0.8, coords.y-0.22 , coords.z +0.6), 0.0, 0.0, 0.0, 50.0, false, false)
			SetCamRot(cam, 0.0, 0.0, -75.0, true)
			SetCamActive(cam, true)
			RenderScriptCams(true)
		elseif type == "nose" then
			cam = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", vector3(coords.x-0.8, coords.y-0.22 , coords.z +0.645), 0.0, 0.0, 0.0, 30.0, false, false)
			SetCamRot(cam, 0.0, 0.0, -74.5, true)
			SetCamActive(cam, true)
			RenderScriptCams(true)
		elseif type == "clothes" then
			cam = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", vector3(coords.x-2.9, coords.y-0.97 , coords.z -0.05), 0.0, 0.0, 0.0, 40.0, false, false)
			SetCamRot(cam, 0.0, 0.0, -74.5, true)
			SetCamActive(cam, true)
			RenderScriptCams(true)
		end

	end
end



function log(msg)
	if Config.Debug then
		print('^1 AtaCharMenuDebug :^7'..msg)
	end
end