SHELL = /bin/bash
DEV_IMG := node:22-slim

.PHONY: help
help: ## this help
	@grep -e '^[a-zA-Z%_-]\+:.*##' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*##"}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: clean
clean: ## Clean
	@echo "Clean"
	rm -rf output/*

.PHONY: build-typescript
build-typescript: ## Build for TypeScript
	@echo "Build"
	docker run -it --rm \
		-v $(PWD)/package.json:/root/package.json \
		-v $(PWD)/openapi:/root/openapi \
		-v $(PWD)/output:/root/output \
		-w /root \
		$(DEV_IMG) \
		bash -c "npm install && npm run generate"
