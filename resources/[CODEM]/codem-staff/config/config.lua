
Config = {}

Config.Framework = 'esx' -- esx, qb, oldqb, oldesx, autodetect

--- mysql-async - oxmysql - ghmattimysql
Config.Mysql = "oxmysql" 
Config.WebhookFooter = {
    logo = "https://cdn.discordapp.com/attachments/1025789416456867961/1106324039808594011/512x512_Logo.png",
    text = "Codem Store - https://discord.gg/zj3QsUfxWs"
}
-- Open Menu Key

Config.Inventory = "ox_inventory" -- codem-inventory, qb_inventory, esx_inventory, ox_inventory, --CLEAR INVENTORY

Config.UseRegisterKeyMappingSystem = true  -- if this option set to true the script will use the RegisterKeyMapping system or false will use the traditional system
--[[
    if you set the option above to true you can reference here if you want to change OpenKey
    https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/

    if false you can reference here to change OpenKey
    https://docs.fivem.net/docs/game-references/controls/

    Note : If Config.UseRegisterKeyMappingSystem is set to true, even if you change the Config.OpenKey value after logging into the server it will still be the same in-game. You can do a few things to fix this
    1- Change the script name
    This will reset the key for everyone and new key you've written in Config.OpenKey will be apply to everyone

    2- Change the key from settings/keybinds/fivem
    This will be only apply to you and other players also need to change from settings

    3- Set Config.UseRegisterKeyMappingSystem to false
    This is not the recommend way because script may consume more resmon value
]]--

Config.OpenKey = 'F10'
Config.FastPanelKey = 'F11'
Config.ShowMouse = 'F9'
---------------------------------No Clip Settings
Config.NoClipKeyUse = true --- true enbabled key -- false disabled key for noclip
Config.NoClipKey = 'PAGEUP'

-- FOR QBCORE ---
-- QBCore:Server:OnPlayerLoaded
--- FOR ESX----
 -- esx:playerLoaded
Config.ServerLoadedEvent = 'esx:playerLoaded'


Config.IdentifierType = 'license' -- license or steam

Config.ServerLogo = 'https://cdn.discordapp.com/attachments/858833601226080286/1115728758662508625/testserverlogo.png'

Config.defaultImage = 'https://cdn.discordapp.com/attachments/858833601226080286/1108105906132103178/testpp.png'

-- Jail Location
Config.JailCoords = vector3(1736.35, 2636.82, 45.56) -- in jail coord
Config.JailExitCoords = vector3(1850.6,2585.71,45.67) -- out of jail coord
Config.JailCheckCommand = 'checkjailtime' -- jail time check command for player in jail 
Config.UnJailCommand = 'unjail' -- unjail command

Config.JailSettings = {
     jailDistanceCheck = true, -- if true player can't escape from jail -- if false player can escape from jail
     jailDistance = 10,
}

--{{locale.adminChat}}
Config.NotificationText = {
   ["godmodeactive"] = {
        text = 'God Mode Active',
        type = 'success',
        timeout = 3000,
    },
    ["godmodedeactive"] = {
        text = 'God Mode Deactive',
        type = 'success',
        timeout = 3000,
    },
    ["healplayer"] = {
        text = 'Healed',
        type = 'success',
        timeout = 3000,
    },
    ['noiswaypoint'] = {
        text = 'Waypoint not found',
        type = 'error',
    },

    ['getidentifer'] = {
        text = function(identifier)
            return "Your " .. identifier .. " is copied to your clipboard"
        end,
        type = 'success',
        timeout = 5000,
    },

}



