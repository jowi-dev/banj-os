-- These configs are copy/pasted with full defaults to maximize 
-- configurability
----------------------------------------------------------------------
require'package_configs/telescope'
require'package_configs/cmp'
-- This plugin was deprecated. Mason.nvim or manage lsps via nix?
--require'package_configs/nvim_lsp_installer'
----------------------------------------------------------------------

----------------------------------------------------------------------
-- The following configs don't justify their own files yet. Chunk this 
-- as it becomes too much of a catch all.
----------------------------------------------------------------------


-- Null LS
local null_ls = require("null-ls")

null_ls.setup({
  null_ls.builtins.diagnostics.credo,
  null_ls.builtins.diagnostics.eslint,
})

  -- LSP freaks but nix handles
local logs = vim.fn.expand(logs_path)
local telekasten = require('telekasten').setup({
  home = logs,
  dailies = logs .. "/dailies/",
  weeklies = logs .. "/weeklies/",
  templates = logs .. "/templates/",
  template_new_note = logs .. "/templates/generic_template.md",
  template_new_daily = logs .. "/templates/daily_template.md",
  template_new_weekly = logs .. "/templates/weekly_template.md",
})

vim.fn.Notes = telekasten

-- UltiSnips Options
vim.g.ultisnips_edit_split="vertical"

-- Git (Fugitive) Options
vim.g.gitgutter_realtime=0
vim.g.gitgutter_eager=0
