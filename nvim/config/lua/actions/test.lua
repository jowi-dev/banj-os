-- To run this, start a tmux session, and then in a window open a neovim session with
-- $ nvim --listen /tmp/<TMUX_SESSION_NAME>.pipe
-- Then open the terminal via :terminal 
-- and start the docker session with `make bash`
-- TODO - make this work for more than just papa context
function RunTests()
    local tmux_session = vim.fn.trim(vim.fn.system("tmux display-message -p '#S'"))

    local current_file = vim.fn.expand('%')

    local cmd = 'nvim --server /tmp/'..tmux_session..'.pipe --remote-send "MIX_ENV=test mix test '..current_file..' <CR>"'

    --debug
    --print(cmd)
    vim.fn.system(cmd)
end
