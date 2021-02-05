.PHONY: all
all: should-purge install

.PHONY: install
install:
	sudo apt-get update
	sudo apt-get -y --no-install-recommends install \
		curl \
		htop \
		tree \
		jq \
		colordiff \
		vim
		firefox \
		xsel \
		openssl \
		gnupg \
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
		libasound2
	$(MAKE) -f install/links.mk
	$(MAKE) -f install/tools.mk
	$(MAKE) -f install/go.mk
	$(MAKE) -f install/dart.mk
	$(MAKE) -f install/python.mk
	$(MAKE) -f install/nvim.mk
	$(MAKE) -f install/docker.mk
	$(MAKE) -f install/kubernetes.mk
	if uname -r | grep -i microsoft > /dev/null; then \
		$(MAKE) -f install/wsl.mk; \
	fi

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

