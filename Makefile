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
		$(MAKE) -f cpp.mk && \
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

.PHONY: clean
clean:
	cd install && \
		$(MAKE) -f links.mk clean && \
		$(MAKE) -f tools.mk clean && \
		$(MAKE) -f go.mk clean && \
		$(MAKE) -f dart.mk clean && \
		$(MAKE) -f python.mk clean && \
		$(MAKE) -f cpp.mk clean && \
		$(MAKE) -f nvim.mk clean && \
		$(MAKE) -f docker.mk clean && \
		$(MAKE) -f kubernetes.mk clean
	if uname -r | grep -i microsoft > /dev/null; then \
		cd install && $(MAKE) -f wsl.mk clean; \
	fi

