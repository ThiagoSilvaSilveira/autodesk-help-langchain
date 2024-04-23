.PHONY: help
help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: setup
setup: ## Install poetry dependencies
	poetry install

.PHONY: black
black: ## Apply Black code formatter
	poetry run black .

.PHONY: isort
isort: ## Sort import order
	poetry run isort --profile black .

.PHONY: autoflake
autoflake: ## Remove unused imports and unused variables
	poetry run autoflake --in-place -r --remove-unused-variables --remove-all-unused-imports .

.PHONY: format-python
format-python: black isort autoflake ## Format all python-based files