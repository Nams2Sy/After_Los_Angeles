RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('getStationQueueRecipes', function(data, cb)
    local recipes = {}
    for _, recipe_id in ipairs(data.recipe_queue) do
        local recipe = Utils.GetRecipe(data.type, recipe_id)
        table.insert(recipes, recipe)
    end
    cb(recipes)
end)

RegisterNUICallback('getStation', function(data, cb)
    local station = GetStation(data.station_id)
    cb(station:toTable())
end)

RegisterNUICallback('craft', function(data, cb)
    lib.callback.await("als_stations:craft", false, data.station_id, data.recipe_id)
    cb(true)
end)

local function openMenu(station_id)
    local station = GetStation(station_id)
    if not station then return end
    print("open")
    SendNUIMessage({
        type = 'open',
        station = station:toTable(),
        recipes = Utils.GetRecipes(station.type)
    })
    SetNuiFocus(true, true)

    -- local options = {}

    -- table.insert(options, {
    --     title = 'Recettes',
    --     description = "Voir la liste des recettes possibles.",
    --     icon = "fa-solid fa-book",
    --     iconColor = "#e67e22",
    --     -- menu = "recipes:"..station.type,
    --     onSelect = function ()
    --         lib.callback.await("als_stations:craft", false, station.id, 1)
    --         Wait(5)
    --         openMenu(station.id)
    --     end
    -- })

    -- table.insert(options, {
    --     disabled = true,
    --     description = "↓ File d'attente ↓"
    -- })
    -- if #station.recipe_queue == 0 then
    --     table.insert(options, {
    --         title = "(Vide)",
    --     })
    -- else
    --     for index, recipe in ipairs(station.recipe_queue) do
    --         local recipe = Utils.GetRecipe(station.type, recipe)

    --         local progress
    --         if index == 1 then
    --             progress = station:getRecipePercentage()
    --         end

    --         table.insert(options, {
    --             title = tostring(recipe.output[1].quantity).."x "..recipe.output[1].name,
    --             progress = progress
    --         })
    --     end
    -- end

    -- table.insert(options, {
    --     disabled = true,
    --     description = "↓ Inventaire ↓"
    -- })
    -- if #station.output == 0 then
    --     table.insert(options, {
    --         title = "(Vide)",
    --     })
    -- else
    --     for _, item in ipairs(station.output) do
    --         table.insert(options, {
    --             title = tostring(item.quantity).."x "..item.name,
    --         })
    --     end
    -- end

    -- lib.registerContext({
    --     id = 'station'..station.id,
    --     title = string.upper(Utils.Translate(station.type)),
    --     options = options
    -- })
    -- lib.showContext('station'..station.id)
end

-- Refreshing UI
CreateThread(function ()
    while true do
        Wait(5000)
        local menu = lib.getOpenContextMenu()

        if not menu then return end
        if not Utils.StartsWith(menu, "station") then return end

        local station_id = tonumber(string.sub(menu, -1))
        openMenu(station_id)
    end
end)

RegisterCommand("station", function (source, args)
    local station_id = tonumber(args[1])
    print(args[1])
    openMenu(station_id)
end, false)