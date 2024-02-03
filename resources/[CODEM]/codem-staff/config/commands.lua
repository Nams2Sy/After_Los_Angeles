


-- Config.NoClipCommand = "codemnoclip" -- noclip command


Config.Commands = {
    {
        name ="cnoclip",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "noclip",
        } -- /cnoclip
    },
    {
        name ="crevive",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "revive",
        } -- /crevive or /crevive [id]
    },
    {
        name ="cgodmode",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "godmode",
        }   -- /cgodmode
    },
    {
        name ="cheal",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "heal",
        }
        -- /cheal or /cheal [id]
    },
    {
        name ="cinvisible",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "invisible",
        } -- /cinvisible
    },
    {
        name ="ckill",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "kill",
        } -- /ckill [id]
    },
    {
        name ="cfreeze",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "freeze",
        } -- /freeze [id]
    },
    {
        name ="cgoto",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "goto",
        } -- /cgoto [id]
    },
    {
        name="cbring",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "bring",
        } -- /cbring [id]
    },
    {
        name="cgivestaff",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "givestaff",
        } -- /cgivestaff [id]
    },
    {
        name="cremoverank",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "removestaff",
        } -- /cremovestaff [id]
    },
    {
        name="cgiveadmin",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "giveadmin",
        } -- /cgiveadmin [id]
    },
    {
        name="cgivesuperadmin",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "givesuperadmin",
        } -- /cgivesuperadmin [id]
    },
    { 
        name="cgivevip",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "givevip",
        } -- /cgivevip [id]
    },
    {
        name="cmarkgps",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "markgps",
        } -- /markgps [id]
    },
    {
        name="cgiveitem",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "giveitem",
        } -- /cgiveitem [id] itemname [amount]
    },
    {
        name="cclearvehicle",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "clearvehicle",
        } -- /clearvehicle
    },
    {
        name="callrevive",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "allrevive",
        } -- /callrevive
    },
    {
        name="ccleararea",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "cleararea",
        } -- /cleararea
    },
    {
        name="cweather",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "weather",
        } -- /weather [weather]
    },
    {
        name="ctime",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "time",
        } -- /time [time]
    },
    {
        name="cgivecash",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "givecash",
        } -- /cgivecash [id] [amount]
    },
    {
        name="cgivebank",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "givebank",
        } -- /cgivebank [id] [amount]
    },
    {
        name="cshowname",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "showname",
        } -- /cshowname
    },
    {
        name="cpm",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "pm",
        } -- /cpm [id] [message]
    },
    {
        name="cgivevehicle",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "givevehicle",
        } -- /cgivevehicle [id] [vehicle]
    },
    {
        name="cgivevehicledatabase",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "givevehicledatabase",
        } -- /cgivevehicledatabase [id] [vehicle]
    },
    {
        name="cannounce",
        event = "staff:server:playerAdminOptions",
        data = {
            name = "announce",
        } -- /cannounce [message]
    },
    {
        name='showCoords',
        event = "staff:server:playerAdminOptions",
        data = {
            name = "showCoords",
        } -- /showCoords
    },
    {
        name='cgiveclothing',
        event = "staff:server:playerAdminOptions",
        data = {
            name = "giveped",
        } -- /cgiveclothing [id]
    },
    {
        name='cgiveped',
        event = "staff:server:playerAdminOptions",
        data = {
            name = "giveped",
        } -- /cgiveped [id]
    },
    {
        name='cclearinventory',
        event = "staff:server:playerAdminOptions",
        data = {
            name = "clearinventory",
        } -- /cclearinventory [id]
    },
    {
        name='csetjob',
        event = "staff:server:playerAdminOptions",
        data = {
            name = "setjob",
        } -- /csetjob [id] [job] [grade]
    },
    {
        name='cfreezetime',
        event = "staff:server:playerAdminOptions",
        data = {
            name = "freezetime",
        } -- /cfreezetime
    },
    {
        name='crepairvehicle',
        event = "staff:server:playerAdminOptions",
        data = {
            name = "repairvehicle",
        } -- /repairvehicle
    },
    {
        name='ctakepicture',
        event = "staff:server:playerAdminOptions",
        data = {
            name = "takepicture",
        } -- /ctakepicture
    },
    {
        name='ctpmarker',
        event = "staff:server:playerAdminOptions",
        data = {
            name = "tpmarker",
        } -- /ctpmarker
    }

}