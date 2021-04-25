CURL := curl -sSfL
DOCKER := /usr/bin/docker

.PHONY: all
all: purge-defaults docker apt

.PHONY: apt
apt:
	sudo apt-get update --fix-missing
	sudo apt-get -y --no-install-recommends install \
		curl \
		openssl \
		gnupg \
		apt-transport-https \
		ca-certificates \
		software-properties-common \
		build-essential
	# brew dependency
	sudo apt-get -y --no-install-recommends install procps
	# python dependencies from
	sudo apt-get -y --no-install-recommends install \
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

.PHONY: purge-defaults
purge-defaults:
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

.PHONY: docker
docker: $(DOCKER)
$(DOCKER):
	$(CURL) https://get.docker.com -o /tmp/get-docker.sh
	sudo sh /tmp/get-docker.sh
	if ! grep -q docker /etc/group; then \
		sudo groupadd docker; \
	fi
	sudo usermod -aG docker $${USER}

