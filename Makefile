##@ Targets
.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: all
all: setup purge install

.PHONY: setup
setup: ## setup
	mkdir -p ${HOME}/bin
	sudo apt-get update
	sudo apt-get -y --no-install-recommends install curl software-properties-common

.PHONY: install
install: ## install
	cd install && \
		$(MAKE) -f links.mk && \
		$(MAKE) -f tools.mk && \
		$(MAKE) -f go.mk && \
		$(MAKE) -f dart.mk && \
		$(MAKE) -f python.mk && \
		$(MAKE) -f rust.mk && \
		$(MAKE) -f cpp.mk && \
		$(MAKE) -f nvim.mk && \
		$(MAKE) -f docker.mk && \
		$(MAKE) -f cloud.mk && \
		$(MAKE) -f kubernetes.mk
	if uname -r | grep -i microsoft > /dev/null; then \
		cd install && $(MAKE) -f wsl.mk; \
	fi

.PHONY: purge
purge: ## purge
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
clean: ## clean
	while true; do \
		read -p "Do you wish to install this program? (y/n)" yn; \
		case $${yn} in \
			[Yy]* ) break;; \
			[Nn]* ) exit 1;; \
			* ) echo "Please answer yes or no.";; \
		esac; \
	done || exit 1
	cd install && \
		$(MAKE) -f links.mk clean && \
		$(MAKE) -f tools.mk clean && \
		$(MAKE) -f go.mk clean && \
		$(MAKE) -f dart.mk clean && \
		$(MAKE) -f python.mk clean && \
		$(MAKE) -f rust.mk clean && \
		$(MAKE) -f cpp.mk clean && \
		$(MAKE) -f nvim.mk nvim-clean && \
		$(MAKE) -f docker.mk clean && \
		$(MAKE) -f cloud.mk clean && \
		$(MAKE) -f kubernetes.mk clean
	if uname -r | grep -i microsoft > /dev/null; then \
		cd install && $(MAKE) -f wsl.mk clean; \
	fi

