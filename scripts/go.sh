#! /bin/bash

set -eu
set -o pipefail

if [ $# -lt 1 ]
then
  echo "USAGE: go.sh <file>" 1>&2
  exit 1
fi

file=$1

if ! which go >/dev/null 2>&1
then
  asdf plugin add golang || true
  asdf install golang latest
  asdf global golang latest
fi

for i in $(grep -vE "^\s*#" ${file} | tr "\n" " ")
do
  echo ${i}
  go install ${i} || exit 1
done

