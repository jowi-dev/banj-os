local lsp = require'lspconfig'


vim.g.mix_format_on_save = 1

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

lsp.elixirls.setup{
  cmd = {"elixir-ls"},
  capabilities = capabilites
}

return lsp.elixirls
