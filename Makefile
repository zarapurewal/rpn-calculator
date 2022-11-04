
# If you start all jobs via this make file, then the port will be set correctly.  Changing the port here
# will change it everywhere.  This allows us to have the port defined in ONLY ONE PLACE.
#
port = 8000

coffeescript = ./node_modules/.bin/coffee
nodemon = ./node_modules/.bin/nodemon

# Run the server.
#
run: $(nodemon)
	PORT=$(port) node index.js

$(nodemon):
	npm install

test: $(nodemon)
	PORT=$(port) node index.js $(coffeescript) test.coffee

dev:
	$(nodemon) -w index.js -w test.coffee -x "make -s test || exit 1"

.PHONY: run test dev
