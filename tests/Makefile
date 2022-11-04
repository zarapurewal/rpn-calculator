# You shouldn't have to make changes here, other than perhaps changing the default target.
#
# Flip the order of the assignments below to change the default target.
#
default_target = rpn
default_target = random

test:
	@$(MAKE) $(default_target)

random:
	../node_modules/.bin/mocha ./random.coffee --exit --bail --require coffeescript/register

rpn:
	../node_modules/.bin/mocha ./rpn.coffee --exit --bail --require coffeescript/register

docker:
	env DOCKER=yes ../node_modules/.bin/mocha ./rpn.coffee --exit --bail --require coffeescript/register

.PHONY: test random rpn docker
