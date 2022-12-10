#!/usr/bin/env bash
if [ -f package.json ] && [ ! -e node_modules ]; then
    npm install
fi
if type "direnv" >/dev/null 2>&1 && [ -f .envrc ]; then
    direnv allow
fi
if [ -f requirements.txt ]; then
    pip3 install --user --disable-pip-version-check -r requirements.txt
fi
if type "pre-commit" >/dev/null 2>&1 && [ -f .pre-commit-config.yaml ] && [ ! -f .git/hooks/pre-commit ]; then
    pre-commit install
fi
mkdocs serve
