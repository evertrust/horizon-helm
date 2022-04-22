all: gen-schema package

gen-schema:
	readme-generator -r README.md -v values.yaml -s values.schema.json

package:
	helm dependencies build
	helm package .