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
	$(MAKE) -f install/go.mk
	$(MAKE) -f install/python.mk
	$(MAKE) -f install/dart.mk

.PHONY: clean
clean:
	$(MAKE) -f install/links.mk clean
	$(MAKE) -f install/brew.mk clean
	$(MAKE) -f install/go.mk clean
	$(MAKE) -f install/python.mk clean
	$(MAKE) -f install/dart.mk clean
