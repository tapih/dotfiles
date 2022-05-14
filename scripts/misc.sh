#! /bin/sh

mkdir -p ~/.tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/tpm

mkdir -p ~/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

mkdir -p ~/.config/nvim
git clone https://github.com/wbthomason/packer.nvim ~/.config/nvim/packer.nvim

yarn global add bash-language-server0
yarn global add typescript-language-server

$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash
