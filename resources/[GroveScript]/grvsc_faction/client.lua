RegisterCommand('faction', function() openFaction('main') end, false)

Citizen.CreateThread(function()
    ESX.TriggerServerCallback('grvsc_faction:getFaction', function(blip)
        if blip then
            blip = blip[1]
            if blip.coords then
                local blip = AddBlipForRadius(blip.coords.x, blip.coords.y, blip.coords.z, 200.0)
                SetBlipHighDetail(blip, true)
                SetBlipDisplay(blip, 4)
                SetBlipColour(blip, 10) -- blip.color
                SetBlipAlpha (blip, 128)
                local blip = AddBlipForCoord(blip.coords.x, blip.coords.y, blip.coords.z)
                SetBlipSprite(blip, blip.blip)
                SetBlipDisplay(blip, 3)
                SetBlipScale(blip, 1.0)
                SetBlipColour(blip,10)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(blip.faction_name)
                EndTextCommandSetBlipName(blip)
            end
        end
    end)
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