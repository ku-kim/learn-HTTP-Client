#!/usr/bin/env bash
# @Author: @ku-kim
#=================================================================

RED="\033[1;31m"
BOLD="\033[1m"
RESET="\033[0m"

run_http_client_test() {
    # Check if -D option is needed
    # Docker에서의 127.0.0.1 주소 매핑이 호스트 ip를 바라보지 못하기 때문에 host ip 바라볼 수 있도록 설정 (docker.host.internal 활용, options -D of HTTP Client)
    if [ "$env" == "local" ]; then
        use_docker_host_internal="-D"
    else
        use_docker_host_internal=""
    fi

    if [ "$debug" = true ]; then
        log_level=VERBOSE
    else
        log_level=BASIC
    fi

    echo -e "Running tests for environment: ${RED}${BOLD}$env${RESET}, log_level: ${RED}${BOLD}$log_level${RESET}"
    # sort -z: *.http 파일/폴더들 문자열 오름차순
    find "$PWD" -name "*.http" -print0 \
        | sort -z \
        | sed "s|$PWD|/workdir|g" \
        | xargs -0 \
        docker run --rm -i -v "$PWD":/workdir -w /workdir/ jetbrains/intellij-http-client \
        -r \
        $use_debug_option \
        -L "$log_level" \
        -e "$env" \
        -v /workdir/http-client.env.json
}

if [ -z "$env" ]; then
  env="local"
fi

if [ "$env" == "local" ] || [ "$env" == "dev" ] || [ "$env" == "qa" ]; then
    run_http_client_test
else
    echo "Invalid environment specified"
    echo "Usage: environment - env={local||dev||qa} debug={true||false}"
    echo "Default: env=local / debug=false"
fi
