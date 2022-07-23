#! /bin/sh

mkdir -p ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

mkdir -p ~/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

mkdir -p ~/.config/nvim
git clone https://github.com/wbthomason/packer.nvim ~/.config/nvim/packer.nvim

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

mkdir -p ~/.zsh/docker
git clone --depth 1 https://github.com/docker/cli.git ~/.zsh/docker/cli
