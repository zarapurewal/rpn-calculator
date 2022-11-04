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
	$(MAKE) -s $(default_test_target)

random:
	zsh misc/check-for-node_modules.zsh
	$(MAKE) -C tests random

rpn:
	zsh misc/check-for-node_modules.zsh
	$(MAKE) -C tests rpn

.PHONY: run node-modules random rpn test

# #################################################################
# These targets are for task 3.

up:
	docker compose build
	docker compose up --detach

docker-test:
	$(MAKE) -C tests docker

down:
	docker compose down -t 1

.PHONY: up down docker-test
