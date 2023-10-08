require('actions.test')
require('actions.gpt')
require('actions.http_post')
require('actions.copy_to_clipboard')
require('actions.build_environment')

-- Leader Key
vim.g.mapleader=","

--local map = vim.api.nvim_set_keymap
local map = vim.keymap.set

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

-- Formatting Keybinds -- PREFIX f
map('n', '<leader>f',   ':lua Format()<CR>',{noremap=true})

-- If you want :UltiSnipsEdit to split your window.
vim.g.UltiSnipsExpandTrigger="<leader>sx"
vim.g.UltiSnipsJumpForwardTrigger="<leader>sf"
vim.g.UltiSnipsJumpBackwardTrigger="<leader>sb"

-- custom actions - because I can
map('v', '<leader>c',   ':lua CopyToClipboard()<CR>',{noremap=true})
map('v', '<leader>gpt', ':lua GPTSubmit()<CR>',{noremap=true})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
map('n', '<space>e', vim.diagnostic.open_float, {noremap=true})
map('n', '[d', vim.diagnostic.goto_prev, {noremap=true})
map('n', ']d', vim.diagnostic.goto_next, {noremap=true})
map('n', '<space>q', vim.diagnostic.setloclist, {noremap=true})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    --local opts = { noremap=true }
    map('n', 'gD', vim.lsp.buf.declaration, opts)
    map('n', 'gd', vim.lsp.buf.definition, opts)
    map('n', 'K', vim.lsp.buf.hover, opts)
    map('n', 'gi', vim.lsp.buf.implementation, opts)
    map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
--    map('n', '<space>wl', function()
--      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--    end, opts)
    map('n', '<space>D', vim.lsp.buf.type_definition, opts)
    map('n', '<space>rn', vim.lsp.buf.rename, opts)
    map('n', '<space>ca', vim.lsp.buf.code_action, opts)
    map('n', 'gr', vim.lsp.buf.references, opts)
    map('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
