CURL := curl -sSfL

BREW ?= /home/linuxbrew/.linuxbrew/bin/brew
TPM := ${HOME}/.tmux/plugins/tpm
ANTIGEN := ${HOME}/.antigen.zsh

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
	kind \
	kustomize \
	helm \
	skaffold \
	stern \
	k9s \
	krew \
	terraform \
	hugo \
	colordiff

.PHONY: all
all: \
	setup \
	install \
	tpm

.PHONY: setup
setup:
	bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

.PHONY: install
install:
	$(BREW) update
	$(BREW) install $(PACKAGES)

.PHONY: tpm
tpm: $(TPM)
$(TPM):
	mkdir -p $(HOME)/.tmux
	git clone https://github.com/tmux-plugins/tpm $@

.PHONY: antigen
antigen: $(ANTIGEN)
$(ANTIGEN):
	$(CURL) git.io/antigen > $@

.PHONY: clean
clean:
	$(BREW) uninstall $(PACKAGES)
	rm -rf $(TPM)

