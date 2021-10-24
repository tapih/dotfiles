#! /bin/sh

set -e

if [ $# -lt 1 ]
then
  echo "USAGE: apt.sh <AptFile>" 1>&2
  exit 1
fi

file=$1

apt-get update
apt-get install -y --no-install-recommends $(grep -vE "^\s*#" $(file) | tr "\n" " ")

