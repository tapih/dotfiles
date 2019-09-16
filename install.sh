#! /usr/bin/env bash
#
# install.sh
# Copyright (C) 2019 hmuraoka <hmuraoka@melchior.local>
#
# Distributed under terms of the MIT license.
#
set -eu

BASE_DIR=`realpath $(dirname $0)`
cd /tmp

NVIM_PYTHON2_VERSION=2.7.16
NVIM_PYTHON3_VERSION=3.7.3
NODE_VERSION=10.16.3
GO_VERSION=1.12.5
TMUX_VERSION=2.9
GLOBAL_VERSION=6.5.6

echo "install debian package..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt -y purge unattended-upgrades

# sudo apt update
sudo apt -y --no-install-recommends install \
    zsh \
    git \
    vim \
    neovim \
    curl \
    wget \
    screen \
    tig \
    nodejs \
    npm \
    htop \
    tree \
    jq \
    xsel \
    make \
    build-essential \
    autotools-dev \
    automake \
    libevent-dev \
    bison \
    flex \
    ncurses-dev \
    llvm \
    clang-tools-6.0 \
    clang-format-6.0 \
    compiz-plugins \
    compiz-plugins-extra \
    compizconfig-settings-manager

# for docker
sudo apt -y --no-install-recommends install \
    docker-ce \
    docker-ce-cli \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    software-properties-common \
    containerd.io

# for python 2.7
sudo apt -y --no-install-recommends install \
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
    python-openssl

# link
echo "link dotfiles ..."
mkdir -p ${HOME}/.config
[ -e ${HOME}/.zshrc       -o -L ${HOME}/.zshrc       ] || ln -s ${BASE_DIR}/.zshrc        ${HOME}/
[ -e ${HOME}/.gitconfig   -o -L ${HOME}/.gitconfig   ] || ln -s ${BASE_DIR}/.gitconfig    ${HOME}/
[ -e ${HOME}/.screenrc    -o -L ${HOME}/.screenrc    ] || ln -s ${BASE_DIR}/.screenrc     ${HOME}/
[ -e ${HOME}/.tmux.conf   -o -L ${HOME}/.tmux.conf   ] || ln -s ${BASE_DIR}/.tmux.conf    ${HOME}/
[ -d ${HOME}/.config/nvim -o -L ${HOME}/.config/nvim ] || ln -s ${BASE_DIR}/nvim          ${HOME}/.config/
[ -e ${HOME}/.vimrc       -o -L ${HOME}/.vimrc       ] || ln -s ${BASE_DIR}/nvim/init.vim ${HOME}/.vimrc

# pyenv
echo "install pyenv ..."
PYENV_ROOT=$HOME/.pyenv
PATH=$PATH:$PYENV_ROOT/shims:$PYENV_ROOT/bin
if [ ! -d $PYENV_ROOT ]; then
    git clone https://github.com/pyenv/pyenv.git ${PYENV_ROOT}
    git clone https://github.com/pyenv/pyenv-virtualenv.git ${PYENV_ROOT}/plugins/pyenv-virtualenv
    eval "$(pyenv init -)"
fi

if [ ! "$(pyenv versions | grep ${NVIM_PYTHON2_VERSION}$)" ]; then
    pyenv install -s ${NVIM_PYTHON2_VERSION}
    pyenv rehash
    pyenv virtualenv ${NVIM_PYTHON2_VERSION} neovim2
    pyenv global neovim2
    pip install neovim
fi

if [ ! "$(pyenv versions | grep ${NVIM_PYTHON3_VERSION}$)" ]; then
    pyenv install -s ${NVIM_PYTHON3_VERSION}
    pyenv rehash
    pyenv virtualenv ${NVIM_PYTHON3_VERSION} neovim3
    pyenv global neovim3
    pip install neovim
    pip install pyls
fi

# goenv
echo "install goenv ..."
GOENV_ROOT=$HOME/.goenv
PATH="$GOENV_ROOT/bin:$PATH"
if [ ! -d $GOENV_ROOT ]; then
    git clone https://github.com/syndbg/goenv.git $GOENV_ROOT
    eval "$(goenv init -)"
fi

PATH="$GOENV_ROOT/shims:$PATH"
if [ ! "$(goenv versions | grep $GO_VERSION$)" ]; then
    goenv install -s $GO_VERSION
    goenv rehash
    goenv global $GO_VERSION
    GO111MODULE=off
    go get -u golang.org/x/tools/cmd/goimports
    go get -u github.com/mdempsky/gocode
    go get -u golang.org/x/tools/cmd/gopls
fi

# n
echo "install n ..."
if type n > /dev/null 2>&1; then
    sudo npm -g i n
    sudo n $NODE_VERSION
fi


# fzf
FZF_ROOT=$HOME/.fzf
if [ ! -d $FZF_ROOT ]; then
    git clone https://github.com/junegunn/fzf.git $FZF_ROOT
    $FZF_ROOT/install
fi

# tmux
echo "install tmux ..."
if [ ! "$(tmux -V | grep $TMUX_VERSION)" ]; then
    TMUX_TMP_PATH=/tmp/tmux-${TMUX_VERSION}.tar.gz
    curl -sSLf https://github.com/tmux/tmux/archive/${TMUX_VERSION}.tar.gz -o ${TMUX_TMP_PATH}
    tar zxf ${TMUX_TMP_PATH}
    cd ${TMUX_TMP_PATH%.tar.gz}
    sh autogen.sh
    ./configure && make
    sudo make install
    rm -f ${TMUX_TMP_PATH}
    git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm
fi

