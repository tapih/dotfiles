CURL := curl -sSfL

PYTHON_VERSION := 3.7.3

PYENV := $(PYENV_DIR)/bin/pyenv
PYENV_DIR := ${HOME}/.pyenv
PYENV_VIRTUALENV_DIR := $(PYENV_DIR)/plugins/pyenv-virtualenv
python_DIR := $(PYENV_DIR)/versions/$(PYTHON_VERSION)
NVIM_DIR := $(PYENV_DIR)/versions/neovim

.PHONY: install
install: \
	pyenv \
	python \
	virtualenv \
	pynvim

.PHONY: pyenv
pyenv: $(PYENV_DIR)
$(PYENV_DIR):
	brew install pyenv

.PHONY: python
python: $(python_DIR)
$(python_DIR): $(PYENV_DIR)
	$(PYENV) install -s $(PYTHON_VERSION)
	$(PYENV) rehash

.PHONY: virtualenv
virtualenv: $(PYENV_VIRTUALENV_DIR)
$(PYENV_VIRTUALENV_DIR): $(PYENV_DIR)
	# The timestamp of pyenv is updated newer than virtualenv
	if [ ! -d $(PYENV_VIRTUALENV_DIR) ]; then \
		git clone https://github.com/pyenv/pyenv-virtualenv.git $@; \
	fi

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

.PHONY: clean
clean:
	rm -rf $(PYENV_DIR)
	rm -rf $(PYENV_VIRTUALENV_DIR)
	rm -rf $(NVIM_DIR)
	brew uninstall pyenv
