#! /bin/sh

set -e

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
  destination=$(echo ${i} | cut -d' ' -f2)

  mkdir -p $(dirname ${destination})
  git clone --depth 1 ${url} ${destination}
done
