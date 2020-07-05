--[[ FXServer Required Metadata ]]--
fx_version 'bodacious'
game 'gta5'

-- [[ Resource Information ]]--
description 'Adds the ability for players to drive for a trucking company and fulfill delivery contracts.'
version '1.0.0'
author 'Kenneth McDonough'

--[[ Script Content ]]--
client_scripts {
  '@es_extended/locale.lua',
  'locale/en.lua',
  'config.lua',
  'client/main.lua'
}

server_scripts {
  '@es_extended/locale.lua',
  'locale/en.lua',
  'config.lua',
  'server/main.lua'
}

--ui_page 'ui/interface.html'

--file 'ui/*.*'