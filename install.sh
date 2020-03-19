#! /usr/bin/env bash
#
# install.sh
# Copyright (C) 2019 hmuraoka <h.muraoka@gmail.com>
#
# Distributed under terms of the MIT license.
#
set -euxC

BASE_DIR=`realpath $(dirname $0)`

CURL="curl -sSLf"
GO111MODULE=on

# versions
NVIM_PYTHON2_VERSION=2.7.16
NVIM_PYTHON3_VERSION=3.7.3
GO_VERSION=1.13.1
DART_VERSION=2.14
TMUX_VERSION=2.9
GLOBAL_VERSION=6.5.6
HUB_VERSION=2.12.8
KUBERNETES_VERSION=1.16.4
HELM_VERSION=3.1.1
STERN_VERSION=1.11.0

# path
BASH_GIT_PROMPT_DIR=${HOME}/.bash-git-prompt
PYENV_DIR=$HOME/.pyenv
PYENV_VIRTUALENV_DIR=$PYENV_DIR/plugins/pyenv-virtualenv
PYENV=$PYENV_DIR/bin/pyenv
GOROOT=/usr/local/go
FZF_DIR=$HOME/.fzf
TMUX_PLUGINS_DIR=${HOME}/.tmux/plugins/tpm

echo "install debian package..."
sudo sh -c "${CURL} https://download.docker.com/linux/ubuntu/gpg | apt-key add -"
sudo sh -c "${CURL} https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -"
sudo sh -c "${CURL} https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list"
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo add-apt-repository -y ppa:neovim-ppa/stable

sudo apt -y purge unattended-upgrades
sudo apt update
sudo apt -y --no-install-recommends install \
    zsh \
    git \
    vim \
    neovim \
    curl \
    wget \
    screen \
    tig \
    htop \
    tree \
    jq \
    xsel \
    make \
    colordiff \
    ranger \
    build-essential \
    autotools-dev \
    automake \
    libevent-dev \
    xdg-utils \
    bison \
    flex \
    ncurses-dev \
    llvm \
    clang-tools-8 \
    clang-format-8 \
    compiz-plugins \
    compiz-plugins-extra \
    compizconfig-settings-manager \
    libnotify-bin \
    # for docker
    docker-ce \
    docker-ce-cli \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    software-properties-common \
    containerd.io \
    # for python 2.7
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev \
    python-openssl \
    # for dart
    dart \
    apt-transport-https

# link
echo "link dotfiles ..."
mkdir -p ${HOME}/.config
[ -e ${HOME}/.zshrc       -o -L ${HOME}/.zshrc       ] || ln -s ${BASE_DIR}/.zshrc        ${HOME}/
[ -e ${HOME}/.bashrc      -o -L ${HOME}/.bashrc      ] || ln -s ${BASE_DIR}/.bashrc       ${HOME}/
[ -e ${HOME}/.gitconfig   -o -L ${HOME}/.gitconfig   ] || ln -s ${BASE_DIR}/.gitconfig    ${HOME}/
[ -e ${HOME}/.screenrc    -o -L ${HOME}/.screenrc    ] || ln -s ${BASE_DIR}/.screenrc     ${HOME}/
[ -e ${HOME}/.tmux.conf   -o -L ${HOME}/.tmux.conf   ] || ln -s ${BASE_DIR}/.tmux.conf    ${HOME}/
[ -d ${HOME}/.config/nvim -o -L ${HOME}/.config/nvim ] || ln -s ${BASE_DIR}/nvim          ${HOME}/.config/
[ -e ${HOME}/.vimrc       -o -L ${HOME}/.vimrc       ] || ln -s ${BASE_DIR}/nvim/init.vim ${HOME}/.vimrc

# git
[ -d ${BASH_GIT_PROMPT_DIR} ] || git clone https://github.com/magicmonty/bash-git-prompt.git ${BASH_GIT_PROMPT_DIR} --depth=1
sudo ${CURL} https://github.com/github/hub/releases/download/v${HUB_VERSION}/hub-linux-amd64-${HUB_VERSION}.tgz | tar xz -C /usr/local/bin --strip-component=2

# python
echo "install pyenv ..."
[ -d ${PYENV_DIR} ] || git clone https://github.com/pyenv/pyenv.git ${PYENV_DIR}
[ -d ${PYENV_VIRTUALENV_DIR} ] || git clone https://github.com/pyenv/pyenv-virtualenv.git ${PYENV_VIRTUALENV_DIR}
eval "$(${PYENV} init -)"

if [ ! "$(${PYENV} versions | grep ${NVIM_PYTHON2_VERSION}$)" ]; then
    ${PYENV} install -s ${NVIM_PYTHON2_VERSION}
    ${PYENV} rehash
    ${PYENV} virtualenv ${NVIM_PYTHON2_VERSION} neovim2
    ${PYENV} global neovim2
    pip install neovim
fi

if [ ! "$(pyenv versions | grep ${NVIM_PYTHON3_VERSION}$)" ]; then
    ${PYENV} install -s ${NVIM_PYTHON3_VERSION}
    ${PYENV} rehash
    ${PYENV} virtualenv ${NVIM_PYTHON3_VERSION} neovim3
    ${PYENV} global neovim3
    pip install neovim
    pip install pyls
fi

# golang
echo "install golang ..."
[ -d ${GOROOT} ] || sudo ${CURL} https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz | tar xz -C ${GOROOT}
mkdir -p ${HOME}/go/{src,bin,pkg}
cd /tmp && \
    ${GO} get -u golang.org/x/tools/cmd/goimports && \
    ${GO} get -u github.com/motemen/ghq && \
    ${GO} get -u golang.org/x/tools/cmd/gopls@latest
GO111MODULE=off ${GO} get -u github.com/spf13/cobra/cobra

# kubernetes
echo "install kubernetes binaries ..."
sudo ${CURL} https://storage.googleapis.com/kubernetes-release/release/v$KUBERNETES_VERSION/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl
sudo ${CURL} https://get.helm.sh/helm-v$HELM_VERSION-linux-amd64.tar.gz -o /usr/local/bin/helm
sudo ${CURL} https://github.com/wercker/stern/releases/download/$STERN_VERSION/stern_linux_amd64 -o /usr/local/bin/stern
sudo ${CURL} https://github.com/derailed/k9s/releases/download/0.9.3/k9s_0.9.3_Linux_x86_64.tar.gz | tar xz -C /usr/local/bin
$(CURL) https://raw.githubusercontent.com/jonmosco/kube-ps1/master/kube-ps1.sh -o ~/.kube-ps1


# flutter
# mkdir -p ${HOME}/dart/flutter && cd -
# git clone https://github.com/flutter/flutter.git -b stable

# other tools
echo "install tmux ..."
if [ ! -e /usr/local/bin/tmux ]; then
    TMUX_TMP_DIR=/tmp/tmux
    ${CURL} https://github.com/tmux/tmux/archive/${TMUX_VERSION}.tar.gz | tar xz -C ${TMUX_TMP_DIR}
    cd ${TMUX_TMP_DIR} && sh autogen.sh && ./configure && make && sudo make install
fi
[ -d ${TMUX_PLUGINS_DIR} ] || git clone https://github.com/tmux-plugins/tpm ${TMUX_PLUGINS_DIR}

echo "install other tools ..."
# fzf
[ -d ${FZF_DIR} ] || git clone https://github.com/junegunn/fzf.git ${FZF_DIR} && ${FZF_DIR}/install

# c++
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-8 100

# completion
${CURL} https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ${HOME}/.git-completion.bash
