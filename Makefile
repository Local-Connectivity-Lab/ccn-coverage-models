SHELL = /bin/bash
DEV_IMG := openapitools/openapi-generator-cli:latest

.PHONY: help
help: ## this help
	@grep -e '^[a-zA-Z%_-]\+:.*##' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*##"}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: clean
clean: ## Clean
	@echo "Clean"
	rm -rf openapi/out

.PHONY: build
build-%: ## Build build-<generator> [typescript-node, kotlin, swift6, etc]
	@echo "Build"
	docker run -it --rm \
		-v $(PWD)/openapi:/local \
		$(DEV_IMG) generate \
		-i /local/v1/ccn-coverage-api.yaml \
		-g "$*" \
		-o "/local/out/$*"
