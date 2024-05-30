-- Built-in actions
local action_state = require('telescope.actions.state')
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local previewers = require("telescope.previewers")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values
local utils = require("telescope.utils")

--- Ask user to confirm an action
---@param prompt string: The prompt for confirmation
---@param default_value string: The default value of user input
---@param yes_values table: List of positive user confirmations ({"y", "yes"} by default)
---@return boolean: Whether user confirmed the prompt
local function ask_to_confirm(prompt, default_value, yes_values)
  yes_values = yes_values or { "y", "yes" }
  default_value = default_value or ""
  local confirmation = vim.fn.input(prompt, default_value)
  confirmation = string.lower(confirmation)
  if string.len(confirmation) == 0 then
    return false
  end
  for _, v in pairs(yes_values) do
    if v == confirmation then
      return true
    end
  end
  return false
end

local refresh_results = function(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local prompt = current_picker:_get_prompt()

  local cmd = {'rg', prompt, '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'}

  local new_finder = finders.new_job(function(new_prompt)
    return cmd
  end, make_entry.gen_from_vimgrep({}), 500, vim.fn.getcwd())--  local results = {}
--  for entry in current_picker.manager:iter() do
--    table.insert(results, entry)
--  end
--
--  local new_finder = finders.new_table {
--    results = results,
--    entry_maker = function(x)
--      return x
--    end,
--  }
  print("Prompt is "..prompt)

  current_picker:refresh(new_finder, { reset_prompt = false })

end


local delete_file = function(prompt_bufnr)
  --pre = append_to_history,
--  action = function(prompt_bufnr)
    local entry = action_state.get_selected_entry(prompt_bufnr)
    --local value = action_set.select(prompt_bufnr, "default")
    print("entry_filename: " .. entry.filename)
    local confirmation = ask_to_confirm("Delete "..entry.filename.."? ", 'y', {"y", "yes"})
    if confirmation then
      vim.fn.system('rm ' .. entry.filename)
      refresh_results(prompt_bufnr)
    end
    --return action_set.edit("drop", prompt_bufnr)
    return confirmation
end

local delete_line = function(prompt_bufnr)
  --pre = append_to_history,
--  action = function(prompt_bufnr)
    local entry = action_state.get_selected_entry(prompt_bufnr)
    print("entry_filename: " .. entry.filename, " line number: " .. entry.lnum)
    local confirmation = ask_to_confirm("Delete "..entry.filename..':'..entry.lnum.."? ", 'y', {"y", "yes"})
    if confirmation then
      vim.fn.system('sed -i '..entry.lnum..'d'..' '.. entry.filename)
      refresh_results(prompt_bufnr)
    end
    --return action_set.edit("drop", prompt_bufnr)
    return confirmation
end

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
  },
  pickers = {
    find_files = {
      mappings = {
        n = {
          ["dd"] = delete_file,
          ["dl"] = delete_line
        }
      }
    },
    live_grep = {
      mappings = {
        n = {
          ["dd"] = delete_file,
          ["dl"] = delete_line
        }
      }
    }

  }
}
require('telescope').load_extension('dap')




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
