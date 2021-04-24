CURL := curl -sSfL

TERRAFORM_VERSION := 0.13.3

HOME_BIN_DIR := ${HOME}/bin
GCLOUD := /usr/bin/gcloud
AWS := /usr/bin/aws

.PHONY: install
install: \
	gcloud \
	aws \
	terraform

.PHONY: gcloud
gcloud: $(GCLOUD)
$(GCLOUD):
	echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
	$(CURL) https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
	sudo apt-get update && \
		sudo apt-get install -y --no-install-recommends google-cloud-sdk

.PHONY: aws
aws: $(AWS)
$(AWS):
	sudo apt-get install -y --no-install-recommends awscli

.PHONY: clean
clean:
	sudo apt-get purge -y google-cloud-sdk awscli
