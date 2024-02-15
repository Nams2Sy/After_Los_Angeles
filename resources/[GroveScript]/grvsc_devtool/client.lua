local rope = nil

-- Fonction pour dessiner une ligne entre deux points
function DrawRope(x1, y1, z1, x2, y2, z2)
    local ped = GetPlayerPed(-1)

    local ropeCoords = {
        x1, y1, z1 - 0.95, -- Point A
        x2, y2, z2 - 0.95, -- Point B
    }

    local ropeEntity = Citizen.InvokeNative(0xFAA599A0353810D7, 2, ropeCoords, 7, 0, 0)

    return ropeEntity
end

-- Commande pour activer la corde
RegisterCommand('activercorde', function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local x2 = playerCoords.x + 2.0

    -- Dessine la corde entre le joueur et x+2
    rope = DrawRope(playerCoords.x, playerCoords.y, playerCoords.z, x2, playerCoords.y, playerCoords.z)
end, false)

-- Commande pour désactiver la corde
RegisterCommand('desactivercorde', function()
    if rope then
        -- Supprime la corde
        DeleteEntity(rope)
        rope = nil
    end
end, false)


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
    local pos = GetEntityCoords(PlayerPedId())
    local heading = GetEntityHeading(PlayerPedId())
    local headingRadians = math.rad(heading)
    local dirX = math.sin(-headingRadians)
    local dirY = math.cos(-headingRadians)
    local dirZ = 0.0 -- Ajustez si nécessaire pour l'angle vertical
    while true do
        Wait(0)
        local colorR = 255
        local colorG = 255
        local colorB = 255
        local distance = 30.0
        local brightness = 20.0
        local hardness = 2.0
        local radius = 8.0
        local falloff = 1.0
        -- DrawSpotLight(pos.x, pos.y, pos.z, dirX, dirY, dirZ, colorR, colorG, colorB, distance, brightness, hardness, radius, falloff)
        DrawSpotLightWithShadow(pos.x, pos.y, pos.z+1.67, dirX, dirY, dirZ, colorR, colorG, colorB, distance, brightness,  10.0, radius, falloff, 1.0)
    end
end, false)

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