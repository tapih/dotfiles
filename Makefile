CURL := curl -sSLf

.PHONY: install
install:
	sudo apt-get update
	sudo apt-get -y --no-install-recommends install \
		curl \
		htop \
		tree \
		jq \
		colordiff \
		xsel \
		openssl \
		gnupg \
		gnupg-agent \
		ca-certificates \
		build-essential \
		autotools-dev \
		automake \
		libevent-dev \
		xdg-utils \
		bison \
		flex \
		ncurses-dev \
		compiz-plugins \
		compiz-plugins-extra \
		compizconfig-settings-manager \
		libnotify-bin \
		libssl-dev \
		zlib1g-dev \
		libbz2-dev \
		libreadline-dev \
		libsqlite3-dev \
		libncurses5-dev \
		libncursesw5-dev \
		xz-utils \
		tk-dev \
		libffi-dev \
		liblzma-dev \
		libasound2 \
		apt-transport-https \
		firefox \
		vim

.PHONY: should-purge
should-purge:
	sudo apt-get -y purge \
		nano \
		ghostscript \
		unattended-upgrades \
		apport \
		apport-symptoms \
		fwupd \
		nano \
		netplan.io \
		popularity-contest \
		update-manager-core

