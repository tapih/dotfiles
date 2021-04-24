CURL := curl -sSfL

BREW_PREFIX := /home/linuxbrew/.linuxbrew
BREW := $(BREW_PREFIX)/bin/brew
ZSH := $(BREW_PREFIX)/bin/zsh
TPM := ${HOME}/.tmux/plugins/tpm

PACKAGES := \
	cask \
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
	brew \
	packages \
	zsh \
	tpm

.PHONY: brew
brew: $(BREW)
$(BREW):
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

.PHONY: packages
packages: $(BREW)
	$(BREW) update
	$(BREW) install $(PACKAGES)

.PHONY: zsh
zsh: $(ZSH)
$(ZSH): $(BREW)
	$(BREW) install zsh
	if ! grep -q $(ZSH) > /dev/null; then \
		echo "$(ZSH)" | sudo tee -a /etc/shells; \
	if
	chsh -s $(ZSH)

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

