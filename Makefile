run:
	node index.js

node-modules:
	npm install

test-random:
	$(MAKE) -C tests random

.PHONY: run node-modules test-random
