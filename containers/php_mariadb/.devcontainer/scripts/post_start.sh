if type "direnv" >/dev/null 2>&1 && [ -f .envrc ]; then
    direnv allow
fi
if [ -f requirements.txt ]; then
    pip3 install --user --disable-pip-version-check -r requirements.txt
fi
apache2ctl start
