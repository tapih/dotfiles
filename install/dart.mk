CURL := curl -sSfL

DART_VERSION := 2.10
FLUTTER_VERSION := 1.22.6

DART := /usr/bin/dart
FLUTTER_DIR := $(HOME)/dart/flutter

.PHONY: install
install: dart flutter

.PHONY: dart
dart: $(DART)
$(DART):
	sudo sh -c "${CURL} https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -"
	sudo sh -c "${CURL} https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list"
	sudo apt-get update
	sudo apt-get -y --no-install-recommends install \
		dart=$(DART_VERSION) \
		apt-transport-https

.PHONY: flutter
flutter: $(FLUTTER_DIR)
$(FLUTTER_DIR):
	mkdir -p $@
	git clone https://github.com/flutter/flutter.git $@ -b $(FLUTTER_VERSION)

.PHONY: clean
clean:
	sudo apt-get purge -y dart
	rm -rf $(FLUTTER_DIR)
