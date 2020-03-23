
port = 8092

run:
	PORT=$(port) node index.js

test-random:
	PORT=$(port) sh test-random.sh
