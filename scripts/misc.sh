#! /bin/sh

mkdir -p ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

mkdir -p ~/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

mkdir -p ~/.config/nvim
git clone https://github.com/wbthomason/packer.nvim ~/.config/nvim/packer.nvim

$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash
