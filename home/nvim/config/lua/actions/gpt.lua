function GPTSubmit(version)
  local max_tokens = nil
  if version == "3" then
    version = "gpt-3.5-turbo"
    max_tokens = 1024
  else
    version = "gpt-4-1106-preview"
    max_tokens = 1024
  end
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
    model=version,
    messages={
      {role="system", content="You are an expert programming assistant"},
      { role="user", content=selected_text }
    },
    max_tokens = max_tokens,
    temperature = 0.5,
  }
  local result = Post(url, payload, api_key, {})

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
