#!/usr/bin/env bash
BASE_DIR=$(pwd)
readonly BASE_DIR
SCRIPT_DIR=$(dirname $0)
readonly SCRIPT_DIR
echo "$(whoami):$(whoami)" | sudo chpasswd

if type "direnv" >/dev/null 2>&1; then
  echo 'eval "$(direnv hook bash)"' >>~/.bashrc
fi

if type "exa" >/dev/null 2>&1; then
  echo 'alias ls="exa --git --header"' >>~/.bashrc
fi

if type "npm" >/dev/null 2>&1; then
  echo 'eval "$(npm completion)"' >>~/.bashrc
fi

if type "yarn" >/dev/null 2>&1; then
  mkdir -p "${HOME}/.local/share/bash-completion/completions/"
  curl -s -o "${HOME}/.local/share/bash-completion/completions/yarn" \
  https://raw.githubusercontent.com/dsifford/yarn-completion/master/yarn-completion.bash
fi

if type "gem" >/dev/null 2>&1; then
  mkdir -p "${HOME}/.local/share/bash-completion/completions/"
  curl -s -o "${HOME}/.local/share/bash-completion/completions/gem" \
  https://raw.githubusercontent.com/mernen/completion-ruby/main/completion-gem
fi

if type "rails" >/dev/null 2>&1; then
  mkdir -p "${HOME}/.local/share/bash-completion/completions/"
  curl -s -o "${HOME}/.local/share/bash-completion/completions/rails" \
  https://raw.githubusercontent.com/mernen/completion-ruby/main/completion-rails
fi

if type "rake" >/dev/null 2>&1; then
  mkdir -p "${HOME}/.local/share/bash-completion/completions/"
  curl -s -o "${HOME}/.local/share/bash-completion/completions/rake" \
  https://raw.githubusercontent.com/mernen/completion-ruby/main/completion-rake
fi

if type "bundle" >/dev/null 2>&1; then
  mkdir -p "${HOME}/.local/share/bash-completion/completions/"
  curl -s -o "${HOME}/.local/share/bash-completion/completions/bundle" \
  https://raw.githubusercontent.com/mernen/completion-ruby/main/completion-bundle
fi

if type "ruby" >/dev/null 2>&1; then
  mkdir -p "${HOME}/.local/share/bash-completion/completions/"
  curl -s -o "${HOME}/.local/share/bash-completion/completions/ruby" \
  https://raw.githubusercontent.com/mernen/completion-ruby/main/completion-ruby
fi

if type "tbls" >/dev/null 2>&1; then
  echo 'export TBLS_DSN="mariadb://app_dev:app_dev_password@db:3306/app_dev"' >>~/.bashrc
fi

if [ ! -f ~/.inputrc ]; then
  echo "set completion-ignore-case on">~/.inputrc
fi

pip3 install --user mycli ansible

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
smart_completion = True
multi_line = False
enable_pager = False
less_chatty = True
[alias_dsn]
dev = mysql://[user[:password]@][host][:port][/dbname]
test = mysql://[user[:password]@][host][:port][/dbname]
stg = mysql://[user[:password]@][host][:port][/dbname]
prod = mysql://[user[:password]@][host][:port][/dbname]
EOT

if [ ! -e "${BASE_DIR}/config/database.yml" ]; then
  echo "Copy database.yml"
  cp ${BASE_DIR}/.devcontainer/redmine/database.yml ${BASE_DIR}/config/database.yml
fi
if [ ! -e "${BASE_DIR}/Gemfile.local" ]; then
  echo "Copy Gemfile.local"
  cp ${BASE_DIR}/.devcontainer/redmine/Gemfile.local ${BASE_DIR}/Gemfile.local
fi

echo "Execute:bundle install"
bundle install
if [ ! -e "${BASE_DIR}/config/initializers/secret_token.rb" ]; then
  echo "Execute:rails generate_secret_token"
  rake generate_secret_token
fi
echo "Execute:rails db:migrate"
rake db:migrate

# echo "Execute:rails redmine:load_default_data"
# rake redmine:load_default_data

echo "Execute:rails redmine:plugins:migrate"
rake redmine:plugins:migrate

echo "Execute:rails r ${BASE_DIR}/.devcontainer/redmine/admin_must_change_passwd_false.rb"
rails r ${BASE_DIR}/.devcontainer/redmine/admin_must_change_passwd_false.rb

if [ -f "${SCRIPT_DIR}/post_create.yml" ]; then
  ansible-playbook -i 127.0.0.1, -c local --diff "${SCRIPT_DIR}/post_create.yml"
fi
