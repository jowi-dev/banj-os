local lsp = require'lspconfig'

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
      diagnostics = {
        -- Surpress the 'undefined global vim' warning
        globals = {'vim'}
      }
    }
  }
}


