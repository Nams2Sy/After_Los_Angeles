-- station
-- id  location  type  inventory

local stations = {}

local function saveStation(station)
    local response = MySQL.prepare.await(
        'INSERT INTO als_stations (`id`, `coords`, `type`, `recipe`, `craft_started`, `input`, `output`) VALUES (?, ?, ?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE `coords` = VALUES(coords), `type` = VALUES(type), `recipe` = VALUES(recipe), `craft_started` = VALUES(craft_started), `input` = VALUES(input), `output` = VALUES(output)',
        {
            station.id,
            json.encode(station.coords),
            station.type,
            station.recipe,
            station.craft_started,
            json.encode(station.input),
            json.encode(station.output)
        }
    )
    return response
end

local function tick(station)
    if station.recipe ~= -1 then
        local recipe = Utils.GetRecipe(station.type, station.recipe)
        if os.time() - station.craft_started >= recipe.time then

            -- Check if input has enough items
            local items_needed = table.clone(recipe.input)
            for index, item_needed in ipairs(items_needed) do
                for _, item in ipairs(station.input) do
                    if item.name == item_needed.name and item.quantity >= item_needed.quantity then
                        table.remove(items_needed, index)
                    end
                end
            end

            -- Cancel craft if not
            if #items_needed > 0 then
                print("craft failed")
            else
                print("craft success")
                -- Removing input items when craft finished
                for _, item_needed in ipairs(recipe.input) do
                    print("needed: ".. item_needed.name)
                    for index, item in ipairs(station.input) do
                        print("looped: ".. item.name)
                        if item.name == item_needed.name and item.quantity >= item_needed.quantity then
                            print("item needed!")
                            table.remove(station.input, index)
                        end
                    end
                end

                -- Adding output items
                for _, item in ipairs(recipe.output) do
                    table.insert(station.output, item)
                end
            end
            station.recipe = -1
            station.craft_started = -1
        end
    end
    return station
end

lib.callback.register("als_stations:get_stations", function (source)
    local response = MySQL.query.await('SELECT * FROM als_stations', {})

    local stations = {}
    for _, row in ipairs(response) do
        local loc = json.decode(row.coords)
        local coords = vector3(loc.x, loc.y, loc.z)
        local station = tick({
            id = row.id,
            coords = coords,
            type = row.type,
            craft_started = row.craft_started,
            recipe = row.recipe,
            input = json.decode(row.input),
            output = json.decode(row.output),
        })
        table.insert(stations, station)
    end
    return stations
end)

local function getStation(station_id)
    local response = MySQL.single.await('SELECT * FROM als_stations WHERE id = ?', { station_id })

    local loc = json.decode(response.coords)
    local coords = vector3(loc.x, loc.y, loc.z)

    local station = tick({
        id = response.id,
        coords = coords,
        type = response.type,
        recipe = response.recipe,
        craft_started = response.craft_started,
        input = json.decode(response.input),
        output = json.decode(response.output)
    })

    return station
end

lib.callback.register("als_stations:os_time", function ()
    return os.time()
end)

lib.callback.register("als_stations:get_station", function (station_id)
    return getStation(station_id)
end)

lib.callback.register("als_stations:craft", function (source, station_id, recipe_id)
    local station = getStation(station_id)
    local recipe = Utils.GetRecipe(station.type, recipe_id)

    for _, item in ipairs(recipe.input) do
        local count = exports.ox_inventory:GetItemCount(source, item.name)
        if count < item.quantity then
            TriggerClientEvent('ox_lib:notify', source, {
                id = 'not_enough_items',
                title = 'Pas assez de '..item.name,
                description = 'Il vous faut '..tostring(item.quantity).." "..item.name..".",
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

    for _, item in ipairs(recipe.input) do
        exports.ox_inventory:RemoveItem(source, item.name, item.quantity)
        table.insert(station.input, item)
    end

    station.recipe = recipe.id
    station.craft_started = os.time()

    saveStation(station)
end)

RegisterCommand("createstation", function (source, args)
    local station = {
        id = 1,
        coords = GetEntityCoords(GetPlayerPed(source)),
        type = "FURNACE",
        recipe = -1,
        craft_started = -1,
        input = {},
        output = {}
    }
    saveStation(station)
    table.insert(stations, station)
    TriggerClientEvent("crafting:update_stations", source)
end, false)
