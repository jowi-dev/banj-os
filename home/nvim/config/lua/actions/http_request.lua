-- this is the counterpart to gql request

HTTP_OUTPUT = vim.fn.stdpath("cache") .. "/http_output.json"
HTTP_DOMAIN = ""

function HttpSetDomain(domain)
  HTTP_DOMAIN = domain
end

function HttpGetDomain()
  if HTTP_DOMAIN ~= ""
    then
      print(HTTP_DOMAIN)
    else
      print("Please set domain")
    end
end

function HttpGet(url)
  os.execute("curl " .. HTTP_DOMAIN .. url .. "| jq .  >> " .. HTTP_OUTPUT)
  vim.cmd("e " ..HTTP_OUTPUT)
end
