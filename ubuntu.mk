DOCKER := /usr/bin/docker
GCLOUD := /usr/bin/gcloud

.PHONY: all
all: setup purge docker gcloud install 
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

.PHONY: docker
docker: $(DOCKER)
$(DOCKER):
	$(CURL) https://get.docker.com -o /tmp/get-docker.sh
	sudo sh /tmp/get-docker.sh
	if ! grep -q docker /etc/group; then \
		sudo groupadd docker; \
	fi
	sudo usermod -aG docker $${USER}

.PHONY: gcloud
gcloud: $(GCLOUD)
$(GCLOUD):
	echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
	$(CURL) https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
	sudo apt-get update
	sudo apt-get install -y --no-install-recommends google-cloud-sdk

.PHONY: install
install:
	$(MAKE) -f install/links.mk
	$(MAKE) -f install/brew.mk
	$(MAKE) -f install/asdf.mk
	if uname -r | grep -i microsoft > /dev/null; then \
		cd install && $(MAKE) -f wsl.mk; \
	fi

.PHONY: clean
clean:
	$(MAKE) -f install/links.mk clean
	$(MAKE) -f install/brew.mk clean
	$(MAKE) -f install/asdf.mk clean
	if uname -r | grep -i microsoft > /dev/null; then \
		$(MAKE) -f install/wsl.mk clean; \
	fi

