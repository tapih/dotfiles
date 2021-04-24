CURL := curl -sSfL

NODE_VERSION := 14.16.0

PACKAGES := \
	ghq \
	gh \
	fd \
	rg \
	bat \
	fzf \
	delta \
	starship \
	neovim \
	tmux \
	git \
	tig \
	lazygit \
	lazydocker \
	unzip \
	jq \
	yq \
	tree \
	htop \
	yarn \
	kubectl \
	kind \
	kustomize \
	helm \
	skaffold \
	stern \
	k9s \
	krew \
	terraform \
	colordiff \
	openssl \
	gnupg

HOME_BIN_DIR := ${HOME}/bin
ANTIGEN := ${HOME}/.antigen.zsh
TMUX_PLUGINS_DIR := ${HOME}/.tmux/plugins/tpm

.PHONY: install
install: \
	packages \
	tmuxplugins \
	node

.PHONY: packages
packages:
	brew install $(PACKAGES)

.PHONY: antigen
antigen: $(ANTIGEN)
$(ANTIGEN):
	curl -L git.io/antigen > $@

.PHONY: node
node: $(NODE)
$(NODE):
	brew install n
	sudo n $(NODE_VERSION)

.PHONY: gcloud
gcloud: $(GCLOUD)
$(GCLOUD):
	echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
	$(CURL) https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
	sudo apt-get update && \
		sudo apt-get install -y --no-install-recommends google-cloud-sdk

.PHONY: tmuxplugins
tmuxplugins: $(TMUX_PLUGINS_DIR)
$(TMUX_PLUGINS_DIR):
	mkdir -p $(HOME)/.tmux
	git clone https://github.com/tmux-plugins/tpm $@

.PHONY: clean
clean:
	brew uninstall $(PACKAGES)
	rm -rf $(TMUX_PLUGIN_DIR)
	sudo rm -rf $(NODE)
