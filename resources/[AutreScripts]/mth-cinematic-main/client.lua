local inCinematic = true
local finalPos = vector3(304.444824, -1204.422729, 38.892593)

local function Subtitle(text, time)
    ClearPrints()
    BeginTextCommandPrint("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandPrint(time and math.ceil(time) or 0, true)
end

RegisterNetEvent("mth-cinematic:start")
AddEventHandler("mth-cinematic:start", function()
    local pos = GetEntityCoords(PlayerPedId())
    DisplayRadar(false)
    DoScreenFadeOut(100)
    Wait(100)
    for i = 1, #Config do
        local endCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamCoord(endCam, Config[i].endPos)
        PointCamAtCoord(endCam, Config[i].endLookAt)
        local startCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamCoord(startCam, Config[i].startPos)
        PointCamAtCoord(startCam, Config[i].startLookAt)
        NewLoadSceneStartSphere(Config[i].endPos, 1000, 0)
        while not IsNewLoadSceneLoaded() do
            Wait(0)
        end
        RenderScriptCams(true, false, 0, true, true)
        DoScreenFadeIn(200)
        Wait(200)
        Subtitle(Config[i].text, Config[i].duration)
        SetCamActiveWithInterp(endCam, startCam, Config[i].duration, 1, 1)
        Wait(Config[i].duration - 500)
        DoScreenFadeOut(1200)
        Wait(1500)
        DestroyCam(startCam, false)
        DestroyCam(endCam, false)
        NewLoadSceneStop()
    end
    Wait(2000)
    SetEntityCoords(PlayerPedId(), pos.x, pos.y, pos.z)
    RenderScriptCams(false, false, 0, true, true)
    DoScreenFadeIn(2000)
    inCinematic = false
    DisplayRadar(true)
end)

RegisterCommand("cinematic", function()
    TriggerEvent("mth-cinematic:start")
end)