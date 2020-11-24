#!/bin/bash

source "00-common.sh"

#
# Change this as much as you like (for your own testing).
#
# See "01-tests.sh" for examples.
#
# For example:

post "/push" '{"values": [123, 456]}'
# get "/peek" 456
# get "/pop" 456
# get "/peek" 123
