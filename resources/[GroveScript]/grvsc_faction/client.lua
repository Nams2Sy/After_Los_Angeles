RegisterCommand('faction', function() openFaction('main') end, false)


local blipzone
local blip
local blipcolor
local blipname
local blipdistance
local change
Citizen.CreateThread(function()
    change = true
    while true do
        Wait(2000)
        ESX.TriggerServerCallback('grvsc_faction:getFaction', function(blips)
            if blips then
                blips = blips[1]
                if blips.coords then
                    if blipcolor ~= tonumber(blips.color) then
                        blipcolor = blips.color
                        change = true
                    end
                    if blipdistance ~= blips.distance then
                        blipdistance = blips.distance
                        change = true
                    end
                    if blipname ~= blips.faction_name then
                        blipname = blips.faction_name
                        change = true
                    end
                    blipcolor = tonumber(blipcolor)
                    if change then
                        change = nil
                        RemoveBlip(blip)
                        RemoveBlip(blipzone)
                        blips.coords = json.decode(blips.coords)
                        blipzone = AddBlipForRadius(blips.coords.x, blips.coords.y, blips.coords.z, blips.distance+1.0-1.0)  -- Ajoute le rayon à la fonction
                        SetBlipHighDetail(blipzone, true)
                        SetBlipDisplay(blipzone, 4)
                        SetBlipColour(blipzone, blipcolor)
                        SetBlipAlpha(blipzone, 128)
                        blip = AddBlipForCoord(blips.coords.x, blips.coords.y, blips.coords.z)
                        SetBlipSprite(blip, blips.blip)
                        SetBlipDisplay(blip, 3)
                        SetBlipScale(blip, 1.0)
                        SetBlipColour(blip, blipcolor)
                        SetBlipAsShortRange(blip, true)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString("[FACTION] "..blips.faction_name)
                        EndTextCommandSetBlipName(blip)
                    end
                end
            end
        end)
    end
end)








function openFaction(info)
    if info == 'main' then
        ESX.TriggerServerCallback('grvsc_faction:getFaction', function(result)
            if result then
                ESX.TriggerServerCallback('grvsc_faction:getPlayer', function(player)
                    result = result[1]
                    local permissions = json.decode(result.permissions)
                    player = player[1]
                    for k, v in pairs(permissions) do
                        for i, o in pairs(v) do
                            print(i)
                        end
                    end

                    local options = {}
                    
                    options[#options + 1] = {
                        title = 'Votre faction: '..result.faction_name,
                        icon = 'fa-solid fa-house-user',
                        iconColor = 'green'
                    }
                    options[#options + 1] = {
                        title = 'Votre Grade: '..player.grade,
                        icon = 'fa-solid fa-user-tie',
                        iconColor = 'green'
                    }

                    lib.registerContext({
                        id = 'Menufaction',
                        title = 'Menu de faction',
                        options = options
                    })
                    Wait(100)
                    lib.showContext('Menufaction')
                end)
            else
                openFaction('create')
            end
        end)
    elseif info == 'create' then
        ESX.TriggerServerCallback('grvsc_faction:DoesPermission', function(result)
            lib.registerContext({
                id = 'Createfaction',
                title = 'Menu de faction',
                options = {
                  {
                    title = 'Vous n\'avez pas faction',
                    icon = 'fa-solid fa-triangle-exclamation',
                    iconColor = 'red'
                  },
                  {
                    title = 'Créer une faction',
                    description = 'Tentez une nouvelle aventure',
                    icon = 'fa-solid fa-plus',
                    iconColor = 'green',
                    disabled = result,
                    onSelect = function()
                        local input = lib.inputDialog('Création de faction', {
                            {type = 'input', label = 'Quel sera le nom de votre faction ?', description = 'Attention a respecter le réglement', required = true, min = 4, max = 16},
                            {type = 'number', label = 'Quel blip souhaitez vous ?', default = '1', required = true, min = 1},
                            {type = 'number', label = 'Quel sera la couleur du blip ?', default = '1', description = 'Cela représentera la couleur du blip', required = true, min = 1},
                          })
                        if input then
                            TriggerServerEvent('grvsc_faction:createFaction', input[1], input[2], input[3])
                            print('Votre faction est crée')
                        else
                            lib.showContext('Createfaction')
                        end
                    end,
                  }
                }
              })
            Wait(100)
            lib.showContext('Createfaction')
        end)
    end
end