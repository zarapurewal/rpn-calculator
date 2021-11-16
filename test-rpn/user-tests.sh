#!/bin/bash

source "00-common.sh"

#
# Change this as much as you like here (for your own testing).
#
#

post "/push" '{"values": [123, 456]}'

# Here is the entire contents of "01-tests.sh".  Uncomment the tests below as you
# implement the various API endpoints.

# clear_stack
# get "/length" 0
# post "/push" '{"values": [123]}'
# get "/length" 1
# get "/peek" 123
# post "/push" '{"values": [456, 789]}'
# get "/length" 3
# get "/peek" 789
#
# check_stack 789 456 123
#
# # Check the /add operator.
# #
# echo
# clear_stack
# echo "testing /add"
# post "/push" '{"values": [1,2,3]}'
# get "/length" 3
# get "/add" ""
# check_stack 5 1
# get "/length" 2
# get "/add" ""
# check_stack 6
# get "/length" 1
#
# # Check the /subtract operator.
# #
# echo
# clear_stack
# echo "testing /subtract"
# post "/push" '{"values": [100,50,5]}'
# get "/length" 3
# get "/subtract" ""
# check_stack 45 100
# get "/length" 2
# get "/subtract" ""
# check_stack 55
# get "/length" 1
#
# # Check the /multiply operator.
# #
# echo
# clear_stack
# echo "testing /multiply"
# post "/push" '{"values": [100,50,5]}'
# get "/length" 3
# get "/multiply" ""
# check_stack 250 100
# get "/length" 2
# get "/multiply" ""
# check_stack 25000
# get "/length" 1
#
# # Check the /divide operator.
# #
# echo
# clear_stack
# echo "testing /divide"
# post "/push" '{"values": [100,10,2]}'
# get "/length" 3
# get "/divide" ""
# check_stack 5 100
# get "/length" 2
# get "/divide" ""
# check_stack 20
# get "/length" 1
