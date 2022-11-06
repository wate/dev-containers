if type "direnv" >/dev/null 2>&1; then
    echo 'eval "$(direnv hook bash)"' >>~/.bashrc
fi
if type "exa" >/dev/null 2>&1; then
    echo 'alias ls="exa --git --header"' >>~/.bashrc
fi
if [ ! -f ~/.inputrc ]; then
    echo "set completion-ignore-case on">~/.inputrc
fi
if [ -f requirements.txt ]; then
    pip3 install --user --disable-pip-version-check --no-cache-dir -r requirements.txt
fi
