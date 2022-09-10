if type "direnv" >/dev/null 2>&1 && [ -f .envrc ]; then
    direnv allow
fi
if [ -f requirements.txt ]; then
    pip3 install --user --disable-pip-version-check -r requirements.txt
fi
apache2ctl start

if type "ansible" >/dev/null 2>&1 [ -f "$(dirname $0)/post_start.yml" ]; then
    ansible-playbook  -i 127.0.0.1, -c local --diff "$(dirname $0)/post_start.yml"
fi
