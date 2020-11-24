# Demonstrates mapping volumes inside a container.
#
# We map the current working directory into the htdocs directory on
# the Apache container, and then fetch the files in this directory
# from there.

# This should be the host name of the dockerd server.
#
server = docker
port = 8401

run:
	$(MAKE) start
	$(MAKE) test
	$(MAKE) stop

start:
	docker run \
	   --detach --rm \
	   --name httpd \
	   --volume $$PWD:/usr/local/apache2/htdocs \
	   --publish $(port):80 \
	      httpd

test:
	wget -O - -q http://$(server):$(port)/index.txt
	@echo
	wget -O - -q http://$(server):$(port)/nobody.txt
	@echo
	wget -O - -q http://$(server):$(port)/Makefile

stop:
	docker container stop httpd

.PHONY: run start test stop
