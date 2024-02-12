-- Enregistrez votre animation dans le fichier animations.meta de votre resource.
RegisterCommand("anim", function()
    RequestAnimDict("missbigscore2aig_3")
    while not HasAnimDictLoaded("missbigscore2aig_3") do
        Wait(500)
    end
    TaskPlayAnim(PlayerPedId(), "missbigscore2aig_3", "wait_for_van_c", 8.0, -8.0, -1, 1, 0, false, false, false)
end, false)
RegisterCommand("anim2", function()
    local ped = PlayerId()
    ClearPedTasks(PlayerPedId())
end, false)
RegisterCommand("spawnPeds", function()
    local playerPed = PlayerId()
    local playerCoords = GetEntityCoords(GetPlayerPed(-1))

    local radius = 30 -- Ajustez la distance entre les PNJs et le joueur
    local numPeds = 45 -- Nombre de PNJs à faire apparaître
    for i = 1, numPeds do
        Wait(100)
        local angle = (2 * math.pi / numPeds) * i
        local x = playerCoords.x + radius * math.cos(angle)
        local y = playerCoords.y + radius * math.sin(angle)
        RequestModel("a_m_m_hillbilly_01") -- Remplacez le modèle du PNJ selon votre choix
        while not HasModelLoaded("a_m_m_hillbilly_01") do
            Wait(500)
        end
        local ped = CreatePed(28, "a_m_m_hillbilly_01", x, y, playerCoords.z, 0.0, true, false)
        TaskWanderStandard(ped, true, true)
        SetEntityInvincible(ped, true)
        TaskCombatPed(ped, GetPlayerPed(-1), 0, 16)
        StopPedSpeaking(ped,true)
        SetEntityAsMissionEntity(ped, true, true)
        SetPedCombatMovement(ped, 0)
        SetRunSprintMultiplierForPlayer(ped, 0.30)
        local walk = 'anim_group_move_ballistic'
        RequestAnimSet(walk)
        while not HasAnimSetLoaded(walk) do
            Citizen.Wait(1)
        end
        SetPedMovementClipset(ped, walk, 1.5)
    end
end, false)


RegisterCommand('light', function(source, args, rawCommand)
    while true do
        Wait(0)
        local pos = GetEntityCoords(PlayerPedId())
        DrawLightWithRangeAndShadow(pos.x, pos.y, pos.z + 2, 255, 0, 0, 10.0, 100.0, 1.0)
    end
end, false)




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
