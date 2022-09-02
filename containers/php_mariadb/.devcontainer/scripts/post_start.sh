if type "direnv" >/dev/null 2>&1 && [ -f .envrc ]; then
    direnv allow
fi
apache2ctl start
