ESX.RegisterServerCallback('grvsc_faction:getFaction', function(source, cb)
    local player = ESX.GetPlayerFromId(source)
    local id = MySQL.Sync.fetchScalar('SELECT faction_id FROM faction_members WHERE member = @member', {['@member'] = player.identifier})
    if id then
        local faction = MySQL.Sync.fetchScalar("SELECT * FROM faction_list WHERE id = @id", {['@id'] = id})
        cb(faction) -- renvoie les informations concernant la faction
    else
        cb(false) -- n'a pas de faction
    end
end)
ESX.RegisterServerCallback('grvsc_faction:DoesPermission', function(source, cb)
    local player = ESX.GetPlayerFromId(source)
    -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    -- ICI PLUS TARD FAIRE UN SYSTEM QUI RENVOIE true (par la permission) SI LE JOUEUR NA PAS UNE COMPETENCE LEVEL 5 PAR EXEMPLE
    -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    cb(false)
end)
ESX.RegisterServerCallback('grvsc_faction:createFaction', function(source, cb, name, color)
    local player = ESX.GetPlayerFromId(source)
    MySQL.Sync.execute("INSERT INTO `faction_list`(`faction_name`, `color`) VALUES (@name, @color)", {['@name'] = name, ['@color'] = color})
    Wait(0)
    -- Utilisez MySQL.Async.fetchScalar pour obtenir l'ID auto-incrémenté
    MySQL.Async.fetchScalar("SELECT LAST_INSERT_ID() as id", {}, function(id)
        MySQL.Sync.execute("INSERT INTO `faction_members`(`member`, `grade`, `faction_id`) VALUES (@member,'chef',@id)", {['@member'] = player.identifier, ['@id'] = id})
    end)
    cb(true)
end)

