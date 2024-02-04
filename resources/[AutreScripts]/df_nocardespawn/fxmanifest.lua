fx_version 'cerulean'

game 'gta5'
author 'DF TEAM'
description 'No more garage scripts'
name 'df_nocardespawn'
lua54 'yes'

version '0.1'

client_script {
    'editClient.lua',
    'client.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'edit.lua',
    'serverConfig.lua',
	'server.lua',
}

server_export 'CarLocking'

escrow_ignore {
    'serverConfig.lua',
    'edit.lua',
    'editClient.lua'
}

dependencies {
    '/assetpacks',
    'es_extended',
    'oxmysql',
}

shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
}