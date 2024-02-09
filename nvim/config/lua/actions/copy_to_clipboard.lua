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

--"-------------------------------------------------------------------------------
--" Places a link to the current file in github in the system paste buffer
--"-------------------------------------------------------------------------------
function GithubLink()
  local repo = vim.fn.substitute(vim.fn.system("git remote get-url --push origin | sed 's/git@github.com://' | sed 's/.git//'"), '\n', '', '')
  local branch = vim.fn.substitute(vim.fn.system('git rev-parse --abbrev-ref HEAD 2>/dev/null'), '\n', '', '')
  local filename = "https://github.com/" .. repo .. "/blob/" .. branch .. "/" .. vim.fn.expand("%:.")
  os.execute("echo '" .. filename .. "' | pbcopy")
end
