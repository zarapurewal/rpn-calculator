
# If you start all jobs via this make file, then the port will be set correctly.  Changing the port here
# will change it everywhere.  This allows us to have the port defined in ONLY ONE PLACE.
#
port = 8000

coffeescript = ./node_modules/.bin/coffee

# Run the server.
#
run: $(coffeescript)
	PORT=$(port) node index.js

$(coffeescript):
	npm install

.PHONY: run test
