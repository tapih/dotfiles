#! /usr/bin/env zsh
#
# install.sh
# Copyright (C) 2019 hmuraoka <hmuraoka@melchior.local>
#
# Distributed under terms of the MIT license.
#

function is_exists() { type $1 >/dev/null 2>&1; return $?; }

WORK_DIR=.cache

NVIM_PYTHON2_VERSION=2.7.16
NVIM_PYTHON3_VERSION=3.7.3
NODE_VERSION=10.16.0
GO_VERSION=1.12.5
TMUX_VERSION=2.8
GLOBAL_VERSION=6.5.6

if [ ! $(echo ${SHELL} | grep zsh) ]; then
	exit 1
fi

cd `dirname $0`
mkdir -p ${WORK_DIR}
cd ${WORK_DIR}

echo "install debian package..."
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get -y install \
	git \
	vim \
	neovim \
	curl \
	wget \
	npm \
	screen \
	tig \
	htop \
	build-essential \
	autotools-dev \
	automake \
	libevent-dev \
	docker.io \
	bison \
	flex \
	xsel \
	ncurses-dev \
	exuberant-ctags \
	silversearcher-ag

echo "install pyenv ..."
PYENV_ROOT_DIR=${HOME}/.pyenv
[ -e ${PYENV_ROOT_DIR} ] || \
	git clone https://github.com/pyenv/pyenv.git ${PYENV_ROOT_DIR} && \
	git clone https://github.com/pyenv/pyenv-virtualenv.git ${PYENV_ROOT_DIR}/plugins/pyenv-virtualenv && \
	source ${HOME}/.zshrc

echo "install python ${NVIM_PYTHON2_VERSION} for nvim ..."
pyenv install -s ${NVIM_PYTHON2_VERSION}
pyenv rehash
pyenv virtualenv ${NVIM_PYTHON2_VERSION} neovim2
pyenv global neovim2
pip install neovim

echo "install python ${NVIM_PYTHON3_VERSION} for nvim ..."
pyenv install -s ${NVIM_PYTHON3_VERSION}
pyenv rehash
pyenv virtualenv ${NVIM_PYTHON3_VERSION} neovim3
pyenv global neovim3
pip install neovim

echo "install goenv ..."
GOENV_ROOT_DIR=${HOME}/.goenv
[ -e ${GOENV_ROOT_DIR} ] || \
	git clone https://github.com/syndbg/goenv.git ${HOME}/.goenv && \
	source ${HOME}/.zshrc

echo "install go ${GO_VERSION}..."
goenv install -s ${GO_VERSION}
goenv rehash
goenv global ${GO_VERSION}

echo "install go repositories ..."
mkdir -p ${GOROOT}/{src,bin,pkg}
GO111MODULE=off
go get -u golang.org/x/tools/cmd/goimports
go get -u github.com/mdempsky/gocode
go get -u golang.org/x/tools/cmd/gopls

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

echo "install NeoBundle ..."
NEOBUNDLE_DIR=${HOME}/.cache/dein
if [ ! -e ${NEOBUNDLE_DIR}/neobundle.vim ]; then
	mkdir -p ${HOME}/.vim/bundle
	INSTALLER_NAME=.installer.sh
	curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > ${INSTALLER_NAME}
	sh ${INSTALLER_NAME}
	rm -f ${INSTALLER_NAME}
fi

echo "link dotfiles ..."
BASE_DIR=`realpath $(dirname $0)`
[ -e ${HOME}/.zshrc       ] || ln -s ${BASE_DIR}/.zshrc        ${HOME}/
[ -e ${HOME}/.gitconfig   ] || ln -s ${BASE_DIR}/.gitconfig    ${HOME}/
[ -e ${HOME}/.screenrc    ] || ln -s ${BASE_DIR}/.screenrc     ${HOME}/
[ -e ${HOME}/.tmux.conf   ] || ln -s ${BASE_DIR}/.tmux.conf    ${HOME}/
[ -e ${HOME}/.config/nvim ] || ln -s ${BASE_DIR}/nvim          ${HOME}/.config/
[ -e ${HOME}/.nvimrc      ] || ln -s ${BASE_DIR}/nvim/init.vim ${HOME}/.vimrc
