CURL := curl -sSfL

ASDF_VERSION := 0.8.0

BREW_DIR ?=
BREW := $(BREW_DIR)/bin/brew
ZSH := $(BREW_DIR)/bin/zsh
ASDF_DIR := ${HOME}/.asdf
ASDF := $(ASDF_DIR)/asdf.sh
ANTIGEN := ${HOME}/.antigen.zsh
TPM := ${HOME}/.tmux/plugins/tpm

.PHONY: install
install: brew zsh asdf antigen tpm

.PHONY: brew
brew: $(BREW)
$(BREW):
	bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	$@ update

.PHONY: zsh
zsh: $(ZSH)
$(ZSH): $(BREW)
	$(BREW) install zsh
	echo "$(ZSH)" | sudo tee -a /etc/shells
	chsh -s $(ZSH)

.PHONY: asdf
asdf: $(ASDF)
$(ASDF):
	git clone https://github.com/asdf-vm/asdf.git $(ASDF_DIR) --branch v$(ASDF_VERSION)

.PHONY: antigen
antigen: $(ANTIGEN)
$(ANTIGEN):
	$(CURL) git.io/antigen > $@

.PHONY: tpm
tpm: $(TPM)
$(TPM):
	mkdir -p $(HOME)/.tmux
	git clone https://github.com/tmux-plugins/tpm $@

