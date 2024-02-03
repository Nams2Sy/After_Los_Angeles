
allMoneyData = {}

RegisterServerEvent(Config.ServerLoadedEvent,function(val)
    if Config.Framework == "esx" or Config.Framework == "oldesx" then
        local src = val
        dataUpload(tonumber(src))
    else
        local src = source
        dataUpload(tonumber(src))
    end
end)

 AddEventHandler("onResourceStart",function(name)
     if name == GetCurrentResourceName() then
         Wait(3050)
         local players = GetPlayers()
         for i = 1, #players do
   
            dataUpload(tonumber(players[i]))            
         
         end
     end
 end)


function reviveFunction(playerId)
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        local xPlayer = GetPlayer(playerId)
        if xPlayer then
            TriggerClientEvent('esx_ambulancejob:revive', playerId)
        end
    else
        local xPlayer = GetPlayer(playerId)
        if xPlayer then
            TriggerClientEvent('hospital:client:Revive', playerId)
        end
        
    end

end

function killFunction(playerId)
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        local xPlayer = GetPlayer(playerId)
        if xPlayer then
            TriggerClientEvent('esx:killPlayer', playerId)
        end
    else
        local xPlayer = GetPlayer(playerId)
        if xPlayer then
            TriggerClientEvent('hospital:client:KillPlayer', playerId)
        end
        
    end
end



function addItemFunction(playerId,itemname,itemcount,src)
    itemcount = tonumber(itemcount)
    if  Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        local xPlayer = GetPlayer(playerId)
        if xPlayer then
            xPlayer.addInventoryItem(itemname, itemcount)
            TriggerClientEvent('staff:client:notify',src, 'Item added..')
        end
      
    else
        local Player = GetPlayer(tonumber(playerId))
        if Player then
         
           Player.Functions.AddItem(itemname,itemcount)
           TriggerClientEvent('staff:client:notify',src, 'Item added..')
        end
    end
end

function setjobFunction(playerId,jobname,jobgrade,src)
    jobgrade = tonumber(jobgrade)
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        local xPlayer = GetPlayer(playerId)
        if xPlayer then
            xPlayer.setJob(jobname, jobgrade)
            TriggerClientEvent('staff:client:notify', src, 'Job Changed..')
        end
    else
        local Player = GetPlayer(tonumber(playerId))
        if Player then
            Player.Functions.SetJob(jobname, jobgrade)
           TriggerClientEvent('staff:client:notify',src, 'Job Changed..')
        end
    end
end

function deleteVehicleFunction()
    TriggerClientEvent('staff:client:deleteVehicles', -1)
end

function clearAreaFunction(coords)
    TriggerClientEvent('staff:client:clearArea', -1, coords)
end

function changeWeatherFunction(weather)
    if weather then
        if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
         
            TriggerClientEvent('staff:client:changeWeather', -1, weather)
          
        else
         
            TriggerEvent('qb-weathersync:server:setWeather', weather)
        end
    end
end

function changeTimerFunction(time)
    if time then 
        if  Config.Framework == 'esx' or Config.Framework == 'oldesx' then
            TriggerClientEvent('staff:client:changeTime', -1, hour)
        else
            TriggerEvent('qb-weathersync:server:setTime', time, 00)
        end
    end
end

function giveCashFunction(playerId,money)
    if  Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        local xPlayer = GetPlayer(playerId)
        if xPlayer then
            xPlayer.addMoney(tonumber(money))
        end
    else
        local xPlayer = GetPlayer(tonumber(playerId))
        if xPlayer then
           xPlayer.Functions.AddMoney('cash',tonumber(money))
        end
    end
end
function giveBankFunction(playerId,money)
    if  Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        local xPlayer = GetPlayer(playerId)
        if xPlayer then
            xPlayer.addAccountMoney('bank', tonumber(money))
        end
    else
        local xPlayer = GetPlayer(tonumber(playerId))
        if xPlayer then
           xPlayer.Functions.AddMoney('bank',tonumber(money))
        end
    end
end


