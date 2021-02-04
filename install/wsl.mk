CURL := curl -sSfL

.PHONY: install
install: genie

.PHONY: genie
genie:
	if uname -r | grep -i microsoft > /dev/null; then \
		$(CURL) https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -o /tmp/packages-microsoft-prod.deb; \
		sudo dpkg -i /tmp/packages-microsoft-prod.deb; \
		sudo apt-get update && \
			sudo apt-get install -y apt-transport-https dotnet-sdk-5.0 daemonize systemd-container; \
		$(CURL) -o /tmp/download.deb https://github.com/arkane-systems/genie/releases/download/1.34/systemd-genie_1.34_amd64.deb; \
		sudo dpkg -i /tmp/download.deb; \
	fi

.PHONY: apt-get
apt-get:
	if uname -r | grep -i microsoft > /dev/null; then \
		sudo apt-get -y --no-install-recommends install \
			vim-gnome \
			x11-apps \
			x11-utils \
			x11-xserver-utils \
			dbus-x11; \
	fi

.PHONY: clean
clean:
	echo TODO
