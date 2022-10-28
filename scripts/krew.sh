#! /bin/sh

set -eu
set -o pipefail

if [ $# -lt 1 ]
then
  echo "USAGE: go.sh <target>" 1>&2
  exit 1
fi

target=$1

for i in $(grep -vE "^\s*#" ${target} | tr "\n" " ")
do
  kubectl krew install ${i} || exit 1
done

