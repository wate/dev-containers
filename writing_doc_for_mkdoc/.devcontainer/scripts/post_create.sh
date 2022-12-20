#!/usr/bin/env bash
if type "direnv" >/dev/null 2>&1; then
  echo 'eval "$(direnv hook bash)"' >>~/.bashrc
fi

if type "exa" >/dev/null 2>&1; then
  echo 'alias ls="exa --git --header"' >>~/.bashrc
fi

if [ ! -f ~/.inputrc ]; then
  echo "set completion-ignore-case on">~/.inputrc
fi

source ~/.bashrc

if [ -f package.json ]; then
  npm install
fi

if [ ! -e mkdocs.yml ]; then
  mkdocs new ./
fi
