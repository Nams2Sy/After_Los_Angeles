
fx_version 'cerulean'

author 'Aiakos#8317'
version '1.8.0'
game 'gta5'

client_scripts {
    'GetCore.lua',
    'config/config.lua',
    'client/editable.lua',
    'client/client.lua',
    'client/delvehicles.lua',
    'client/weather.lua',

}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'GetCore.lua',
    'config/config.lua',
    'config/commands.lua',
    'server/function.lua',
    'server/command.lua',
    'config/server_config.lua',
    'config/permissions.lua',
    'server/editable.lua',
    'server/server.lua',
    'server/discordlog.lua',

}
ui_page 'html/index.html'

files {
    'html/index.html',
    'html/css/style.css',
    'html/images/*.png',
    'html/fonts/*.OTF',
    'html/fonts/*.otf',
    'html/fonts/*.ttf',
    'html/sound/*.ogg',
    'html/js/index.js',
    'html/js/*.js',
}

escrow_ignore {
	'config/*.lua',
	'GetCore.lua',
	'server/editable.lua',
	'client/editable.lua',

}

lua54 'yes'
dependency '/assetpacks'