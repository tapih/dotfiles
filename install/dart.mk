CURL := curl -sSfL

FLUTTER_VERSION := 2.0.4

FLUTTER_DIR := ${HOME}/flutter

.PHONY: install
install: setup flutter

.PHONY: setup
setup:
	mkdir -p ${HOME}/dart/src

.PHONY: flutter
flutter: $(FLUTTER_DIR)
$(FLUTTER_DIR):
	git clone https://github.com/flutter/flutter.git $@ -b $(FLUTTER_VERSION)
	$(FLUTER_DIR)/bin/flutter pub global activate devtools

.PHONY: clean
clean:
	rm -rf $(FLUTTER_DIR)
