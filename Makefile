##@ Targets
.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: all
all: setup purge install

.PHONY: setup
setup: ## setup
	mkdir -p ${HOME}/bin
	if [ $$(lsb_release -d -s | cut -d' ' -f1) = "Ubuntu" ]; then \
		$(MAKE) ubuntu; \
	fi
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew update
	brew install cask

.PHONY: ubuntu
ubuntu:
	sudo apt-get update --fix-missing
	sudo apt-get -y --no-install-recommends install \
		curl \
		ca-certificates \
		software-properties-common \
		build-essential \
		procps
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
	# install with brew because it contains git completion out of the box
	brew install zsh
	echo "/home/linuxbrew/.linuxbrew/bin/zsh" | sudo tee -a /etc/shells

.PHONY: install
install: ## install
	cd install && \
		$(MAKE) -f links.mk && \
		$(MAKE) -f tools.mk && \
		$(MAKE) -f go.mk && \
		$(MAKE) -f dart.mk && \
	if [ $$(lsb_release -d -s | cut -d' ' -f1) = "Ubuntu" ]; then \
		$(MAKE) -f docker.mk; \
	fi
	if uname -r | grep -i microsoft > /dev/null; then \
		cd install && $(MAKE) -f wsl.mk; \
	fi

.PHONY: clean
clean: ## clean
	while true; do \
		read -p "Do you wish to uninstall these program? (y/n)" yn; \
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
	if [ $$(lsb_release -d -s | cut -d' ' -f1) = "Ubuntu" ]; then \
		$(MAKE) -f docker.mk clean; \
	fi
	if uname -r | grep -i microsoft > /dev/null; then \
		cd install && $(MAKE) -f wsl.mk clean; \
	fi

