CURL := curl -sSfL

KUBERNETES_VERSION := 1.17.15
KIND_VERSION := 0.10.0
HELM_VERSION := 3.5.1
KUSTOMIZE_VERSION := 3.9.4
KREW_VERSION := 0.4.1
STERN_VERSION := 1.11.0

HOME_BIN_DIR := $(HOME)/bin
KUBECTL := $(HOME_BIN_DIR)/kubectl
KIND := $(HOME_BIN_DIR)/kind
KUSTOMIZE := $(HOME_BIN_DIR)/kustomize
HELM := $(HOME_BIN_DIR)/helm
KREW := $(HOME_BIN_DIR)/krew
STERN := $(HOME_BIN_DIR)/stern

.PHONY: install
install: \
	kubectl \
	kind \
	kustomize \
	helm \

.PHONY: kubectl
kubectl: $(KUBECTL)
$(KUBECTL):
	mkdir -p $(HOME_BIN_DIR)
	sudo $(CURL) https://storage.googleapis.com/kubernetes-release/release/v$(KUBERNETES_VERSION)/bin/linux/amd64/kubectl -o $@
	sudo chmod 755 $@

.PHONY: kind
kind: $(KIND)
$(KIND):
	mkdir -p $(HOME_BIN_DIR)
	sudo $(CURL) https://github.com/kubernetes-sigs/kind/releases/download/v$(KIND_VERSION)/kind-linux-amd64 -o $@
	sudo chmod 755 $@

.PHONY: kustomize
kustomize: $(KUSTOMIZE)
$(KUSTOMIZE):
	mkdir -p $(HOME_BIN_DIR)
	sudo sh -c "$$(echo \
		"$(CURL) https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv$(KUSTOMIZE_VERSION)/kustomize_v$(KUSTOMIZE_VERSION)_linux_amd64.tar.gz |" \
		"tar xz -C $(HOME_BIN_DIR)")"

.PHONY: helm
helm: $(HELM)
$(HELM):
	mkdir -p $(HOME_BIN_DIR)
	sudo sh -c "$(CURL) https://get.helm.sh/helm-v$(HELM_VERSION)-linux-amd64.tar.gz | tar xz -C $(HOME_BIN_DIR) --strip-components=1"
	sudo chmod 755 $@

.PHONY: krew
krew: $(KREW)
$(KREW):
	$(CURL) https://github.com/kubernetes-sigs/krew/releases/download/v$(KREW_VERSION)/krew.tar.gz -o /tmp/krew.tar.gz && \
		cd /tmp && \
		tar xvzf krew.tar.gz && \
		mv krew-linux_amd64 $@ && \
		$(KERW) install krew && \
		kubectl krew update

.PHONY: stern
stern: $(STERN)
$(STERN):
	$(CURL) https://github.com/wercker/stern/releases/download/$(STERN_VERSION)/stern_linux_amd64 -o $@
	chmod +x $@

.PHONY: clean
clean:
	rm -f $(KUBECTL) $(KIND) $(KUSTOMIZE) $(HELM)
