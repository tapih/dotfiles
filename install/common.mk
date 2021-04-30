KUBECTL_VERSION := 1.19.2
GCLOUD_VERSION := 337.0.0
GO_VERSION := 1.16.1
FLUTTER_VERSION := 2.0.4
PYTHON_VERSION := 3.7.3
NODE_VERSION := 14.16.0

SHELL := /bin/bash
COMMON_MK := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))/common.mk
GOPATH := ${HOME}/go
GO := $(ASDF_DIR)/shims/go
PIP := $(ASDF_DIR)/shims/pip
ASDF := ${HOME}/.asdf/asdf.sh

PACKAGES := \
	cask \
	ghq \
	gh \
	fd \
	rg \
	bat \
	fzf \
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
	tree \
	htop \
	yarn \
	kind \
	kustomize \
	helm \
	skaffold \
	stern \
	k9s \
	krew \
	terraform \
	hugo \
	colordiff

.PHONY: all
all: brew asdf gotools

.PHONY: brew
brew:
	brew update
	brew install $(PACKAGES)

.PHONY: asdf
asdf: kubectl golang python flutter nodejs gcloud

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
gcloud: python
	$(MAKE) -f $(COMMON_MK) _asdf_install TARGET_NAME=gcloud TARGET_VERSION=$(GCLOUD_VERSION)

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

