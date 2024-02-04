

Config.OwnerPermission = { -- only owner can use this permission
    -- ['ZXS20889'] = true,
    ['c77c85b0361a556a21c168a15e640ddbc115e67c'] = true, --  licenseid   -- example
    ['75bc4cfc86cb442e38950a6b028f62352ac49d82'] = true, --  licenseid   -- example
    -- ['char2:d6b94cf21d1e6ef8aa5d713d4016027f14c408b9'] = true, --  licenseid   -- example
    --['THI38496'] = true, --  citizenid   -- example
    --['RUJ16865'] = true, --  citizenid   
   --if you don't know enter the game and type myidentifier in f8
}


Config.Permissions = {
    ['user'] = {
        rank = 0,
        label = "user",
        name = "user",
    },
    ['vip'] = {
        rank = 1,
        label = "Vip",
        name = "vip",
    }, -- vip is only designed to display the scoreboard. It does not have any admin function.
    ['staff'] = {
        rank = 2,
        label = "Staff",
        name = "staff",
    },
    ['admin'] = {
        rank = 3,
        label = "Admin",
        name = "admin",
    },
    ['superadmin'] = {
        rank = 4,
        label = "Super Admin",
        name = "superadmin",
    },
    ['owner'] = {
        rank = 5,
        label = "Owner",
        name = "owner",
    },
}


Config.playerPermission = {

    ['staffChat'] =  false,
    ['warnPlayer'] =  false,
    ['kickPlayer'] =  false,
    ['jailPlayer'] =  false,
    ['banPlayer'] =  false,
    ['permaBanPlayer'] =  false,
    ['spectatePlayer'] =  false,
    ['revivePlayer'] =  false,
    ['killPlayer'] = false,
    ['freezePlayer'] = false,
    ['gotoPlayer'] = false,
    ['bringPlayer'] = false,
    ['giveVip'] = false,
   
    ['markGps'] = false,
    ['giveItem'] = false,
    ['clearVehicle'] = false,
    ['allRevive'] = false,
    ['clearArea'] = false,
    ['changeWeather'] = false,
    ['changeTime'] = false,
    ['giveCash'] = false,
    ['giveBank'] = false,
    ['devtools'] = false,
    ['noclip'] = false,
    ['godmode'] = false,
    ['healPlayer'] = false,
    ['invisible'] = false,
    
    ['showPlayerName'] = false,
    ['sendPM'] = false,
    ['giveVehicle'] = false,
    ['giveVehicleDatabase'] = false,
    ['unbanPlayer'] = false,
    ['announce'] = false,
    ['showcoords'] = false,
    ['giveClothingMenu'] = false,
    ['takePicture'] = false,
    ['clearInventory'] = false,
    ['setJob'] = false,
    ['freezeTime'] = false,
    ['runCommand'] = false,
    ['repairVehicle'] = false,
    ['unjailPlayer'] = false,
    ['tpmarker'] = false,
    ['givePerm'] = false,
    
    ['allPermission'] = false, --- dont thach this
}