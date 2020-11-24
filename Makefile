
# If you start all jobs via this make file, then the port will be set correctly.  Changing the port here
# will change it everywhere.  This allows us to have the port defined in ONLY ONE PLACE.
#
port = 8092

# Run the server.
#
run:
	PORT=$(port) node index.js

# Run the tests for the /test/random API.  This assumes that the server is running.
# This will fail if the server is not running.
#
test-random:
	PORT=$(port) bash test-random.sh

# Start the server, run the tests for the /test/random API and exit.
# This will fail if the server is already running!
#
run-test-random:
	PORT=$(port) node index.js test-random

# Run the tests for the /test/rpn API.  This assumes that the server is running.
# This will fail if the server is not running.
# This will fail if you haven't yet implemented the necessary API.
#
test-rpn:
	PORT=$(port) bash test-rpn.sh

# Start the server, run the tests for the /test/rpn API and exit.
# This will fail if the server is already running!
# This will also fail if you haven't yet implemented the necessary API.
#
# For developing the RPN API, this is the quickest way start the server, run the
# tests, and stop the server again.
#
run-test-rpn:
	PORT=$(port) node index.js test-rpn

# You shouldn't change test-rpn/01-tests.sh; but you can change test-rpn/user-tests.sh.
# These targets run those tests.
#
user-tests:
	cd test-rpn && PORT=$(port) bash user-tests.sh

run-user-tests:
	PORT=$(port) node index.js user-tests

# Build the static HTML file.
# Requires asciidoc.
# If you don't have asciidoc, read the comment in the Makefile in the
# static directory.
#
build:
	$(MAKE) -C static build

# If you have gitlab-runner locally, then you can test your .gitlab-ci.yml
# configuration with these targets.
#
gitlab-shell:
	gitlab-runner exec shell test


# For docker, do not use the "smblott/dcu-docker-gitlab-ci" image.  Just use "node"
# instead.  The node image doesn't contain asciidoc, of course, but you can test
# everything else.
#
gitlab-docker:
	gitlab-runner exec docker test

.PHONY: run build
.PHONY: test-random run-test-random
.PHONY: test-rpn run-test-rpn
.PHONY: user-tests run-user-tests
.PHONY: gitlab-shell gitlab-docker
