#!/usr/bin/env bash
# @Author: @Kukim
#=================================================================

run_deploy_test() {
    env=$1
    if [ "$LOG" = true ]; then
        log_level=VERBOSE
    else
        log_level=BASIC
    fi
    echo "Running tests for environment: $env"
    echo "$PWD"
    find "$PWD/integration-test" -name "*.http" -print0 \
        | sed "s|$PWD|/workdir|g" \
        | xargs -0 docker run --rm -i -v "$PWD":/workdir -w /workdir/integration-test jetbrains/intellij-http-client \
        -r \
        -L "$log_level" \
        -e "$env" \
        -v /workdir/integration-test/http-client-test.json
}

if [ "$1" == "dev" ] || [ "$1" == "qa" ]; then
    run_deploy_test "$1"
else
    echo "Invalid environment specified"
fi