CURL := curl -sSfL
SHELL := /bin/bash

ASDF_VERSION := 0.8.0
KUBECTL_VERSION := 1.21.0
GCLOUD_VERSION := 337.0.0
GO_VERSION := 1.16.1
FLUTTER_VERSION := 2.2.0
PYTHON_VERSION := 3.9.4
NODE_VERSION := 16.1.0
FIREBASE_VERSION := 9.12.0

BREW_DIR ?=
BREW := $(BREW_DIR)/bin/brew
ZSH := $(BREW_DIR)/bin/zsh
ASDF_DIR := ${HOME}/.asdf
ASDF := $(ASDF_DIR)/asdf.sh
ANTIGEN := ${HOME}/.antigen.zsh
TPM := ${HOME}/.tmux/plugins/tpm

LINKS_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))/../links
ZSHRC := ${HOME}/.zshrc
ZSHRC_COMMANDS := ${HOME}/.zshrc.commands
INPUTRC := ${HOME}/.inputrc
GITCONFIG := ${HOME}/.gitconfig
TMUX_CONF := ${HOME}/.tmux.conf
NVIMRC_DIR := ${HOME}/.config/nvim
VIMRC := ${HOME}/.vimrc
IDEAVIMRC := ${HOME}/.ideavimrc
STARSHIPRC := ${HOME}/.config/starship.toml

COMMON_MK := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))/common.mk
GOPATH := ${HOME}/go
GO := $(ASDF_DIR)/shims/go
PIP := $(ASDF_DIR)/shims/pip
ASDF := ${HOME}/.asdf/asdf.sh

BREW_PACKAGES := \
	cask \
	ghq \
	gh \
	fd \
	rg \
	bat \
	git-delta \
	starship \
	neovim \
	tmux \
	git \
	tig \
	lazygit \
	lazydocker \
	unzip \
	jq \
	yq \
	colordiff \
	tree \
	htop \
	watch \
	yarn \
	buildkit \
	kind \
	kustomize \
	jsonnet \
	helm \
	skaffold \
	stern \
	k9s \
	krew \
	terraform \
	hugo

.PHONY: postinst
postinst: brew zsh asdf antigen tpm remove-links links

.PHONY: brew
brew: $(BREW)
$(BREW):
	bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	$@ update

.PHONY: zsh
zsh: $(ZSH)
$(ZSH): $(BREW)
	$(BREW) install zsh

.PHONY: asdf
asdf: $(ASDF)
$(ASDF):
	git clone https://github.com/asdf-vm/asdf.git $(ASDF_DIR) --branch v$(ASDF_VERSION)

.PHONY: antigen
antigen: $(ANTIGEN)
$(ANTIGEN):
	$(CURL) git.io/antigen > $@

.PHONY: tpm
tpm: $(TPM)
$(TPM):
	mkdir -p $(HOME)/.tmux
	git clone https://github.com/tmux-plugins/tpm $@

.PHONY: links
links:
	mkdir -p ${HOME}/.config
	[ -f $(ZSHRC) ]          || ln -s $(LINKS_DIR)/zshrc $(ZSHRC)
	[ -f $(ZSHRC_COMMANDS) ] || ln -s $(LINKS_DIR)/zshrc.commands $(ZSHRC_COMMANDS)
	[ -f $(INPUTRC) ]        || ln -s $(LINKS_DIR)/inputrc $(INPUTRC)
	[ -f $(GITCONFIG) ]      || ln -s $(LINKS_DIR)/gitconfig $(GITCONFIG)
	[ -f $(TMUX_CONF) ]      || ln -s $(LINKS_DIR)/tmux.conf $(TMUX_CONF)
	[ -f $(VIMRC)  ]         || ln -s $(LINKS_DIR)/config/nvim/init.vim $(VIMRC)
	[ -f $(IDEAVIMRC) ]      || ln -s $(LINKS_DIR)/ideavimrc $(IDEAVIMRC)
	[ -f $(STARSHIPRC) ]     || ln -s $(LINKS_DIR)/config/starship.toml $(STARSHIPRC)
	[ -d $(NVIMRC_DIR) ]     || ln -s $(LINKS_DIR)/config/nvim $(NVIMRC_DIR)

