# You should not make any changes to this file.
#
# This file uses Coffeescript instead if Javascript beause I (SB) just find
# Coffeescript more convenient.

port = process.env.PORT ? 8000
host = "localhost"
url = "http://#{host}:#{port}"
console.log "running tests against #{url}..."

http = require "http"

Middleware = require "simple-middleware"
mw = new Middleware

get = (path, callback) ->
  console.log "#{url}#{path}"
  http.get "#{url}#{path}", (response) ->
    data = ""
    response.on "data", (chunk) -> data = data + chunk.toString()
    response.on "end", () ->
      if response.statusCode == 200 then callback JSON.parse data
      else
        console.error "error response: #{response.statusCode}"
        process.exit 1

expect = (expected, actual, callback) ->
  console.log "expect: #{expected}..."
  if expected == actual
    console.log "             ... ok"
    callback()
  else
    console.error "failed test: expected: #{expected}, actual: #{actual}"
    process.exit 1

mw.use (_, next) -> get "/test/maximum", (data) -> expect 10, data.maximum, next

mw.run null
