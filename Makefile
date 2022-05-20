HUGO := hugo
ASSETS_DIR := themes/fotographic-theme/assets/js/vendor/
PUBLIC_DIR := public/
.DEFAULT_GOAL := deploy-mac

serve:
	$(HUGO) server

build:
	$(HUGO)

clean-mac:
	rm -fr $(PUBLIC_DIR)

sent-files-mac:
	./deploy-mac.sh

deploy-mac: clean-mac build sent-files-mac

