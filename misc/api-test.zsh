#!/usr/bin/env zsh

url="http://localhost:8000"

get () {
  local pathname=$argv[1]
  local full_url="$url$pathname"
  print ">>>" "GET" $full_url
  wget -O - -q $full_url | jq .
}

post () {
  local pathname=$argv[1]
  local full_url="$url$pathname"
  print ">>>" POST $full_url
  curl -H "Content-Type: application/json" -d $argv[2] -X "POST" $full_url
}

get "/test/maximum"
post "/test/maximum" '{"maximum": 20}'
get "/test/maximum"
