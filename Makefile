HUGO := hugo
ASSETS_DIR := themes/fotographic-theme/assets/js/vendor/
PUBLIC_DIR := public/
build-js:
	mkdir -p $(ASSETS_DIR)
	cp node_modules/jquery/dist/jquery.min.js $(ASSETS_DIR)
	cp node_modules/popper.js/dist/umd/popper.min.js $(ASSETS_DIR)
	cp node_modules/bootstrap/dist/js/bootstrap.min.js $(ASSETS_DIR)
build: build-js
	$(HUGO)
serve: build-js
	$(HUGO) server
build-mac:
	@echo "╠ Removing public dir..."
	rm -fr $(PUBLIC_DIR)
	@echo "╠ Createing web..."
	$(HUGO)

build-win:
	@echo "╠ Removing public dir..."
	rmdir -force -r .\$(PUBLIC_DIR)
	@echo "╠ Createing web..."
	$(HUGO)