function giveVehicleDatabase(plyid, name)
    local Player = GetPlayer(plyid)
    local plate = GeneratePlate()
    local vehicleProps = GetVehicleProperties(name, plate)
    if Player then
        if Config.Framework == 'esx'  then
            local identifier = Player.identifier
            if identifier then
                
                local garage = 'SanAndreasAvenue'

                local plate = GeneratePlate()
                local vehicleProps = GetVehicleProperties(name, plate)
                if identifier and plate and vehicleProps then
                    ExecuteSql(string.format("INSERT INTO owned_vehicles (owner, plate, vehicle, stored, parking) VALUES ('%s', '%s', %q, '%s', '%s')", identifier, plate, json.encode(vehicleProps), "1", garage))
                end
            end
        elseif Config.Framework == 'oldesx' then
            local identifier = Player.identifier
            if identifier then
                local plate = GeneratePlate()
                local vehicleProps = GetVehicleProperties(name, plate)
                if identifier and plate and vehicleProps then
                    ExecuteSql(string.format("INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES ('%s', '%s', %q)", identifier, plate, json.encode(vehicleProps)))
                end
            end        
        else
            local identifier = Player.PlayerData.citizenid
            local garage = 'pillboxgarage'
            ExecuteSql(string.format("INSERT INTO `player_vehicles` (license, citizenid, vehicle, hash, mods, plate, garage) VALUES ('%s', '%s', '%s', '%s', %q, '%s', '%s')",
            Player.PlayerData.license, identifier, name, GetHashKey(name), json.encode(vehicleProps),  plate, garage))
        end
    end
end

function giveClothingMenuFunction(plyid)
    if plyid then 
        TriggerClientEvent('qb-clothing:client:openMenu', plyid)
        TriggerClientEvent('staff:client:close', plyid) -- dont touch   
    end
end


function clearInventoryFunction(plyid)
    local xPlayer = GetPlayer(plyid)
    if xPlayer and plyid then
        if Config.Inventory == "codem-inventory" then
            exports["codem-inventory"]:ClearInventory(plyid)
        elseif Config.Inventory == 'ox_inventory' then
            exports.ox_inventory:ClearInventory(plyid)
        elseif Config.Inventory == 'qb_inventory' then
            exports['qb-inventory']:ClearInventory(plyid)
        elseif Config.Inventory == 'esx_inventory' then
            TriggerEvent('esx:playerInventoryCleared', plyid)
        end
    end
end

function freezeTimeFunction(value,src)
  
    if  Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        
    else
        TriggerEvent('codem:staff:server:toggleFreezeTime', value,src)
    end
end





 function Round(value, numDecimalPlaces)
	if numDecimalPlaces then
		local power = 10^numDecimalPlaces
		return math.floor((value * power) + 0.5) / (power)
	else
		return math.floor(value + 0.5)
	end
end

