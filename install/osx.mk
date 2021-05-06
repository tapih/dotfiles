.PHONY: install
install:
	# python dependencies
	brew update
	brew install \
		openssl \
		readline \
		sqlite3 \
		xz \
		zlib
	# nodejs dependencies
	brew install gnupg
