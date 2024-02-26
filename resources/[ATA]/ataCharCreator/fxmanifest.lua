fx_version 'adamant'
game 'gta5'
author '!! AtaRevals#1538'
description 'Character Creator '
version '2.4'
lua54 'yes'
ui_page 'client/html/index.html'

client_scripts {
	'client/*.lua',
	'config/client.lua'
}


shared_scripts {
	'config/config.lua'
}


server_scripts {
	"@mysql-async/lib/MySQL.lua",
	'server/*.lua'
}

files {
	'client/html/**'
}

escrow_ignore {
	'server/VersionCheck.lua',
	'config/*.lua'
}
