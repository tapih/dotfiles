.PHONY: install
install:
	# flutter dependencies
	sudo gem install cocoapods
	# python dependencies
	brew tap fishtown-analytics/dbt
	brew update
	brew install \
		openssl \
		readline \
		sqlite3 \
		xz \
		zlib \
		gnu-sed \
		reattach-to-user-namespace
	brew install --cask font-hack-nerd-font
	# nodejs dependencies
	brew install gnupg
