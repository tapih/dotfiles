CURL := curl -sSfL

DOCKER_VERSION := 20.10.3~3-0
CONTAINERD_VERSION := 1.4.3-1

CONTAINERD := /usr/bin/containerd
DOCKER := /usr/bin/docker
DOCKERD := /usr/bin/dockerd

.PHONY: containerd
containerd: $(CONTAINERD)
$(CONTAINERD):
	sudo apt-get purge -y containerd runc
	$(CURL) -o /tmp/containerd.deb https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/containerd.io_$(CONTAINERD_VERSION)_amd64.deb
	sudo dpkg -i /tmp/containerd.deb

.PHONY: docker-cli
docker-cli: $(DOCKER)
$(DOCKER):
	sudo apt-get purge -y docker docker.io
	$(CURL) -o /tmp/docker-ce-cli.deb https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce-cli_$(DOCKER_VERSION)~ubuntu-focal_amd64.deb
	sudo dpkg -i /tmp/docker-ce-cli.deb

.PHONY: docker
docker: $(DOCKERD)
$(DOCKERD): $(CONTAINERD) $(DOCKER)
	sudo apt-get purge -y docker-engine
	sudo apt-get install -y --no-install-recommends \
		curl \
		software-properties-common \
		ca-certificates \
		gnupg-agent \
		apt-transport-https
	$(CURL) -o /tmp/docker-ce.deb https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce_$(DOCKER_VERSION)~ubuntu-focal_amd64.deb
	sudo dpkg -i /tmp/docker-ce.deb
	if ! grep -q docker /etc/group; then \
		sudo groupadd docker; \
	fi
	sudo usermod -aG docker $${USER}; \

