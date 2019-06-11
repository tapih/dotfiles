#! /bin/sh
#
# install.sh
# Copyright (C) 2019 hmuraoka <hmuraoka@melchior.local>
#
# Distributed under terms of the MIT license.
#

WORK_DIR='.cache'

ANACONDA_VERSION=3.5.1
NVIM_PYTHON2_VERSION=2.7.16
NVIM_PYTHON3_VERSION=3.7.3
NODE_VERSION=10.16.0
GO_VERSION=1.12.5
TMUX_VERSION=2.8
GLOBAL_VERSION=6.5.6

mkdir -p ${WORK_DIR}
cd ${WORK_DIR}

echo "install debian package..."
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get -y install \
	zsh \
	git \
	vim \
    nvim \
	curl \
	wget \
    npm \
	screen \
	tig \
	peco \
	htop \
    build-essential \
    docker.io \
	# ---- for python ----
    bison \
    flex \
	# ---- for tmux ----
	xsel \
	# ---- for nvim ----
	ncurses-dev \
	exuberant-ctags \
	silversearcher-ag

touch ~/.zshrc.local

echo "install anaconda ${ANACONDA_VERSION} ..."
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc.local
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc.local
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc.local
exec ${SHELL}
pyenv install anaconda3-${ANACONDA_VERSION}
pyenv rehash
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

echo "install python ${NVIM_PYTHON2_VERSION} for nvim ..."
pyenv install ${NVIM_PYTHON2_VERSION}
pyenv rehash
pyenv virtualenv ${NVIM_PYTHON2_VERSION} neovim2
pyenv activate neovim2
pip install neovim
pyenv which python
pyenv deactivate

echo "install python ${NVIM_PYTHON3_VERSION} for nvim ..."
pyenv install ${NVIM_PYTHON3_VERSION}
pyenv rehash
pyenv virtualenv ${NVIM_PYTHON3_VERSION} neovim3
pyenv activate neovim3
pip install neovim
pyenv which python
pyenv deactivate

echo "install goenv ..."
git clone https://github.com/syndbg/goenv.git ~/.goenv
echo 'export GOENV_ROOT="$HOME/.goenv"' >> ~/.zshrc.local
echo 'export PATH="$GOENV_ROOT/bin:$GOROOT/bin:$GOPATH/bin:$PATH"' >> ~/.zshrc.local
echo 'eval "$(goenv init -)"' >> ~/.zshrc.local
exec ${SHELL}

echo "install go ${GO_VERSION}..."
goenv install ${GO_VERSION}
goenv rehash
goenv global ${GO_VERSION}

echo "install go repositories ..."
GO111MODULE=off
go get -u golang.org/x/tools/cmd/goimports
go get -u github.com/mdempsky/gocode
go get -u golang.org/x/tools/cmd/gopls

echo "install n ..."
sudo npm -g i n

echo "install node ${NODE_VERSION} ..."
sudo n ${NODE_VERSION}
n use ${NODE_VERSION}

echo "install GNU global..."
curl -sSLf -O http://tamacom.com/global/global-${GLOBAL_VERSION}.tar.gz
tar zxvf global-${GLOBAL_VERSION}.tar.gz
cd global-${GLOBAL_VERSION}
./configure && make
sudo make install
cd ..
rm -f global-${GLOBAL_VERSION}.tar.gz

pyenv activate neovim2
pip install pygments
pyenv deactivate

echo "install tmux ..."
curl -sSLf https://github.com/tmux/tmux/archive/${TMUX_VERSION}.tar.gz -o tmux-${TMUX_VERSION}.tar.gz
tar zxvf tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_VERSION}
./configure && make
sudo make install
cd ..
rm -f tmux-${TMUX_VERSION}.tar.gz

echo "install tmux plugins ..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "install dein ..."
mkdir -p ~/.cache/dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > dein-installer.sh
sh ./dein-installer.sh ~/.cache/dein
rm -f dein_installer.sh

echo "install NeoBundle ..."
mkdir -p ~/.vim/bundle
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > neobundle-installer.sh
sh ./neobundle-installer.sh
rm -f neobundle-installer.sh

