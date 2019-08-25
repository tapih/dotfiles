#! /usr/bin/env zsh
#
# install.sh
# Copyright (C) 2019 hmuraoka <hmuraoka@melchior.local>
#
# Distributed under terms of the MIT license.
#
set -e

function is_exists() { type $1 >/dev/null 2>&1; return $?; }

BASE_DIR=`realpath $(dirname $0)`
WORK_DIR=.cache
echo $BASE_DIR

NVIM_PYTHON2_VERSION=2.7.16
NVIM_PYTHON3_VERSION=3.7.3
NODE_VERSION=10.16.0
GO_VERSION=1.12.5
TMUX_VERSION=2.9
GLOBAL_VERSION=6.5.6

if [ ! $(echo ${SHELL} | grep zsh) ]; then
	exit 1
fi

cd `dirname $0`
mkdir -p ${WORK_DIR}
cd ${WORK_DIR}

echo "install debian package..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt-add-repository -y ppa:brightbox/ruby-ng
sudo apt update
sudo apt purge unattended-upgrades
sudo apt -y --no-install-recommends install \
	jq \
	git \
	vim \
	neovim \
	curl \
	wget \
	npm \
	screen \
	tig \
	htop \
	llvm \
	tree \
	make \
	build-essential \
	autotools-dev \
	automake \
	libevent-dev \
	ruby \
	bison \
	flex \
	ncurses-dev

# for vim
sudo apt -y --no-install-recommends install \
	xsel \
	exuberant-ctags \
	silversearcher-ag \
    compiz-plugins \
    compiz-plugins-extra \
    compizconfig-settings-manager

# for docker
sudo apt -y --no-install-recommends install \
	apt-transport-https \
	ca-certificates \
	gnupg-agent \
	software-properties-common \
	docker-ce \
	docker-ce-cli \
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
rehash

echo "link dotfiles ..."
mkdir -p ${HOME}/.config
[ -e ${HOME}/.zshrc       -o -L ${HOME}/.zshrc       ] || ln -s ${BASE_DIR}/.zshrc        ${HOME}/
[ -e ${HOME}/.gitconfig   -o -L ${HOME}/.gitconfig   ] || ln -s ${BASE_DIR}/.gitconfig    ${HOME}/
[ -e ${HOME}/.screenrc    -o -L ${HOME}/.screenrc    ] || ln -s ${BASE_DIR}/.screenrc     ${HOME}/
[ -e ${HOME}/.tmux.conf   -o -L ${HOME}/.tmux.conf   ] || ln -s ${BASE_DIR}/.tmux.conf    ${HOME}/
[ -d ${HOME}/.config/nvim -o -L ${HOME}/.config/nvim ] || ln -s ${BASE_DIR}/nvim          ${HOME}/.config/
[ -e ${HOME}/.vimrc       -o -L ${HOME}/.vimrc       ] || ln -s ${BASE_DIR}/nvim/init.vim ${HOME}/.vimrc

echo "install pyenv ..."
PYENV_ROOT_DIR=${HOME}/.pyenv
[ -e ${PYENV_ROOT_DIR} ] || git clone https://github.com/pyenv/pyenv.git ${PYENV_ROOT_DIR}
[ -e ${PYENV_ROOT_DIR}/plugins/pyenv-virtualenv ] || \
    git clone https://github.com/pyenv/pyenv-virtualenv.git ${PYENV_ROOT_DIR}/plugins/pyenv-virtualenv
PYENV_ROOT=$HOME/.pyenv
PATH=$PATH:$PYENV_ROOT/shims:$PYENV_ROOT/bin
eval "$(pyenv init -)";

echo "install python ${NVIM_PYTHON2_VERSION} for nvim ..."
if [ $(pyenv versions | grep ${NVIM_PYTHON2_VERSION}) ]; then
    pyenv install -s ${NVIM_PYTHON2_VERSION}
    pyenv rehash
    pyenv virtualenv ${NVIM_PYTHON2_VERSION} neovim2
    pyenv global neovim2
    pip install neovim
