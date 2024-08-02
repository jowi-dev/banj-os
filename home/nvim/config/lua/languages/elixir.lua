local lsp = require'lspconfig'


vim.g.mix_format_on_save = 0

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

--lsp.elixirls.setup{
--  cmd = {"elixir-ls"},
--  capabilities = capabilites
--}

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
--    cmd = elixir_ls_home .. "/bin/elixir-ls", -- path to the executable. mutually exclusive with `port`
--    settings = elixirls.settings {
--      dialyzerEnabled = true,
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

function ElixirOpenTestFile()
  local current_file = vim.fn.expand("%")

  current_file = current_file:gsub("lib", "test")

  current_file = current_file:gsub(".ex", "_test.exs")

  vim.cmd("vs " .. current_file)
end

local configs = require("lspconfig.configs")

local lexical_config = {
  filetypes = { "elixir", "eelixir", "heex" },
  cmd = { lexicalls .."/bin/lexical" },
  settings = {},
}

if not configs.lexical then
  configs.lexical = {
    default_config = {
      filetypes = lexical_config.filetypes,
      cmd = lexical_config.cmd,
      root_dir = function(fname)
        return lsp.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.os_homedir()
      end,
      -- optional settings
      settings = lexical_config.settings,
    },
  }
end

lsp.lexical.setup({})

--return lsp.elixirls
return lsp.lexical
