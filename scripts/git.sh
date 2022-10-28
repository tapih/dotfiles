#! /bin/sh

set -eu
set -o pipefail

if [ $# -lt 1 ]
then
  echo "USAGE: git.sh <target>" 1>&2
  exit 1
fi

target=$1

IFS='
'; for i in $(grep -vE "^\s*#" ${target})
do
  echo ${i}
  url=$(echo ${i} | cut -d' ' -f1)
  destination=$(bash -c "echo ${i} | cut -d' ' -f2")

  mkdir -p $(dirname ${destination})
  if [ -d ${destination} ]
  then
    echo "skip installing ${i}"
  else 
    git clone --depth 1 ${url} ${destination} || exit 1
  fi
done
