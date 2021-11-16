#!/bin/bash

# ************************
# DO NOT CHANGE THIS FILE.
# ************************

#
# You should not need to change anything in here.
#
# These are some shell functions which wrap wget and curl, and simplify
# the rest of the test code.
#

# Fail on any command which fails.
#
set -e

# Set the default port.
#
: ${PORT:=8092}

url="http://localhost:$PORT"

get ()
{
   path="$1"; shift
   expected="$1"; shift

   echo "GET: $url$path"
   result=$( wget -O - -q "$url$path" )

   [ -n "$expected" ] && echo "  expect: $expected"
   echo "  result: $result"

   [ -z "$expected" ] || [ "$result" == "$expected" ]
}

post ()
{
   path="$1"; shift
   data="$1"; shift

   echo "POST: $url$path, data:$data"
   result=$( curl -s -d "$data" -H "Content-Type: application/json" -X POST "$url$path" )
   echo $result
}

length ()
{
   print "verifying length"
   get "/length" $length
}

clear_stack ()
{
   echo "** clearing stack (this requires /length and /pop to work)..."
   while ! get "/length" 0
   do
      get "/pop" ""
   done
   echo "** stack cleared"
   echo
}

# This is a bit of a hammer.  It verifies the contents of the stack by popping each item off in turn
# (recursively), checking them, and pushing them all back on again.
#
check_stack ()
{
   if [ $# != 0 ]
   then
      echo "** checking stack:" "$@"
      local value=$1; shift
      get "/pop" $value
      check_stack "$@"
      post "/push" '{"values": ['$value']}'
   fi
}
