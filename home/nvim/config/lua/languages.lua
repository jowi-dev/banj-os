local lsp = require'lspconfig'

require'lspconfig'.ccls.setup{}
-- Going to try a new LS for elixir

lsp.elixirls = require'languages/elixir'

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
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      }
    }
  }
}


