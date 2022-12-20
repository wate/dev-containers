#!/usr/bin/env bash
if type "direnv" >/dev/null 2>&1 && [ -f .envrc ]; then
    direnv allow
fi

if type "pre-commit" >/dev/null 2>&1 && [ -f .pre-commit-config.yaml ]; then
    if [ ! -e .git/hooks/pre-commit ]; then
        pre-commit install
    fi
    pre-commit autoupdate
fi
