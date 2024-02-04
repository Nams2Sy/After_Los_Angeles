function GetStation(station_id)
    local station_data = lib.callback.await("als_stations:getStation", false, station_id)
    if not station_data then return end
    return Station:new(nil, station_data.id, station_data.coords, station_data.type, station_data.recipe_queue, station_data.time_left, station_data.output)
end
