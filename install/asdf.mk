CURL := curl -sSfL

KUBECTL_VERSION := 1.19.2
GCLOUD_VERSION := 337.0.0
GO_VERSION := 1.16.1
FLUTTER_VERSION := 2.0.4
PYTHON_VERSION := 3.7.3
NODE_VERSION := 14.16.0

.PHONY: all
all: setup global pynvim gotools

.PHONY: setup
setup:
	mkdir -p ${GOPATH}/src
	mkdir -p ${GOPATH}/bin
	mkdir -p ${GOPATH}/pkg
	mkdir -p $(FLUTTER_DIR)

.PHONY: plugins
plugins:
	(asdf plugin list | grep -q kubectl) || asdf plugin add kubectl
	(asdf plugin list | grep -q gcloud) || asdf plugin add gcloud
	(asdf plugin list | grep -q python) || asdf plugin add python
	(asdf plugin list | grep -q golang) || asdf plugin add golang
	(asdf plugin list | grep -q nodejs) || asdf plugin add nodejs
	(asdf plugin list | grep -q flutter) || asdf plugin add flutter

.PHONY: install
install: plugins
	asdf install kubectl $(KUBECTL_VERSION)
	asdf install gcloud $(GCLOUD_VERSION)
	asdf install golang $(GO_VERSION)
	asdf install flutter $(FLUTTER_VERSION)-stable
	asdf install nodejs $(NODE_VERSION)
	asdf install python $(PYTHON_VERSION)

.PHONY: global
global: install
	asdf global kubectl $(KUBECTL_VERSION)
	asdf global gcloud $(GO_VERSION)
	asdf global golang $(GO_VERSION)
	asdf global flutter $(FLUTTER_VERSION)-stable
	asdf global nodejs $(NODE_VERSION)
	asdf global python $(PYTHON_VERSION)

.PHONY: pynvim
pynvim:
	asdf global python $(PYTHON_VERSION)
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

