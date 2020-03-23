#!/bin/bash

source "00-common.sh"

#
# Change this as much as you like (for your own testing).
#
# See "01-tests.sh" for examples.
#
# For example:

post "/push" '{"values": [123]}'
get "/peek" 123
