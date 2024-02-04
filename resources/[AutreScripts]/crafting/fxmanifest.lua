fx_version 'cerulean'
games { 'gta5' }

author 'Nouma'
description 'Example resource'
version '1.0.0'

lua54 'yes'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua',
    'server/callbacks.lua',
}
client_scripts {
    'client/client.lua',
    'client/interface.lua',
}
shared_scripts {
    '@ox_lib/init.lua',
    'station.lua',
    'config.lua',
    "utils.lua"
}

dependencies {
    'es_extended',
    'oxmysql',
    'ox_lib',
}