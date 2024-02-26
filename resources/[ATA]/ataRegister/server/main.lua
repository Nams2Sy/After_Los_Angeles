
Citizen.CreateThread(function()
  if not Config.ESX_1_9_0 then
      ESX = nil
      TriggerEvent(Config.GetSharedObject, function(obj) ESX = obj end)
  else
      ESX = exports["es_extended"]:getSharedObject()
  end
end)
local multichar = ESX.GetConfig().Multichar




math.randomseed(math.floor(os.time() + math.random(100)))

-- Get Identity
function getIdentity(source, callback)
  local identifier = ESX.GetIdentifier(source)
  MySQL.Async.fetchAll("SELECT identifier, firstname, lastname, dateofbirth, sex, height FROM `users` WHERE `identifier` = @identifier",
  {
    ['@identifier'] = identifier
  },
  function(result)
    if result[1].firstname ~= nil then
      local data = {
        identifier  = result[1].identifier,
        firstname  = result[1].firstname,
        lastname  = result[1].lastname,
        dateofbirth  = result[1].dateofbirth,
        sex      = result[1].sex,
        height    = result[1].height
      }
      callback(data)
    else
      local data = {
        identifier   = '',
        firstname   = '',
        lastname   = '',
        dateofbirth = '',
        sex     = '',
        height     = ''
      }
      callback(data)
    end
  end)
end

-- Register the player
ESX.RegisterServerCallback('ataRegister:callBackServerSideForRegister', function(source, cb, data)
  local identifier = ESX.GetIdentifier(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  if data.sex == 'male' then
    data.sex = 'm'
  else
    data.sex = 'f'
  end
	if xPlayer then
  MySQL.Async.execute("UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier",
  {
    ['@identifier']   = identifier,
    ['@firstname']    = data.firstname,
    ['@lastname']     = data.lastname,
    ['@dateofbirth']  = data.dateofbirth,
    ['@sex']          = data.sex,
    ['@height']       = data.height
  },
    function( result )
   
      cb(true)
    end)
  else
  TriggerEvent('esx_identity:completedRegistration', source, data)
          cb(true)
  end
end)

if not multichar then
  AddEventHandler('esx:playerLoaded', function(source)
      getIdentity(source, function(data)
        if data.firstname == '' or data.firstname == nil or data.firstname == 0 or data.firstname == '0' then
          TriggerClientEvent('ataRegister:openFormRegister', source)
        else
          TriggerClientEvent('ataRegister:AlreadyRegistered',source)
        end
      end)
  end)
end



RegisterNetEvent("ataRegister:changeworld")
AddEventHandler("ataRegister:changeworld",function(hastyana)
    local source = source
    if not hastyana then
        SetPlayerRoutingBucket(source,source)
    else
        SetPlayerRoutingBucket(source,Config.DefualtWorldValue)
    end
end)
