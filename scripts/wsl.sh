#! /bin/sh

curl -sSLf https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -o /tmp/packages-microsoft-prod.deb
sudo dpkg -i /tmp/packages-microsoft-prod.deb

sudo apt-get update
sudo apt-get install -y --no-install-recommends \
	apt-transport-https \
	dotnet-sdk-5.0 \
	daemonize \
	systemd-container \
	x11-apps \
	x11-utils \
	x11-xserver-utils \
	dbus-x11

curl -sSLf -o /tmp/download.deb https://github.com/arkane-systems/genie/releases/download/v1.43/systemd-genie_1.43_amd64.deb
sudo dpkg -i /tmp/download.deb || true
sudo apt-get --fix-broken install
sudo dpkg -i /tmp/download.deb

sudo curl -o /usr/local/bin/wsl-open https://raw.githubusercontent.com/4U6U57/wsl-open/master/wsl-open.sh
sudo chmod +x /usr/local/bin/wsl-open
