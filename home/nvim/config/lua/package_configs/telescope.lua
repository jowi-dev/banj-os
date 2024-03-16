local telescope = require('telescope')
telescope.setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      height = 0.95,
      width = 0.95,
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
        results = {height = 0.2}
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}
require('telescope').load_extension('dap')

local pickers = require("telescope.pickers")
local previewers = require("telescope.previewers")
local make_entry = require("telescope.make_entry")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local utils = require("telescope.utils")



function GitDiffs(opts)
  opts.git_command = vim.F.if_nil(opts.git_command, utils.__git_command({ "diff", "--name-only", "--relative" }, opts))
  opts.entry_maker = vim.F.if_nil(opts.entry_maker, make_entry.gen_from_file(opts))

  local previewer_opts = {
    get_command = function(entry, status)
      return {'git', 'diff', entry.path}
    end
  }

  pickers.new(opts, {
      prompt_title = "Git Diff",
      __locations_input = true,
      finder = finders.new_oneshot_job(
        vim.tbl_flatten({
          opts.git_command,
        }),
        opts
      ),
      previewer = previewers.new_termopen_previewer(previewer_opts),
      sorter = conf.file_sorter(opts),
    }):find()
end
function GitConflicts(opts)
  opts.git_command = vim.F.if_nil(opts.git_command, utils.__git_command({ "diff", "--name-only", "--diff-filter=U", "--relative" }, opts))
  opts.entry_maker = vim.F.if_nil(opts.entry_maker, make_entry.gen_from_file(opts))

  pickers.new(opts, {
      prompt_title = "Git Conflicts",
      __locations_input = true,
      finder = finders.new_oneshot_job(
        vim.tbl_flatten({
          opts.git_command,
        }),
        opts
      ),
      previewer = conf.grep_previewer(opts),
      sorter = conf.file_sorter(opts),
    }):find()
end

--telescope.register_extension({
--  exports = {
--    conflicts = function(opts)
--      opts.git_command = vim.F.if_nil(opts.git_command, telescope.utils.__git_command({ "diff", "--name-only", "--diff-filter=U", "--relative" }, opts))
--      opts.entry_maker = vim.F.if_nil(opts.entry_maker, telescope.make_entry.gen_from_file(opts))
--
--      telescope.pickers.new(opts, {
--          prompt_title = "Git Conflicts",
--          __locations_input = true,
--          finder = telescope.finders.new_oneshot_job(
--            vim.tbl_flatten({
--              opts.git_command,
--            }),
--            opts
--          ),
--          previewer = telescope.config.grep_previewer(opts),
--          sorter = telescope.config.file_sorter(opts),
--        }):find()
--    end
--  }
--})
--
--telescope.load_extension('conflicts')
