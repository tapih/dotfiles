#! /bin/sh

echo "=== key ===" ; ./scripts/keygen.sh
echo "=== apt ===" ; ./scripts/apt.sh  Debfile
echo "=== misc ==="; ./scripts/misc.sh
echo "=== dot ===" ; ./scripts/dot.sh  Dotfile $(pwd)/dotfiles
echo "=== brew ==="; ./scripts/brew.sh Brewfile
echo "=== go ==="  ; ./scripts/go.sh   Gofile # depends on Brewfile
echo "=== krew ==="; ./scripts/krew.sh Krewfile # depends on Brewfile
