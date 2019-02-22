HUGO := hugo
ASSETS_DIR := assets/js/vendor/
build-js:
	mkdir -p $(ASSETS_DIR)
	cp node_modules/jquery/dist/jquery.min.js $(ASSETS_DIR)
	cp node_modules/what-input/dist/what-input.js $(ASSETS_DIR)
	cp node_modules/foundation-sites/dist/js/foundation.min.js $(ASSETS_DIR)
build: build-js
	$(HUGO)
serve: build-js
	$(HUGO) server