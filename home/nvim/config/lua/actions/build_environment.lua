local function source_all()
  local files = {
    "aliases.lua",
    "init.lua",
    "keybindings.lua",
    "languages.lua",
    "opts.lua",
    "package_config.lua",
    "actions/build_environment.lua",
    "actions/send_to_note.lua",
    "actions/copy_to_clipboard.lua",
    "actions/gpt.lua",
    "actions/http_post.lua",
    "actions/gql_request.lua",
    "actions/http_request.lua",
    "actions/test.lua",
    "languages/elixir.lua",
    "languages/typescript.lua",
    "package_configs/cmp.lua",
    "package_configs/telescope.lua",


  }

  for _, file in ipairs(files) do
    vim.cmd(':source ' .. nvimHome .. '/' .. file)
  end
end

function BuildEnv()
  vim.cmd("term gum spin -s line  --title 'Reloading Nix Environment' -- home-manager switch")
  source_all()

  --print("Environment Rebuilt.")
end

function LightMode()
  vim.cmd('let ayucolor="light"')
  vim.cmd('colorscheme github')
  --BuildEnv()
end

function DarkMode()
  vim.cmd('colorscheme angr')
  --BuildEnv()
end

