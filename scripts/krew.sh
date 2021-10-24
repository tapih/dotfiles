#! /bin/sh

set -e

if [ $# -lt 1 ]
then
  echo "USAGE: go.sh <file>" 1>&2
  exit 1
fi

file=$1

for i in $(grep -vE "^\s*#" ${file} | tr "\n" " ")
do
  kubectl krew install ${i}
done

