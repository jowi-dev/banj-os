require('actions.test')
require('actions.gpt')
require('actions.http_post')
require('actions.copy_to_clipboard')

-- Leader Key
vim.g.mapleader=","

local map = vim.api.nvim_set_keymap

-- Misc Copying Keybinds
map('n',  '<leader>m', ':let @+=expand("%")<CR>',{noremap=true})
map('v',  '<leader>k', '"*y<CR>',{noremap=true})

-- Git Keybinds -- PREFIX g
map('n',  '<leader>gs', ':GitGutterStageHunk<CR>',{noremap=true})
map('n',  '<leader>gr', ':GitGutterRevertHunk<CR>',{noremap=true})
map('n',  '<leader>gd', ':Gvdiffsplit!<CR>',{noremap=true})
map('n',  '<leader>gq', ':diffget //2<CR>',{noremap=true})
map('n',  '<leader>gp', ':diffget //3<CR>',{noremap=true})
map('n',  '<leader>gm', ':Merginal<CR>',{noremap=true})
map('n',  '<leader>gg', ':Git<CR>',{noremap=true})

-- Search and  FileNavigation Related keybinds
map('n',  '<C-p>',      ':Telescope find_files<CR>',{noremap=true})
map('n',  '<C-f>',      ':Telescope live_grep<CR>',{noremap=true})
map('n',  '<leader>c',  ':bd<CR>',{noremap=true})
map('n',  '<leader>q',  ':bprev<CR>',{noremap=true})
map('n',  '<leader>p',  ':bnext<CR>',{noremap=true})
map('n',  '<leader>l',  ':NERDTreeToggle<CR>',{noremap=true})
map('n', '<leader><space>', ':nohlsearch<CR>', {noremap=true})

-- Snippet Keybinds -- PREFIX s
map('i', '<leader>sx',   ':UltiSnipsExpandTrigger',{noremap=true})
map('n', '<leader>sd',   ':UltiSnipsEdit',{noremap=true})
map('n', '<leader>sf',   ':UltiSnipsJumpForwardTrigger',{noremap=true})
map('n', '<leader>sb',   ':UltiSnipsJumpBackwardTrigger',{noremap=true})


-- Nvim Config Keybinds -- PREFIX v
map('n', '<leader>vc', ':e ~/.config/nvim/init.lua', {noremap=true})
map('n', '<leader>vr', ':source ~/.config/nvim/init.lua', {noremap=true})


-- Testing Keybinds -- PREFIX t
map('n', '<leader>t',   ':lua RunTests()<CR>',{noremap=true})

-- If you want :UltiSnipsEdit to split your window.
vim.g.UltiSnipsExpandTrigger="<leader>sx"
vim.g.UltiSnipsJumpForwardTrigger="<leader>sf"
vim.g.UltiSnipsJumpBackwardTrigger="<leader>sb"

-- custom actions - because I can
map('v', '<leader>c',   ':lua CopyToClipboard()<CR>',{noremap=true})
map('v', '<leader>gpt', ':lua GPTSubmit()<CR>',{noremap=true})
