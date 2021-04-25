BREW := /usr/local/bin/brew

.PHONY: all
all: setup install

.PHONY: setup
setup:
	xcode-select --install
	brew install \
		# python dependencies
		openssl \
		readline \
		sqlite3 \
		xz \
		zlib
	brew install --cask \
		slack \
		google-chrome \
		android-studio \
		notion

.PHONY: install
install:
	$(MAKE) -f install/links.mk
	$(MAKE) -f install/brew.mk BREW=$(BREW)
	$(MAKE) -f install/asdf.mk

.PHONY: clean
clean:
	$(MAKE) -f install/links.mk clean
	$(MAKE) -f install/brew.mk clean
	$(MAKE) -f install/asdf.mk clean
