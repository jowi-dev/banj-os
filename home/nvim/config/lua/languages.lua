local lsp = require'lspconfig'

-- Going to try a new LS for elixir


local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

lsp.elixirls = require'languages/elixir'
lsp.ccls.setup{
  capabilities=capabilities
}
local lsp_flags = {
  debounce_text_changes = 150
}
local on_attach = function(client, buf)
	-- Example maps, set your own with vim.api.nvim_buf_set_keymap(buf, "n", <lhs>, <rhs>, { desc = <desc> })
	-- or a plugin like which-key.nvim
	-- <lhs>        <rhs>                        <desc>
	-- "K"          vim.lsp.buf.hover            "Hover Info"
	-- "<leader>qf" vim.diagnostic.setqflist     "Quickfix Diagnostics"
	-- "[d"         vim.diagnostic.goto_prev     "Previous Diagnostic"
	-- "]d"         vim.diagnostic.goto_next     "Next Diagnostic"
	-- "<leader>e"  vim.diagnostic.open_float    "Explain Diagnostic"
	-- "<leader>ca" vim.lsp.buf.code_action      "Code Action"
	-- "<leader>cr" vim.lsp.buf.rename           "Rename Symbol"
	-- "<leader>fs" vim.lsp.buf.document_symbol  "Document Symbols"
	-- "<leader>fS" vim.lsp.buf.workspace_symbol "Workspace Symbols"
	-- "<leader>gq" vim.lsp.buf.formatting_sync  "Format File"

	vim.api.nvim_buf_set_option(buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")
	vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
	vim.api.nvim_buf_set_option(buf, "tagfunc", "v:lua.vim.lsp.tagfunc")
end

--local on_attach = function()
--	vim.opt.signcolumn = "yes"
--end

lsp.graphql.setup{}
lsp.tsserver = require'languages/typescript'
lsp.zls.setup{}
lsp.rust_analyzer.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities=capabilities,
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


