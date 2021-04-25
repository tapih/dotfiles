CURL := curl -sSfL

ASDF_VERSION := 0.8.0
KUBECTL_VERSION := 1.19.2
GCLOUD_VERSION := 337.0.0
GO_VERSION := 1.16.1
FLUTTER_VERSION := 2.0.4
PYTHON_VERSION := 3.7.3
NODE_VERSION := 14.16.0

SHELL := /bin/bash
ASDF_MK := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))/asdf.mk
ASDF_DIR := ${HOME}/.asdf
ASDF := $(ASDF_DIR)/asdf.sh
GOPATH := ${HOME}/go
GO := $(ASDF_DIR)/shims/go
PIP := $(ASDF_DIR)/shims/pip

.PHONY: all
all: setup kubectl golang python gcloud flutter nodejs gotools

.PHONY: setup
setup: $(ASDF)
$(ASDF):
	git clone https://github.com/asdf-vm/asdf.git $(ASDF_DIR) --branch v$(ASDF_VERSION)

.PHONY: _install
_install: setup
	{ \
		. $(ASDF); \
		(asdf plugin list | grep -q $(TARGET_NAME)) || asdf plugin add $(TARGET_NAME); \
		asdf install $(TARGET_NAME) $(TARGET_VERSION); \
		asdf global $(TARGET_NAME) $(TARGET_VERSION); \
	}

.PHONY: kubectl
kubectl: setup
	{ \
		. $(ASDF); \
		$(MAKE) -f $(ASDF_MK) _install TARGET_NAME=kubectl TARGET_VERSION=$(KUBECTL_VERSION); \
	}

.PHONY: gcloud
gcloud: setup python
	{ \
		. $(ASDF); \
		$(MAKE) -f $(ASDF_MK) _install TARGET_NAME=gcloud TARGET_VERSION=$(GCLOUD_VERSION); \
	}

.PHONY: golang
golang: setup
	mkdir -p ${GOPATH}/src
	mkdir -p ${GOPATH}/bin
	mkdir -p ${GOPATH}/pkg
	{ \
		. $(ASDF); \
		$(MAKE) -f $(ASDF_MK) _install TARGET_NAME=golang TARGET_VERSION=$(GO_VERSION); \
	}

.PHONY: nodejs
nodejs: setup
	{ \
		. $(ASDF); \
		$(MAKE) -f $(ASDF_MK) _install TARGET_NAME=nodejs TARGET_VERSION=$(NODE_VERSION); \
	}

.PHONY: flutter
flutter: setup
	{ \
		. $(ASDF); \
		$(MAKE) -f $(ASDF_MK) _install TARGET_NAME=flutter TARGET_VERSION=$(FLUTTER_VERSION); \
	}

.PHONY: python
python: setup
	{ \
		. $(ASDF); \
		$(MAKE) -f $(ASDF_MK) _install TARGET_NAME=python TARGET_VERSION=$(PYTHON_VERSION); \
	}
	$(PIP) install pynvim neovim-remote

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

.PHONY: clean
clean:
	rm -rf $(ASDF_DIR)
	rm -f $(GOPATH)/bin/goimports
	rm -f $(GOPATH)/bin/gopls
	rm -f $(GOPATH)/bin/golangci_lint
	rm -f $(GOPATH)/bin/golangci_lint_ls
	rm -f $(GOPATH)/bin/gotests
	rm -f $(GOPATH)/bin/gomodifytags
	rm -f $(GOPATH)/bin/staticcheck
	rm -f $(GOPATH)/bin/cobra
	rm -f $(GOPATH)/bin/dlv
	rm -f $(GOPATH)/bin/misspell
	rm -f $(GOPATH)/bin/impl
	rm -f $(GOPATH)/bin/interfacer
	rm -f $(GOPATH)/bin/go_expr_completion

