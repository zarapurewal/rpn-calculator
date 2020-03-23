
port = 8092

run:
	PORT=$(port) node index.js

run-test-random:
	PORT=$(port) node index.js test-random

test-random:
	PORT=$(port) bash test-random.sh

.PHONY: run run-test-random test-random
