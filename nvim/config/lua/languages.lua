local lsp = require'lspconfig'

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp_flags = {
  debounce_text_changes = 150
}

local on_attach = function()
	vim.opt.signcolumn = "yes"
end

lsp.tsserver = require'languages/typescript'
lsp.elixirls = require'languages/elixir'
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
