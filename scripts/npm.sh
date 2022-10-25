#! /bin/sh

set -e

if [ $# -lt 1 ]
then
  echo "USAGE: go.sh <file>" 1>&2
  exit 1
fi

file=$1

if ! which go >/dev/null 2>&1
then
  asdf plugin add nodejs || true
  asdf install nodejs latest
  asdf global nodejs latest
fi

for i in $(grep -vE "^\s*#" ${file} | tr "\n" " ")
do
  echo ${i}
  npm -g i ${i}
done

