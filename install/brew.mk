CURL := curl -sSfL

NODE_VERSION := 14.16.0

HOME_BIN_DIR := ${HOME}/bin
ZSH := /home/linuxbrew/.linuxbrew/bin/zsh
BREW := /home/linuxbrew/.linuxbrew/bin/brew
TMUX_PLUGINS_DIR := ${HOME}/.tmux/plugins/tpm

PACKAGES := \
	zsh \
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
	hugo \
	colordiff \
	openssl \
	gnupg

.PHONY: install
install: \
	setup \
	packages \
	tmuxplugins \
	node

.PHONY: brew
brew: $(BREW)
$(BREW):
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	$@ update
	$@ install cask

.PHONY: packages
packages: $(BREW)
	$(BREW) install $(PACKAGES)

.PHONY: zsh
zsh: $(BREW) $(ZSH)
$(ZSH):
	$(BREW) install zsh antigen
	echo "$@" | sudo tee -a /etc/shells
	chsh -s $@

.PHONY: node
node: $(NODE)
$(NODE):
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
