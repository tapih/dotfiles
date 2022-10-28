#! /bin/sh

set -eu
set -o pipefail

if [ $# -lt 1 ]
then
  echo "USAGE: apt.sh <target>" 1>&2
  exit 1
fi

target=$1

sudo apt-get update
sudo apt-get install -y --no-install-recommends $(grep -vE "^\s*#" ${target} | tr "\n" " ")

