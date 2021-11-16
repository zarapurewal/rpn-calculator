
# If you start all jobs via this make file, then the port will be set correctly.  Changing the port here
# will change it everywhere.  This allows us to have the port defined in ONLY ONE PLACE.
#
port = 8092

depends = node_modules static/index.html

# Run the server.
#
run: $(depends)
	PORT=$(port) node index.js

# ##########################################################
# Targets specific to the random number generator.

# Run the tests for the /test/random API.  This assumes that the server is running.
# This will fail if the server is not running.
#
test-random: $(depends)
	PORT=$(port) bash test-random.sh

# Start the server, run the tests for the /test/random API and exit.
# This will fail if the server is already running!
#
run-test-random: $(depends)
	PORT=$(port) node index.js test-random

# ##########################################################
# Targets specific to the RPN calculator.

# Run the tests for the /test/rpn API.  This assumes that the server is running.
# This will fail if the server is not running.
# This will fail if you haven't yet implemented the necessary API.
#
test-rpn: $(depends)
	PORT=$(port) bash test-rpn.sh

# Start the server, run the tests for the /test/rpn API and exit.
# This will fail if the server is already running!
# This will also fail if you haven't yet implemented the necessary API.
#
# For developing the RPN API, this is the quickest way start the server, run the
# tests, and stop the server again.
#
run-test-rpn: $(depends)
	PORT=$(port) node index.js test-rpn

# ##########################################################
# Targets specific to the user tests for RPN calculator.
#
# You shouldn't change test-rpn/01-tests.sh; but you can change test-rpn/user-tests.sh.
# These targets run those tests.
#
user-tests: $(depends)
	cd test-rpn && PORT=$(port) bash user-tests.sh

run-user-tests: $(depends)
	PORT=$(port) node index.js user-tests

# ##########################################################
# Dependencies.

# Install the required npm modules.
#
node_modules:
	npm install

# Build the required index.html (from static/index.ascii).
#
static/index.html:
	$(MAKE) -C static

.PHONY: run build
.PHONY: test-random run-test-random
.PHONY: test-rpn run-test-rpn
.PHONY: user-tests run-user-tests
