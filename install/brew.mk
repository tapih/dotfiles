CURL := curl -sSfL

ifeq ($(IS_UBUNTU), true)
BREW := /home/linuxbrew/.linuxbrew/bin/brew
else
BREW := /usr/local/bin/brew
endif
TPM := ${HOME}/.tmux/plugins/tpm

PACKAGES := \
	cask \
	zsh \
	antigen
	asdf \
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
	colordiff \
	openssl \
	gnupg

.PHONY: install
install: \
	setup \
	install \
	tpm

.PHONY: setup
setup:
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

.PHONY: install
install:
	$(BREW) update
	$(BREW) install $(PACKAGES)

.PHONY: tpm
tpm: $(TPM)
$(TPM):
	mkdir -p $(HOME)/.tmux
	git clone https://github.com/tmux-plugins/tpm $@

.PHONY: clean
clean:
	brew uninstall $(PACKAGES)
	rm -rf $(TPM)

