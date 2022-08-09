echo 'eval "$(direnv hook bash)"' >>~/.bashrc
echo 'eval "$(direnv hook zsh)"' >>~/.zshrc
if [ -f requirements.txt ]; then
  pip3 install --user -r requirements.txt
fi
