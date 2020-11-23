# Demonstrates mapping volumes inside a container.
#
# We map the current working directory into the htdocs directory on
# the Apache container, and then fetch the files in this directory
# from there.

# This would be "docker" on TermCast/docker (where the docker daemon
# is running in a diffrent container).
docker = localhost
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
	wget -O - -q http://$(docker):$(port)/index.txt
	@echo
	wget -O - -q http://$(docker):$(port)/nobody.txt
	@echo
	wget -O - -q http://$(docker):$(port)/Makefile

stop:
	docker container stop httpd

.PHONY: run start test stop
