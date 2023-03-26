#! /bin/bash

set -eu
set -o pipefail

echo "=== apt ===" ; ./scripts/apt.sh  Aptfile
echo "=== git ===" ; ./scripts/git.sh  Gitfile
echo "=== dot ===" ; ./scripts/dot.sh  Dotfile $(pwd)/dotfiles
echo "=== brew ==="; ./scripts/brew.sh Brewfile
echo "=== go ==="  ; ./scripts/go.sh   Gofile # depends on Brewfile
echo "=== npm ===" ; ./scripts/npm.sh  Npmfile # depends on Brewfile
echo "=== krew ==="; ./scripts/krew.sh Krewfile # depends on Brewfile
echo "=== gh ===";   ./scripts/gh.sh   Ghfile  # depends on Brewfile
