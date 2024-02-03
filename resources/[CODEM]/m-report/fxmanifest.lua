fx_version 'adamant'
game 'gta5'
version '1.1.1'
author 'CodeM Team'
description 'Codem-mReport'

shared_script{
	'shared/config.lua',
    'shared/GetFrameworkObject.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'shared/server_config.lua',
    'server/main.lua',
    'server/function.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/css/*.css',
    'html/fonts/*.otf',
    'html/fonts/*.OTF',
    'html/img/*.png',
    'html/js/*.js'
}

escrow_ignore{
    'shared/*.lua',
    'server/function.lua'
}

lua54 'yes'
dependency '/assetpacks'