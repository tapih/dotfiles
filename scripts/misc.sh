#! /bin/sh

mkdir -p ~/.tmux/plugins
git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

mkdir -p ~/.zsh
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

mkdir -p ~/.config/nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.config/nvim/packer.nvim

mkdir -p ~/.asdf
git clone --depth 1 https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2

mkdir -p ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

mkdir -p ~/.zsh/docker
git clone --depth 1 https://github.com/docker/cli.git ~/.zsh/docker/cli
