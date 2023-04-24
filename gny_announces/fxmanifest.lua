fx_version 'adamant'
lua54 'yes'
game 'gta5'

description 'Garny Announces'
version '1.0.0'

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

ui_page 'ui/index.html'

files {
    'ui/**',
    'ui/assets/**'
}
