all: package test setup-unittest

package:
	helm dependencies build
	helm package .

test: setup-unittest
	helm unittest . -v tests/values.yaml

setup-unittest:
	@if ! helm plugin list | grep -q "unittest"; then \
		echo "Installing helm unittest plugin..."; \
		helm plugin install https://github.com/helm-unittest/helm-unittest.git; \
	else \
		echo "helm unittest plugin already installed"; \
	fi