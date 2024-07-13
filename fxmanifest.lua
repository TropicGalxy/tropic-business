fx_version 'cerulean'
game 'gta5'

lua54 'yes'
author 'tropicgalxy'
description 'a very script to buy multiple business'
version '1.0.0'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@ox_lib/init.lua',
    'server.lua'
}

dependencies {
    'qb-core',
    'ox_target', -- comment out if using qb target
    -- 'qb-target'  -- comment out if using ox target
}