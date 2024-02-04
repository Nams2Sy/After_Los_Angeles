local stations = {}

local function load()
    stations = {}

    local response = MySQL.query.await('SELECT * FROM `als_stations`', {})
    if not response then return end

    for i = 1, #response do
        local row = response[i]

        local coords = json.decode(row.coords)
        local vec3 = vector3(coords.x, coords.y, coords.z)

        local station = Station:new(nil, row.id, vec3, row.type, row.recipe_queue, row.time_left, row.output)
        stations[station.id] = station
    end
end

load()