.PHONY: remove-links
remove-links:
	rm -f $(ZSHRC)
	rm -f $(ZSHRC_COMMANDS)
	rm -f $(INPUTRC)
	rm -f $(GITCONFIG)
	rm -f $(TMUX_CONF)
	rm -f $(VIMRC)
	rm -f $(IDEAVIMRC)
	rm -f $(STARSHIPRC)
	rm -rf $(NVIMRC_DIR)

.PHONY: install
install: brew-packages asdf-packages gotools

.PHONY: brew-packages
brew-packages:
	brew update
	brew install $(BREW_PACKAGES)
	$(MAKE) -f $(COMMON_MK) fzf

.PHONY: fzf
fzf:
	brew install fzf
	$$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash

.PHONY: asdf-packages
asdf-packages: kubectl golang python flutter nodejs gcloud firebase

.PHONY: _asdf_install
_asdf_install:
	{ \
		. $(ASDF); \
		(asdf plugin list | grep -q $(TARGET_NAME)) || asdf plugin add $(TARGET_NAME); \
		asdf install $(TARGET_NAME) $(TARGET_VERSION); \
		asdf global $(TARGET_NAME) $(TARGET_VERSION); \
	}

.PHONY: kubectl
kubectl:
	$(MAKE) -f $(COMMON_MK) _asdf_install TARGET_NAME=kubectl TARGET_VERSION=$(KUBECTL_VERSION)

.PHONY: golang
golang:
	mkdir -p ${GOPATH}/src
	mkdir -p ${GOPATH}/bin
	mkdir -p ${GOPATH}/pkg
	$(MAKE) -f $(COMMON_MK) _asdf_install TARGET_NAME=golang TARGET_VERSION=$(GO_VERSION)

.PHONY: nodejs
nodejs:
	$(MAKE) -f $(COMMON_MK) _asdf_install TARGET_NAME=nodejs TARGET_VERSION=$(NODE_VERSION)

.PHONY: flutter
flutter:
	$(MAKE) -f $(COMMON_MK) _asdf_install TARGET_NAME=flutter TARGET_VERSION=$(FLUTTER_VERSION)

.PHONY: python
python:
	$(MAKE) -f $(COMMON_MK) _asdf_install TARGET_NAME=python TARGET_VERSION=$(PYTHON_VERSION)
	$(PIP) install pynvim neovim-remote

.PHONY: gcloud
gcloud:
	$(MAKE) -f $(COMMON_MK) _asdf_install TARGET_NAME=gcloud TARGET_VERSION=$(GCLOUD_VERSION)

.PHONY: firebase
firebase:
	$(MAKE) -f $(COMMON_MK) _asdf_install TARGET_NAME=firebase TARGET_VERSION=$(FIREBASE_VERSION)

.PHONY: gotools
gotools:
	$(GO) install golang.org/x/tools/cmd/goimports@latest
	$(GO) install github.com/sqs/goreturns@latest
	$(GO) install golang.org/x/tools/gopls@latest
	$(GO) install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
	$(GO) install github.com/nametake/golangci-lint-langserver@latest
	$(GO) install github.com/cweill/gotests/gotests@latest
	$(GO) install honnef.co/go/tools/cmd/staticcheck@latest
	$(GO) install github.com/fatih/gomodifytags@latest
	$(GO) install github.com/spf13/cobra/cobra@latest
	$(GO) install github.com/go-delve/delve/cmd/dlv@latest
	$(GO) install github.com/client9/misspell/cmd/misspell@latest
	$(GO) install github.com/josharian/impl@latest
	$(GO) install github.com/rjeczalik/interfaces/cmd/interfacer@latest
	$(GO) install github.com/110y/go-expr-completion@latest
	$(GO) install github.com/99designs/gqlgen@latest
	$(GO) install github.com/deepmap/oapi-codegen/cmd/oapi-codegen@latest
	$(GO) install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	$(GO) install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	$(GO) install github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc@latest

