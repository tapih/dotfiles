CURL := curl -sSfL

.PHONY: install
install:
	$(CURL) --proto '=https' --tlsv1.2 https://sh.rustup.rs -o /tmp/rust.sh
	chmod +x /tmp/rust.sh
	/tmp/rust.sh -y
