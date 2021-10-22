CURL := curl -sSfL

GENIE_VERSION := 1.34

GENIE := /usr/bin/genie
WSL_OPEN := /usr/local/bin/xdg-open
WINDOWS_USER ?= tapih
WINDOWS_DIR := ${HOME}/windows
LINKS_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))/../links


.PHONY: link
link:
	[ -L $(WINDOWS_DIR) ] || ln -s /mnt/c/Users/$(WINDOWS_USER) $(WINDOWS_DIR)

curl -sSLf https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -o /tmp/packages-microsoft-prod.deb
sudo dpkg -i /tmp/packages-microsoft-prod.deb
sudo apt-get update && \
sudo apt-get install -y --no-install-recommends \
	apt-transport-https \
	dotnet-sdk-5.0 \
	daemonize \
	systemd-container \
	x11-apps \
	x11-utils \
	x11-xserver-utils \
	dbus-x11 \
curl -sSLf -o /tmp/download.deb https://github.com/arkane-systems/genie/releases/download/${GENIE_VERSION}/systemd-genie_${GENIE_VERSION}_amd64.deb
sudo dpkg -i /tmp/download.deb || true
sudo apt-get --fix-broken install
sudo dpkg -i /tmp/download.deb

.PHONY: wsl-open
wsl-open: $(WSL_OPEN)
$(WSL_OPEN):
	sudo curl -o $@ https://raw.githubusercontent.com/4U6U57/wsl-open/master/wsl-open.sh
	sudo chmod 755 $@
