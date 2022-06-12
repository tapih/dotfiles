#! /bin/bash

set -e

if [ $# -lt 1 ]
then
  echo "USAGE: brew.sh <target>" 1>&2
  exit 1
fi

target=$1

if ! which brew >/dev/null 2>&1
then
  echo "brew command is not found.\nstart installing brew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew update
brew bundle --file ${target}
