fx_version 'cerulean'
game 'gta5'

name "ataRegister"
description "Register Player System"
author "!! AtaRevals#1538"
version "1.1"

shared_script '@es_extended/imports.lua'

ui_page 'client/ui/index.html'


shared_scripts {
	'shared/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/*.lua'
}


files {
	'client/ui/index.html',
    'client/ui/**'
}