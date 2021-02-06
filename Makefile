.PHONY: all
all: setup purge install

.PHONY: setup
setup:
	sudo apt-get update
	sudo apt-get -y --no-install-recommends install curl

.PHONY: install
install:
	cd install && \
		$(MAKE) -f links.mk && \
		$(MAKE) -f tools.mk && \
		$(MAKE) -f go.mk && \
		$(MAKE) -f dart.mk && \
		$(MAKE) -f python.mk && \
		$(MAKE) -f nvim.mk && \
		$(MAKE) -f docker.mk && \
		$(MAKE) -f kubernetes.mk
	if uname -r | grep -i microsoft > /dev/null; then \
		cd install && $(MAKE) -f wsl.mk; \
	fi

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

