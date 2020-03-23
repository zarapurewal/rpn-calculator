#!/bin/bash

# This is a poor-man's test of the RPNAPI.
# It requires "wget" and "curl".

# PORT is set in Makefile, or defaults here to 6781 if the environment variable
# PORT is not set.
: ${PORT:=6781}

# Fail with an error if any of the following commands fail.
#
set -e

expect_length ()
{
   expected=$1
   shift

   echo "testing length (expecting $expected)..."
   wget -O - -q "http://localhost:$PORT/length"
   wget -O - -q "http://localhost:$PORT/length" | grep -w $expected > /dev/null
}

expect_top () {
   expected=$1
   shift
   value=$( wget -O - -q "http://localhost:$PORT/peek" )
   echo "checking top of stack..."
   echo "  expect $expected"
   echo "  actual $value"
   [ "$expected" = "$value" ]
}
expect_length 0

# Push some values...
#
curl -s -d '{"values": [10, 40, 32]}' -H "Content-Type: application/json" -X POST "http://localhost:$PORT/push"
expect_length 3
curl -s -d '{"values": [20, 5]}' -H "Content-Type: application/json" -X POST "http://localhost:$PORT/push"
expect_length 5
curl -s -d '{"values": [18, 123]}' -H "Content-Type: application/json" -X POST "http://localhost:$PORT/push"
expect_length 7

# Check the top of the stack (peek and pop).
#
expect_top 123
echo "popping 123..."
value=$( wget -O - -q "http://localhost:$PORT/pop" )
echo "  got $value"
[ "$value" = 123 ]
expect_top 18
expect_length 6
echo "popping 18..."
value=$( wget -O - -q "http://localhost:$PORT/pop" )
echo "  got $value"
[ "$value" = 18 ]
expect_top 5
expect_length 5

# Test add.
#
echo "testing add..."
wget -O - -q "http://localhost:$PORT/add"
expect_top 25
expect_length 4

# Add a couple more values.
curl -s -d '{"values": [90, 10]}' -H "Content-Type: application/json" -X POST "http://localhost:$PORT/push"
expect_length 6

# Test subtract.
#
echo "testing subtract..."
wget -O - -q "http://localhost:$PORT/subtract"
expect_top 80
expect_length 5

# Test multiply.
#
echo "testing multiply..."
wget -O - -q "http://localhost:$PORT/multiply"
expect_top 2000
expect_length 4

# Add anther value.
curl -s -d '{"values": [50]}' -H "Content-Type: application/json" -X POST "http://localhost:$PORT/push"
expect_length 5

# Test divide.
#
echo "testing divide..."
wget -O - -q "http://localhost:$PORT/divide"
expect_top 40
expect_length 4

# Test add.
#
echo "testing add..."
wget -O - -q "http://localhost:$PORT/add"
expect_top 72
expect_length 3

# Test add.
#
echo "testing add..."
wget -O - -q "http://localhost:$PORT/add"
expect_top 112
expect_length 2

# Test add.
#
echo "testing add..."
wget -O - -q "http://localhost:$PORT/add"
expect_top 122
expect_length 1

expect_top 122
echo "popping 122..."
value=$( wget -O - -q "http://localhost:$PORT/pop" )
echo "  got $value"
[ "$value" = 122 ]
expect_length 0




