# Demonstrates loading test data into MySQL running in a docker
# container.
#

# This should be the host name of the dockerd server.
#
server = docker
port = 3306
mysql = mysql -u root -h $(server) --protocol=tcp

run:
	$(MAKE) start
	$(MAKE) load
	$(MAKE) test
	$(MAKE) stop

start:
	docker run \
	   --detach --rm \
	   --name mysql \
	   --publish $(port):$(port) \
	   --env MYSQL_ALLOW_EMPTY_PASSWORD=yes \
	      mysql

load:
	echo "create database world99;" | $(mysql)
	gunzip -c ./world99.dump.sql.gz | $(mysql) world99

test:
	$(mysql) world99 < test.sql

stop:
	docker container stop mysql

.PHONY: run start load test stop
