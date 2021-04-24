CURL := curl -sSfL

GO_VERSION := 1.16.1
FLUTTER_VERSION := 2.0.4
PYTHON_VERSION := 3.7.3
NODE_VERSION := 14.16.0

GOROOT := /usr/local/go
GO := ${GOROOT}/bin/go
FLUTTER_DIR := ${HOME}/dart/src/flutter
PYENV_DIR := ${HOME}/.pyenv
PYENV := $(PYENV_DIR)/bin/pyenv
PYENV_VIRTUALENV_DIR := $(PYENV_DIR)/plugins/pyenv-virtualenv
python_DIR := $(PYENV_DIR)/versions/$(PYTHON_VERSION)
NVIM_DIR := $(PYENV_DIR)/versions/neovim


.PHONY: install
install: \
	go \
	flutter \
	python \
	node

.PHONY: go
go: $(GO)
$(GO):
	sudo mkdir -p ${GOROOT}
	sudo sh -c "$(CURL) https://dl.google.com/go/go$(GO_VERSION).linux-amd64.tar.gz | tar xz -C ${GOROOT} --strip-components=1"
	mkdir -p ${GOPATH}/src
	mkdir -p ${GOPATH}/bin
	mkdir -p ${GOPATH}/pkg

.PHONY: flutter
flutter: $(FLUTTER_DIR)
$(FLUTTER_DIR):
	mkdir -p $@
	$(CURL) https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_$(FLUTTER_VERSION)-stable.tar.xz | tar Jxf - -C $@ --strip-components=1

.PHONY: python
python: \
	pyenv \
	virtualenv \
	_python \
	pynvim

.PHONY: pyenv
pyenv: $(PYENV_DIR)
$(PYENV_DIR):
	git clone https://github.com/pyenv/pyenv.git $@

.PHONY: virtualenv
virtualenv: $(PYENV_VIRTUALENV_DIR)
$(PYENV_VIRTUALENV_DIR): $(PYENV_DIR)
	# The timestamp of pyenv is updated with a timestamp newer than virtualenv
	if [ ! -d $(PYENV_VIRTUALENV_DIR) ]; then \
		git clone https://github.com/pyenv/pyenv-virtualenv.git $@; \
	fi

.PHONY: _python
_python: $(PYTHON_DIR)
$(PYTHON_DIR): $(PYENV_DIR)
	$(PYENV) install -s $(PYTHON_VERSION)
	$(PYENV) rehash

.PHONY: pynvim
pynvim: $(NVIM_DIR)
$(NVIM_DIR): $(PYENV_VIRTUALENV_DIR) $(python_DIR)
	$(PYENV) virtualenv $(PYTHON_VERSION) neovim
	CURRENT=$($(PYENV) global) && \
			$(PYENV) global neovim && \
			$(NVIM_DIR)/bin/pip install -U pip && \
			$(NVIM_DIR)/bin/pip install pynvim && \
			$(NVIM_DIR)/bin/pip install neovim-remote && \
			$(PYENV) global $${CURRENT}

.PHONY: node
node: $(NODE)
$(NODE):
	brew install n
	sudo n $(NODE_VERSION)

.PHONY: clean
clean:
	rm -rf $(GOROOT)
	rm -rf $(FLUTTER_DIR)
	rm -rf $(PYENV_DIR)
	brew uninstall pyenv
