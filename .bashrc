#! /usr/bin/env bash
case $- in
    *i*) ;;
      *) return;;
esac

exists() { type $1 >/dev/null 2>&1; return $?; }

export SHELL=`which bash`
export PATH=$HOME/bin:$PATH
export EDITOR=nvim
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

stty werase undef
bind '"\C-w": unix-filename-rubout'

shopt -s histappend
shopt -s cmdhist
shopt -s globstar
HISTCONTROL=ignoreboth
HISTSIZE=100000
HISTFILESIZE=100000
export HISTTIMEFORMAT="%h %d %H:%M:%S "
export PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"

bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'

# NOTE: .bashrc.wsl should be read before .bashrc.tmux
[ -f ~/.bashrc.wsl ] && . ~/.bashrc.wsl
[ -f ~/.bashrc.tmux ] && . ~/.bashrc.tmux
[ -f ~/.bashrc.langs ] && . ~/.bashrc.langs
[ -f ~/.bashrc.commands ] && . ~/.bashrc.commands
[ -f ~/.bashrc.completion ] && . ~/.bashrc.completion
[ -f ~/.bashrc.prompt ] && . ~/.bashrc.prompt

[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.bashrc.local ] && . ~/.bashrc.local


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
