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
