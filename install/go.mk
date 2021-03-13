CURL := curl -sSfL

GO_VERSION := 1.16.1
HUGO_VERSION := 0.81.0

GOROOT := /usr/local/go
GOPATH := $(HOME)/go

HOME_BIN_DIR := $(HOME)/bin
GO := $(GOROOT)/bin/go
GOIMPORTS := $(GOPATH)/bin/goimports
GORETURNS := $(GOPATH)/bin/goreturns
GOPLS := $(GOPATH)/bin/gopls
GOLANG_LINT := $(GOPATH)/bin/golangci-lint
GOLANG_LINT_LS := $(GOPATH)/bin/golangci-lint-langserver
GOTESTS := $(GOPATH)/bin/gotests
GOMODIFYTAGS := $(GOPATH)/bin/gomodifytags
GHQ := $(GOPATH)/bin/ghq
HUGO := $(HOME_BIN_DIR)/hugo
COBRA := $(GOPATH)/bin/cobra
STATICCHECK := $(GOPATH)/bin/staticcheck
MISSPELL := $(GOPATH)/bin/misspell
DLV := $(GOPATH)/bin/dlv
IMPL := $(GOPATH)/bin/impl

.PHONY: install
install: \
	go \
	goimports \
	goreturns \
	gopls \
	gotests \
	gomodifytags \
	staticcheck \
	cobra \
	dlv \
	hugo \
	misspell \
	ghq

.PHONY: go
go: $(GO)
$(GO):
	sudo mkdir -p $(GOROOT)
	sudo sh -c "$(CURL) https://dl.google.com/go/go$(GO_VERSION).linux-amd64.tar.gz | tar xz -C $(GOROOT) --strip-components=1"
	mkdir -p $(GOPATH)/src
	mkdir -p $(GOPATH)/bin
	mkdir -p $(GOPATH)/pkg

.PHONY: goimports
goimports: $(GOIMPORTS)
$(GOIMPORTS):
	$(GO) install golang.org/x/tools/cmd/goimports@latest

.PHONY: goreturns
goreturns: $(GORETURNS)
$(GORETURNS):
	$(GO) install github.com/sqs/goreturns

.PHONY: gopls
gopls: $(GOPLS)
$(GOPLS):
	$(GO) install golang.org/x/tools/gopls@latest

.PHONY: golangci-lint
golangci-lint: $(GOLANGCI_LINT)
$(GOLANGCI_LINT):
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

.PHONY: golangci-lint-langserver
golangci-lint-langserver: $(GOLANGCI_LINT_LS)
$(GOLANGCI_LINT_LS):
	$(GO) install github.com/nametake/golangci-lint-langserver@latest

.PHONY: gotests
gotests: $(GOTESTS)
$(GOTESTS):
	$(GO) install github.com/cweill/gotests/gotests@latest

.PHONY: staticcheck
staticcheck: $(STATICCHECK)
$(STATICCHECK):
	$(GO) install honnef.co/go/tools/cmd/staticcheck@latest

.PHONY: gomodifytags
gomodifytags: $(GOMODIFYTAGS)
$(GOMODIFYTAGS):
	$(GO) install github.com/fatih/gomodifytags@latest

.PHONY: cobra
cobra: $(COBRA)
$(COBRA):
	$(GO) install github.com/spf13/cobra/cobra@latest

.PHONY: dlv
dlv: $(DLV)
$(DLV):
	$(GO) install github.com/go-delve/delve/cmd/dlv@latest

.PHONY: misspell
misspell: $(MISSPELL)
$(MISSPELL):
	$(GO) install github.com/client9/misspell/cmd/misspell@latest

.PHONY: hugo
hugo: $(HUGO)
$(HUGO):
	$(CURL) https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_extended_$(HUGO_VERSION)_Linux-64bit.tar.gz | tar xzf - -C $(HOME_BIN_DIR) hugo

.PHONY: ghq
ghq: $(GHQ)
$(GHQ):
	$(GO) install github.com/x-motemen/ghq@latest

.PHONY: impl
impl: $(IMPL)
$(IMPL):
	$(GO) install github.com/josharian/impl@latest

.PHONY: uninstall
uninstall:
	sudo rm -rf $(GOROOT)

.PHONY: clean
clean: uninstall
	rm -f $(GOIMPORTS)
	rm -f $(GOPLS)
	rm -f $(GOTESTS)
	rm -f $(GOMODIFYTAGS)
	rm -f $(STATICCHECK)
	rm -f $(COBRA)
	rm -f $(DLV)
	rm -f $(HUGO)
	rm -f $(MISSPELL)
	rm -f $(GHQ)

