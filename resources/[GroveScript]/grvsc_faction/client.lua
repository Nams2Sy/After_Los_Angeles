RegisterCommand('faction', function() openFaction('main') end, false)


local blipzone
local blip

Citizen.CreateThread(function()
    while true do
        Wait(2000)
        ESX.TriggerServerCallback('grvsc_faction:getFaction', function(blips)
            if blips then
                blips = blips[1]
                if blips.coords then
                    RemoveBlip(blipzone)
                    RemoveBlip(blip)
                    Wait(0)
                    blips.coords = json.decode(blips.coords)
                    blipzone = AddBlipForRadius(blips.coords.x, blips.coords.y, blips.coords.z, blips.distance+1.0-1.0)  -- Ajoute le rayon à la fonction
                    print(type(blips.faction_name))
                    SetBlipHighDetail(blipzone, true)
                    SetBlipDisplay(blipzone, 4)
                    SetBlipColour(blipzone, 10)
                    SetBlipAlpha(blipzone, 128)

                    blip = AddBlipForCoord(blips.coords.x, blips.coords.y, blips.coords.z)
                    SetBlipSprite(blip, blips.blip)
                    SetBlipDisplay(blip, 3)
                    SetBlipScale(blip, 1.0)
                    SetBlipColour(blip,10)
                    SetBlipAsShortRange(blip, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(blips.faction_name)
                    EndTextCommandSetBlipName(blip)
                end
            end
        end)
    end
end)

function openFaction(info)
    if info == 'main' then
        ESX.TriggerServerCallback('grvsc_faction:getFaction', function(result)
            if result then
                print('open my faction')
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