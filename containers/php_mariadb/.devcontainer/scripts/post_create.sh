if type "direnv" >/dev/null 2>&1; then
  echo 'eval "$(direnv hook bash)"' >>~/.bashrc
fi
if type "exa" >/dev/null 2>&1; then
  echo 'alias ls="exa --git --header"' >>~/.bashrc
fi
source ~/.bashrc
if [ -f composer.json ] && [ ! -d vendor ]; then
  composer install --no-interaction
fi
if [ -f package.json ] && [ ! -d node_modules ]; then
  npm install
fi

sudo chmod a+x "$(pwd)"
sudo rm -rf /var/www/html
sudo ln -s "$(pwd)/webroot" /var/www/html
