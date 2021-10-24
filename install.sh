#! /bin/sh

echo "=== key ===" ; ./scripts/keygen.sh  Dotfile
echo "=== dot ===" ; ./scripts/dot.sh  Dotfile
source ~/.zshrc
echo "=== brew ==="; ./scripts/brew.sh Brewfile
echo "=== go ==="  ; ./scripts/go.sh   Gofile # depends on Brewfile
echo "=== krew ==="; ./scripts/krew.sh Krewfile # depends on Brewfile
echo "=== misc ==="; ./script/misc.sh # depends on Brewfile
case "$(uname -s)" in
  "Darwin")
    echo "=== darwin ==="
    ./scripts/brew.sh Brewfile.ios
    ;;
  # debian only
  "Linux")
    echo "=== debian ==="
    ./scripts/apt.sh Debfile
    ;;
esac
