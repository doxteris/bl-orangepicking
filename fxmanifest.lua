fx_version 'cerulean'
game 'gta5'

name "baylife-orangepicking"
description "baylife-orangepicking"
author "doxteris"
version "1"
lua54 'yes'

shared_scripts {
	'shared/*.lua',
	'@ox_lib/init.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}
