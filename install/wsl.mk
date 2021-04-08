CURL := curl -sSfL

GENIE_VERSION := 1.34

GENIE := /usr/bin/genie
WSL_OPEN := /usr/local/bin/xdg-open
WINDOWS_DIR := ${HOME}/windows

WINDOWS_USER ?= tapih

PACKAGES := \
	apt-transport-https \
	dotnet-sdk-5.0 \
	daemonize \
	systemd-container \
	x11-apps \
	x11-utils \
	x11-xserver-utils \
	dbus-x11

.PHONY: install
install: link genie wsl-open

.PHONY: link
link: ${WINDOWS_DIR}
${WINDOWS_DIR}:
	ln -s /mnt/c/Users/$(WINDOWS_USER) ${HOME}/windows

.PHONY: genie
genie: $(GENIE)
$(GENIE):
	$(CURL) https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -o /tmp/packages-microsoft-prod.deb
	sudo dpkg -i /tmp/packages-microsoft-prod.deb
	sudo apt-get update && \
		sudo apt-get install -y --no-install-recommends $(PACKAGES)
	$(CURL) -o /tmp/download.deb https://github.com/arkane-systems/genie/releases/download/$(GENIE_VERSION)/systemd-genie_$(GENIE_VERSION)_amd64.deb
	sudo dpkg -i /tmp/download.deb || true
	sudo apt-get --fix-broken install
	sudo dpkg -i /tmp/download.deb

.PHONY: wsl-open
wsl-open: $(WSL_OPEN)
$(WSL_OPEN):
	sudo mv /usr/bin/xdg-open /usr/bin/xdg-open-bkup
	sudo npm -g i wsl-open
	sudo ln -s $(wsl-open) $@

.PHONY: clean
clean:
	sudo apt-get purge -y $(PACKAGES)
	sudo dpkg -P systemd-genie
