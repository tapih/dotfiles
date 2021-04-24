.PHONY: all
all: setup purge install

.PHONY: setup
setup:
	sudo apt-get update --fix-missing
	sudo apt-get -y --no-install-recommends install \
		curl \
		ca-certificates \
		software-properties-common \
		build-essential \
		# brew dependencies
		procps
		# python dependencies
		libssl-dev \
		zlib1g-dev \
		libbz2-dev \
		libreadline-dev \
		libsqlite3-dev \
		wget \
		llvm \
		libncurses5-dev \
		xz-utils \
		tk-dev \
		libxml2-dev \
		libxmlsec1-dev \
		libffi-dev \
		liblzma-dev

.PHONY: purge
purge:
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

.PHONY: install
install:
	# install with brew because it contains git completion out of the box
	brew install zsh
	echo "/home/linuxbrew/.linuxbrew/bin/zsh" | sudo tee -a /etc/shells
	$(MAKE) -f install/links.mk
	$(MAKE) -f install/brew.mk
	$(MAKE) -f install/go.mk
	$(MAKE) -f install/python.mk
	$(MAKE) -f install/dart.mk
	$(MAKE) -f install/docker.mk
	if uname -r | grep -i microsoft > /dev/null; then \
		cd install && $(MAKE) -f wsl.mk; \
	fi

.PHONY: clean
clean:
	$(MAKE) -f install/links.mk clean
	$(MAKE) -f install/brew.mk clean
	$(MAKE) -f install/go.mk clean
	$(MAKE) -f install/python.mk clean
	$(MAKE) -f install/dart.mk clean
	if uname -r | grep -i microsoft > /dev/null; then \
		$(MAKE) -f install/wsl.mk clean; \
	fi

