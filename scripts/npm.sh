#!/bin/bash

set -eu
set -o pipefail

if [ $# -lt 1 ]
then
  echo "USAGE: npm.sh <target>" 1>&2
  exit 1
fi

target=$1

npm install -g $(grep -vE "^\s*#" ${target} | tr "\n" " ")

