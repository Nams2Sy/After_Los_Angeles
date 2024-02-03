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

RegisterNetEvent('grvsc_faction:createFaction')
AddEventHandler('grvsc_faction:createFaction', function(name, blip, color)
    local player = ESX.GetPlayerFromId(source)
    MySQL.Sync.execute("INSERT INTO `faction_list`(`faction_name`, `color`, `blip`) VALUES (@name, @color, @blip)", {['@name'] = name, ['@color'] = color, ['@blip'] = blip})
    Wait(0)
    -- Utilisez MySQL.Async.fetchScalar pour obtenir l'ID auto-incrémenté
    MySQL.Async.fetchScalar("SELECT LAST_INSERT_ID() as id", {}, function(id)
        MySQL.Sync.execute("INSERT INTO `faction_members`(`member`, `grade`, `faction_id`) VALUES (@member,'chef',@id)", {['@member'] = player.identifier, ['@id'] = id})
    end)
end)