function GetVehicleProperties(name, plate)
    local extras = {}
    for i=1, 12 do
        extras[i] = false
    end
    if Config.Framework == 'esx' or Config.Framework == 'newesx' then
        return {
			model             = GetHashKey(name),
			plate             = plate,
			plateIndex        = 0,

			bodyHealth        = Round(1000, 1),
			engineHealth      = Round(1000, 1),
			tankHealth        = Round(1000, 1),

			fuelLevel         = Round(100, 1),
			dirtLevel         = Round(0, 1),
			color1            = 0,
            color1Custom =      {255, 255, 255},

			color2            = 0,
		    color2Custom      = {255, 255, 255},

            color1Type = 0,
            color2Type = 0,
			customPrimaryColor = {255, 255, 255},
			customSecondaryColor = {255, 255, 255},

			pearlescentColor  = 111,
			wheelColor        = 156,

			wheels            = 0,
			windowTint        = -1,
			xenonColor        = 255,

			neonEnabled       = {
				false,
				false,
				false,
				false
			},

			neonColor         = {255,0,255},
			extras            = extras,
			tyreSmokeColor    = {255,255,255},
            dashboardColor    = 0,
            interiorColor     = 0,
			modSpoilers       = -1,
			modFrontBumper    = -1,
			modRearBumper     = -1,
			modSideSkirt      = -1,
			modExhaust        = -1,
			modFrame          = -1,
			modGrille         = -1,
			modHood           = -1,
			modFender         = -1,
			modRightFender    = -1,
			modRoof           = -1,

			modEngine         = -1,
			modBrakes         = -1,
			modTransmission   = -1,
			modHorns          = -1,
			modSuspension     = -1,
			modArmor          = -1,

			modTurbo          = false,
			modSmokeEnabled   = false,
			modXenon          = false,

			modFrontWheels    = -1,
			modBackWheels     = -1,

			modPlateHolder    = -1,
			modVanityPlate    = -1,
			modTrimA          = -1,
			modOrnaments      = -1,
			modDashboard      = -1,
			modDial           = -1,
			modDoorSpeaker    = -1,
			modSeats          = -1,
			modSteeringWheel  = -1,
			modShifterLeavers = -1,
			modAPlate         = -1,
			modSpeakers       = -1,
			modTrunk          = -1,
			modHydrolic       = -1,
			modEngineBlock    = -1,
			modAirFilter      = -1,
			modStruts         = -1,
			modArchCover      = -1,
			modAerials        = -1,
			modTrimB          = -1,
			modTank           = -1,
			modWindows        = -1,
			modDoorR          = -1,
			modLivery         = -1,
			modLightbar       = -1,
            livery            = -1,
		}
    else
        return {
            model = GetHashKey(name),
            plate = plate,
			plateIndex        = 0,
			bodyHealth        = Round(1000,  0.1),
			engineHealth      = Round(1000,  0.1),
			tankHealth        = Round(1000,  0.1),
			fuelLevel         = Round(100, 0.1),
			dirtLevel         = Round(0, 0.1),

			color1            = 0,
			color2            = 0,

			pearlescentColor  = 111,
			wheelColor        = 156,
            dashboardColor    = 0,
            interiorColor     = 0,
			wheels            = 0,
			windowTint        = -1,
			xenonColor        = 255,
            neonEnabled = {
                false,
                false,
                false,
                false
            },
			neonColor         = {255,0,255},
			extras            = extras,
			tyreSmokeColor    = {255,255,255},
            modSpoilers = -1,
            modFrontBumper = -1,
            modRearBumper = -1,
            modSideSkirt = -1,
            modExhaust = -1,
            modFrame = -1,
            modGrille =-1,
            modHood = -1,
            modFender = -1,
            modRightFender = -1,
            modRoof =-1,
            modEngine = -1,
            modBrakes = -1,
            modTransmission = -1,
            modHorns = -1,
            modSuspension = -1,
            modArmor = -1,
            modTurbo = false,
            modSmokeEnabled = false,
            modXenon = false,
            modFrontWheels = -1,
            modBackWheels =-1,
            modCustomTiresF = false,
            modCustomTiresR = false,
            modPlateHolder = -1,
            modVanityPlate = -1,
            modTrimA = -1,
            modOrnaments = -1,
            modDashboard = -1,
            modDial = -1,
            modDoorSpeaker = -1,
            modSeats = -1,
            modSteeringWheel = -1,
            modShifterLeavers = -1,
            modAPlate = -1,
            modSpeakers = -1,
            modTrunk = -1,
            modHydrolic = -1,
            modEngineBlock = -1,
            modAirFilter = -1,
            modStruts = -1,
            modArchCover = -1,
            modAerials = -1,
            modTrimB = -1,
            modTank = -1,
            modWindows = -1,
            modLivery = 0,
        }
    end
end

local StringCharset = {}
local NumberCharset = {}

