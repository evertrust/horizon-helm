all: dependencies package test setup-unittest

resolve-base-branch:
	@if [ -z "$(HORIZON_VERSION)" ]; then echo "HORIZON_VERSION is not set" >&2; exit 1; fi; \
	base_version="$$(echo "$(HORIZON_VERSION)" | cut -d. -f1,2)"; \
	branch="legacy/horizon-$$base_version"; \
	if git ls-remote --exit-code --heads origin "$$branch" >/dev/null 2>&1; then \
		echo "$$branch"; \
	else \
		echo "master"; \
	fi

bump:
	@if [ -z "$(HORIZON_VERSION)" ]; then echo "HORIZON_VERSION is not set"; exit 1; fi
	@if [ -z "$(MIGRATION_VERSION)" ]; then echo "MIGRATION_VERSION is not set"; exit 1; fi
	HORIZON_VERSION="$(HORIZON_VERSION)" yq -i '.appVersion = strenv(HORIZON_VERSION) | .appVersion style="double"' Chart.yaml
	HORIZON_VERSION="$(HORIZON_VERSION)" yq -i '.image.tag = strenv(HORIZON_VERSION)' values.yaml
	MIGRATION_VERSION="$(MIGRATION_VERSION)" yq -i '.upgrade.image.tag = strenv(MIGRATION_VERSION)' values.yaml

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
