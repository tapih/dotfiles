#! /bin/bash
set -euo pipefail

current=$(tmux display-message -p "#S")
next=$(tmux list-sessions -F "#S" | grep -v "^\(attached\)$" | head -n 1)
if [ -n "$next" ]; then
  tmux switch-client -t "$next"
  tmux kill-session -t "$current"
else
  tmux kill-session -t "$current"
fi
