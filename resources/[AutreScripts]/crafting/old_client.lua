local stations = {}

local targets = {}

local current_station_id

local function openMenu(station_id)
    local station = lib.callback.await('als_stations:get_station', false, station_id)

    local options = {}

    table.insert(options, {
        disabled = true,
        description = "↓ Ingrédients ↓"
    })
    if #station.input == 0 then
        table.insert(options, {
            title = "(Vide)",
        })
    else
        for _, item in ipairs(station.input) do
            table.insert(options, {
                title = tostring(item.quantity).."x "..item.name,
            })
        end
    end

    table.insert(options, {
        disabled = true,
        description = "↓ Sortie ↓"
    })
    if #station.output == 0 then
        table.insert(options, {
            title = "(Vide)",
        })
    else
        for _, item in ipairs(station.output) do
            table.insert(options, {
                title = tostring(item.quantity).."x "..item.name,
            })
        end
    end

    table.insert(options, {
        title = 'Recettes',
        description = "Voir la liste des recettes possibles.",
        icon = "fa-solid fa-book",
        iconColor = "#e67e22",
        menu = "recipes:"..station.type
    })

    lib.registerContext({
        id = 'station',
        title = string.upper(Utils.Translate(station.type)),
        onExit = function ()
            if lib.progressActive() then lib.cancelProgress() end
        end,
        options = options
    })
    current_station_id = station_id
    lib.showContext('station')

    if station.recipe == -1 then return end
    local recipe = Utils.GetRecipe(station.type, station.recipe)

    local time = lib.callback.await("als_stations:os_time", false)
    if lib.progressBar({
        duration = (recipe.time - (time - station.craft_started)) * 1000,
        label = 'Fabrication de '..recipe.output[1].name,
    }) then
        openMenu(station.id)
    else
        print('Do stuff when cancelled')
    end
end

local function registerRecipe(type)
    local options = {}
    if type == "FURNACE" then
        for _, recipe in ipairs(Config.Recipes[type]) do
            table.insert(options, {
                title = tostring(recipe.output[1].quantity).."x "..recipe.output[1].name,
                description = "Pour "..tostring(recipe.input[1].quantity).."x "..recipe.input[1].name,
                onSelect = function ()
                    lib.callback('als_stations:craft', false, function(response)
                        openMenu(current_station_id)
                    end, GetPlayerServerId(PlayerId()), current_station_id, recipe.id)
                end
            })
        end
    end
    lib.registerContext({
        id = 'recipes:'..type,
        title = "Recettes du "..Utils.Translate(type),
        menu = "station",
        onExit = function ()
            if lib.progressActive() then lib.cancelProgress() end
        end,
        options = options
    })
end

registerRecipe("FURNACE")

local function refreshTargets()
    for _, id in ipairs(targets) do
        exports.ox_target:removeZone(id)
    end
    targets = {}

    stations = lib.callback.await('als_stations:get_stations', false)

    for _, station in ipairs(stations) do
        table.insert(targets, exports.ox_target:addBoxZone({
            coords = station.coords,
            options = {
                {
                    label = "Ouvrir le "..Utils.Translate(station.type),
                    onSelect = function (data)
                        openMenu(station.id)
                    end
                }
            }
        }))
    end
end

refreshTargets()

RegisterNetEvent("crafting:update_stations", function()
    refreshTargets()
end)