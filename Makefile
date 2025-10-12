PUBLIC_DIR := public


# Deployment variables
DEPLOY_USER=ubuntu
DEPLOY_HOST=ovh-afparets
DEPLOY_PORT=28419
DEPLOY_PATH=/var/www/fotographicparets.com/public
# Set to your private key path if needed, e.g. ~/.ssh/id_rsa
DEPLOY_KEY?=$(HOME)/.ssh/ovh-afparets

.PHONY: build serve clean-public deploy

build: clean-public
	@hugo --gc --minify --cleanDestinationDir

serve:
	@hugo server -D

# Remove generated public content
clean-public:
	@rm -rf $(PUBLIC_DIR)/* || true
	@echo "Cleaned $(PUBLIC_DIR)"

# Build and deploy to remote server with www-data ownership
deploy: build
	@echo "Deploying to $(DEPLOY_USER)@$(DEPLOY_HOST):$(DEPLOY_PATH)"
	@echo "Staging files on remote host..."
	@rsync -az --delete -e "ssh -p $(DEPLOY_PORT) -i $(DEPLOY_KEY)" $(PUBLIC_DIR)/ $(DEPLOY_USER)@$(DEPLOY_HOST):/home/$(DEPLOY_USER)/.afparets_deploy/
	@echo "Promoting staged files into $(DEPLOY_PATH) with www-data ownership..."
	@ssh -p $(DEPLOY_PORT) -i $(DEPLOY_KEY) $(DEPLOY_USER)@$(DEPLOY_HOST) "sudo mkdir -p $(DEPLOY_PATH) && sudo rsync -a --delete --chown=www-data:www-data /home/$(DEPLOY_USER)/.afparets_deploy/ $(DEPLOY_PATH)/ && sudo find $(DEPLOY_PATH) -type d -exec chmod 755 {} \\; && sudo find $(DEPLOY_PATH) -type f -exec chmod 644 {} \\; && echo 'Deployment completed.'"
