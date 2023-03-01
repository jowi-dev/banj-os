HOME = os.getenv("HOME")


print(HOME)
--package.path = package.path..';./?.lua'
package.path = HOME.."/.config/nvim/?.lua"
require('keybindings')
require('opts')
--require('package_installer')
require('package_config')
require('languages')
