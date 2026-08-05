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
	awk -v v="$(HORIZON_VERSION)" '/^appVersion:/ { sub(/appVersion:.*/, "appVersion: \"" v "\"") } { print }' \
		Chart.yaml > Chart.yaml.tmp && mv Chart.yaml.tmp Chart.yaml
	awk -v hv="$(HORIZON_VERSION)" -v mv="$(MIGRATION_VERSION)" ' \
		/^[[:space:]]*repository:[[:space:]]*horizon[[:space:]]*$$/           { pending="horizon" } \
		/^[[:space:]]*repository:[[:space:]]*horizon-migration[[:space:]]*$$/ { pending="migration" } \
		/^[[:space:]]*tag:[[:space:]]/ { \
			if (pending=="horizon")        { sub(/tag:[[:space:]].*/, "tag: " hv); pending="" } \
			else if (pending=="migration") { sub(/tag:[[:space:]].*/, "tag: " mv); pending="" } \
		} \
		{ print }' \
		values.yaml > values.yaml.tmp && mv values.yaml.tmp values.yaml

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
