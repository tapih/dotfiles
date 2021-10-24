#! /bin/sh

mkdir -p ~/.tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/tpm

mkdir -p ~/.config/nvim
git clone https://github.com/wbthomason/packer.nvim ~/.config/nvim/packer.nvim

yarn add bash-language-server0
