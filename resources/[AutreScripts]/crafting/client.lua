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
                    print(current_station_id)
                    TriggerServerEvent("als_stations:craft", current_station_id, {
                        input = { "1:raw_metal" },
                        output = { "1:ingot" } -- TODO check if recipe exist on serverside or add an identifier to make it unique
                    })
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

    lib.registerContext({
        id = 'station',
        title = string.upper(Utils.Translate(station.type)),
        options = {
            {
                title = 'INPUT',
            },
            {
                title = 'OUTPUT',
            },
            {
                title = 'Recettes',
                menu = "recipes:"..station.type
            },
        }
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