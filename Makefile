WINDOWS_USER ?=

ifeq ($(OS),ubuntu)
BREW_DIR := /home/linuxbrew/.linuxbrew
TARGET := ubuntu.mk
else
BREW_DIR := /usr/local
TARGET := osx.mk
endif

.PHONY: postinst
postinst:
	$(MAKE) -f install/postinst.mk BREW_DIR=$(BREW_DIR)

.PHONY: install
install:
	$(MAKE) -f install/$(TARGET)
	$(MAKE) -f install/common.mk

.PHONY: wsl
wsl:
	$(MAKE) -f install/wsl.mk WINDOWS_USER=$(WINDOWS_USER)
