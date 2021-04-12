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
	mkdir -p $@
	$(CURL) https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_$(FLUTTER_VERSION)-stable.tar.xz | tar Jxf - -C $@ --strip-components=1

.PHONY: clean
clean:
	rm -rf $(FLUTTER_DIR)
