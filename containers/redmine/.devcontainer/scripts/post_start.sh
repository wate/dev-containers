#!/bin/bash -e
if type "direnv" >/dev/null 2>&1 && [ -f .envrc ]; then
    direnv allow
fi
bundle update
rails s -b 0.0.0.0 -p 3000
