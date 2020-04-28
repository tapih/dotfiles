#! /usr/bin/env bash
case $- in
    *i*) ;;
      *) return;;
esac

exists() { type $1 >/dev/null 2>&1; return $?; }

export SHELL=`which bash`
export PATH=$HOME/bin:$PATH
exists vim && export EDITOR=vim

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# delete word and slash
stty werase undef
bind '"\C-w": unix-filename-rubout'

# history
shopt -s histappend
shopt -s cmdhist
HISTCONTROL=ignoreboth
HISTSIZE=100000
HISTFILESIZE=100000
export HISTTIMEFORMAT="%h %d %H:%M:%S "
export PROMPT_COMMAND='history -a'
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'

# color 256
case "$TERM" in
  xterm*)
  # determine best terminal
  if [ -f /usr/share/terminfo/x/xterm-256color ]; then
    export TERM=xterm-256color
  elif [ -f /usr/share/terminfo/x/xterm-debian ]; then
    export TERM=xterm-debian
  elif [ -f /usr/share/terminfo/x/xterm-color ]; then
    export TERM=xterm-color
  else
    export TERM=xterm
  fi ;;
esac

shopt -s checkwinsize

# python
if [ -d ${HOME}/.pyenv ]; then
  export PYENV_ROOT=$HOME/.pyenv
  export PATH=$PATH:$PYENV_ROOT/shims:$PYENV_ROOT/bin
  eval "$(pyenv init -)";
fi

# go
GOROOT="/usr/local/go"
if [ -x $GOROOT/bin/go ]; then
    export GOPATH="$HOME/go"
    export GOROOT
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

# dart
exists dart && export PATH=$PATH:/usr/lib/dart/bin:${HOME}/.pub-cache/bin
# exists dart && export PATH=${PATH}:${HOME}/dart/flutter/bin
# exists flutter && export ANDROID_HOME=~/Android/Sdk

# node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# prompt
eval "$(starship init bash)"

export VTE_CJK_WIDTH=1

# completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
[ -f ~/.git-completion.bash ] && source ~/.git-completion.bash && __git_complete g _git
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.bashrc.tmux ] && . ~/.bashrc.tmux
[ -f ~/.bashrc.commands ] && . ~/.bashrc.commands
[ -f ~/.bashrc.local ] && . ~/.bashrc.local

# wsl
[ -n "uname -a | grep microsoft" ] && export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0

