ESX.RegisterServerCallback('grvsc_faction:getFaction', function(source, cb)
    local player = ESX.GetPlayerFromId(source)
    if player then
        local id = MySQL.Sync.fetchScalar('SELECT faction_id FROM faction_members WHERE member = @member', {['@member'] = player.identifier})
        if id then
            local faction = MySQL.Sync.fetchAll("SELECT * FROM faction_list WHERE id = @id", {['@id'] = id})
            cb(faction) -- renvoie les informations concernant la faction
        else
            cb(false) -- n'a pas de faction
        end
    end
end)
ESX.RegisterServerCallback('grvsc_faction:getAllFaction', function(source, cb)
    local faction = MySQL.Sync.fetchAll("SELECT * FROM faction_list")
    cb(faction)
end)
ESX.RegisterServerCallback('grvsc_faction:DoesPermission', function(source, cb)
    local player = ESX.GetPlayerFromId(source)
    -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    -- ICI PLUS TARD FAIRE UN SYSTEM QUI RENVOIE true (pas la permission) SI LE JOUEUR NA PAS UNE COMPETENCE LEVEL 5 PAR EXEMPLE
    -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    cb(false)
end)
ESX.RegisterServerCallback('grvsc_faction:getPlayer', function(source, cb)
    local player = ESX.GetPlayerFromId(source)
    if player then
        local id = MySQL.Sync.fetchAll('SELECT * FROM faction_members WHERE member = @member', {['@member'] = player.identifier})
        cb(id)
    else
        cb(false)
    end
end)
ESX.RegisterServerCallback('grvsc_faction:fetchAllMembers', function(source, cb)
    local player = ESX.GetPlayerFromId(source)
    if player then
        local id = MySQL.Sync.fetchScalar('SELECT faction_id FROM faction_members WHERE member = @member', {['@member'] = player.identifier})
        local members = MySQL.Sync.fetchAll('SELECT * FROM faction_members WHERE faction_id = @id', {['@id'] = id})
        cb(members)
    else
        cb(false)
    end
end)
ESX.RegisterServerCallback('grvsc_faction:getPermissions', function(source, cb, faction_id)
    local faction = MySQL.Sync.fetchScalar("SELECT permissions FROM faction_list WHERE id = @id", {['@id'] = faction_id})
    cb(faction)
end)
ESX.RegisterServerCallback('grvsc_faction:getMemberfromrank', function(source, cb, faction_id, rank)
    local members = MySQL.Sync.fetchAll('SELECT * FROM faction_members WHERE faction_id = @id AND grade = @rank', {['@id'] = faction_id, ['@rank'] = rank})
    cb(#members)
end)
RegisterNetEvent('grvsc_faction:createFaction')
AddEventHandler('grvsc_faction:createFaction', function(name, blip, color)
    local permissions = {
        ['Chef'] = {
            hierarchy = 15, -- MAXIMUM
            -- MEMBER
            recruit = true,
            kick = true,
            promote = true,
            -- GRADE
            creategrade = true,
            modifygrade = true,
            deletegrade = true,
            -- FACTION
            modifyfactionname = true,
            modifyfactioncolor = true,
            modifyfactionblip = true,
            modifyfactioncoords = true,
            -- BUILDING
            builddestroy = true,
            default = false
        },
        ['Membre'] = {
            hierarchy = 0,
            -- MEMBER
            recruit = false,
            kick = false,
            promote = false,
            -- GRADE
            creategrade = false,
            modifygrade = false,
            deletegrade = false,
            -- FACTION
            modifyfactionname = false,
            modifyfactioncolor = false,
            modifyfactionblip = false,
            modifyfactioncoords = false,
            -- BUILDING
            builddestroy = false,
            default = true
        }
    }
    local player = ESX.GetPlayerFromId(source)
    MySQL.Sync.execute("INSERT INTO `faction_list`(`faction_name`, `color`, `blip`, `permissions`) VALUES (@name, @color, @blip, @permissions)", {['@name'] = name, ['@color'] = color, ['@blip'] = blip, ['@permissions'] = json.encode(permissions)})
    Wait(0)
    -- Utilisez MySQL.Async.fetchScalar pour obtenir l'ID auto-incrémenté
    MySQL.Async.fetchScalar("SELECT LAST_INSERT_ID() as id", {}, function(id)
        MySQL.Sync.execute("INSERT INTO `faction_members`(`member`, `grade`, `faction_id`) VALUES (@member,'Chef',@id)", {['@member'] = player.identifier, ['@id'] = id})
    end)
end)
RegisterNetEvent('grvsc_faction:newClaim')
AddEventHandler('grvsc_faction:newClaim', function(faction, coords)
    MySQL.Async.execute("UPDATE `faction_list` SET `coords`=@coords WHERE id = @id", {['@id'] = faction, ['@coords'] = json.encode(coords)})
    -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    -- BIEN PENSER A APPELLER LEVENT/FONCTION QUI DELETE TOUT LES PROPS DE LA BASE DE DONNEE DE LANCIEN TERRITOIRE
    -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
end)
RegisterNetEvent('grvsc_faction:updateName')
AddEventHandler('grvsc_faction:updateName', function(faction, name)
    MySQL.Async.execute("UPDATE `faction_list` SET `faction_name`=@name WHERE id = @id", {['@id'] = faction, ['@name'] = name})
end)
RegisterNetEvent('grvsc_faction:updateColor')
AddEventHandler('grvsc_faction:updateColor', function(faction, color)
    MySQL.Async.execute("UPDATE `faction_list` SET `color`=@color WHERE id = @id", {['@id'] = faction, ['@color'] = color})
end)
RegisterNetEvent('grvsc_faction:updateBlip')
AddEventHandler('grvsc_faction:updateBlip', function(faction, blip)
    MySQL.Async.execute("UPDATE `faction_list` SET `blip`=@blip WHERE id = @id", {['@id'] = faction, ['@blip'] = blip})
end)
RegisterNetEvent('grvsc_faction:kickPlayer')
AddEventHandler('grvsc_faction:kickPlayer', function(target, faction, auteur)
    local gradeauteur = MySQL.Sync.fetchScalar("SELECT grade FROM faction_members WHERE faction_id = @faction AND member = @member", {['@faction'] = faction, ['@member'] = auteur})
    local gradetarget = MySQL.Sync.fetchScalar("SELECT grade FROM faction_members WHERE faction_id = @faction AND member = @member", {['@faction'] = faction, ['@member'] = target})
    local permissions = MySQL.Sync.fetchScalar("SELECT permissions FROM faction_list WHERE id = @faction", {['@faction'] = faction})
    permissions = json.decode(permissions)
    if permissions[gradeauteur].hierarchy > permissions[gradetarget].hierarchy then
        if permissions[gradeauteur].kick then
            MySQL.Async.execute("DELETE FROM `faction_members` WHERE member=@member", {['@member'] = target})
        end
    end
end)
RegisterNetEvent('grvsc_faction:promote')
AddEventHandler('grvsc_faction:promote', function(target, faction, auteur, rank)
    local gradeauteur = MySQL.Sync.fetchScalar("SELECT grade FROM faction_members WHERE faction_id = @faction AND member = @member", {['@faction'] = faction, ['@member'] = auteur})
    local gradetarget = MySQL.Sync.fetchScalar("SELECT grade FROM faction_members WHERE faction_id = @faction AND member = @member", {['@faction'] = faction, ['@member'] = target})
    local permissions = MySQL.Sync.fetchScalar("SELECT permissions FROM faction_list WHERE id = @faction", {['@faction'] = faction})
    permissions = json.decode(permissions)
    if permissions[gradeauteur].hierarchy > permissions[gradetarget].hierarchy then
        if permissions[gradeauteur].promote then
            MySQL.Async.execute("UPDATE `faction_members` SET `grade`=@rank WHERE member=@member", {['@member'] = target, ['@rank'] = rank})
        end
    end
end)
RegisterNetEvent('grvsc_faction:setPermission')
AddEventHandler('grvsc_faction:setPermission', function(auteur, faction, permissionName, value, grade)
    local gradeauteur = MySQL.Sync.fetchScalar("SELECT grade FROM faction_members WHERE faction_id = @faction AND member = @member", {['@faction'] = faction, ['@member'] = auteur})
    local permissions = MySQL.Sync.fetchScalar("SELECT permissions FROM faction_list WHERE id = @faction", {['@faction'] = faction})
    permissions = json.decode(permissions)
    if permissions[gradeauteur].hierarchy > permissions[grade].hierarchy then
        if permissions[gradeauteur][permissionName] then
            if value then
                permissions[grade][permissionName] = false
            else
                permissions[grade][permissionName] = true
            end
            permissions = json.encode(permissions)
            MySQL.Async.execute("UPDATE `faction_list` SET `permissions`='"..permissions.."' WHERE id="..faction.."")
        end
    end
end)
RegisterNetEvent('grvsc_faction:changeRankName')
AddEventHandler('grvsc_faction:changeRankName', function(grade, faction, auteur, name)
    local gradeauteur = MySQL.Sync.fetchScalar("SELECT grade FROM faction_members WHERE faction_id = @faction AND member = @member", {['@faction'] = faction, ['@member'] = auteur})
    local permissions = MySQL.Sync.fetchScalar("SELECT permissions FROM faction_list WHERE id = @faction", {['@faction'] = faction})
    permissions = json.decode(permissions)
    if permissions[gradeauteur].hierarchy > permissions[grade].hierarchy then
        permissions[name] = permissions[grade]
        permissions[grade] = nil
        permissions = json.encode(permissions)
        MySQL.Async.execute("UPDATE `faction_list` SET `permissions`='"..permissions.."' WHERE id="..faction.."")
        MySQL.Async.execute("UPDATE `faction_members` SET `grade`=@name WHERE grade=@grade AND faction_id=@faction",{['@grade'] = grade, ['@name'] = name, ['@faction']=faction})
    end
end)
RegisterNetEvent('grvsc_faction:changeRankHierarchy')
AddEventHandler('grvsc_faction:changeRankHierarchy', function(grade, faction, auteur, number)
    local gradeauteur = MySQL.Sync.fetchScalar("SELECT grade FROM faction_members WHERE faction_id = @faction AND member = @member", {['@faction'] = faction, ['@member'] = auteur})
    local permissions = MySQL.Sync.fetchScalar("SELECT permissions FROM faction_list WHERE id = @faction", {['@faction'] = faction})
    permissions = json.decode(permissions)
    if permissions[gradeauteur].hierarchy > permissions[grade].hierarchy and permissions[gradeauteur].hierarchy > number then
        permissions[grade].hierarchy = number
        permissions = json.encode(permissions)
        MySQL.Async.execute("UPDATE `faction_list` SET `permissions`='"..permissions.."' WHERE id="..faction.."")
    end
end)
RegisterNetEvent('grvsc_faction:addMember')
AddEventHandler('grvsc_faction:addMember', function(auteur, target, name, faction)
    local gradeauteur = MySQL.Sync.fetchScalar("SELECT grade FROM faction_members WHERE faction_id = @faction AND member = @member", {['@faction'] = faction, ['@member'] = auteur})
    local permissions = MySQL.Sync.fetchScalar("SELECT permissions FROM faction_list WHERE id = @faction", {['@faction'] = faction})
    permissions = json.decode(permissions)
    if permissions[gradeauteur].recruit == true then
        for k, v in pairs(permissions) do
            if v.default == true then
                local player = ESX.GetPlayerFromId(target)
                if player then
                    local exist = MySQL.Sync.fetchScalar("SELECT faction_id FROM faction_members WHERE member = @member", {['@member'] = player.identifier})
                    if not exist then
                        MySQL.Sync.execute("INSERT INTO `faction_members`(`member`, `grade`, `faction_id`, `member_name`) VALUES (@member,@grade,@id,@name)", {['@member'] = player.identifier,['@grade'] = k ,['@id'] = faction, ['@name'] = name})
                    end
                end
                break
            end
        end
    end
end)
RegisterNetEvent('grvsc_faction:createRank')
AddEventHandler('grvsc_faction:createRank', function(auteur, name, hierarchy, faction)
    local gradeauteur = MySQL.Sync.fetchScalar("SELECT grade FROM faction_members WHERE faction_id = @faction AND member = @member", {['@faction'] = faction, ['@member'] = auteur})
    local permissions = MySQL.Sync.fetchScalar("SELECT permissions FROM faction_list WHERE id = @faction", {['@faction'] = faction})
    permissions = json.decode(permissions)
    if permissions[gradeauteur].creategrade == true then
        permissions[name] = {
            hierarchy = hierarchy, -- MAXIMUM
            -- MEMBER
            recruit = false,
            kick = false,
            promote = false,
            -- GRADE
            creategrade = false,
            modifygrade = false,
            deletegrade = false,
            -- FACTION
            modifyfactionname = false,
            modifyfactioncolor = false,
            modifyfactionblip = false,
            modifyfactioncoords = false,
            -- BUILDING
            builddestroy = false,
            default = false
        }
        permissions = json.encode(permissions)
        MySQL.Async.execute("UPDATE `faction_list` SET `permissions`='"..permissions.."' WHERE id="..faction.."")
    end
end)
RegisterNetEvent('grvsc_faction:deleteRank')
AddEventHandler('grvsc_faction:deleteRank', function(auteur, grade, faction)
    local gradeauteur = MySQL.Sync.fetchScalar("SELECT grade FROM faction_members WHERE faction_id = @faction AND member = @member", {['@faction'] = faction, ['@member'] = auteur})
    local permissions = MySQL.Sync.fetchScalar("SELECT permissions FROM faction_list WHERE id = @faction", {['@faction'] = faction})
    permissions = json.decode(permissions)
    if permissions[gradeauteur].hierarchy > permissions[grade].hierarchy then
        local members = MySQL.Sync.fetchAll('SELECT * FROM faction_members WHERE faction_id = @id AND grade = @rank', {['@id'] = faction, ['@rank'] = grade})
        if #members == 0 then
            permissions[grade] = nil
            MySQL.Async.execute("UPDATE `faction_list` SET `permissions`='"..permissions.."' WHERE id="..faction.."")
        end
    end
end)
RegisterNetEvent('grvsc_faction:leaveFaction')
AddEventHandler('grvsc_faction:leaveFaction', function(auteur, faction)
    local gradeauteur = MySQL.Sync.fetchScalar("SELECT grade FROM faction_members WHERE faction_id = @faction AND member = @member", {['@faction'] = faction, ['@member'] = auteur})
    if gradeauteur ~= 'Chef' then
        MySQL.Sync.execute('DELETE FROM `faction_members` WHERE faction_id = @faction AND member = @member', {['@faction'] = faction, ['@member'] = auteur})
    end
end)
RegisterNetEvent('grvsc_faction:addProp')
AddEventHandler('grvsc_faction:addProp', function(auteur, faction_id, prop, coords, heading)
    local gradeauteur = MySQL.Sync.fetchScalar("SELECT grade FROM faction_members WHERE faction_id = @faction AND member = @member", {['@faction'] = faction_id, ['@member'] = auteur})
    local permissions = MySQL.Sync.fetchScalar("SELECT permissions FROM faction_list WHERE id = @faction", {['@faction'] = faction_id})
    permissions = json.decode(permissions)
    if permissions[gradeauteur].builddestroy then
        local props = MySQL.Sync.fetchScalar("SELECT props FROM faction_list WHERE id = @faction", {['@faction'] = faction_id})
        if props then
            props = json.decode(props)
        else
            props = {}
        end
        props[#props+1] = {data = prop, coords = coords, heading = heading}
        props = json.encode(props)
        MySQL.Sync.execute("UPDATE `faction_list` SET `props`='"..props.."' WHERE id="..faction_id.."")
    end
end)
RegisterNetEvent('grvsc_faction:removeProp')
AddEventHandler('grvsc_faction:removeProp', function(auteur, faction_id, coords)
    local source = source
    local gradeauteur = MySQL.Sync.fetchScalar("SELECT grade FROM faction_members WHERE faction_id = @faction AND member = @member", {['@faction'] = faction_id, ['@member'] = auteur})
    local permissions = MySQL.Sync.fetchScalar("SELECT permissions FROM faction_list WHERE id = @faction", {['@faction'] = faction_id})
    permissions = json.decode(permissions)
    if permissions[gradeauteur].builddestroy then
        local props = MySQL.Sync.fetchScalar("SELECT props FROM faction_list WHERE id = @faction", {['@faction'] = faction_id})
        props = json.decode(props)
        for k, v in pairs(props) do
            v.coords = vec3(v.coords.x,v.coords.y, v.coords.z)
            coords = vec3(coords.x,coords.y, coords.z)
            if v.coords == coords then
                exports.ox_inventory:AddItem(source, v.data.name, 1)
                props[k] = nil
            end
        end
        if #props > 0 then
            props = json.encode(props)
            MySQL.Sync.execute("UPDATE `faction_list` SET `props`='"..props.."' WHERE id="..faction_id.."")
        else
            MySQL.Sync.execute("UPDATE `faction_list` SET `props`=NULL WHERE id="..faction_id.."")
        end
    end
end)

exports.ox_inventory:RegisterStash('test', 'Faction', 10, 10000)

-- local props = MySQL.Sync.fetchScalar('SELECT props FROM faction_list WHERE id = 25')
-- props = json.decode(props)
-- for k, v in pairs(props) do
--     print(k, v.name, v.coords)
-- end
-- local props = {}
-- local i = 200
-- while i > 0 do
--     i = i-1
--     Wait(0)
--     table.insert(props, 
--         {
--             name = 'prop_air_watertank2',
--             coords = vec3(0, 0, 0)
--         }
    
--     )
-- end
-- props = json.encode(props)
-- MySQL.Async.execute("UPDATE `faction_list` SET `props`='"..props.."' WHERE id=25")
-- print('finish')