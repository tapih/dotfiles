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
		zlib
	brew install --cask font-fira-code
	# nodejs dependencies
	brew install gnupg
