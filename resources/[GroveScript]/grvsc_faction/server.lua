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
            builddestroy = true
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
            builddestroy = false
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