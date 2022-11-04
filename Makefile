# This is a nodejs project.  It depends on a number of node modules.
# First install those modules with the "node-modules" target.
#
# The script "misc/check-for-node_modules.zsh" is just a wrapper around
# "npm install" to quickly check whether we have the

run:
	zsh misc/check-for-node_modules.zsh
	node index.js

node-modules:
	zsh misc/check-for-node_modules.zsh

# Perhaps flip the order of these to change the default test target.
#
default_test_target = rpn
default_test_target = random

test:
	$(MAKE) -s test-$(default_test_target)

test-random:
	zsh misc/check-for-node_modules.zsh
	$(MAKE) -C tests random

test-rpn:
	zsh misc/check-for-node_modules.zsh
	$(MAKE) -C tests rpn

.PHONY: run node-modules test-random test-rpn test
