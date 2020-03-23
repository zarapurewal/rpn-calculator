
build: index.html
	@true

watch:
	watch -n 1 $(MAKE) build

%.html: %.ascii
	asciidoc $<

.PHONY: build watch
