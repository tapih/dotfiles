CURL := curl -sSfL

PYTHON2_VERSION := 2.7.16
PYTHON3_VERSION := 3.7.3

PYENV_DIR=$(HOME)/.pyenv
PYENV := $(PYENV_DIR)/bin/pyenv
PYTHON2_DIR := $(PYENV_DIR)/versions/$(PYTHON2_VERSION)
PYTHON3_DIR := $(PYENV_DIR)/versions/$(PYTHON3_VERSION)

.PHONY: install
install: \
	pyenv \
	python2 \
	python3

.PHONY: pyenv
pyenv: $(PYENV_DIR)
$(PYENV_DIR):
	git clone https://github.com/pyenv/pyenv.git $@
	eval "$$($(PYENV) init -)"

.PHONY: python2
python2: $(PYTHON2_DIR)
$(PYTHON2_DIR): $(PYENV_DIR)
	$(PYENV) install -s $(PYTHON2_VERSION)
	$(PYENV) rehash

.PHONY: python3
python3: $(PYTHON3_DIR)
$(PYTHON3_DIR): $(PYENV_DIR)
	$(PYENV) install -s $(PYTHON3_VERSION)
	$(PYENV) rehash

.PHONY: clean
clean:
	rm -rf $(PYENV_DIR)
