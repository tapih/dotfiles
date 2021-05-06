WINDOWS_USER ?=

ifeq ($(OS),ubuntu)
BREW_DIR := /home/linuxbrew/.linuxbrew
TARGET := ubuntu.mk
else
BREW_DIR := /opt/homebrew
TARGET := osx.mk
endif

.PHONY: postinst
postinst:
	$(MAKE) -f install/common.mk postinst BREW_DIR=$(BREW_DIR)

.PHONY: install
install:
	$(MAKE) -f install/$(TARGET) install
	$(MAKE) -f install/common.mk install

.PHONY: wsl
wsl:
	$(MAKE) -f install/wsl.mk install WINDOWS_USER=$(WINDOWS_USER)
