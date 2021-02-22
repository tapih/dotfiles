CURL := curl -sSfL

GO_VERSION := 1.15.7

GOROOT := /usr/local/go
GOPATH := $(HOME)/go

GO := $(GOROOT)/bin/go
GOIMPORTS := $(GOPATH)/bin/goimports
GOPLS := $(GOPATH)/bin/gopls
GOTESTS := $(GOPATH)/bin/gotests
GHQ := $(GOPATH)/bin/ghq
COBRA := $(GOPATH)/bin/cobra
STATICCHECK := $(GOPATH)/bin/staticcheck
DLV := $(GOPATH)/bin/dlv

.PHONY: install
install: \
	go \
	goimports \
	gopls \
	staticcheck \
	cobra \
	dlv \
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

.PHONY: staticcheck
staticcheck: $(STATICCHECK)
$(STATICCHECK):
	cd /tmp; env GO111MODULE=on $(GO) get honnef.co/go/tools/cmd/staticcheck

.PHONY: gotest
gotests: $(GOTESTS)
$(GOTESTS):
	GO111MODULE=off $(GO) get -u github.com/cweill/gotests/...

.PHONY: cobra
cobra: $(COBRA)
$(COBRA):
	GO111MODULE=off $(GO) get -u github.com/spf13/cobra/cobra

.PHONY: dlv
dlv: $(DLV)
$(DLV):
	GO111MODULE=off $(GO) get -u github.com/go-delve/delve/cmd/dlv

.PHONY: ghq
ghq: $(GHQ)
$(GHQ):
	GO111MODULE=off $(GO) get -u github.com/x-motemen/ghq

.PHONY: clean
clean:
	sudo rm -rf $(GOROOT)
	rm -f $(GOIMPORTS)
	rm -f $(GOPLSS)
	rm -f $(GHQ)
	rm -f $(COBRA)
	rm -f $(STATICCHECK)
	rm -f $(DLV)

