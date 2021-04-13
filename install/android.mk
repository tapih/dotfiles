CURL := curl -sSfL

ANDROID_DIR := ${HOME}/src/Android
SDKMANAGER_PATH := $(ANDROID_DIR)/tools/bin/sdkmanager

PACKAGES := unzip lib32z1 openjdk-8-jdk gradle

.PHONY: install
install: setup sdk

.PHONY: setup
setup:
	sudo apt-get -y --no-install-recommends install $(PACKAGES)

.PHONY: sdk
sdk: $(SDKMANAGER_PATH)
$(SDKMANAGER_PATH):
	$(CURL) -o /tmp/sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
	unzip /tmp/sdk.zip -d $(ANDROID_DIR)
	rm -f /tmp/sdk.zip
	$(SDKMANAGER_PATH) "platform-tools" "platforms;android-26" "build-tools;26.0.3"

.PHONY: clean
clean:
	sudo apt-get remove $(PACKAGES)
	sudo rm -rf $(ANDROID_DIR)

