
port = 8092

run:
	PORT=$(port) node index.js

test-random:
	PORT=$(port) bash test-random.sh

run-test-random:
	PORT=$(port) node index.js test-random

.PHONY: run
.PHONY: test-random
.PHONY: run-test-random
