#! /bin/bash

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export VISUAL="vim"
export EDITOR="vim"

stty werase undef
bind '"\C-w": unix-filename-rubout'

set -o noclobber
shopt -s histappend
shopt -s cmdhist
shopt -s globstar
HISTCONTROL=ignoreboth
HISTSIZE=100000
HISTFILESIZE=100000
export HISTTIMEFORMAT="%h %d %H:%M:%S "
export PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"

alias g='git'

bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'

[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.bashrc.local ] && . ~/.bashrc.local
