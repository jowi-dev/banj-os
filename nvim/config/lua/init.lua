HOME = os.getenv("HOME")


--package.path = package.path..';./?.lua'
--package.path = HOME.."/.config/nvim/?.lua"
--package.path = package.path .. ";/nix/store/xxgimip1x0mpqdvjnfs7jklfilrvpf2r-luajit0.3-http-0.3-0/share/lua/5.1/?.lua"

require('keybindings')
require('opts')
--require('package_installer')
require('package_config')
require('languages')
require('aliases')


function Yes()
  print("OK")
end
