-- station
-- id  location  type  inventory

local stations = {}

local function saveStation(station)
    local response = MySQL.prepare.await(
        'INSERT INTO als_stations (`id`, `coords`, `type`, `recipe`, `input`, `output`) VALUES (?, ?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE `coords` = VALUES(coords), `type` = VALUES(type), `recipe` = VALUES(recipe), `input` = VALUES(input), `output` = VALUES(output)',
        {
            station.id,
            json.encode(station.coords),
            station.type,
            station.recipe,
            json.encode(station.input),
            json.encode(station.output)
        }
    )
    return response
end

lib.callback.register("als_stations:get_stations", function (source)
    local response = MySQL.query.await('SELECT * FROM als_stations', {})

    local stations = {}
    for _, row in ipairs(response) do
        local loc = json.decode(row.coords)
        local coords = vector3(loc.x, loc.y, loc.z)
        table.insert(stations, {
            id = row.id,
            coords = coords,
            type = row.type,
            recipe = row.recipe,
            input = json.decode(row.input),
            output = json.decode(row.output),
        })
    end
    return stations
end)

local function getStation(station_id)
    local response = MySQL.single.await('SELECT * FROM als_stations WHERE id = ?', { station_id })

    local loc = json.decode(response.coords)
    local coords = vector3(loc.x, loc.y, loc.z)

    local station = {
        id = response.id,
        coords = coords,
        type = response.type,
        recipe = response.recipe,
        input = json.decode(response.input),
        output = json.decode(response.output)
    }

    return station
end

lib.callback.register("als_stations:get_station", function (station_id)
    return getStation(station_id)
end)

RegisterNetEvent("als_stations:craft", function (source, station_id, recipe_id)
    local station = getStation(station_id)
    local recipe = Utils.GetRecipe(station.type, recipe_id)

    for _, item_data in ipairs(recipe.input) do
        local quantity = tonumber(Utils.Split(item_data, ":")[1])
        local item = Utils.Split(item_data, ":")[2]

        local count = exports.ox_inventory:GetItemCount(source, item)
        if count < quantity then
            TriggerClientEvent('ox_lib:notify', source, {
                id = 'not_enough_items',
                title = 'Pas assez de '..item,
                description = 'Il vous faut '..tostring(quantity).." "..item..".",
                position = 'top',
                style = {
                    backgroundColor = '#141517',
                    color = '#C1C2C5',
                    ['.description'] = {
                      color = '#909296'
                    }
                },
                icon = 'ban',
                iconColor = '#C53030'
            })
            return
        end
    end

    for _, item_data in ipairs(recipe.input) do
        local quantity = tonumber(Utils.Split(item_data, ":")[1])
        local item = Utils.Split(item_data, ":")[2]

        exports.ox_inventory:RemoveItem(source, item, quantity)

        table.insert(station.input, tostring(quantity)..":"..item)
    end

    station.recipe = recipe.id

    saveStation(station)
end)

CreateThread(function ()
    
    Wait(1)
end)

RegisterCommand("createstation", function (source, args)
    local station = {
        id = 1,
        coords = GetEntityCoords(GetPlayerPed(source)),
        type = "FURNACE",
        recipe = -1,
        input = {},
        output = {}
    }
    saveStation(station)
    table.insert(stations, station)
    TriggerClientEvent("crafting:update_stations", source)
end, false)
