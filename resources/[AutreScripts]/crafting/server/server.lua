Stations = {}

local function load()
    Stations = {}

    local response = MySQL.query.await('SELECT * FROM `als_stations`', {})
    if not response then return end

    for i = 1, #response do
        local row = response[i]

        local coords = json.decode(row.coords)
        local vec3 = vector3(coords.x, coords.y, coords.z)

        local station = Station:new(
            nil,
            row.id,
            vec3,
            row.type,
            json.decode(row.recipe_queue),
            row.time_left,
            json.decode(row.output)
        )
        table.insert(Stations, station)
    end
end

load()

local function save(station)
    local response = MySQL.prepare.await('INSERT INTO als_stations (`id`, `coords`, `type`, `recipe_queue`, `time_left`, `output`) VALUES (?, ?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE `coords` = VALUES(coords), `type` = VALUES(type), `recipe_queue` = VALUES(recipe_queue), `time_left` = VALUES(time_left), `output` = VALUES(output)', {
        station.id,
        json.encode(station.coords),
        station.type,
        station.recipe_queue,
        station.time_left,
        json.encode(station.output)
    })
end

CreateThread(function ()
    while true do
        Wait(Config.Tick)
        for _, station in ipairs(Stations) do
            station:tick()
        end
    end
end)

CreateThread(function ()
    while true do
        Wait(10000)
        for _, station in ipairs(Stations) do
            save(station)
        end
    end
end)

function GetStation(id)
    for _, station in ipairs(Stations) do
        if station.id == id then return station end
    end
end
