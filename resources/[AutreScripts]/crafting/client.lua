local stations = {}

local targets = {}

local current_station_id

local function registerRecipe(type)
    local options = {}
    if type == "FURNACE" then
        options = {
            {
                title = "1 raw metal = 1 ingot",
                onSelect = function ()
                    TriggerServerEvent("als_stations:craft", GetPlayerServerId(PlayerId()), current_station_id, 1)
                end
            }
        }
    end
    lib.registerContext({
        id = 'recipes:'..type,
        title = "Recettes du "..Utils.Translate(type),
        menu = "station",
        options = options
    })
end

registerRecipe("FURNACE")

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
        for _, item_data in ipairs(station.input) do
            local quantity = tonumber(Utils.Split(item_data, ":")[1])
            local item = Utils.Split(item_data, ":")[2]
    
            table.insert(options, {
                title = tostring(quantity).."x "..item,
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
        for _, item_data in ipairs(station.output) do
            local quantity = tonumber(Utils.Split(item_data, ":")[1])
            local item = Utils.Split(item_data, ":")[2]

            table.insert(options, {
                title = tostring(quantity).."x "..item,
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
        options = options
    })
    current_station_id = station_id
    lib.showContext('station')
end

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