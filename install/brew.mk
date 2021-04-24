CURL := curl -sSfL

HOME_BIN_DIR := ${HOME}/bin
ZSH := /home/linuxbrew/.linuxbrew/bin/zsh
TPM := ${HOME}/.tmux/plugins/tpm

PACKAGES := \
	cask \
	zsh \
	antigen \
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
	tpm \
	node

.PHONY: setup
setup:
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	if ! grep -q $(ZSH) > /dev/null; then \
		echo "$(ZSH)" | sudo tee -a /etc/shells; \
	if
	chsh -s $(ZSH)

.PHONY: packages
packages:
	$(BREW) update
	$(BREW) install $(PACKAGES)

.PHONY: gcloud
gcloud: $(GCLOUD)
$(GCLOUD):
	echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
	$(CURL) https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
	sudo apt-get update && \
		sudo apt-get install -y --no-install-recommends google-cloud-sdk

.PHONY: tpm
tpm: $(TPM)
$(TPM):
	mkdir -p $(HOME)/.tmux
	git clone https://github.com/tmux-plugins/tpm $@

.PHONY: clean
clean:
	brew uninstall $(PACKAGES)
	brew uninstall zsh
	rm -rf $(TMUX_PLUGIN_DIR)

