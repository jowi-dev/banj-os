local dap = require('dap')
dap.adapters.mix_task = {
  type = 'executable',
  command = elixir_ls_home ..'/bin/elixir-debug-adapter', -- debugger.bat for windows
  args = {}
}
dap.configurations.elixir = {
  {
    type = "mix_task",
    name = "mix test",
    task = 'test',
    taskArgs = {"--trace"},
    request = "launch",
    startApps = true, -- for Phoenix projects
    projectDir = "${workspaceFolder}",
    requireFiles = {
      "test/**/test_helper.exs",
      "test/**/*_test.exs"
    }
  },
}