fi

echo "install python ${NVIM_PYTHON3_VERSION} for nvim ..."
if [ $(pyenv versions | grep ${NVIM_PYTHON3_VERSION}) ]; then
    pyenv install -s ${NVIM_PYTHON3_VERSION}
    pyenv rehash
    pyenv virtualenv ${NVIM_PYTHON3_VERSION} neovim3
    pyenv global neovim3
    pip install neovim
fi

# echo "install goenv ..."
# GOENV_ROOT_DIR=${HOME}/.goenv
# [ -e ${GOENV_ROOT_DIR} ] || git clone https://github.com/syndbg/goenv.git ${HOME}/.goenv
# GOENV_ROOT=$HOME/.goenv
# PATH="$GOENV_ROOT/bin:$GOROOT/bin:$GOPATH/bin:$PATH"
# eval "$(goenv init -)";
# 
# echo "install go ${GO_VERSION}..."
# if [ goenv versions | grep ${GO_VERSION} ]; then
#     goenv install -s ${GO_VERSION}
#     goenv rehash
#     goenv global ${GO_VERSION}
# fi
# 
# echo "install go repositories ..."
# mkdir -p ${GOROOT}/{src,bin,pkg}
# GO111MODULE=off
# go get -u golang.org/x/tools/cmd/goimports
# go get -u github.com/mdempsky/gocode
# go get -u golang.org/x/tools/cmd/gopls

echo "install n ..."
is_exists n || sudo npm -g i n

echo "install node ${NODE_VERSION} ..."
sudo n ${NODE_VERSION}

echo "install GNU global..."
if ! is_exists gtags ; then
	GLOBAL_TMP_PATH=global-${GLOBAL_VERSION}.tar.gz
	curl -sSLf -O http://tamacom.com/global/${GLOBAL_TMP_PATH}
	tar zxf ${GLOBAL_TMP_PATH}
	cd ${GLOBAL_TMP_PATH%.tar.gz}
	./configure && make
	sudo make install
	cd ..
	rm -f ${GLOBAL_TMP_PATH}
fi

echo "install pygments..."
pyenv global neovim2
pip install pygments

echo "install tmux ..."
if ! is_exists tmux ; then
	TMUX_TMP_PATH=tmux-${TMUX_VERSION}.tar.gz
	curl -sSLf https://github.com/tmux/tmux/archive/${TMUX_VERSION}.tar.gz -o ${TMUX_TMP_PATH}
	tar zxf ${TMUX_TMP_PATH}
	cd ${TMUX_TMP_PATH%.tar.gz}
	sh autogen.sh
	./configure && make
	sudo make install
	cd ..
	rm -f ${TMUX_TMP_PATH}
fi

echo "install tmuxinator..."
sudo gem install tmuxinator
mkdir -p ${HOME}/.bin
wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh -o ~/.bin/tmuxinator.zsh

echo "install tmux plugins ..."
TPM_PATH=${HOME}/.tmux/plugins/tpm
[ -e ${TPM_PATH} ] || git clone https://github.com/tmux-plugins/tpm ${TPM_PATH}

echo "install dein ..."
DEIN_DIR=${HOME}/.cache/dein
if [ ! -e ${DEIN_DIR} ]; then
	mkdir -p ${DEIN_DIR}
	INSTALLER_NAME=.installer.sh
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ${INSTALLER_NAME}
	sh ${INSTALLER_NAME} ${DEIN_DIR}
	rm -f ${INSTALLER_NAME}
fi

# echo "install NeoBundle ..."
# NEOBUNDLE_DIR=${HOME}/.cache/dein
# if [ ! -e ${NEOBUNDLE_DIR}/neobundle.vim ]; then
# 	mkdir -p ${HOME}/.vim/bundle
# 	INSTALLER_NAME=.installer.sh
# 	curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > ${INSTALLER_NAME}
# 	sh ${INSTALLER_NAME}
# 	rm -f ${INSTALLER_NAME}
# fi
