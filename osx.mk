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
	$(MAKE) -f install/tools.mk
	$(MAKE) -f install/go.mk
	$(MAKE) -f install/python.mk
	$(MAKE) -f install/dart.mk

.PHONY: clean
clean:
	$(MAKE) -f install/links.mk clean
	$(MAKE) -f install/tools.mk clean
	$(MAKE) -f install/go.mk clean
	$(MAKE) -f install/python.mk clean
	$(MAKE) -f install/dart.mk clean
	if uname -r | grep -i microsoft > /dev/null; then \
		$(MAKE) -f install/wsl.mk clean; \
	fi

