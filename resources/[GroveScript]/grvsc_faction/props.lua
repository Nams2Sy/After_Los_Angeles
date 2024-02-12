entity = {}
openlast = {}
opennow = {}
Citizen.CreateThread(function()
    while true do
        Citizen.CreateThread(function()
            for k, v in pairs(entity) do
                ESX.TriggerServerCallback('grvsc_faction:getProp', function(propList)
                    if not propList then
                        DeleteEntity(entity[k])
                        entity[k] = nil
                    end
                end, k)
            end
        end)
        Wait(100)
        ESX.TriggerServerCallback('grvsc_faction:getAllFaction', function(result) 
            if result then
                for _, v in pairs(result) do
                    if v.coords then
                        v.coords = json.decode(v.coords)
                        local f_coords = vec3(v.coords.x, v.coords.y, v.coords.z)
                        local p_coords = GetEntityCoords(PlayerPedId())
                        if GetDistanceBetweenCoords(f_coords.x, f_coords.y, f_coords.z, p_coords.x, p_coords.y, p_coords.z, true) < 150 then
                            ESX.TriggerServerCallback('grvsc_faction:getProps', function(propList)
                                for k, p in pairs(propList) do
                                    p_coords = GetEntityCoords(PlayerPedId())
                                    p.data = json.decode(p.data)
                                    p.coords = json.decode(p.coords)
                                    p.coords = vec3(p.coords.x, p.coords.y, p.coords.z)
                                    if GetDistanceBetweenCoords(p.coords.x, p.coords.y, p.coords.z, p_coords.x, p_coords.y, p_coords.z, true) < 110 then
                                        if not DoesEntityExist(entity[p.id]) then
                                            entity[p.id] = CreateObject(p.data.name, p.coords.x, p.coords.y, p.coords.z, false, true, true)
                                            SetEntityHeading(entity[p.id], p.heading+0.1-0.1)
                                            SetEntityCoordsNoOffset(entity[p.id], p.coords.x, p.coords.y, p.coords.z, true, true, true)
                                            SetModelAsNoLongerNeeded(p.data.name)
                                            FreezeEntityPosition(entity[p.id], true)
                                            SetEntityCollision(entity[p.id], true, true)
                                            addTargetProp(entity[p.id], p)
                                            if p.data.door then
                                                openlast[entity[p.id]] = p.data.door.open
                                            end
                                            if p.data.chest then
                                                TriggerServerEvent('grvsc_faction:checkStash', p.id)
                                            end
                                        else
                                            if p.data.door then
                                                opennow[entity[p.id]] = p.data.door.open
                                                if opennow[entity[p.id]] ~= openlast[entity[p.id]] then
                                                    openlast[entity[p.id]] = opennow[entity[p.id]]
                                                    if opennow[entity[p.id]] == true then
                                                        local i = 90
                                                        Citizen.CreateThread(function()
                                                            while i > 0 do
                                                                Wait(6)
                                                                SetEntityHeading(entity[p.id], GetEntityHeading(entity[p.id])+1)
                                                                i = i-1
                                                            end
                                                        end)
                                                    else
                                                        local i = 90
                                                        Citizen.CreateThread(function()
                                                            while i > 0 do
                                                                Wait(6)
                                                                SetEntityHeading(entity[p.id], GetEntityHeading(entity[p.id])-1)
                                                                i = i-1
                                                            end
                                                        end)
                                                    end
                                                    p.data.heading = GetEntityHeading(entity[p.id])
                                                end
                                            end
                                        end
                                    else
                                        if DoesEntityExist(entity[p.id]) then
                                            DeleteEntity(entity[p.id])
                                            entity[p.id] = nil
                                        end
                                        entity[p.id] = nil
                                    end
                                end
                            end, v.id)
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
            if faction then
                faction = faction[1]
                player = player[1]
                local permissions = json.decode(faction.permissions)
                if permissions[player.grade].builddestroy then
                    target[#target + 1] = { 
                        label = 'Démolir l\'objet',
                        icon = 'fa-solid fa-trash',
                        iconColor = 'red',
                        name = 'boxzone',
                        onSelect = function(data)
                            if lib.progressBar({
                                duration = 6000,
                                label = 'Démolition',
                                useWhileDead = false,
                                canCancel = true,
                                disable = {
                                    move = true,
                                    car = true,
                                    combat = true,
                                    mouse = true,
                                    sprint = true,
                                },
                                anim = {
                                    dict = 'melee@large_wpn@streamed_core',
                                    clip = 'ground_attack_on_spot',
                                    flags = 49
                                },
                                prop = {
                                    model = 'prop_tool_hammer',
                                    pos = vec3(0.05, 0.07, 0),
                                    rot = vec3(-110, -90, 0.5)
                                },
                            }) then
                                TriggerServerEvent('grvsc_faction:removeProp', player.member, faction.id, dataProp)
                            end
                        end
                    }
                end
                if dataProp.data.chest then
                    target[#target + 1] = { 
                        label = 'Modifier le code',
                        icon = 'fa-solid fa-key',
                        iconColor = 'orange',
                        name = 'boxzone',
                        onSelect = function(data)
                            ESX.TriggerServerCallback('grvsc_faction:getProp', function(result)
                                result = json.decode(result)
                                if result.chest.password ~= 'nopassword' then
                                    local input = lib.inputDialog('Modification du code', {
                                        {type = 'number', label = 'Ancien code', description = 'Veuillez saisir l\'ancien code', icon = 'hashtag', min = 1000, max = 9999},
                                        {type = 'number', label = 'Nouveau code', description = 'Veuillez saisir le nouveau code', icon = 'hashtag', min = 1000, max = 9999},
                                        {type = 'number', label = 'Confirmation nouveau code', description = 'Veuillez resaisir le nouveau code', icon = 'hashtag', min = 1000, max = 9999},
                                    })
                                    if input then
                                        if input[1] == tonumber(result.chest.password) then
                                            if input[2] == input[3] then
                                                dataProp.data.chest.password = input[2]
                                                TriggerServerEvent('grvsc_faction:updateProp', dataProp)
                                                exports['okokNotify']:Alert('Modification effectué', 'Nouveau code de dévérouillage', 3000, 'success', true)
                                            else
                                                print('confirm false')
                                            end
                                        else
                                            print('password invalid')
                                        end
                                    end
                                else
                                    local input = lib.inputDialog('Modification du code', {
                                        {type = 'number', label = 'Nouveau code', description = 'Veuillez saisir le nouveau code', icon = 'hashtag', min = 1000, max = 9999},
                                        {type = 'number', label = 'Confirmation nouveau code', description = 'Veuillez resaisir le nouveau code', icon = 'hashtag', min = 1000, max = 9999},
                                    })
                                    if input then
                                        if input[1] == input[2] then
                                            dataProp.data.chest.password = input[2]
                                            TriggerServerEvent('grvsc_faction:updateProp', dataProp)
                                            exports['okokNotify']:Alert('Modification effectué', 'Nouveau code de dévérouillage', 3000, 'success', true)
                                        else
                                            print('confirm false')
                                        end
                                    end
                                end
                
                            end, dataProp.id)
                        end
                    }
                    target[#target + 1] = { 
                        label = 'Accéder au coffre',
                        icon = 'fa-solid fa-box',
                        iconColor = 'green',
                        name = 'boxzone',
                        onSelect = function(data)
                            ESX.TriggerServerCallback('grvsc_faction:getProp', function(result)
                                result = json.decode(result)
                                if result.chest.password ~= 'nopassword' then
                                    local input = lib.inputDialog('Code nécéssaire', {
                                        {type = 'number', label = 'Code de dévérouillage', description = 'Veuillez saisir le code', icon = 'hashtag', min = 1000, max = 9999},
                                      })
                                    if input then
                                        if input[1] == tonumber(result.chest.password) then
                                            exports.ox_inventory:openInventory('stash', {id='chest:'..dataProp.id})
                                        end
                                    end
                                else
                                    exports.ox_inventory:openInventory('stash', {id='chest:'..dataProp.id})
                                end
                            end, dataProp.id)
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
                                    dataProp.heading = dataProp.heading+90
                                    TriggerServerEvent('grvsc_faction:updateProp', dataProp, faction.id)
                                else
                                    dataProp.data.door.open = true
                                    dataProp.heading = dataProp.heading-90
                                    TriggerServerEvent('grvsc_faction:updateProp', dataProp, faction.id)
                                end
                            end
                        end
                    }
                end
                exports.ox_target:addLocalEntity(prop,target)
            end
        end)
    end)
end