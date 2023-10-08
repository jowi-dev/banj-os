local function source_all()
  local files = {
    "aliases.lua",
    "init.lua",
    "keybindings.lua",
    "languages.lua",
    "opts.lua",
    "package_config.lua",
    "actions/build_environment.lua",
    "actions/copy_to_clipboard.lua",
    "actions/gpt.lua",
    "actions/http_post.lua",
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
  vim.cmd(':silent exec "!home-manager switch"')
  source_all()

  print("Environment Rebuilt.")
end