Config.Locale = {
    ['authorizeYorself'] =  "You can't authorize yourself.",
    ['cannotperform'] = "You cannot perform this operation on yourself.",
    ['authority'] = "Your authority is not enough.",
    ['rankAlreadyExists'] = "First reset rank.",
    ['staffText'] = 'STAFF',
    ['sentyourmessage'] = 'SENT YOU A MESSAGE!',
    ['warnedByStaff'] = "You’ve been warned by Staff!",
    ['Announcement'] = "ANNOUNCEMENT",
    ['jail'] = "JAIL",
    ['adminJailIn'] = 'You are going to out of admin Jail in',
    ['adminQuickPanel'] = 'Admin Quick Panel',
    ['adminChat'] = 'ADMIN CHAT',
    ['devTools'] = 'DEV TOOLS',
    ['exitFrom'] = 'EXIT FROM',
    ['heading'] = 'HEADING',
    ['spectmenu'] = 'SPECTATING MENU',
    ['custom'] = 'Custom',
    ['cancel'] = 'CANCEL',
    ['bans'] = 'BAN',
    ['ban'] = 'BAN',
    ['rank'] = 'Rank',
    ['unban'] = 'UNBAN',
    ['fraction'] = 'Fraction',
    ['ping'] = 'Ping',
    ['id'] = 'ID',
    ['discordid'] = 'Discord ID',
    ['steamid'] = 'Steam ID',
    ['licenseid'] = 'License ID',
    ['player'] = 'Player',
    ['weather'] = 'Weather',
    ['time'] = 'Time',
    ['set'] = 'SET',
    ['freezetime'] = 'Freeze Time',
    ['defreezetime'] = 'Defreeze Time',
    ['staffCenter'] = 'STAFF CENTER',
    ['description'] = 'Description',
    ['online'] = 'Online',
    ['customs'] = 'Customs',
    ['staffMember'] = 'Staff Member since',
    ['showName'] = 'Show Name',
     ['removeName'] = 'Remove Name',
     ['showBlips'] = 'Show Blips',
     ['removeBlips'] = 'Remove Blips',
     ['submitButton'] = 'Submit',
     ['youText'] = 'You',
     ['warn'] = 'Warnss',
     ['kicks'] = 'Kicks',
     ['adminjail'] = "Admin Jails",
     ['bans2'] = 'Bans',
     ['perma'] = 'Permas',
     ['noclip'] = 'No Clip',
     ['godmode'] = 'God Mode',
     ['revive'] = 'Revive',
     ['heal'] = 'Heal',
     ['invisible'] = 'Invisible',
     ['repairvehicle'] = 'Repair Vehicle',
     ['itemcode'] = 'Item Code ',
     ['amount'] = ' Amount ',
     ['cancel2'] = 'Cancel',
     ['givevehicle'] = 'Give Vehicle',
     ['vehiclename'] = 'Vehicle Name',
     ['givevehicletodatabase'] = 'Give Veh DB',
     ['giveitem'] = 'Give Item',
     ['givemoney'] = 'Give Money',
     ['givecash'] = 'Give Cash',
     ['givebank'] = 'Give Bank',
     ['showplayerblip'] = 'Show Player Blip',
     ['clothingmenu'] = 'Clothing Menu',
     ['teleportmarker'] = 'TP Marker',
     ['jobname'] = 'Job Name',
     ['grade'] = 'Grade',
     ['setjob'] = 'Set Job',
     ['surevip'] = 'Are you sure to give this player VIP ? ',
     ['textPlayer'] = 'Are you sure to give this player  ',
     ['textPlayer2'] = 'Are you sure to remove this player ',
     ['yessurevip'] = 'Yes, im sure',
     ['setvip'] = 'Set Vip ',
     ['surestaff'] = 'Are you sure to give this player Staff ?',
     ['yessurestaff'] = 'Yes, im sure',
     ['givestaff'] = 'Give Perm',
     ['sureadmin'] = 'Are you sure to give this player Admin ?',
     ['yessureadmin'] = 'Yes, im sure',
     ['giveadmin'] = 'Give Admin',
     ['suresuperadmin'] = 'Are you sure to give this player Super Admin ?',
     ['yessuresuperadmin'] = 'Yes, im sure',
     ['givesuperadmin'] = 'Give Super Admin',
     ['givesadmin'] = 'Give SAdmin',
     ['sendmsg'] = 'Send msg to player...',
     ['sendpm'] = 'Send PM',
     ['sendpm2'] = 'Send Pm',
     ['anntext'] = 'Announcement Text',
     ['announcement'] = 'Announcement',
     ['announce'] = 'Announce',
     ['extrasunny'] = 'Extra Sunny',
     ['clear'] = 'Clear',
     ['clearing'] = 'Clearing',
     ['blizzard'] = 'Blizzard',
     ['overcast'] = 'Overcast',
     ['thunder'] = 'Thunder',
     ['cloudy'] = 'Cloudy',
     ['foggy'] = 'Foggy',
     ['smog'] = 'Smog',
     ['hallowen'] = 'Hallowen',
     ['neutral'] = 'Neutral',
     ['rain'] = 'Rain',
     ['snow'] = 'Snow',
     ['xmas'] = 'XMas',
     ['spectate'] = 'Spectate',
     ['kill'] = 'Kill',
     ['freeze'] = 'Freeze',
     ['goto'] = 'Go To',
     ['bring'] = 'Bring',
     ['markgps'] = 'Mark Gps',
     ['pm'] = 'Pm',
     ['clearinv'] = 'Clear Inv',
     ['takepicture'] = 'Take Picture',
     ['giveveh'] = 'Give Veh',
     ['cleararea'] = 'Clear Area',
     ['clearvehicle'] = 'Clear Vhcl',
     ['allrevive'] = 'All Revive',
     ['devtooltext'] = 'Dev Tools',
     ['showcoords'] = 'Show Coords',
     ['showMouse'] = 'Show Mouse',
     ['copyvector3'] = 'Copy Vector3',
     ['copyvector4'] = 'Copy Vector4',
     ['copyxyzh'] = 'Copy X Y Z H',
     ['copyheading'] = 'Copy Heading',
     ['runcmd'] = 'Run Cmd',
     ['returntopage'] = 'Return To Page',

     ['removevip'] = 'Remove VIP',
     ['givevip'] = 'Give VIP',
     ['inputisnot'] = 'Input is not a number !',
     ['inputisempty'] = 'Input is empty!',

     --- Version v1.2 Update 
     ['logplayerkill'] = 'Player Kill',
    ['logplayerfreeze'] = 'Player Freeze'   ,
    ['logplayerunfreeze'] = 'Player Unfreeze',
    ['logplayergoto'] = 'Player Goto, Coords :',
    ['logplayerbring'] = 'Player Bring, Coords : ',
    ['logplayergivestaff'] = 'Player Give Staff Rank',
    ['logplayerremovestaff'] = 'Player Remove Rank',
    ['logplayergiveadmin'] = 'Player Give Admin Rank',
    ['logplayergivesuperadmin'] = 'Player Give Super Admin Rank',
    ['logplayergivevip'] = 'Player Give Vip Rank',
    ['logplayermarkgps'] = 'Mark Gps',
    ['logweatherchange'] = 'Change Weather',
    ['logtimechange'] = 'Time Change',
    ['loggivecash'] = 'Give Cash Amount : ',
    ['loggivebank'] = 'Give Cash Bank Amount : ',
    ['lognoclipdeactive'] = 'No Clip Deactive',
    ['lognoclipactive'] = 'No Clip Active',
    ['loggodmodeactive'] = 'God Mode Active',
    ['loggodmodedeactive'] = 'God Mode Deactive',
    ['loghealplayer'] = 'Heal Player',
    ['loginvisibledeactive'] = 'Invisible deactive',
    ['loginvisibleactive'] = 'Invisible Active',
    ['logopenshowname'] = 'Open Show Name',
    ['logopenclosename'] = 'Close Show Name',
    ['logsendpm'] = 'Send Pm : ',
    ['loggivevehicle'] = 'Give Vehicle : ',
    ['loggivevehicledatabase'] = 'Give Vehicle Database : ',
    ['logsharaannounce'] = 'Share Announce : ',
    ['loggiveclothing'] = 'Give Clothing Menu ',
    ['logclearinv'] = 'Clear Inventory ',
    ['logsetjobname'] = 'Set Job, Name : ',
    ['logsetjobgrade'] = 'Set Job Grade : ',
    ['logsetfreezetime'] = 'Freeze Time',
    ['logvehiclerepair'] = 'Repair Vehicle',
    ['logplayerjail'] = 'Player Jail, Time :  ',
    ['logopenbanned'] = 'Player Open Banned ',
  

    --- version 1.5.0

    ['loginserver'] = 'Player Connection',
    ['quitserver'] = 'Player Disconnect',
    ['staffChat'] = 'Staff Chat',
    ['changeTime'] = 'Change Time',
    ['unjail'] = 'Unjail',
    ['onlyowner'] = 'Only owner perm',
    ['ownernotchange'] = 'Owner perm not change',
    ['youcantperm'] = 'You cant add perm owner ',
    ['cantperm'] = 'Not change your perm.'


 }

