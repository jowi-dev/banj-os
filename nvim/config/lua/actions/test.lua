function RunTests()
    local tmux_session = vim.fn.trim(vim.fn.system("tmux display-message -p '#S'"))

    local current_file = vim.fn.expand('%')

    local cmd = 'nvim --server /tmp/'..tmux_session..'.pipe --remote-send "MIX_ENV=test mix test '..current_file..' <CR>"'

    --debug
    --print(cmd)
    vim.fn.system(cmd)
end