for i = 48,  57 do NumberCharset[#NumberCharset+1] = string.char(i) end
for i = 65,  90 do StringCharset[#StringCharset+1] = string.char(i) end
for i = 97, 122 do StringCharset[#StringCharset+1] = string.char(i) end

function RandomStr(length)
    if length <= 0 then return '' end
    return RandomStr(length - 1) .. StringCharset[math.random(1, #StringCharset)]
end

function RandomInt(length)
    if length <= 0 then return '' end
    return RandomInt(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
end


function GeneratePlate()
    local tableName = 'player_vehicles'
    local plate = RandomInt(1) .. RandomStr(2) .. RandomInt(3) .. RandomStr(2)

    if Config.Framework == 'esx' or Config.Framework == 'newesx' then
        tableName = 'owned_vehicles'
		plate = RandomStr(3) .. ' ' .. RandomInt(3)
    end
    plate = plate:upper()
    local result =  ExecuteSql(string.format("SELECT plate FROM %s WHERE plate = '%s'", tableName, plate))
    if result[1] then
        return GeneratePlate()
    else
        return plate:upper()
    end
end
onlineTestPlayersCount = 0
uploadProblem = false

RegisterCommand('onlineplayers', function (source)
    
    print("onlineTestPlayersCount",onlineTestPlayersCount)
    print("uploadProblem",uploadProblem)

end)




function dataUpload(source)
  
    local src = source
    local loadedPlayer = GetPlayer(tonumber(src))
    if loadedPlayer then 
        onlineTestPlayersCount = onlineTestPlayersCount + 1
        local playerIdentifier = GetIdentifier(src)
        local xPlayer, playerJob, playerJobName
        playTime[GetIdentifier(src)] = os.time()
        if Config.Framework == "esx" or Config.Framework == "oldesx" then
            xPlayer = Core.GetPlayerFromId(src)
            playerJob = xPlayer.job.grade_label or "unemployed"
            playerJobName = xPlayer.job.name or "unemployed"
        else
            xPlayer = Core.Functions.GetPlayer(src)
            playerJob = xPlayer.PlayerData.job.label or "unemployed"
            playerJobName = xPlayer.PlayerData.job.grade.name or "unemployed"
        end
        local rank, rankname, ranklabel, image
      
        local myRank = 0
        if allPlayerData[playerIdentifier] then
            myRank = allPlayerData[playerIdentifier].rank
        else
            myRank = 0
        end
      
        if tonumber(myRank) > 0 then
            rank, rankname, ranklabel = checkRank(myRank)
            image = Config.ScoreBoard[rankname]
        else
            rank, rankname, ranklabel = 0, "user", "user"
            image = Config.ScoreBoard[playerJobName] or Config.ScoreBoard["user"]
        end
        local lastreason = ''
        if allPlayerData[playerIdentifier] then
            lastreason = allPlayerData[playerIdentifier].lastreason
        else
            lastreason = ''
        end
        if Config.OwnerPermission[playerIdentifier] then
            image = Config.ScoreBoard['owner']
            rank, rankname, ranklabel = 5, 'owner', Config.Permissions['owner'].label
         
        end
        if allPlayerData[playerIdentifier] == nil then 
            local stateArray = {
                warn = {},
                kick = {},
                jail = {},
                ban = {},
                perma = {},
                playerTimes = 0,
                playerTimesLabel = '',
                joinDate = os.date("%d.%m.%Y"),
                perm = Config.playerPermission
             }
            local dataInfo = {
                identifier = playerIdentifier,
                rank = rank,
                stateAttr = stateArray,
                banned = 0,
                name = GetName(src),
                time =  0,
                jailData = {
                     jailTime = 0,
                     jailEntryTime = 0,
                 }
            }
            allPlayerData[playerIdentifier] = dataInfo
        end
      

        local jailTime = allPlayerData[playerIdentifier].jailData.jailTime or 0
        local jailEntryTime = allPlayerData[playerIdentifier].jailData.jailEntryTime or 0
        local playerTable = {
            id = src,
            name = GetName(src),
            identifier = playerIdentifier,
            job = playerJob,
            jobname = playerJobName,
            ranklabel = ranklabel,
            image = image,
            ping = GetPlayerPing(src),
            rank = rank,
            attr = {
                warn = allPlayerData[playerIdentifier].stateAttr.warn or {},
                kick = allPlayerData[playerIdentifier].stateAttr.kick or {},
                jail =  allPlayerData[playerIdentifier].stateAttr.jail or {},
                ban = allPlayerData[playerIdentifier].stateAttr.ban or {},
                perma =  allPlayerData[playerIdentifier].stateAttr.perma or {},
                playerTimes = allPlayerData[playerIdentifier].stateAttr.playerTimes or 0,
                playerTimesLabel = allPlayerData[playerIdentifier].stateAttr.playerTimesLabel or "",
                joinDate = allPlayerData[playerIdentifier].stateAttr.joinDate or "",
                perm = allPlayerData[playerIdentifier].stateAttr.perm or Config.playerPermission
            },
            rankname = rankname,
            sessionTime = 0,
            avatar = GetDiscordAvatar(src) or Config.defaultImage,
            joinDate = os.date("%d.%m.%Y"),
            ExtractIdentifiers = ExtractIdentifiers(src) or {},
            banned = 0,
            time = 0,
            lastreason = lastreason,
            jailData = {
                jailTime = jailTime ,
                jailEntryTime = jailEntryTime,
            }
        }
    

        local jailEntryTime =  0
        local totalJailTime =  0
        if allPlayerData[playerIdentifier] then
             jailEntryTime = allPlayerData[playerIdentifier].jailData.jailEntryTime 
             totalJailTime = allPlayerData[playerIdentifier].jailData.jailTime 
        else
            jailEntryTime = 0
            totalJailTime = 0
        end
        local currentTime = os.time()        
        local elepsedTime = currentTime - jailEntryTime
        local remainingTime = totalJailTime - elepsedTime    
      
        if remainingTime > 0 then
            TriggerClientEvent("staff:client:sendToJail", src, remainingTime)
        else
            if allPlayerData[playerIdentifier] then
                jailEntryTime = 0
                totalJailTime = 0
            else
               jailEntryTime = 0
               totalJailTime = 0
           end
        end
        
      
        if Config.IdentifierType == "license" then
            for kkk, vvv in ipairs(GetPlayerIdentifiers(src)) do
                if string.sub(vvv, 1, string.len("license:")) == "license:" then
                    twoIdentifier = vvv
                end
            end
        else
            for kkk, vvv in ipairs(GetPlayerIdentifiers(src)) do
                if string.sub(vvv, 1, string.len("steam:")) == "steam:" then
                    twoIdentifier = vvv
                end
            end
       end
        local result = ExecuteSql("SELECT * FROM `codemstaff` WHERE `identifier` = '" .. playerIdentifier .. "'")
        if next(result) then 
           
        else
            ExecuteSql("INSERT INTO `codemstaff` (`identifier`,`stateattr`, `name`, `rank`,`banned`,`time`,`lastreason`,`bannedidentifier`) VALUES ('" ..playerTable.identifier .. "','" .. json.encode(playerTable.attr) .. "', '" ..playerTable.name .. "','" .. playerTable.rank .. "','" .. playerTable.banned .. "','" .. playerTable.time .. "','" .. playerTable.lastreason .. "','"..twoIdentifier.."')")
        end
        staffAllPlayers[src] = playerTable

        local playerData = staffAllPlayers[tonumber(src)]
        if Config.OwnerPermission[playerIdentifier] then
            for __,p in pairs(playerData.attr.perm) do
                playerData.attr.perm[__] = true
            end
        end
        

        local onlineStaff = onlineStaff()
        local numW = #onlineStaff
        if tonumber(rank) > 1 then 
  
            onlineAdmins[src] = src
            TriggerClientEvent('staff:client:OnlineAdminNumber',src,numW)
            TriggerClientEvent('staff:client:myAdminData', src, staffAllPlayers[src])
            TriggerClientEvent('staff:client:refreshAllMoneyData',src,allMoneyData)
            for indexPlayer, allData in pairs(staffAllPlayers) do 
                TriggerClientEvent("staff:client:getPlayers", tonumber(src), allData)
            end
           
        end

        for online, staff in pairs(onlineStaff) do
            if tonumber(src) ~= tonumber(staff) then 
                TriggerClientEvent('staff:client:OnlineAdminNumber',staff,numW)
                TriggerClientEvent('staff:client:getPlayers', staff, staffAllPlayers[src])
            end
        end
        if discord_webhook["loginserver"].allow and discord_webhook["loginserver"].webhook ~= "" then
            discordLogStaff(src,staffAllPlayers[tonumber(src)], Config.Locale['loginserver'], 'loginserver')
        end
    else

        uploadProblem = true
        print('DATA UPLOAD PROBLEM PLS CONTACT CODEM Aiakos')
        print("Ignore this print if you restarted the script")
    end

    
end





AddEventHandler("playerConnecting",function(name, setCallback, deferrals)
    local src = source
    local identifier = false

     if Config.IdentifierType == "license" then
         for k, v in ipairs(GetPlayerIdentifiers(src)) do
             if string.sub(v, 1, string.len("license:")) == "license:" then
                 identifier = v
             end
         end
     else
         for k, v in ipairs(GetPlayerIdentifiers(src)) do
             if string.sub(v, 1, string.len("steam:")) == "steam:" then
                 identifier = v
             end
         end
     end
    deferrals.defer()
    deferrals.update("Checking Ban List...")

    local result = ExecuteSql("SELECT * FROM `codemstaff` WHERE  `bannedidentifier` = '" .. identifier .. "'")

    if next(result) and tonumber(result[1].time) > 0 then
        local banEndTime = result[1].time

        if tonumber(os.time()) < tonumber(banEndTime) then
             deferrals.done(
                "Banned from server!\n Reason: " .. result[1].lastreason .. " \n End Time : " .. os.date("%d.%m.%Y %H:%M", banEndTime)
             )
        else
            deferrals.done()
            local banTimeNew = 0
            local lastReason = 0
            ExecuteSql("UPDATE `codemstaff` SET `time` = '" ..banTimeNew .."', lastreason = '" ..lastReason .."' , banned = '" .. banTimeNew .. "'  WHERE `identifier` = '" .. identifier .. "'")
        end
    else
        deferrals.done()
    end
end)




RegisterNetEvent('QBCore:Server:OnPlayerUnload',function(id)
  
    local src = id
    local identifier = GetIdentifier(src)
    local twoIdentifier = false
    local sessionTime = 0
    onlineTestPlayersCount = onlineTestPlayersCount - 1
    if playTime[identifier] then 
        sessionTime = tonumber(staffAllPlayers[tonumber(src)].attr.playerTimes) + (os.time() - playTime[identifier])
    else
        sessionTime = tonumber(staffAllPlayers[tonumber(src)].attr.playerTimes) + (os.time() - 0 )
    end
    local hours = math.floor(sessionTime / 3600)
    local minutes = math.floor((sessionTime % 3600) / 60)
    staffAllPlayers[tonumber(src)].attr.playerTimesLabel = hours .. " h " .. minutes .. " mn"
    local reason = staffAllPlayers[tonumber(src)].lastreason
    if not reason then
        staffAllPlayers[tonumber(src)].lastreason = "No reason specified"
    end

    if Config.IdentifierType == "license" then
        for kkk, vvv in ipairs(GetPlayerIdentifiers(src)) do
            if string.sub(vvv, 1, string.len("license:")) == "license:" then
                twoIdentifier = vvv
            end
        end
    else
        for kkk, vvv in ipairs(GetPlayerIdentifiers(src)) do
            if string.sub(vvv, 1, string.len("steam:")) == "steam:" then
                twoIdentifier = vvv
            end
        end
    end
    ExecuteSql("UPDATE `codemstaff` SET `stateattr` = '" ..json.encode(staffAllPlayers[tonumber(src)].attr) .."', `name` = '" ..staffAllPlayers[tonumber(src)].name .."', `rank` = '" .. staffAllPlayers[tonumber(src)].rank .. "', `banned` = '"..staffAllPlayers[tonumber(src)].banned.."' , `time` = '"..tonumber(staffAllPlayers[tonumber(src)].time).."', `lastreason` = '"..staffAllPlayers[tonumber(src)].lastreason.."',`bannedidentifier` = '"..twoIdentifier.."'  WHERE `identifier` = '" .. identifier .. "'")
    
    playTime[identifier] = nil

   
  
    for s, w in pairs(onlineStaff()) do
        TriggerClientEvent("staff:client:droppedPlayer", w, staffAllPlayers[tonumber(src)])
    end
 

    if discord_webhook["quitserver"].allow and discord_webhook["quitserver"].webhook ~= "" then
        discordLogStaff(src,staffAllPlayers[tonumber(src)], Config.Locale['quitserver'], 'quitserver')
    end
    staffAllPlayers[tonumber(src)] = false
end)

RegisterServerEvent("esx:playerLogout")
AddEventHandler("esx:playerLogout", function(source)
    local src = source
    local identifier = GetIdentifier(src)
    local twoIdentifier = false
    local sessionTime = 0
    onlineTestPlayersCount = onlineTestPlayersCount - 1
    if playTime[identifier] then 
        sessionTime = tonumber(staffAllPlayers[tonumber(src)].attr.playerTimes) + (os.time() - playTime[identifier])
    else
        sessionTime = tonumber(staffAllPlayers[tonumber(src)].attr.playerTimes) + (os.time() - 0 )
    end
    local hours = math.floor(sessionTime / 3600)
    local minutes = math.floor((sessionTime % 3600) / 60)
    staffAllPlayers[tonumber(src)].attr.playerTimesLabel = hours .. " h " .. minutes .. " mn"
    local reason = staffAllPlayers[tonumber(src)].lastreason
    if not reason then
        staffAllPlayers[tonumber(src)].lastreason = "No reason specified"
    end

    if Config.IdentifierType == "license" then
        for kkk, vvv in ipairs(GetPlayerIdentifiers(src)) do
            if string.sub(vvv, 1, string.len("license:")) == "license:" then
                twoIdentifier = vvv
            end
        end
    else
        for kkk, vvv in ipairs(GetPlayerIdentifiers(src)) do
            if string.sub(vvv, 1, string.len("steam:")) == "steam:" then
                twoIdentifier = vvv
            end
        end
    end
    ExecuteSql("UPDATE `codemstaff` SET `stateattr` = '" ..json.encode(staffAllPlayers[tonumber(src)].attr) .."', `name` = '" ..staffAllPlayers[tonumber(src)].name .."', `rank` = '" .. staffAllPlayers[tonumber(src)].rank .. "', `banned` = '"..staffAllPlayers[tonumber(src)].banned.."' , `time` = '"..tonumber(staffAllPlayers[tonumber(src)].time).."', `lastreason` = '"..staffAllPlayers[tonumber(src)].lastreason.."',`bannedidentifier` = '"..twoIdentifier.."'  WHERE `identifier` = '" .. identifier .. "'")
    
    playTime[identifier] = nil

   
  
    for s, w in pairs(onlineStaff()) do
        TriggerClientEvent("staff:client:droppedPlayer", w, staffAllPlayers[tonumber(src)])
    end
 

    if discord_webhook["quitserver"].allow and discord_webhook["quitserver"].webhook ~= "" then
        discordLogStaff(src,staffAllPlayers[tonumber(src)], Config.Locale['quitserver'], 'quitserver')
    end
    staffAllPlayers[tonumber(src)] = false
    onlineAdmins[tonumber(src)] = false
end)



RegisterServerEvent('codem-staff:UpdateJob',function (id)
    local src = id
    if staffAllPlayers[tonumber(src)] then 
        local xPlayer,playerJob,playerJobName = false
        if Config.Framework == "esx" or Config.Framework == "oldesx" then
            
            xPlayer = GetPlayer(src)
            if xPlayer then 
                playerJob = xPlayer.job.grade_label or "unemployed"
                playerJobName = xPlayer.job.grade_name or "unemployed"
            end
        
        else
            xPlayer = GetPlayer(src)
            if xPlayer then 

                playerJob = xPlayer.PlayerData.job.label or "unemployed"
                playerJobName = xPlayer.PlayerData.job.name or "unemployed"
            end
        
        end
        staffAllPlayers[tonumber(src)].job = playerJob
        staffAllPlayers[tonumber(src)].jobname = playerJobName
        local myRank = staffAllPlayers[tonumber(src)].rank
        if tonumber(myRank) > 0 then
            rank, rankname, ranklabel = checkRank(myRank)
            staffAllPlayers[tonumber(src)].image = Config.ScoreBoard[rankname]
        else
            rank, rankname, ranklabel = 0, "user", "user"
            staffAllPlayers[tonumber(src)].image = Config.ScoreBoard[playerJobName] or Config.ScoreBoard["user"]
        end
   
        for s, w in pairs(onlineStaff()) do
            TriggerClientEvent("staff:client:getPlayers", w , staffAllPlayers[tonumber(src)])
        end
    end

end)

RegisterCommand("myidentifier", function (source)
    local src = source
    local identifier = GetIdentifier(src)
    TriggerClientEvent("staff:client:copyIdentifier", src, identifier)
    Config.ServerNotification(src, Config.NotificationText['getidentifer'].text(identifier), Config.NotificationText['getidentifer'].type,  Config.NotificationText['getidentifer'].timeout)
end)

AddEventHandler("playerDropped", function(reason)
    local src = source
    local identifier = GetIdentifier(src)
    local twoIdentifier = false
    local sessionTime = 0
    onlineTestPlayersCount = onlineTestPlayersCount - 1
    if staffAllPlayers[tonumber(src)] then 
    if playTime[identifier] then 
        sessionTime = tonumber(staffAllPlayers[tonumber(src)].attr.playerTimes) + (os.time() - playTime[identifier])
    else
        sessionTime = tonumber(staffAllPlayers[tonumber(src)].attr.playerTimes) + (os.time() - 0 )
    end
    if sessionTime > 0 then 
        local hours = math.floor(sessionTime / 3600)
        local minutes = math.floor((sessionTime % 3600) / 60)
        staffAllPlayers[tonumber(src)].attr.playerTimesLabel = hours .. " h " .. minutes .. " mn"
    end

    local reason = staffAllPlayers[tonumber(src)].lastreason
    if not reason then
        staffAllPlayers[tonumber(src)].lastreason = "No reason specified"
    end

    if Config.IdentifierType == "license" then
        for kkk, vvv in ipairs(GetPlayerIdentifiers(src)) do
            if string.sub(vvv, 1, string.len("license:")) == "license:" then
                twoIdentifier = vvv
            end
        end
    else
        for kkk, vvv in ipairs(GetPlayerIdentifiers(src)) do
            if string.sub(vvv, 1, string.len("steam:")) == "steam:" then
                twoIdentifier = vvv
            end
        end
    end
    allPlayerData[identifier].rank = staffAllPlayers[tonumber(src)].rank
    ExecuteSql("UPDATE `codemstaff` SET `stateattr` = '" ..json.encode(staffAllPlayers[tonumber(src)].attr) .."', `name` = '" ..staffAllPlayers[tonumber(src)].name .."', `rank` = '" .. staffAllPlayers[tonumber(src)].rank .. "', `banned` = '"..staffAllPlayers[tonumber(src)].banned.."' , `time` = '"..tonumber(staffAllPlayers[tonumber(src)].time).."', `lastreason` = '"..staffAllPlayers[tonumber(src)].lastreason.."',`bannedidentifier` = '"..twoIdentifier.."'  WHERE `identifier` = '" .. identifier .. "'")
    
    playTime[identifier] = nil
    for s, w in pairs(onlineStaff()) do
        TriggerClientEvent("staff:client:droppedPlayer", w, staffAllPlayers[tonumber(src)])
    end
 

    if discord_webhook["quitserver"].allow and discord_webhook["quitserver"].webhook ~= "" then
        discordLogStaff(src,staffAllPlayers[tonumber(src)], Config.Locale['quitserver'], 'quitserver')
    end
    staffAllPlayers[tonumber(src)] = false
    onlineAdmins[tonumber(src)] = false
    end
end)

--- version 1.5.0

Citizen.CreateThread(function()
    while not Core do
        Citizen.Wait(0)
    end
    local totalmoney = 0
    local totalbank = 0
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then 
        local result = ExecuteSql("SELECT * FROM users")
        for i = 1, #result do
            local data = result[i]
            if data then 
                local playerMoney = json.decode(data.accounts)
                if playerMoney.money and playerMoney.bank then
                    local moneyData = {
                        totalmoney = totalmoney + playerMoney.money,
                        totalbank = totalbank + playerMoney.bank
                    }
                    allMoneyData[data.identifier] = moneyData
                else
                    local moneyData = {
                        totalmoney = 0,
                        totalbank = 0,
                    }
                    allMoneyData[data.identifier] = moneyData
                end
          
            end
        end
        print('--------- Loaded Money Data -------------')
        Citizen.Wait(2000)
        for s, w in pairs(onlineStaff()) do
            TriggerClientEvent("staff:client:refreshAllMoneyData", w, allMoneyData)
        end
    else
        local result = ExecuteSql("SELECT * FROM players")
        for i = 1, #result do
            local data = result[i]
            if data then 
                local playerMoney = json.decode(data.money)
                local moneyData = {
                    totalmoney = totalmoney + playerMoney.cash,
                    totalbank = totalbank + playerMoney.bank
                }
                allMoneyData[data.citizenid] = moneyData
            end
        end
        print('--------- Loaded Money Data -------------')
        Citizen.Wait(4000)
        for s, w in pairs(onlineStaff()) do
            TriggerClientEvent("staff:client:refreshAllMoneyData", w, allMoneyData)
        end

    end
end)





function handleHealPanelAction(src,playerData,data)

    if staffAllPlayers[src].attr.perm['healPlayer'] then
         TriggerClientEvent("staff:client:heal", src)
         Config.ServerNotification(data.plyid,Config.NotificationText['healplayer'].text,Config.NotificationText['healplayer'].type,Config.NotificationText['healplayer'].timeout)
         if discord_webhook["heal"].allow and discord_webhook["heal"].webhook ~= "" then
              discordLogStaff(src,playerData,Config.Locale["loghealplayer"] , 'heal')
          end
    else
         TriggerClientEvent("staff:client:notify", src, Config.Locale["authority"])
    end
end

function handleHealTwoAction(src,playerData,data)

    if staffAllPlayers[src].attr.perm['healPlayer'] then
        TriggerClientEvent("staff:client:heal", data.plyid)
        Config.ServerNotification(data.plyid,Config.NotificationText['healplayer'].text,Config.NotificationText['healplayer'].type,Config.NotificationText['healplayer'].timeout)
        if discord_webhook["heal"].allow and discord_webhook["heal"].webhook ~= "" then
             discordLogStaff(src,playerData,Config.Locale["loghealplayer"], 'heal')
       end
    else
        TriggerClientEvent("staff:client:notify", src, Config.Locale["authority"])
    end
end