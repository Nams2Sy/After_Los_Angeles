movingDoor = {}
entity = {}
Citizen.CreateThread(function()
    while true do
        Wait(100)
        ESX.TriggerServerCallback('grvsc_faction:getAllFaction', function(result) 
            if result then
                for _, v in pairs(result) do
                    if v.props then
                        v.coords = json.decode(v.coords)
                        local f_coords = vec3(v.coords.x, v.coords.y, v.coords.z)
                        local p_coords = GetEntityCoords(PlayerPedId())
                        if GetDistanceBetweenCoords(f_coords.x, f_coords.y, f_coords.z, p_coords.x, p_coords.y, p_coords.z, true) < 150 then
                            local propList = json.decode(v.props)
                            for k, p in pairs(propList) do
                                p_coords = GetEntityCoords(PlayerPedId())
                                if GetDistanceBetweenCoords(p.coords.x, p.coords.y, p.coords.z, p_coords.x, p_coords.y, p_coords.z, true) < 110 then
                                    if not DoesEntityExist(entity[k]) then
                                        entity[k] = CreateObject(p.data.name, p.coords.x, p.coords.y, p.coords.z, false, true, true)
                                        SetEntityHeading(entity[k], p.heading)
                                        SetEntityCoordsNoOffset(entity[k], p.coords.x, p.coords.y, p.coords.z, true, true, true)
                                        SetModelAsNoLongerNeeded(p.data.name)
                                        FreezeEntityPosition(entity[k], false)
                                        SetEntityCollision(entity[k], true, true)
                                        addTargetProp(entity[k], p)
                                    else
                                        local heading = GetEntityHeading(entity[k])
                                        if heading ~= p.heading then
                                            if not movingDoor[entity[k]] then
                                                SetEntityHeading(entity[k], p.heading)
                                            end
                                        end
                                    end
                                else
                                    if DoesEntityExist(entity[k]) then
                                        DeleteEntity(entity[k])
                                        entity[k] = nil
                                    end
                                    entity[k] = nil
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

function addTargetProp(prop, dataProp)
    local target = {}
    ESX.TriggerServerCallback('grvsc_faction:getFaction', function(faction) 
        ESX.TriggerServerCallback('grvsc_faction:getPlayer', function(player) 
            faction = faction[1]
            player = player[1]
            local permissions = json.decode(faction.permissions)
            if permissions[player.grade].builddestroy then
                target[#target + 1] = { 
                    label = 'Supprimer le prop',
                    icon = 'fa-solid fa-trash',
                    iconColor = 'red',
                    name = 'boxzone',
                    onSelect = function(data)
                        TriggerServerEvent('grvsc_faction:removeProp', player.member, faction.id, dataProp.coords)
                        Wait(120)
                        DeleteEntity(prop)
                    end
                }
            end
            if dataProp.data.door then
                target[#target + 1] = { 
                    label = 'Intéragir avec [Porte]',
                    icon = 'fa-solid fa-user-tie',
                    iconColor = 'orange',
                    name = 'boxzone',
                    onSelect = function(data)
                        if dataProp.data.door.type == 'normal' then
                            if dataProp.data.door.open then
                                dataProp.data.door.open = false
                                local i = 90
                                dataProp.heading = dataProp.heading+90
                                movingDoor[data.entity] = true
                                Citizen.CreateThread(function()
                                    while i > 0 do
                                        Wait(6)
                                        SetEntityHeading(data.entity, GetEntityHeading(data.entity)+1)
                                        i = i-1
                                    end
                                    movingDoor[data.entity] = false
                                end)
                            else
                                dataProp.data.door.open = true
                                local i = 90
                                dataProp.heading = dataProp.heading-90
                                movingDoor[data.entity] = true
                                Citizen.CreateThread(function()
                                    while i > 0 do
                                        Wait(6)
                                        SetEntityHeading(data.entity, GetEntityHeading(data.entity)-1)
                                        i = i-1
                                    end
                                    movingDoor[data.entity] = false
                                end)
                            end
                            TriggerServerEvent('grvsc_faction:updateProp', dataProp, faction.id)
                        end
                    end
                }
            end
            exports.ox_target:addLocalEntity(prop,target)
        end)
    end)
end