CURL := curl -sSfL

HOME_BIN_DIR := $(HOME)/bin
DOCKER := /usr/bin/docker
DOCKER_COMPOSE := $(HOME_BIN_DIR)/docker-compose

DOCKER_PACKAGES := \
	docker-ce \
	docker-ce-cli \
	software-properties-common \
	containerd.io

.PHONY: install
install: \
	docker \
	docker-compose

.PHONY: docker
docker: $(DOCKER)
$(DOCKER):
	sudo apt-get purge -y docker docker.io containerd runc
	sudo sh -c "${CURL} https://download.docker.com/linux/ubuntu/gpg | apt-key add -"
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
	sudo apt-get update
	sudo apt-get -y --no-install-recommends install $(DOCKER_PACKAGES)
	sudo groupadd docker
	sudo usermod -aG docker $${USER}

.PHONY: docker-compose
docker-compose: $(DOCKER_COMPOSE)
$(DOCKER_COMPOSE):
	sudo $(CURL) https://github.com/docker/compose/releases/download/$(DOCKER_COMPOSE_VERSION)/docker-compose-$$(uname -s)-$$(uname -m) -o $@
	sudo chmod +x $@

.PHONY: clean
clean:
	sudo apt-get purge -y $(DOCKER_PACKAGES
	rm -f $(DOCKER_COMPOSE)
