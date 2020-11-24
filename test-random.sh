#!/bin/bash

# This is a poor-man's test of the random-number generator (test API).
# It requires "wget" and "curl".

# PORT is set in Makefile, or defaults here to 8092 if the environment variable
# PORT is not set.
: ${PORT:=8092}

get () {
   path="$1"; shift

   wget -O - -q "http://localhost:$PORT$path"
}

post () {
   path="$1"; shift
   data="$1"; shift

   curl -s -d "$data" -H "Content-Type: application/json" -X POST "http://localhost:$PORT$path"
}

# Fail with an error if any of the following commands fail.
#
set -e

# Set the maximum.
#
echo "set maximum to 30..."
post "/test/maximum" '{"maximum": 30}'

echo
echo "test maximum is now 30..."
get "/test/maximum"
get "/test/maximum" | grep -w 30 > /dev/null

# Set the maximum to an invalid value (expecting "bad request" here).
#
echo
echo "setting the maximum to a couple of invalid values (expect 'bad request')..."
echo "(these should fail)"
! post "/test/maximum" '{"maximum": -5}'
! post "/test/maximum" '{"maximum": "123"}'

# Set the maximum again.
#
echo
echo "set maximum to 20..."
post "/test/maximum" '{"maximum": 20}'

echo
echo "test maximum is now 20..."
get "/test/maximum"
get "/test/maximum" | grep -w 20 > /dev/null

# Test some random numbers.  We expect numbers in the range 0 (inclusive) to 20 (exclusive) here.
#

echo
echo "generating some random numbers (r)"
echo "expecting numbers in the range 0 <= r < 20..."
for t in `seq 5`
do
   r=$( get "/test/random" )
   echo " " "received:" $r
   (( 0 <= r && r < 20 ))
done

# Finally, we'll test that we can read "index.html".
#
# We'll not worry about the contents, only that it exists.
#
echo
echo "verifying that we can download 'index.html'..."
echo wget -O /dev/null -q "http://localhost:$PORT/"
if wget -O /dev/null -q "http://localhost:$PORT/"
then
   echo "ok"
else
   false
fi
