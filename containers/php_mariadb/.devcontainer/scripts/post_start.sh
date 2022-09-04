if type "direnv" >/dev/null 2>&1 && [ -f .envrc ]; then
    direnv allow
fi
if [ -f requirements.txt ]; then
    pip install --user -r requirements.txt
fi
apache2ctl start
