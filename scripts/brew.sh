#! /bin/bash

set -e

if [ $# -lt 1 ]
then
  echo "USAGE: brew.sh <file>" 1>&2
  exit 1
fi

file=$1

if ! which brew >/dev/null 2>&1
then
  echo "brew command is not found.\nstart installing brew..."
  arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew update
brew bundle --file ${file}
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash

