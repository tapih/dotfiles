#! /bin/sh

TARGETS=$(grep -vE "^\s*#" AptFile | tr "\n" " ")
apt-get update
apt-get install -y --no-install-recommends

