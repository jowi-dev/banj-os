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

  print(resp_body)

  return result
end
