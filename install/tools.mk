CURL := curl -sSfL

NODE_VERSION := 14.16.0

PACKAGES := \
	gh \
	fd \
	rg \
	bat \
	fzf \
	delta \
	starship \
	git \
	tig \
	lazygit \
	unzip \
	tmux \
	jq \
	tree \
	htop \
	yarn \
	terraform \
	colordiff \
	openssl \
	gnupg

HOME_BIN_DIR := ${HOME}/bin
TMUX_PLUGINS_DIR := ${HOME}/.tmux/plugins/tpm
GIT_OPEN := /usr/local/bin/git-open
GIT_COMPLETION_BASH := ${HOME}/.zsh/.git-completion.bash
GIT_COMPLETION_ZSH := ${HOME}/.zsh/_git
ZSH_AUTO_SUGGESTIONS_DIR := ${HOME}/.zsh/zsh-autosuggestions

.PHONY: install
install: \
	packages \
	tmuxplugins \
	node \
	completion

.PHONY: packages
packages:
	brew install $(PACKAGES)

.PHONY: tmuxplugins
tmuxplugins: $(TMUX_PLUGINS_DIR)
$(TMUX_PLUGINS_DIR):
	mkdir -p $(HOME)/.tmux
	git clone https://github.com/tmux-plugins/tpm $@

.PHONY: completion
completion: \
	git-completion-bash \
	git-completion-zsh \
	git-prompt \
	auto-suggestion

.PHONY: git-completion-bash
git-completion-bash: $(GIT_COMPLETION_BASH)
$(GIT_COMPLETION_BASH):
	$(CURL) -o $@ https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

.PHONY: git-completion-zsh
git-completion-zsh: $(GIT_COMPLETION_ZSH)
$(GIT_COMPLETION_ZSH):
	$(CURL) -o $@ https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

.PHONY: auto-suggestion
auto-suggestion: $(ZSH_AUTO_SUGGESTIONS_DIR)
$(ZSH_AUTO_SUGGESTIONS_DIR):
	mkdir ${HOME}/.zsh
	git clone https://github.com/zsh-users/zsh-autosuggestions $@

.PHONY: node
node: $(NODE)
$(NODE):
	brew install n
	sudo n $(NODE_VERSION)

.PHONY: git-open
git-open: $(GIT_OPEN)
$(GIT_OPEN): $(NODE)
	sudo npm -g i git-open

.PHONY: clean
clean:
	brew uninstall $(PACKAGES)
	rm -rf $(TMUX_PLUGIN_DIR)
	rm -f $(GIT_COMPLETION_ZSH)
	rm -f $(GIT_COMPLETION_BASH)
	sudo rm -rf $(NODE)
