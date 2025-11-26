all: gen-schema dependencies package test setup-unittest

gen-schema:
	readme-generator -r README.md -v values.yaml -s values.schema.json

dependencies:
	helm dependencies build .

package: dependencies
	helm package .

test: dependencies setup-unittest
	helm unittest . -v tests/values.yaml

setup-unittest:
	@if ! helm plugin list | grep -q "unittest"; then \
		echo "Installing helm unittest plugin..."; \
		helm plugin install https://github.com/helm-unittest/helm-unittest.git; \
	else \
		echo "helm unittest plugin already installed"; \
	fi