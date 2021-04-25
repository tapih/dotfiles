.PHONY: install
install:
	xcode-select --install
	# python dependencies
	brew install \
		openssl \
		readline \
		sqlite3 \
		xz \
		zlib
	brew install --cask \
		slack \
		google-chrome \
		android-studio \
		notion \
		iterm2