Config.Attribute = {
    {name  = "warn",    label = Config.Locale.warn,     text  = "Warn", image = "warn"},
    {name  = "kick",    label = Config.Locale.kicks,    text  = "Kick", image = "kick"},
    {name  = "jail",    label = Config.Locale.adminjail,text  = "Jail", image = "jail"},
    {name  = "ban",     label = Config.Locale.bans2,    text  = "Ban",  image = "ban"},
    {name  = "perma",   label = Config.Locale.perma,    text  = "Perma",image = "perma"}
}

Config.AdminPermissions = {
    {name= "noclip",            label= Config.Locale.noclip,        allow= true},
    {name= "godmode",           label= Config.Locale.godmode,       allow= true},
    {name= "revivepanel",       label= Config.Locale.revive,        allow= true},
    {name= "healpanel",         label= Config.Locale.heal,          allow= true},
    {name= "invisible",         label= Config.Locale.invisible,     allow= true},
    {name= "givevehiclepanel",  label= Config.Locale.givevehicle,   allow= true},
    {name= "repairvehicle",     label= Config.Locale.repairvehicle, allow= true},
    {name= "showname",          label= Config.Locale.showName,      allow=true},
    {name= "giveitempanel",     label= Config.Locale.giveitem,      allow= true},
    {name= "giveped",           label= Config.Locale.clothingmenu,  allow= true},
    {name= "tpmarker",          label= Config.Locale.teleportmarker,allow= true}
}

