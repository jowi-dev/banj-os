-- Used to send the currently highlighted text to the end of the current day's notes
function SendToNote()
  vim.cmd('y')

  local selected_text = vim.fn.getreg('"')
  local current_date = os.date("%Y-%m-%d")
  local file = logs_path .. '/' .. current_date .. '.md'

  os.execute("echo " .. selected_text .. " >> " .. file)
  --print(file)
end
-- TODO - use the commented code below to open file, read contents, append new contents, write file
---- Open the file in r mode (don't modify file, just read)
--local out = io.open('file.txt', 'r')
--
---- Fetch all lines and add them to a table
--local lines = {}
--for line in f:lines() do
--    table.insert(lines, line)
--end
--
---- Close the file so that we can open it in a different mode
--out:close()
--
---- Insert what we want to write to the first line into the table
--table.insert(lines, 1, "<what you want to write to the first line>\n")
--
---- Open temporary file in w mode (write data)
---- Iterate through the lines table and write each line to the file
--local out = io.open('file.tmp.txt', 'w')
--for _, line in ipairs(lines) do
--    out:write(line)
--end
--out:close()
--
---- At this point, we should have successfully written the data to the temporary file
--
---- Delete the old file
--os.remove('file.txt')
--
---- Rename the new file
--os.rename('file.tmp.txt', 'file.txt')
