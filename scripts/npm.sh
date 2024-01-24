#! /bin/bash

set -eu
set -o pipefail

if [ $# -lt 1 ]
then
  echo "USAGE: go.sh <file>" 1>&2
  exit 1
fi

file=$1

for i in $(grep -vE "^\s*#" ${file} | tr "\n" " ")
do
  echo ${i}
  npm -g i ${i} || exit 1
done

