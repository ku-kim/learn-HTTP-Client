integration-test-dev:
	./integration-test/run-http-client.sh dev

integration-test-qa:
	./integration-test/run-http-client.sh qa

.PHONY: integration-test-local integration-test-dev integration-test-qa