Config.PlayerPermission = {
    {name= "spectate",      label= Config.Locale.spectate,     image= "spectate",          allow= true},
    {name= "revive",        label= Config.Locale.revive,       image= "revive2",           allow= true},
    {name= "heal",          label= Config.Locale.heal,         image= "heal2",             allow= true},
    {name= "kill",          label= Config.Locale.kill,         image= "kill",              allow= true},
    {name= "freeze",        label= Config.Locale.freeze,       image= "freeze",            allow= true},
    {name= "goto",          label= Config.Locale['goto'],      image= "goto",              allow= true},
    {name= "bring",         label= Config.Locale.bring,        image= "bring",             allow= true},
    {name= "markgps",       label= Config.Locale.markgps,      image= "markgps",           allow= true},
    {name= "pm",            label= Config.Locale.pm,           image= "pm",                allow= true},
    {name= "giveclothing",  label= Config.Locale.clothingmenu, image= "giveped2",          allow= true},
    {name= "clearinventory",label= Config.Locale.clearinv,     image= "clearinventory",    allow= true},
    {name= "takepicture",   label= Config.Locale.takepicture,  image= "takepicture",       allow= true},
    {name= "givevehicle",   label= Config.Locale.giveveh,      image= "givevehicle2",      allow= true},
    {name= "giveitem",      label= Config.Locale.giveitem,     image= "giveitem",          allow= true},
    {name= "givemoney",     label= Config.Locale.givemoney,    image= "givemoney",         allow= true},
    {name= "setjob",        label= Config.Locale.setjob,       image= "setjob",            allow= true},
    -- {name= "givevip",       label= Config.Locale.givevip,      image= "givevip",           allow= true},
    {name= "giveperm",     label= Config.Locale.givestaff,    image= "givestaff" ,        allow= true},
    -- {name= "giveadmin",     label= Config.Locale.giveadmin,    image= "giveadmin",         allow= true},
    -- {name= "givesuperadmin",label= Config.Locale.givesadmin,   image= "givesuperadmin",    allow= true}

}

Config.ServerAdminSet = {
    {name= "weather",       label= Config.Locale.weather,       image= "weather",     interaction= true,allow= true},
    {name= "time",          label= Config.Locale.time,          image= "timer",       interaction= true,allow= true},
    {name= "announce",      label= Config.Locale.announce,      image= "announce",    interaction= true,allow= true},
    {name= "cleararea",     label= Config.Locale.cleararea,     image= "cleararea",   interaction= false,allow= true},
    {name= "clearvehicle",  label= Config.Locale.clearvehicle,  image= "clearvehicle",interaction= false,allow= true},
    {name= "allrevive",     label= Config.Locale.allrevive,     image= "allrevive",   interaction= false,allow= true},
    {name= "devtools",      label= Config.Locale.devtooltext,   image= "devtools",    interaction= false,allow= true}
}

