function Output(data)
  vim.cmd("new output.json")
  local buffer = vim.api.nvim_win_get_buf(0)
  vim.api.nvim_buf_set_lines(buffer, 0, 0, false, {data})
  vim.cmd("%! jq .")

end
-- Env Vars needed per project
-- url - HOST
-- token - bearer token for auth

-- body - request itself
-- This could be done the same way GPT grabs prompts from nvim?
function GqlRequest()
  local body = {}
  body.query = "{ currentAccount {data {id}} }"
  local token = ""
  local url = "https://stable-main.backend.papadev.co/api/graphql"
  --local body = { "query": "query ($id: Int) { user(id: $id) { name } }", "variables": { "id": 1 } }
  local options = {}
  options["disable_decode"] = true
  local result = Post(url, body, token, options)
  Output(result)

--
--  if result == nil then
--    return
--  end
--
--  for k,v in pairs(result) do
--    print("result line")
--    print(k)
--    print(v)
--  end
end

--How to format a GQL request body in a curl request?
--When making a GQL (GraphQL) request using `curl`, you need to specify the HTTP method as `POST` and include the `Content-Type: application/json` header. The body of the request should be a JSON object containing a `query` field, which holds your GraphQL query. Optionally, you can also include a `variables` field if your query requires any parameters.
--
--Here's a basic example:
--
--```bash
--curl -X POST -H "Content-Type: application/json" --data '{ "query": "{ hello }" }' http://localhost:4000/graphql
--```
--
--In this example, `{ hello }` is the GraphQL query. Replace it with your own query.
--
--If your query requires variables, include them like so:
--
--```bash
--curl -X POST -H "Content-Type: application/json" --data '{ "query": "query ($id: Int) { user(id: $id) { name } }", "variables": { "id": 1 } }' http://localhost:4000/graphql
--```
--
--In this example, the query is `query ($id: Int) { user(id: $id) { name } }`, and the variable is `"id": 1`.
--
--Remember to replace `http://localhost:4000/graphql` with the URL of your GraphQL server.
