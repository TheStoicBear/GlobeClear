fx_version 'cerulean'
game 'gta5'
author 'Azure'
description 'GlobeClear: clears NPCs, vehicles, and objects via server console command'
version '1.0.0'

shared_scripts {
    'config.lua'
}

server_script 'server.lua'
client_script 'client.lua'

ui_page 'ui/index.html'

files {
    'ui/index.html',
}
