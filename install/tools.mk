CURL := curl -sSfL

TMUX_VERSION := 2.9
HUB_VERSION := 2.12.8
FD_VERSION := 8.1.0

TMUX := $(HOME_BIN_DIR)/tmux
TMUX_PLUGINS_DIR := $(HOME)/.tmux/plugins/tpm

HOME_BIN_DIR := $(HOME)/bin
HUB := $(HOME_BIN_DIR)/hub
GH := /usr/bin/gh
FD := /usr/bin/fd
FZF_DIR := $(HOME)/.fzf
STARSHIP := $(HOME_BIN_DIR)/starship
BASH_GIT_PROMPT_DIR := $(HOME)/.bash-git-prompt
BASH_COMPLETION_PATH := $(HOME)/.git-completion.bash:

.PHONY: install
install: \
	tmux \
	tmuxplugins \
	hub \
	gh \
	fd \
	fzf \
	starship \
	completion

.PHONY: tmux
tmux: $(TMUX) $(TMUX_PLUGINS_DIR)
$(TMUX):
	sudo apt-get install -y --no-install-recommends tmux

.PHONY: tmuxplugins
tmuxplugins: $(TMUX_PLUGINS_DIR)
$(TMUX_PLUGINS_DIR):
	git clone https://github.com/tmux-plugins/tpm $@

.PHONY: hub
hub: $(HUB)
$(HUB):
	mkdir -p $(HOME_BIN_DIR)
	sudo sh -c "$(CURL) https://github.com/github/hub/releases/download/v$(HUB_VERSION)/hub-linux-amd64-$(HUB_VERSION).tgz | \
		tar xz -C $(HOME_BIN_DIR) --strip-component=2"

.PHONY: gh
gh: $(GH)
$(GH):
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
	sudo apt-add-repository https://cli.github.com/packages
	sudo apt-get update
	sudo apt-get install -y --no-install-recommends gh

.PHONY: fd
fd: $(FD)
$(FD):
	sudo apt-get install -y --no-install-recommends fd-find

.PHONY: fzf
fzf: $(FZF_DIR)
$(FZF_DIR):
	git clone https://github.com/junegunn/fzf.git $(FZF_DIR) && \
		$(FZF_DIR)/install --no-key-bindings --no-completion --no-update-rc

.PHONY: starship
starship: $(STARSHIP)
$(STARSHIP):
	mkdir -p $(HOME_BIN_DIR)
	$(CURL) https://starship.rs/install.sh -o /tmp/starship_install.sh
	bash /tmp/starship_install.sh -y -b $(HOME_BIN_DIR)

.PHONY: completion
completion: $(BASH_COMPLETION_PATH)
$(BASH_COMPLETION_PATH):
	${CURL} https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o $@

.PHONY: clean
clean:
	sudo apt-get purge tmux gh fd
	rm -rf $(TMUX_PLUGIN_DIR)
	rm -f $(HUB)
	rm -rf $(FZF_DIR)
	rm -f $(STARSHIP)
	rm -f $(BASH_COMPLETION_PATH)
