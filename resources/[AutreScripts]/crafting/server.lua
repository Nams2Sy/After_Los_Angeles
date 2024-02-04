-- station
-- id  location  type  inventory

local stations = {}

local function saveStation(station)
    local response = MySQL.prepare.await(
        'INSERT INTO als_stations (`id`, `coords`, `type`, `input`, `output`) VALUES (?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE `coords` = VALUES(coords), `type` = VALUES(type), `input` = VALUES(input), `output` = VALUES(output)',
        {
            station.id,
            json.encode(station.coords),
            station.type,
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
        input = json.decode(response.input),
        output = json.decode(response.output)
    }

    return station
end

lib.callback.register("als_stations:get_station", function (source, station_id)
    return getStation(station_id)
end)

RegisterNetEvent("als_stations:craft", function (station_id, recipe)
    local station = getStation(station_id)
    for _, item in ipairs(recipe.input) do
        local quantity = Utils.Split(item, ":")[1]
        local item = Utils.Split(item, ":")[2]
    end
end)

RegisterCommand("createstation", function (source, args)
    local station = {
        id = 1,
        coords = GetEntityCoords(GetPlayerPed(source)),
        type = "FURNACE",
        input = {},
        output = {}
    }
    saveStation(station)
    table.insert(stations, station)
    TriggerClientEvent("crafting:update_stations", source)
end, false)
