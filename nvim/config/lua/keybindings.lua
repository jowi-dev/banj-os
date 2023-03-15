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

map('v', '<leader>c',   ':lua CopyToClipboard()<CR>',{noremap=true})

-- Nvim Config Keybinds -- PREFIX v
map('n', '<leader>vc', ':e ~/.config/nvim/init.lua', {noremap=true})
map('n', '<leader>vr', ':source ~/.config/nvim/init.lua', {noremap=true})

-- If you want :UltiSnipsEdit to split your window.
vim.g.UltiSnipsExpandTrigger="<leader>sx"
vim.g.UltiSnipsJumpForwardTrigger="<leader>sf"
vim.g.UltiSnipsJumpBackwardTrigger="<leader>sb"


-- This could be moved to a separate file to keep implementation details out
-- mostly written with ChatGPT
function CopyToClipboard()
    -- save current register to restore later
    local saved_register = vim.fn.getreg('"')

    -- yank (copy) the highlighted text to the default register
    vim.cmd('y')

    -- send the text to xclip via shell command
    local cmd = 'echo -n "'..vim.fn.escape(vim.fn.getreg('"'), '"')..'" | xclip -selection clipboard'
    print(vim.fn.escape(vim.fn.getreg('"'), '"'))
    os.execute(cmd)

    -- restore original register
    vim.fn.setreg('"', saved_register)
end
