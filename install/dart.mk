CURL := curl -sSfL

DART_VERSION := 2.12.2
FLUTTER_VERSION := 2.0.4

DART := /usr/bin/dart
FLUTTER_DIR := ${HOME}/dart/flutter
DEVTOOLS := ${HOME}/bin

.PHONY: install
install: dart flutter

.PHONY: dart
dart: $(DART)
$(DART):
	$(CURL) -o /tmp/dart.deb https://storage.googleapis.com/dart-archive/channels/stable/release/$(DART_VERSION)/linux_packages/dart_$(DART_VERSION)-1_amd64.deb
	sudo dpkg -i /tmp/dart.deb; rm -f /tmp/dart.deb

.PHONY: flutter
flutter: $(FLUTTER_DIR)
$(FLUTTER_DIR):
	mkdir -p $@
	git clone https://github.com/flutter/flutter.git $@ -b $(FLUTTER_VERSION)

.PHONY: devtools
devtools: $(DEVTOOLS)
$(DEVTOOLS):
	$(FLUTER_DIR)/bin/flutter pub global activate devtools

.PHONY: clean
clean:
	sudo dpkg -P dart
	rm -rf $(FLUTTER_DIR)
