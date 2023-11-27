-- this is the counterpart to gql request

HAMMERCURL_OUTPUT = "~/.hammercurl/output.json"
-- for testing
HAMMERCURL_DOMAIN = "https://stable-main.backend.papadev.co"

function HttpSetDomain(domain)
  HAMMERCURL_DOMAIN = domain
end

function HttpGetDomain()
  if HAMMERCURL_DOMAIN ~= ""
    then
      print(HAMMERCURL_DOMAIN)
    else
      print("Please set domain")
    end
end

function HttpGet(url)
  os.execute("curl " .. HAMMERCURL_DOMAIN .. url .. "| jq .  >> " .. HAMMERCURL_OUTPUT)
  vim.cmd("e " ..HAMMERCURL_OUTPUT)
end
