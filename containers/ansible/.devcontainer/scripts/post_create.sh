if type "direnv" >/dev/null 2>&1; then
  echo 'eval "$(direnv hook bash)"' >>~/.bashrc
fi
if type "exa" >/dev/null 2>&1; then
  echo 'alias ls="exa --git --header"' >>~/.bashrc
fi
if [ -f requirements.txt ]; then
  pip3 install --user -r requirements.txt
fi
pip install --user argcomplete
echo 'eval $(register-python-argcomplete ansible)' >>~/.bashrc
echo 'eval $(register-python-argcomplete ansible-config)' >>~/.bashrc
echo 'eval $(register-python-argcomplete ansible-console)' >>~/.bashrc
echo 'eval $(register-python-argcomplete ansible-doc)' >>~/.bashrc
echo 'eval $(register-python-argcomplete ansible-galaxy)' >>~/.bashrc
echo 'eval $(register-python-argcomplete ansible-inventory)' >>~/.bashrc
echo 'eval $(register-python-argcomplete ansible-playbook)' >>~/.bashrc
echo 'eval $(register-python-argcomplete ansible-pull)' >>~/.bashrc
echo 'eval $(register-python-argcomplete ansible-vault)' >>~/.bashrc
source ~/.bashrc
