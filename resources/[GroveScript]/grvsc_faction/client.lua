RegisterCommand('faction', function() openFaction('main') end, false)

Citizen.CreateThread(function()
    local blipzone
    local blip
    local blipcolor
    local blipname
    local blipdistance
    local blipcoords
    local change = true
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
                    if blipcoords ~= blips.coords then
                        blipcoords = blips.coords
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
                    local options = {}
                    options[#options + 1] = {
                        title = '',
                        description = '↓ Information personnel ↓',
                        disabled = true,
                    }
                    options[#options + 1] = {
                        title = 'Vous êtes '..player.grade,
                        icon = 'fa-solid fa-user-tie',
                        iconColor = 'green'
                    }
                    options[#options + 1] = {
                        title = '',
                        description = '↓ Information de la faction ↓',
                        disabled = true,
                    }
                    options[#options + 1] = {
                        title = result.level,
                        description = 'Rayon de construction: '..result.distance..' mètres',
                        icon = 'fa-solid fa-campground',
                        onSelect = function()
                            lib.alertDialog({
                                header = result.level..' ['..result.distance..'M]',
                                content = 'Ceci est votre grade de faction, au plus votre faction évolue dans le temps et au plus votre grade augmentera afin de vous offrir un plus grand rayon d\'action.',
                                centered = true,
                            })
                            openFaction('main')
                        end
                    }
                    if permissions[player.grade].modifyfactioncoords then
                        if not result.coords then
                            options[#options + 1] = {
                                title = 'Vous n\'avez pas encore de territoire',
                                description = 'Cliquez pour installer votre territoire sur votre position',
                                icon = 'fa-solid fa-circle-exclamation',
                                iconColor = 'red',
                                onSelect = function()
                                    claimZone(result.id, GetEntityCoords(PlayerPedId()))
                                end
                            }
                        else
                            options[#options + 1] = {
                                title = 'Vous avez un territoire',
                                description = 'Cliquez pour redéfinir votre territoire sur votre position',
                                icon = 'fa-solid fa-circle-exclamation',
                                iconColor = 'green',
                                onSelect = function()
                                    claimZone(result.id, GetEntityCoords(PlayerPedId()))
                                end
                            }
                        end
                    end
                    options[#options + 1] = {
                        title = '',
                        description = '↓ Vos permissions et action ↓',
                        disabled = true,
                    }
                    if permissions[player.grade].modifyfactionname or permissions[player.grade].modifyfactioncolor or permissions[player.grade].modifyfactionblip then
                        local indexOptions = {}
                        options[#options + 1] = {
                            title = 'Gérer la faction',
                            icon = 'fa-solid fa-flag',
                            iconColor = 'orange',
                            onSelect = function()
                                lib.registerContext({
                                    id = 'ManageFaction',
                                    title = '[FACTION] '..result.faction_name,
                                    menu = 'Menufaction',
                                    options = indexOptions
                                })
                                Wait(100)
                                lib.showContext('ManageFaction')
                            end
                        }
                    end
                    if permissions[player.grade].kick or permissions[player.grade].promote or permissions[player.grade].modifyhierarchy then
                        options[#options + 1] = {
                            title = 'Gérer les membres',
                            icon = 'fa-solid fa-user-pen',
                            iconColor = 'orange'
                        }
                    end
                    if permissions[player.grade].creategrade or permissions[player.grade].modifygrade or permissions[player.grade].deletegrade then
                        options[#options + 1] = {
                            title = 'Gérer les grades',
                            icon = 'fa-solid fa-file-pen',
                            iconColor = 'orange'
                        }
                    end
                    if permissions[player.grade].recruit then
                        options[#options + 1] = {
                            title = 'Recruter joueur proche',
                            icon = 'fa-solid fa-user-plus',
                            iconColor = 'green'
                        }
                    end

                    lib.registerContext({
                        id = 'Menufaction',
                        title = '[FACTION] '..result.faction_name,
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

function claimZone(faction, coords)
    ESX.TriggerServerCallback('grvsc_faction:getFaction', function(result)
        result = result[1]
        if result.coords then
            local alert = lib.alertDialog({
                header = 'Réfléchissez bien avant de faire ceci',
                content = 'Cela supprimmera définitivement toute les constructions présente sur votre térritoire',
                centered = true,
                cancel = true
            })
            if alert == 'confirm' then
                TriggerServerEvent('grvsc_faction:newClaim', faction, coords)
            end 
        else
            TriggerServerEvent('grvsc_faction:newClaim', faction, coords)
        end
        openFaction('main')
    end)
end