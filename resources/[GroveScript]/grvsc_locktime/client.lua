NetworkOverrideClockTime(20, 0, 0)

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        SetWeatherTypePersist("HALLOWEEN")
        SetWeatherTypeNowPersist("HALLOWEEN")
        SetWeatherTypeNow("HALLOWEEN")
        SetArtificialLightsState(true)
        SetArtificialLightsStateAffectsVehicles(true)
        SetTimecycleModifier("RED")
        SetTransitionTimecycleModifier("RED", 0.0)
    end
end)