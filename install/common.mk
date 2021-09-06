CURL := curl -sSfL
SHELL := /bin/bash

ASDF_VERSION := 0.8.0
KUBECTL_VERSION := 1.21.0
HELM_VERSION := 3.5.3
KUSTOMIZE_VERSION := 4.1.3
GCLOUD_VERSION := 337.0.0
GO_VERSION := 1.16.1
FLUTTER_VERSION := 2.2.0
DART_VERSION := 2.12.4
PYTHON_VERSION := 3.9.4
NODE_VERSION := 16.1.0
FIREBASE_VERSION := 9.12.0
TERRAFORM_VERSION := 1.0.0

BREW_DIR ?=
BREW := $(BREW_DIR)/bin/brew
ZSH := $(BREW_DIR)/bin/zsh
ASDF_DIR := ${HOME}/.asdf
ASDF := $(ASDF_DIR)/asdf.sh
ANTIGEN := ${HOME}/.antigen.zsh
TPM := ${HOME}/.tmux/plugins/tpm

LINKS_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))/../links
ZSHRC := ${HOME}/.zshrc
VIMRC := ${HOME}/.vimrc
NVIM_DIR := ${HOME}/.config/nvim
NVIM_INIT := ${HOME}/.config/nvim/init.lua
NVIM_LUA := ${HOME}/.config/nvim/lua
PACKER_DIR := ${NVIM_DIR}/packer.nvim
ZSHRC_COMMANDS := ${HOME}/.zshrc.commands
INPUTRC := ${HOME}/.inputrc
GITCONFIG := ${HOME}/.gitconfig
TMUX_CONF := ${HOME}/.tmux.conf
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
	hub \
	fzf \
	fzy \
	fd \
	rg \
	bat \
	git-delta \
	starship \
	tmux \
	git \
	tig \
	lazygit \
	lazydocker \
	terraform-ls \
	unzip \
	jq \
	yq \
	colordiff \
	tree \
	gnu-sed \
	htop \
	watch \
	yarn \
	buildkit \
	grpcurl \
	trivy \
	kind \
	skaffold \
	kubeval \
	stern \
	k9s \
	krew \
	hadolint

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

.PHONY: packer
packer: $(PACKER_DIR)
$(PACKER_DIR):
	git clone https://github.com/wbthomason/packer.nvim $@

.PHONY: links
links:
	mkdir -p $(NVIM_DIR)
	[ -f $(ZSHRC) ]          || ln -s $(LINKS_DIR)/zshrc $(ZSHRC)
	[ -f $(ZSHRC_COMMANDS) ] || ln -s $(LINKS_DIR)/zshrc.commands $(ZSHRC_COMMANDS)
	[ -f $(INPUTRC) ]        || ln -s $(LINKS_DIR)/inputrc $(INPUTRC)
	[ -f $(GITCONFIG) ]      || ln -s $(LINKS_DIR)/gitconfig $(GITCONFIG)
	[ -f $(TMUX_CONF) ]      || ln -s $(LINKS_DIR)/tmux.conf $(TMUX_CONF)
	[ -f $(VIMRC)  ]         || ln -s $(LINKS_DIR)/vimrc $(VIMRC)
	[ -f $(NVIM_INIT)  ]     || ln -s $(LINKS_DIR)/nvim/init.lua $(NVIM_INIT)
	[ -f $(NVIM_LUA)  ]      || ln -s $(LINKS_DIR)/nvim/lua $(NVIM_LUA)
	[ -f $(IDEAVIMRC) ]      || ln -s $(LINKS_DIR)/ideavimrc $(IDEAVIMRC)
	[ -f $(STARSHIPRC) ]     || ln -s $(LINKS_DIR)/starship.toml $(STARSHIPRC)

.PHONY: remove-links
remove-links:
	rm -f $(ZSHRC)
	rm -f $(ZSHRC_COMMANDS)
	rm -f $(INPUTRC)
	rm -f $(GITCONFIG)
	rm -f $(TMUX_CONF)
	rm -f $(VIMRC)
	rm -f $(NVIMINIT)
	rm -f $(NVIMLUA)
	rm -f $(IDEAVIMRC)
	rm -f $(STARSHIPRC)

.PHONY: install
install: brew-packages asdf-packages gotools

.PHONY: brew-packages
brew-packages:
	brew tap homebrew/cask-fonts
	brew tap instrumenta/instrumenta
	brew update
	brew install $(BREW_PACKAGES)
	brew install --HEAD neovim
	$$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash

.PHONY: asdf-packages
asdf-packages: \
	kubectl \
	kustomize \
	golang \
	python \
	flutter \
	nodejs \
	gcloud \
	firebase \
	terraform

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
	$(MAKE) -f $(COMMON_MK) _asdf_install TARGET_NAME=$@ TARGET_VERSION=$(KUBECTL_VERSION)

# NOT working currently on Apple Sillicon
.PHONY: helm
helm:
	$(MAKE) -f $(COMMON_MK) _asdf_install TARGET_NAME=$@ TARGET_VERSION=$(HELM_VERSION)

.PHONY: kustomize
kustomize:
	$(MAKE) -f $(COMMON_MK) _asdf_install TARGET_NAME=$@ TARGET_VERSION=$(KUSTOMIZE_VERSION)

.PHONY: golang
golang:
	mkdir -p ${GOPATH}/src
	mkdir -p ${GOPATH}/bin
	mkdir -p ${GOPATH}/pkg
	$(MAKE) -f $(COMMON_MK) _asdf_install TARGET_NAME=$@ TARGET_VERSION=$(GO_VERSION)

.PHONY: nodejs
nodejs:
	$(MAKE) -f $(COMMON_MK) _asdf_install TARGET_NAME=$@ TARGET_VERSION=$(NODE_VERSION)

.PHONY: flutter
flutter:
	$(MAKE) -f $(COMMON_MK) _asdf_install TARGET_NAME=$@ TARGET_VERSION=$(FLUTTER_VERSION)

.PHONY: dart
dart:
	$(MAKE) -f $(COMMON_MK) _asdf_install TARGET_NAME=$@ TARGET_VERSION=$(DART_VERSION)

.PHONY: python
python:
	$(MAKE) -f $(COMMON_MK) _asdf_install TARGET_NAME=$@ TARGET_VERSION=$(PYTHON_VERSION)
	$(PIP) install pynvim neovim-remote

.PHONY: gcloud
gcloud:
	$(MAKE) -f $(COMMON_MK) _asdf_install TARGET_NAME=$@ TARGET_VERSION=$(GCLOUD_VERSION)

.PHONY: firebase
firebase:
	$(MAKE) -f $(COMMON_MK) _asdf_install TARGET_NAME=$@ TARGET_VERSION=$(FIREBASE_VERSION)

.PHONY: terraform
terraform:
	$(MAKE) -f $(COMMON_MK) _asdf_install TARGET_NAME=$@ TARGET_VERSION=$(TERRAFORM_VERSION)

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
	$(GO) install github.com/homeport/dyff/cmd/dyff@latest
	$(GO) install github.com/sachaos/viddy@latest