Config.Devtools = {
    {name= "noclip",        label= Config.Locale.noclip,       icon= false},
    {name= "showcoords",    label= Config.Locale.showcoords,   icon= false},
    {name= "showmouse",     label= Config.Locale.showMouse,    icon= false},
    {name= "copyvector3",   label= Config.Locale.copyvector3,  icon= 'copy'},
    {name= "copyvector4",   label= Config.Locale.copyvector4,  icon= 'copy'},
    {name= "copyxyzh",      label= Config.Locale.copyxyzh,     icon= 'copy'},
    {name= "copyheading",   label= Config.Locale.copyheading,  icon= 'copy'},
    {name= "runcmd",        label= Config.Locale.runcmd,       icon= 'runcmd'}
}

Config.SpecTate = {
    {name= "warn",  image= "spectatebuttonwarn",    label= Config.Locale.warn,        color= "#FF906F"},
    {name= "kick",  image= "spectatebuttonkick",    label= Config.Locale.kicks,       color= "#FFAF65"},
    {name= "jail",  image= "spectatebuttonjail",    label= Config.Locale.adminjail,   color= "#49FFD3"},
    {name= "ban",   image= "spectatebuttonban",     label= Config.Locale.bans2,       color= "#FF4949"},
    {name= "perma", image= "spectatebuttonperma",   label= Config.Locale.perma,       color= "#FF0000"},
    {name= "pm",    image= "spectatebuttonpm",      label= Config.Locale.pm,          color= "#8F00FF"},
    {name= "return",image= "returntopage",          label= Config.Locale.returntopage,color= "#FFFFFF"}
 }


Config.ScoreBoardSearchIcon = {
    {
        name= "all", -- jobname
        image= "scoreboardsearchall",  -- not change

    },
    {
        name= "staff",
        image= "scoreboardsearchstaff",  -- not change
    },
    {
        name= "police", -- jobname
        image= "scoreboardsearchpolice",  -- not change

    },
    {
        name= "ambulance", -- jobname
        image= "scoreboardsearchambulance",  -- not change

    },
    {
        name= "mechanic", -- jobname
        image= "scoreboardsearchmechanic", -- not change
    },
    {
        name= "banned", -- jobname
        image= "scoreboardsearchban", -- not change
    },
}

Config.ScoreBoard = {
    
    ['police'] = {
        image = 'scoreboardpolice',
    },
    ['ambulance'] = {
        image = 'scoreboardambulance',
    },
    ['mechanic'] = {
        image = 'scoreboardmechanic',
    },
    ['vip'] = {
        image = 'scoreboardvip',
    },
    ['admin'] = {
        image = 'scoreboardadmin',
    },
    ['staff'] = {
        image = 'scoreboardstaff',
    },
    ['superadmin'] = {
        image = 'scoreboardsuperadmin',
    },
    ['owner'] = {
        image = 'scoreboardowner',
    },
    ['user'] = {
        image = 'scoreboarduser',
    },

}


Config.ClientNotification = function(message, type, length) -- You can change notification event here
    if Config.Framework == "esx" then
        TriggerEvent("esx:showNotification", message)
    else
        TriggerEvent('QBCore:Notify', message, type, length)
    end
end

Config.ServerNotification = function(source, message, type, length) -- You can change notification event here
    if Config.Framework == "esx" or Config.Framework == 'oldesx' then
        TriggerClientEvent("esx:showNotification",source, message)
    else

        TriggerClientEvent('QBCore:Notify', source, message, type, length)
    end
end

function GetIdentifier(source)
    if Config.Framework == "esx" or Config.Framework == "oldesx" then
        local xPlayer = Core.GetPlayerFromId(tonumber(source))
        if xPlayer then
            return xPlayer.getIdentifier()
        else
            return "0"
        end
    else
        local Player = Core.Functions.GetPlayer(tonumber(source))
        if Player then
            return Player.PlayerData.citizenid
        else
            return "0"
        end
    end
end


function GetName(source)

   if Config.Framework == "esx" or Config.Framework == 'oldesx' then
       local xPlayer = Core.GetPlayerFromId(tonumber(source))
       if xPlayer then
           return xPlayer.getName()
       else
           return "0"
       end
   else
       local Player = Core.Functions.GetPlayer(tonumber(source))
       if Player then
            
           return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
       else
           return "0"
       end
   end
end




function GetPlayer(source)
    local Player = false
    while Core == nil do
        Citizen.Wait(0)
    end
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        Player = Core.GetPlayerFromId(source)
    else
        Player = Core.Functions.GetPlayer(source)
        
    end
    return Player
end