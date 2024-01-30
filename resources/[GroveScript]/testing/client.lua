Citizen.CreateThread(function()
    NetworkOverrideClockTime(23, 0, 0)
end)

-- Set the weather to stormy
SetWeatherTypePersist("HALLOWEEN")
SetWeatherTypeNowPersist("HALLOWEEN")
SetWeatherTypeNow("HALLOWEEN")

-- Set the light level to dark
SetArtificialLightsState(true)
SetArtificialLightsStateAffectsVehicles(true)

SetTimecycleModifier("RED")
SetTransitionTimecycleModifier("RED", 0.0)

-- Display a message to indicate the apocalypse ambiance
TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Welcome to the apocalypse!")