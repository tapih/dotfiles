CURL := curl -sSfL

KUBECTL_VERSION := 1.19.2
GCLOUD_VERSION := 337.0.0
GO_VERSION := 1.16.1
FLUTTER_VERSION := 2.0.4
PYTHON_VERSION := 3.7.3
NODE_VERSION := 14.16.0

.PHONY: all
all: kubectl gcloud golang python flutter nodejs

.PHONY: _install
_install:
	(asdf plugin list | grep -q $(TARGET_NAME)) || asdf plugin add $(TARGET_NAME)
	asdf install $(TARGET_NAME) $(TARGET_VERSION)
	asdf global $(TARGET_NAME) $(TARGET_VERSION)

.PHONY: kubectl
kubectl:
	$(MAKE) -f ./asdf.mk _install TARGET_NAME=kubectl TARGET_VERSION=$(KUBECTL_VERSION)

.PHONY: gcloud
gcloud:
	$(MAKE) -f ./asdf.mk _install TARGET_NAME=gcloud TARGET_VERSION=$(GCLOUD_VERSION)

.PHONY: golang
golang:
	mkdir -p ${GOPATH}/src
	mkdir -p ${GOPATH}/bin
	mkdir -p ${GOPATH}/pkg
	$(MAKE) -f ./asdf.mk _install TARGET_NAME=golang TARGET_VERSION=$(GO_VERSION)

.PHONY: nodejs
nodejs:
	$(MAKE) -f ./asdf.mk _install TARGET_NAME=nodejs TARGET_VERSION=$(NODE_VERSION)

.PHONY: flutter
flutter:
	mkdir -p $(FLUTTER_DIR)
	$(MAKE) -f ./asdf.mk _install TARGET_NAME=flutter TARGET_VERSION=$(FLUTTER_VERSION)

.PHONY: python
python:
	$(MAKE) -f ./asdf.mk _install TARGET_NAME=python TARGET_VERSION=$(PYTHON_VERSION)
	pip install pynvim neovim-remote

.PHONY: gotools
gotools:
	go install golang.org/x/tools/cmd/goimports@latest
	go install github.com/sqs/goreturns@latest
	go install golang.org/x/tools/gopls@latest
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
	go install github.com/nametake/golangci-lint-langserver@latest
	go install github.com/cweill/gotests/gotests@latest
	go install honnef.co/go/tools/cmd/staticcheck@latest
	go install github.com/fatih/gomodifytags@latest
	go install github.com/spf13/cobra/cobra@latest
	go install github.com/go-delve/delve/cmd/dlv@latest
	go install github.com/client9/misspell/cmd/misspell@latest
	go install github.com/josharian/impl@latest
	go install github.com/rjeczalik/interfaces/cmd/interfacer@latest
	go install github.com/110y/go-expr-completion@latest
	go install github.com/99designs/gqlgen@latest
	go install github.com/deepmap/oapi-codegen/cmd/oapi-codegen@latest
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	go install github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc@latest

.PHONY: clean
clean:
	asdf uninstall kubectl $(KUBECTL_VERSION)
	asdf uninstall gcloud $(GCLOUD_VERSION)
	asdf uninstall golang $(GO_VERSION)
	asdf uninstall flutter $(FLUTTER_VERSION)-stable
	asdf uninstall nodejs $(NODE_VERSION)
	asdf uninstall python $(PYTHON_VERSION)
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

