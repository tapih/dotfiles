.PHONY: install
install:
	wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -
	sudo apt-get update
	sudo apt-get install -y clang-11 lldb-11 lld-11

.PHONY: clean
	sudo apt-get purge -y clang-11 lldb-11 lld-11
