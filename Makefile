
port = 8092

run:
	PORT=$(port) node index.js

test-random:
	PORT=$(port) bash test-random.sh
