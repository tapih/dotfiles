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
install: brew zsh asdf antigen tpm clean-links links

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

.PHONY: links
links:
	mkdir -p ${HOME}/.config
	[ -f $(ZSHRC) ]          || ln -s $(LINKS_DIR)/zshrc $(ZSHRC)
	[ -f $(ZSHRC_COMMANDS) ] || ln -s $(LINKS_DIR)/zshrc.commands $(ZSHRC_COMMANDS)
	[ -f $(INPUTRC) ]        || ln -s $(LINKS_DIR)/inputrc $(INPUTRC)
	[ -f $(GITCONFIG) ]      || ln -s $(LINKS_DIR)/gitconfig $(GITCONFIG)
	[ -f $(TMUX_CONF) ]      || ln -s $(LINKS_DIR)/tmux.conf $(TMUX_CONF)
	[ -f $(VIMRC)  ]         || ln -s $(LINKS_DIR)/config/nvim/init.vim $(VIMRC)
	[ -f $(IDEAVIMRC) ]      || ln -s $(LINKS_DIR)/ideavimrc $(IDEAVIMRC)
	[ -f $(STARSHIPRC) ]     || ln -s $(LINKS_DIR)/config/starship.toml $(STARSHIPRC)
	[ -d $(NVIMRC_DIR) ]     || ln -s $(LINKS_DIR)/config/nvim $(NVIMRC_DIR)

.PHONY: clean-links
clean-links:
	rm -f $(ZSHRC)
	rm -f $(ZSHRC_COMMANDS)
	rm -f $(INPUTRC)
	rm -f $(GITCONFIG)
	rm -f $(TMUX_CONF)
	rm -f $(VIMRC)
	rm -f $(IDEAVIMRC)
	rm -f $(STARSHIPRC)
	rm -rf $(NVIMRC_DIR)

