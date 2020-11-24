
ascii = $(wildcard *.ascii)
html = $(patsubst %.ascii, %.html, $(ascii))

build: $(html)
	@true

watch:
	watch -n 1 $(MAKE) build

# asciidoc is installed and works on the default CI image, so "make build"
# should work there.
#
# If you're testing this somewhere where asciidoc is not installed, then it is
# enough to just copy the file "garbage.html" into "index.html".  That should
# get you going.  Comment and uncomment lines below as appropriate (if required).
#
%.html: %.ascii
	asciidoc $<
	# If that doesn't work, then just do this:
	#
	# cp garbage.html index.html

.PHONY: build watch
