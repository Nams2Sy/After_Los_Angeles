local build

local prop = nil -- Déclarer la variable en dehors de la boucle pour qu'elle soit accessible globalement

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if build then
            if not prop then
                -- Si la porte n'a pas encore été créée, la créer
                local coords = GetEntityCoords(PlayerPedId())
                local forwardVector = GetEntityForwardVector(PlayerPedId())
                local offset = 3
                local pos = coords + forwardVector * offset
                RequestModel("prop_door_01")
                while not HasModelLoaded("prop_door_01") do
                    Wait(500)
                end
                -- Créer le prop à la position spécifiée
                prop = CreateObject("prop_door_01", pos.x, pos.y, pos.z, true, true, true)
                -- Rendre la porte transparente (remplacez "mp_f_freemode_01" par le modèle de votre choix si nécessaire)
                SetEntityAlpha(prop, 150, false)
                -- Libérer le modèle maintenant qu'il est chargé
                SetModelAsNoLongerNeeded("prop_door_01")
                FreezeEntityPosition(prop,true)
            else
                -- Si la porte existe déjà, la mettre à jour pour suivre les mouvements du joueur
                local coords = GetEntityCoords(PlayerPedId())
                local forwardVector = GetEntityForwardVector(PlayerPedId())
                local offset = 3
                local pos = coords + forwardVector * offset
                SetEntityCoordsNoOffset(prop, pos.x, pos.y, pos.z, true, true, true)
                FreezeEntityPosition(prop,true)
            end
        elseif prop then
            -- Si le mode "build" est désactivé et que la porte existe, la supprimer
            DeleteEntity(prop)
            prop = nil -- Réinitialiser la variable
        end
    end

end)

RegisterCommand("build", function(source, args, rawCommand)
    if build then
        build = false
    else
        build = true
    end
end,false)

print('script load')