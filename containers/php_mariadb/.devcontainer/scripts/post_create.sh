if type "direnv" >/dev/null 2>&1; then
    echo 'eval "$(direnv hook bash)"' >>~/.bashrc
fi
if type "exa" >/dev/null 2>&1; then
    echo 'alias ls="exa --git --header"' >>~/.bashrc
fi
if [ ! -f ~/.inputrc ]; then
    echo "set completion-ignore-case on">~/.inputrc
fi

pip install mycli ansible mkdocs-material --user

source ~/.bashrc

cat << EOT >~/.my.cnf
[mysql]
auto-rehash

[client]
host=db
database=app_dev
user=app_dev
password=app_dev_password
default-character-set=utf8mb4
EOT
cat << EOT >~/.myclirc
[main]
# Enables context sensitive auto-completion. If this is disabled then all
# possible completions will be listed.
smart_completion = True

# Multi-line mode allows breaking up the sql statements into multiple lines. If
# this is set to True, then the end of the statements must have a semi-colon.
# If this is set to False then sql statements can't be split into multiple
# lines. End of line (return) is considered as the end of the statement.
multi_line = False

# Enable the pager on startup.
enable_pager = False
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
