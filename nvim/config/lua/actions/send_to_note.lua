-- Used to send the currently highlighted text to the end of the current day's notes
function SendToNote()
  vim.cmd('y')

  local selected_text = vim.fn.getreg('"')
  local current_date = os.date("%Y-%m-%d")
  local file = logs_path .. '/' .. current_date .. '.md'

  os.execute("echo " .. selected_text .. " >> " .. file)
end
