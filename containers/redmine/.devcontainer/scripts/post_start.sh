#!/bin/bash -e
BASE_DIR=$(pwd)
readonly BASE_DIR
SCRIPT_DIR=$(dirname $0)
readonly SCRIPT_DIR
if type "direnv" >/dev/null 2>&1 && [ -f .envrc ]; then
    direnv allow
fi
if type "direnv" >/dev/null 2>&1 && [ -f .envrc ]; then
    direnv allow
fi
if [ -f "${SCRIPT_DIR}/post_start.yml" ]; then
    ansible-playbook -i 127.0.0.1, -c local --diff "${SCRIPT_DIR}/post_start.yml"
fi
bundle update
rails s -b 0.0.0.0 -p 3000
