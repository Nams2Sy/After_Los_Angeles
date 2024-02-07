

local keybind = lib.addKeybind({
    name = 'particle',
    description = 'particle test',
    defaultKey = 'Y',
    onPressed = function(self)
        local input = lib.inputDialog('Hey', {
            {type = 'input', label = 'Particle name', required = true, min = 1, max = 200},
            {type = 'number', label = 'Loop', min = 2, max = 200},
            {type = 'number', label = 'Distance', required = true, min = 2, max = 200, default = 5},
            {type = 'number', label = 'Taille', required = true, min = 2, max = 200, default = 5.0},
        })
        if input then
            if input[2] then
                showParticle(input[1], input[2], input[3], input[4])
            elseif input then
                showParticle(input[1], 0, input[3], input[4])
            end
        end
    end,
})
function showParticle(particle, loop, distance, scale)
    NetworkOverrideClockTime(12, 0, 0)
    Citizen.CreateThread(function()
        SetWeatherTypePersist("CLEAR")
        SetWeatherTypeNowPersist("CLEAR")
        SetWeatherTypeNow("CLEAR")
        SetArtificialLightsState(true)
        SetArtificialLightsStateAffectsVehicles(true)
    end)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local forwardVector = GetEntityForwardVector(playerPed)
    local offset = distance
    local fireCoords = coords + forwardVector * offset
    if loop > 0 then
        while 0 < loop do
            Wait(100)
            loop = loop -1
            UseParticleFxAssetNextCall("core")
            StartParticleFxLoopedAtCoord(particle, fireCoords.x, fireCoords.y, fireCoords.z-0.5, 0.0, 0.0, 0.0, scale+1.0, false, false, false, false)
        end
    else
        UseParticleFxAssetNextCall("core")
        local fireParticle = StartParticleFxLoopedAtCoord(particle, fireCoords.x, fireCoords.y, fireCoords.z-0.5, 0.0, 0.0, 0.0, 5.0, scale+1.0, false, false, false)
        Wait(4000)
        StopParticleFxLooped(fireParticle, false)
    end
end
