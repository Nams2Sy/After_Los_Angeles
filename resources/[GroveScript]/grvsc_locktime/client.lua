Citizen.CreateThread(function()
    while true do
        Wait(1000)
        NetworkOverrideClockTime(12, 0, 0)
        SetWeatherTypePersist("HALLOWEEN")
        SetWeatherTypeNowPersist("HALLOWEEN")
        SetWeatherTypeNow("HALLOWEEN")
        SetArtificialLightsState(true)
        SetArtificialLightsStateAffectsVehicles(false)
        SetTimecycleModifier("RED")
        SetTransitionTimecycleModifier("RED", 0.0)
    end
end)