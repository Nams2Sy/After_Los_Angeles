lib.callback.register('als_stations:getStation', function(source, id)
    local station = GetStation(id)
    if not station then return end
    return {
        id = station.id,
        coords = station.coords,
        type = station.type,
        recipe_queue = station.recipe_queue,
        time_left = station.time_left,
        output = station.output
    }
end)

lib.callback.register("als_stations:craft", function (source, station_id, recipe_id)
    local station = GetStation(station_id)
    if not station then return end
    station:craft(recipe_id)
end)

lib.callback.register('als_stations:getTime', function(source)
    return os.time()
end)
