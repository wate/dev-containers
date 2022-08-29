if type "direnv" >/dev/null 2>&1; then
  echo 'eval "$(direnv hook bash)"' >>~/.bashrc
fi
if type "exa" >/dev/null 2>&1; then
  echo 'alias ls="exa --git --header"' >>~/.bashrc
fi
if [ -f /usr/local/share/nvm/nvm.sh ]; then
  echo "source /usr/local/share/nvm/nvm.sh" >>~/.bashrc
fi

source ~/.bashrc

cat << EOT > ~/.my.cnf
[mysql]
auto-rehash

[client]
host=db
database=app_dev
user=app_dev
password=app_dev_password
default-character-set=utf8mb4
EOT

sudo chmod a+x "$(pwd)"
sudo rm -rf /var/www/html
WEB_DOC_ROOT=$(pwd)
if [ -d public ]; then
  WEB_DOC_ROOT="$(pwd)/public"
elif [ -d webroot ]; then
  WEB_DOC_ROOT="$(pwd)/webroot"
fi
sudo ln -s "${WEB_DOC_ROOT}" /var/www/html

if [ -f composer.json ] && [ ! -d vendor ]; then
  composer install --no-interaction
fi
if [ -f package.json ] && [ ! -d node_modules ]; then
  npm install
fi
