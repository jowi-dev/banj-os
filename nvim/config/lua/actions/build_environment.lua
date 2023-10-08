local function source_all()
  local rel_path = "~/.config/nvim"
  local files = {
    "lua/aliases.lua",
    "lua/init.lua",
    "lua/keybindings.lua",
    "lua/languages.lua",
    "lua/opts.lua",
    "lua/package_config.lua",
    "lua/actions/build_environment.lua",
    "lua/actions/copy_to_clipboard.lua",
    "lua/actions/gpt.lua",
    "lua/actions/http_post.lua",
    "lua/actions/test.lua",
    "lua/languages/elixir.lua",
    "lua/languages/typescript.lua",
    "lua/package_configs/cmp.lua",
    "lua/package_configs/telescope.lua",


  }

  for _, file in ipairs(files) do
    vim.cmd(':source ' .. rel_path .. '/' .. file)
  end
end

function BuildEnv()
  vim.cmd(':silent exec "!home-manager switch"')
  source_all()

  print("Environment Rebuilt.")
end
