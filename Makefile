
.DEFAULT: help
.PHONY: help
help:
	@grep -E -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build: ## Build the docker image, you can set UCC_PACKAGE to a specific package name/pip reference
build:
	docker build -t ucc-gen-docker . --build-arg='UCC_PACKAGE=$(UCC_PACKAGE)'

.PHONY: run
run: ## run the docker container
run:
	docker run -it --rm -v "$(PWD):/app" ucc-gen-docker
