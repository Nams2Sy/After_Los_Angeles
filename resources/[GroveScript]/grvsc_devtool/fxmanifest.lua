fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Nam2Sy'
description 'Faction'
version '1.0.0'

-- Script côté serveur
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua',
    'json.lua',
}
client_scripts {
    'client.lua',
    'config.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
}
dependencies {
    'ox_lib',
    'es_extended',
    'oxmysql',
    'ox_inventory'
}

files {
    '@oxmysql/lib/define.lua'
}