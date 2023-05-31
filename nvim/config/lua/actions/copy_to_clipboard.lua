function CopyToClipboard()
    -- save current register to restore later
    local saved_register = vim.fn.getreg('"')

    -- yank (copy) the highlighted text to the default register
    vim.cmd('y')

    -- send the text to xclip via shell command
    local cmd = 'echo -n "'..vim.fn.escape(vim.fn.getreg('"'), '"')..'" | xclip -selection clipboard'
    print(vim.fn.escape(vim.fn.getreg('"'), '"'))
    os.execute(cmd)

    -- restore original register
    vim.fn.setreg('"', saved_register)
end
