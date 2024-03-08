local lsp = require'lspconfig'


vim.g.mix_format_on_save = 1

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

--lsp.elixirls.setup{
--  cmd = {"elixir-ls"},
--  capabilities = capabilites
--}

local elixirls = require("elixir.elixirls")
require("elixir").setup({
  nextls = {
    enable = false, -- defaults to false
    cmd = elixir_tools .. "/bin/nextls", -- path to the executable. mutually exclusive with `port`
    version = "0.5.0", -- version of Next LS to install and use. defaults to the latest version
    on_attach = function(client, bufnr)
      -- custom keybinds
      vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
      vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
      vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
    end
  },
  credo = {
    enable = true, -- defaults to true
    cmd = elixir_tools .. "/bin/credo-language-server", -- path to the executable. mutually exclusive with `port`
    version = "0.1.0-rc.3", -- version of credo-language-server to install and use. defaults to the latest release
    on_attach = function(client, bufnr)
      -- custom keybinds
    end
  },
  elixirls = {
    enable = true,
    cmd = elixir_ls_home .. "/bin/elixir-ls", -- path to the executable. mutually exclusive with `port`
    settings = elixirls.settings {
      dialyzerEnabled = true,
      enableTestLenses = true,
    },
    on_attach = function(client, bufnr)
      vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
      vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
      vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
    end,
  }
 -- elixirls = {enable = true},
})

return lsp.elixirls
