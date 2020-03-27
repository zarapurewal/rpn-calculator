
# If you start all jobs via this make file, then the port will be set correctly.  Changing the port here
# will change it everywhere.  This allows us to have the port defined in ONLY ONE PLACE.
#
port = 8092

# Run the server.
#
run:
	PORT=$(port) node index.js

# Run the tests for the /test/random API.  This assumes that the server is running.
#
test-random:
	PORT=$(port) bash test-random.sh

# Run the tests for the /test/random API.  This assumes that the server is running.
# This will fail if the server is not running.
# This will fail if you haven't yet implemented the necessary API.
#
test-rpn:
	PORT=$(port) bash test-rpn.sh

# Start the server, run the tests for the /test/random API and exit.
# This will fail if the server is already running!
# This will also fail if you haven't yet implemented the necessary API.
#
run-test-random:
	PORT=$(port) node index.js test-random

# Start the server, run the tests for the /test/random API and exit.
# This will fail if the server is already running!
#
run-test-rpn:
	PORT=$(port) node index.js test-rpn

# Build the static HTML file.
# Requires asciidoc.
# If you don't have asciidoc, read the comment in the Makefile in the
# static directory.
#
build:
	$(MAKE) -C static build

.PHONY: run
.PHONY: test-random
.PHONY: run-test-random
.PHONY: test-rpn
.PHONY: run-test-rpn
.PHONY: build
