function Output(data)
  vim.cmd("new output.json")
  local buffer = vim.api.nvim_win_get_buf(0)
  vim.api.nvim_buf_set_lines(buffer, 0, 0, false, {data})
  vim.cmd("%! jq .")
end

function GqlInput()
  vim.cmd("new request.gql")
end

function GqlGetHost()
  if HAMMERCURL_HOST ~= ""
    then
      print(HAMMERCURL_HOST)
    else
      print("Please Set GQL Host")
    end
end

function GqlSetHost(host)
  HAMMERCURL_HOST = host
end

function GqlGetToken()
  if HAMMERCURL_TOKEN ~= ""
    then
      print(HAMMERCURL_TOKEN)
    else
      print("Please Set GQL Bearer Token")
    end
end

function GqlSetToken(token)
  HAMMERCURL_TOKEN = token
end

function GqlRequest()
  local buffer = vim.api.nvim_win_get_buf(0)
  local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)

  local body = {}
  body.query = table.concat(lines, " ")
  local options = {}
  options["disable_decode"] = true
  local result = Post(HAMMERCURL_HOST, body, HAMMERCURL_TOKEN, options)

  Output(result)
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
