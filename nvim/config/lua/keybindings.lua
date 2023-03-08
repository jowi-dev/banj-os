-- Leader Key
vim.g.mapleader=","

local map = vim.api.nvim_set_keymap

-- Misc Copying Keybinds
map('n',  '<leader>m', ':let @+=expand("%")<CR>',{noremap=true})
map('v',  '<leader>k', '"*y<CR>',{noremap=true})

-- Git Keybinds -- PREFIX g
map('n',  '<leader>gs', ':GitGutterStageHunk<CR>',{noremap=true})
map('n',  '<leader>gr', ':GitGutterRevertHunk<CR>',{noremap=true})
map('n',  '<leader>gd', ':Gvdiffsplit!<CR>',{noremap=true})
map('n',  '<leader>gq', ':diffget //2<CR>',{noremap=true})
map('n',  '<leader>gp', ':diffget //3<CR>',{noremap=true})
map('n',  '<leader>gm', ':Merginal<CR>',{noremap=true})
map('n',  '<leader>gg', ':Git<CR>',{noremap=true})

-- Search and  FileNavigation Related keybinds
map('n',  '<C-p>',      ':Telescope find_files<CR>',{noremap=true})
map('n',  '<C-f>',      ':Telescope live_grep<CR>',{noremap=true})
map('n',  '<leader>c',  ':bd<CR>',{noremap=true})
map('n',  '<leader>q',  ':bprev<CR>',{noremap=true})
map('n',  '<leader>p',  ':bnext<CR>',{noremap=true})
map('n',  '<leader>l',  ':NERDTreeToggle<CR>',{noremap=true})
map('n', '<leader><space>', ':nohlsearch<CR>', {noremap=true})

-- Snippet Keybinds -- PREFIX s
map('i', '<leader>sx',   ':UltiSnipsExpandTrigger',{noremap=true})
map('n', '<leader>sd',   ':UltiSnipsEdit',{noremap=true})
map('n', '<leader>sf',   ':UltiSnipsJumpForwardTrigger',{noremap=true})
map('n', '<leader>sb',   ':UltiSnipsJumpBackwardTrigger',{noremap=true})


-- Nvim Config Keybinds -- PREFIX v
map('n', '<leader>vc', ':e ~/.config/nvim/init.lua', {noremap=true})
map('n', '<leader>vr', ':source ~/.config/nvim/init.lua', {noremap=true})


-- If you want :UltiSnipsEdit to split your window.
vim.g.UltiSnipsExpandTrigger="<leader>sx"
vim.g.UltiSnipsJumpForwardTrigger="<leader>sf"
vim.g.UltiSnipsJumpBackwardTrigger="<leader>sb"

-- custom actions - because I can
map('v', '<leader>c',   ':lua CopyToClipboard()<CR>',{noremap=true})
map('v', '<leader>gpt', ':lua GPTSubmit()<CR>',{noremap=true})


-- This could be moved to a separate file to keep implementation details out
-- mostly written with ChatGPT
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


-- This is a generic post request written mostly for the OpenAPI request
-- but should work for any request using a bearer token style, or 
-- that does not require a token to post
function Post(url, body, api_key)
  local request = require("http.request")
  local http_headers = require("http.headers")
  local json = require "cjson"
  local payload, err = json.encode(body)
  if err then error(err) end

  local headers = http_headers.new()
  headers:append(":method", "POST")
  headers:append(":scheme", "https")
  headers:append(":path", url)
  headers:append(":authority", "")
  headers:append("content-type", "application/json")

  if api_key ~= nil then
    headers:append("authorization", "Bearer " .. api_key)
  end

  local req = request.new_from_uri(url, headers)
  req:set_body(payload)


  local head, stream = assert(req:go())
  local resp_body = assert(stream:get_body_as_string())
  local result = json.decode(resp_body)

  local status = head:get(":status")
  print("Response Status: ".. status)

  if status ~= "200" then
    return
  end

  return result
end

function GPTSubmit()
  local answer = ""
  vim.cmd('y')
  local selected_text = vim.fn.getreg('"')

  -- LSP will freak about this, but this open_api_key var exists in 
  -- nvim/default.nix
  local api_key = open_api_key

  local url = "https://api.openai.com/v1/chat/completions"

  -- With this training style, maybe it would be possible to have 
  -- different actions for programming tips vs code review vs 
  -- debugging vs other? TBD
  local payload = {
    model="gpt-3.5-turbo",
    messages={
      {role="system", content="You are an expert programming assistant"},
      { role="user", content=selected_text }
    },
    max_tokens = 1024,
    temperature = 0.5,
  }
  local result = Post(url, payload, api_key)

  if result == nil then
    return
  end

  for k,v in pairs(result) do
    if k == "choices" then
      answer = v[1]["message"]["content"]
    end
  end

  vim.fn.setreg("+", answer)
end
