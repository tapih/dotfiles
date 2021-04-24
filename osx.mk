.PHONY: all
all: setup install

.PHONY: setup
setup:
	brew install \
		# python dependencies
		openssl \
		readline \
		sqlite3 \
		xz \
		zlib

.PHONY: install
install:
	$(MAKE) -f install/links.mk
	$(MAKE) -f install/brew.mk
	$(MAKE) -f install/langs.mk
	$(MAKE) -f install/gotools.mk

.PHONY: clean
clean:
	$(MAKE) -f install/links.mk clean
	$(MAKE) -f install/brew.mk clean
	$(MAKE) -f install/langs.mk clean
	$(MAKE) -f install/gotools.mk clean
