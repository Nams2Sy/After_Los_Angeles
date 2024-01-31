RegisterCommand('faction', function() openFaction('main') end, false)

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
                            {type = 'color', label = 'Quel est la couleur de votre faction ?', default = '#eb4034'},
                          })
                        if input then
                            createFaction(input[1], input[2])
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

function createFaction(name, color)
    ESX.TriggerServerCallback('grvsc_faction:createFaction', function(result)
        print(name, color)
    end, name, color)
end