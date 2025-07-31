#!/bin/bash

set -eu
set -o pipefail

if [ $# -lt 1 ]; then
  echo "USAGE: mcp.sh <target>" 1>&2
  exit 1
fi

target=$1

while IFS=':' read -r name command; do
  if [[ ! "$name" =~ ^[[:space:]]*# ]] && [[ -n "$name" ]]; then
    echo "Installing MCP server: $name"
    claude mcp add "$name" -s user -- $command || true
  fi
done <"$target"
