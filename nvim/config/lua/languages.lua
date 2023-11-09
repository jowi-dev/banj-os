local lsp = require'lspconfig'

require'lspconfig'.clangd.setup{}
-- Going to try a new LS for elixir

lsp.elixirls = require'languages/elixir'
--local elixirls = require("elixir.elixirls")
--require("elixir").setup({
--  nextls = {
--    enable = false, -- defaults to false
--    cmd = elixir_tools .. "/bin/nextls", -- path to the executable. mutually exclusive with `port`
--    version = "0.5.0", -- version of Next LS to install and use. defaults to the latest version
--    on_attach = function(client, bufnr)
--      -- custom keybinds
--      vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
--      vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
--      vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
--    end
--  },
--  credo = {
--    enable = true, -- defaults to true
--    cmd = elixir_tools .. "/bin/credo-language-server", -- path to the executable. mutually exclusive with `port`
--    version = "0.1.0-rc.3", -- version of credo-language-server to install and use. defaults to the latest release
--    on_attach = function(client, bufnr)
--      -- custom keybinds
--    end
--  },
--  elixirls = {
--    enable = true,
--    cmd = elixir_tools .. "/bin/elixirls", -- path to the executable. mutually exclusive with `port`
--    settings = elixirls.settings {
--      dialyzerEnabled = false,
--      enableTestLenses = false,
--    },
--    on_attach = function(client, bufnr)
--      vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
--      vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
--      vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
--    end,
--  }
-- -- elixirls = {enable = true},
--})

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp_flags = {
  debounce_text_changes = 150
}

local on_attach = function()
	vim.opt.signcolumn = "yes"
end

lsp.graphql.setup{}
lsp.tsserver = require'languages/typescript'
lsp.zls.setup{}
lsp.rust_analyzer.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}
lsp.html.setup{
  capabilities = capabilities
}

lsp.cssls.setup{
  capabilities = capabilities
}

lsp.lua_ls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',  -- set this to 'Lua' if you're not using LuaJIT
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Surpress the 'undefined global vim' warning
        enable = true,
        globals = {'vim'}
      }
    }
  }

--    Lua = {
--      runtime = {
--        version = 'LuaJIT',  -- set this to 'Lua' if you're not using LuaJIT
--        path = vim.split(package.path, ';'),
--      },
--      diagnostics = {
--        enable = true,
--        globals = {'vim'},  -- this is for neovim, add other globals you need
--      },
--      workspace = {
--        library = {
--          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
--          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
--        },
--      },
}

--how can I integrate the lua lsp into my neovim config without using any open source plugins?
-- 3
-- To integrate the Lua LSP into your Neovim config without using any open source plugins, you can follow these steps:

--1. Install the Lua LSP by running the following command in your terminal:
--   ```
--   npm install -g lua-lsp
--   ```
--
--2. Create a new file called `lua-lsp.sh` in a directory of your choice and add the following contents to it:
--   ```bash
--   #!/bin/bash
--   lua-lsp
--   ```
--
--3. Make the `lua-lsp.sh` file executable by running the following command in your terminal:
--   ```bash
--   chmod +x /path/to/lua-lsp.sh
--   ```
--
--4. In your Neovim config file (usually located at `~/.config/nvim/init.vim`), add the following lines:
--
--   ```vim
--   let g:lua_lsp_command = '/path/to/lua-lsp.sh'
--   let g:lua_lsp_arguments = ['-E', '/path/to/lua-lsp/main.lua']
--   let g:lua_lsp_root_dir = '/path/to/lua-lsp'
--   let g:lua_lsp_disable_formatting = 1
--   let g:lua_lsp_disable_snippets = 1
--
--   au FileType lua lua require('lspconfig').lua.setup{
--       cmd = { g:lua_lsp_command },
--       on_attach = require('lsp').on_attach,
--       root_dir = function() return g:lua_lsp_root_dir end,
--       settings = {
--           Lua = {
--               diagnostics = {
--                   globals = { 'vim' },
--               },
--               workspace = {
--                   library = {
--                       [vim.fn.expand('$VIMRUNTIME/lua')] = true,
--                       [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
--                   },
--               },
--               telemetry = {
--                   enable = false,
--               },
--           },
--       },
--   }
--   ```
--
--   Make sure to replace `/path/to/lua-lsp.sh` with the actual path to your `lua-lsp.sh` file, and `/path/to/lua-lsp` with the actual path to the Lua LSP installation directory.
--
--5. Save the changes to your Neovim config file and restart Neovim.
--
--Now, the Lua LSP should be integrated into your Neovim config without using any open source plugins.
--
--
--Setting up Lua language server protocol (LSP) for Neovim without using any plugins can be a bit tricky. However, you can do it manually by following these steps:

--1. Install Lua Language Server
--
--First, you need to install the Lua language server. You can do this by following the instructions on the GitHub page of the Lua language server you want to use. For example, you can use `sumneko_lua`, which is a popular choice.
--
--2. Configure Neovim
--
--Next, you need to configure Neovim to use the Lua language server. You can do this by adding the following code to your `init.vim` file:
--
--```vim
--lua << EOF
--local nvim_lsp = require('lspconfig')
--
--local on_attach = function(_, bufnr)
--  require('vim.lsp').buf_attach_client(bufnr, client)
--end
--
--nvim_lsp.sumneko_lua.setup {
--  cmd = {"path/to/your/lua-language-server", "-E", "path/to/your/main.lua"};
--  on_attach = on_attach,
--  settings = {
--    Lua = {
--      runtime = {
--        version = 'LuaJIT',  -- set this to 'Lua' if you're not using LuaJIT
--        path = vim.split(package.path, ';'),
--      },
--      diagnostics = {
--        enable = true,
--        globals = {'vim'},  -- this is for neovim, add other globals you need
--      },
--      workspace = {
--        library = {
--          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
--          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
--        },
--      },
--    },
--  },
--}
--
---- Use a loop to conveniently both setup defined servers 
---- and map buffer local keybindings when the language server attaches
--local servers = { "sumneko_lua" }
--for _, lsp in ipairs(servers) do
--  nvim_lsp[lsp].setup { on_attach = on_attach }
--end
--EOF
--```
--
--3. Update the Path
--
--Make sure to replace `path/to/your/lua-language-server` and `path/to/your/main.lua` with the actual paths where you installed your Lua language server and the main.lua file.
--
--In the settings section, you can adjust the settings according to your preferences. The example above sets the Lua version to LuaJIT, enables diagnostics, and sets the globals for the diagnostics to `vim`.
--
--4. Install LSPConfig
--
--The `lspconfig` module is a built-in module in neovim that is used to configure language servers. It is not an open-source plugin but a built-in feature of neovim. You can install it using the package manager in neovim.
--
--This setup should allow you to use the Lua language server with Neovim. You might need to restart Neovim or reload the configuration for the changes to take effect.


