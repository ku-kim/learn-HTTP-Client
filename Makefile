# make integration-test env={local||dev||qa} debug={true||false}
# default env=local / debug=false

integration-test:
	@cd integration-test && ./run-http-client.sh

.PHONY: integration-test
