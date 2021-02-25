CURL := curl -sSfL

GO_VERSION := 1.15.7
HUGO_VERSION := 0.81.0

GOROOT := /usr/local/go
GOPATH := $(HOME)/go

HOME_BIN_DIR := $(HOME)/bin
GO := $(GOROOT)/bin/go
GOIMPORTS := $(GOPATH)/bin/goimports
GOPLS := $(GOPATH)/bin/gopls
GOTESTS := $(GOPATH)/bin/gotests
GOMODIFYTAGS := $(GOPATH)/bin/gomodifytags
GHQ := $(GOPATH)/bin/ghq
HUGO := $(HOME_BIN_DIR)/hugo
COBRA := $(GOPATH)/bin/cobra
STATICCHECK := $(GOPATH)/bin/staticcheck
MISSPELL := $(GOPATH)/bin/misspell
DLV := $(GOPATH)/bin/dlv

.PHONY: install
install: \
	go \
	goimports \
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
	cd /tmp; env GO111MODULE=on $(GO) get golang.org/x/tools/cmd/goimports

.PHONY: gopls
gopls: $(GOPLS)
$(GOPLS):
	cd /tmp && GO111MODULE=on $(GO) get golang.org/x/tools/gopls@latest

.PHONY: gotests
gotests: $(GOTESTS)
$(GOTESTS):
	GO111MODULE=off $(GO) get github.com/cweill/gotests/...

.PHONY: staticcheck
staticcheck: $(STATICCHECK)
$(STATICCHECK):
	cd /tmp; env GO111MODULE=on $(GO) get honnef.co/go/tools/cmd/staticcheck

.PHONY: gomodifytags
gomodifytags: $(GOMODIFYTAGS)
$(GOMODIFYTAGS):
	GO111MODULE=off $(GO) get github.com/fatih/gomodifytags

.PHONY: cobra
cobra: $(COBRA)
$(COBRA):
	GO111MODULE=off $(GO) get github.com/spf13/cobra/cobra

.PHONY: dlv
dlv: $(DLV)
$(DLV):
	GO111MODULE=off $(GO) get github.com/go-delve/delve/cmd/dlv

.PHONY: misspell
misspell: $(MISSPELL)
$(MISSPELL):
	GO111MODULE=off $(GO) get github.com/client9/misspell/cmd/misspell

.PHONY: hugo
hugo: $(HUGO)
$(HUGO):
	$(CURL) https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_extended_$(HUGO_VERSION)_Linux-64bit.tar.gz | tar xzf - -C $(HOME_BIN_DIR) hugo

.PHONY: ghq
ghq: $(GHQ)
$(GHQ):
	GO111MODULE=off $(GO) get github.com/x-motemen/ghq

.PHONY: clean
clean:
	sudo rm -rf $(GOROOT)
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

