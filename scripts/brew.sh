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
  echo "brew command is not found." 1>&2
  exit 1
fi

brew update
brew bundle --file ${target}
