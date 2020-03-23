#!/bin/bash

# This is a poor-man's test of the random-number generator (test API).
# It requires "wget" and "curl".

# PORT is set in Makefile, or defaults here to 6781 if the environment variable
# PORT is not set.
: ${PORT:=6781}

# Fail with an error if any of the following commands fail.
#
set -e

# Set the maximum.
#
echo "set maximum to 30..."
curl -s -d '{"maximum": 30}' -H "Content-Type: application/json" -X POST "http://localhost:$PORT/test/maximum"

echo "test maximum is now 30..."
wget -O - -q "http://localhost:$PORT/test/maximum"
wget -O - -q "http://localhost:$PORT/test/maximum" | grep -w 30 > /dev/null

# Set the maximum to an invalid value (expecting "bad request" here).
#
! curl -s -d '{"maximum": -5}' -H "Content-Type: application/json" -X POST "http://localhost:$PORT/test/maximum"
! curl -s -d '{"maximum": "123"}' -H "Content-Type: application/json" -X POST "http://localhost:$PORT/test/maximum"

# Set the maximum again.
#
echo "set maximum to 20..."
curl -s -d '{"maximum": 20}' -H "Content-Type: application/json" -X POST "http://localhost:$PORT/test/maximum"

echo "test maximum is now 20..."
wget -O - -q "http://localhost:$PORT/test/maximum"
wget -O - -q "http://localhost:$PORT/test/maximum" | grep -w 20 > /dev/null

# Test some random numbers.  We expect numbers in the range 0 (inclusive) to 20 (exclusive) here.
#

echo
echo "generating random numbers (r)"
echo "expecting numbers in the range 0 <= r < 20..."
for t in `seq 5`
do
   r=$( wget -O - -q "http://localhost:$PORT/test/random" )
   echo " " "received:" $r
   (( 0 <= r && r < 20 ))
done

# Finally, we'll test that we can read "index.html".
#
# We'll not worry about the contents, only that it exists.
#
echo wget -O /dev/null -q "http://localhost:$PORT/"
if wget -O /dev/null -q "http://localhost:$PORT/"
then
   echo "ok"
fi
