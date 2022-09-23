# [Choice] Ruby version (use -bullseye variants on local arm64/Apple Silicon): 3, 3.1, 3.0, 2, 2.7, 2.6, 3-bullseye, 3.1-bullseye, 3.0-bullseye, 2-bullseye, 2.7-bullseye, 2.6-bullseye, 3-buster, 3.1-buster, 3.0-buster, 2-buster, 2.7-buster, 2.6-buster
ARG VARIANT=3.1-bullseye
FROM mcr.microsoft.com/vscode/devcontainers/ruby:0-${VARIANT}

# Install Rails
RUN gem install rails webdrivers 

# Default value to allow debug server to serve content over GitHub Codespace's port forwarding service
# The value is a comma-separated list of allowed domains 
ENV RAILS_DEVELOPMENT_HOSTS=".githubpreview.dev"

# [Choice] Node.js version: lts/*, 16, 14, 12, 10
ARG NODE_VERSION="lts/*"
RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"

RUN . /etc/os-release \
    && echo "deb http://deb.debian.org/debian ${VERSION_CODENAME}-backports main" > /etc/apt/sources.list.d/backports.list \
    && apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y -t ${VERSION_CODENAME}-backports install --no-install-recommends mariadb-client golang

# Install tbls
RUN go install github.com/k1LoW/tbls@main \
    && mv ~/go/bin/tbls /usr/local/bin/tbls \
    && rm -fr ~/go

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends bash-completion tig direnv silversearcher-ag vim exa python3-pip fonts-ipafont fonts-ipaexfont fonts-noto-cjk \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# [Optional] Uncomment this line to install additional gems.
# RUN gem install <your-gem-names-here>

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1
