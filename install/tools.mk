CURL := curl -sSfL

TMUX_VERSION := 2.9
HUB_VERSION := 2.12.8
FD_VERSION := 8.1.0
DELTA_VERSION := 0.6.0
RG_VERSION := 12.1.1
NODE_VERSION := 14.16.0

PACKAGES := \
	unzip \
	tig \
	tmux \
	jq \
	tree \
	htop \
	colordiff \
	xsel \
	openssl \
	gnupg \
	ca-certificates \
	build-essential

HOME_BIN_DIR := $(HOME)/bin
JQ := /usr/bin/jq
TMUX := $(HOME_BIN_DIR)/tmux
TMUX_PLUGINS_DIR := $(HOME)/.tmux/plugins/tpm
LAZYGIT := /usr/bin/lazygit
GH := /usr/bin/gh
FD := $(HOME_BIN_DIR)/fd
BAT := $(HOME_BIN_DIR)/bat
DELTA := /usr/bin/delta
RG := /usr/bin/rg
FZF_DIR := $(HOME)/.fzf
STARSHIP := $(HOME_BIN_DIR)/starship
NODE := /usr/local/bin/node
YARN := /usr/bin/yarn
GIT_OPEN := /usr/local/bin/git-open
BASH_GIT_PROMPT_DIR := $(HOME)/.bash-git-prompt
BASH_COMPLETION_PATH := $(HOME)/.git-completion.bash

.PHONY: install
install: \
	apt \
	fd \
	bat \
	tmuxplugins \
	git \
	lazygit \
	gh \
	fzf \
	delta \
	rg \
	starship \
	node \
	yarn \
	completion

.PHONY: apt
apt:
	sudo apt-get install -y --no-install-recommends $(PACKAGES)

.PHONY: fd
fd: $(FD)
$(FD):
	sudo apt-get install -y --no-install-recommends fd-find
	ln -s $$(which fdfind) $(HOME_BIN_DIR)/fd

.PHONY: bat
bat: $(BAT)
$(BAT):
	sudo apt-get install -y --no-install-recommends bat
	ln -s $$(which batcat) $(HOME_BIN_DIR)/bat

.PHONY: tmuxplugins
tmuxplugins: $(TMUX_PLUGINS_DIR)
$(TMUX_PLUGINS_DIR):
	git clone https://github.com/tmux-plugins/tpm $@

.PHONY: git
git:
	if [ $$(git --version | cut -d' ' -f3 | awk -F. '{printf "%2d%02d%02d", $$1,$$2,$$3}') -lt 22800 ]; then \
		sudo add-apt-repository -y ppa:git-core/ppa; \
		sudo apt-get update; \
		sudo apt-get install -y --no-install-recommends git; \
	fi

.PHONY: lazygit
lazygit: $(LAZYGIT)
$(LAZYGIT):
	sudo add-apt-repository -y ppa:lazygit-team/release
	sudo apt-get update
	sudo apt-get install lazygit

.PHONY: gh
gh: $(GH)
$(GH):
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
	sudo apt-add-repository https://cli.github.com/packages
	sudo apt-get update
	sudo apt-get install -y --no-install-recommends gh

.PHONY: fzf
fzf: $(FZF_DIR)
$(FZF_DIR):
	git clone https://github.com/junegunn/fzf.git $(FZF_DIR) && \
		$(FZF_DIR)/install --no-update-rc --completion --key-bindings

.PHONY: starship
starship: $(STARSHIP)
$(STARSHIP):
	mkdir -p $(HOME_BIN_DIR)
	$(CURL) https://starship.rs/install.sh -o /tmp/starship_install.sh
	bash /tmp/starship_install.sh -y -b $(HOME_BIN_DIR)

.PHONY: delta
delta: $(DELTA)
$(DELTA):
	$(CURL) -o /tmp/delta.deb https://github.com/dandavison/delta/releases/download/$(DELTA_VERSION)/git-delta_$(DELTA_VERSION)_amd64.deb
	sudo dpkg -i /tmp/delta.deb

.PHONY: rg
rg: $(RG)
$(RG):
	$(CURL) -o /tmp/rg.deb https://github.com/BurntSushi/ripgrep/releases/download/$(RG_VERSION)/ripgrep_$(RG_VERSION)_amd64.deb
	sudo dpkg -i /tmp/rg.deb

.PHONY: completion
completion: $(BASH_COMPLETION_PATH)
$(BASH_COMPLETION_PATH):
	${CURL} https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o $@

.PHONY: node
node: $(NODE)
$(NODE):
	sudo apt-get -y --no-install-recommends install npm
	sudo npm i -g n
	sudo n $(NODE_VERSION)

.PHONY: yarn
yarn: $(YARN)
$(YARN): $(NODE)
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
	sudo apt update
	sudo apt install -y --no-install-recommends yarn

.PHONY: git-open
git-open: $(GIT_OPEN)
$(GIT_OPEN): $(NODE)
	sudo npm -g i git-open

.PHONY: clean
clean:
	sudo apt-get purge -y $(PACKAGES) gh lazygit
	sudo dpkg -P delta
	sudo dpkg -P rg
	rm -rf $(TMUX_PLUGIN_DIR)
	rm -rf $(FZF_DIR)
	rm -f $(STARSHIP)
	rm -f $(BASH_COMPLETION_PATH)
	sudo rm -rf $(NODE)
