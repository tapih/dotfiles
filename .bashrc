#! /usr/bin/env bash

case $- in
    *i*) ;;
      *) return;;
esac

export SHELL=`which bash`
export PATH=$HOME/bin:$PATH

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# bind
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
bind '"\C-n": history-search-fowward'

# color 256
export LANG=ja_JP.UTF-8
unset LC_ALL
export LC_MESSAGES=C
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
case "$OSTYPE" in
    darwin*)
        export TERM=xterm-256color
    ;;
esac

shopt -s checkwinsize
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# prompt
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh"  ]; then
    # GIT_PROMPT_ONLY_IN_REPO=1
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

if [ $UID -eq 0 ]; then
    GIT_PROMPT_START='\[\e[0;30;45m[\u@\h] \w \]\[\e[m\]'
    GIT_PROMPT_END='
%\[\e[0;35m$\]\[\e[m\] '
else
    GIT_PROMPT_START='\[\e[0;30;46m[\u@\h] \w \]\[\e[m\]'
    GIT_PROMPT_END='
%\[\e[0;36m$\]\[\e[m\] '
fi

do_exist() { type $1 >/dev/null 2>&1; return $?; }
alias ls='ls -FG --color=auto'
alias ll='ls -FGlh --color=auto'
alias la='ls -FGlha --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias mv='mv -i'
alias rm='rm -i'
alias quit='exit'
alias Q='exit'
alias H='cd ~'
alias ..='cd ..'
alias ...='cd ...'
alias ....='cd ....'
alias diff='colordiff'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
do_exist vim && export EDITOR=vim
do_exist nvim && alias nv='nvim'
do_exist nvim && alias agit='nvim +Agit'
do_exist w3m && alias w3m='w3m -O ja_JP.UTF-8'
do_exist gsed && alias sed='gsed'
do_exist tmux && alias tmux="tmux -2"
do_exist git && alias g='git'
do_exist kubectl && alias k='kubectl'

cd() {
  if ! builtin cd 2>/dev/null $@; then
    echo "$fg[yellow]cannot cd: $@$reset_color"
    return
  fi
  if [ "$?" -eq 0 ]; then
    lscdmax=40
    nfiles=$(/bin/ls|wc -l)
    if [ $nfiles -eq 0 ]; then
      if [ "$(/bin/ls -A|wc -l)" -eq 0 ]; then
        echo "$fg[yellow]no files in: $(pwd)$reset_color"
      else
        echo "$fg[yellow]only hidden files in: $(pwd)$reset_color"
        ls -A
      fi
    elif [ $lscdmax -ge $nfiles ]; then
      ls
    else
      echo "$fg[yellow]$nfiles files in: $(pwd)$reset_color"
    fi
  fi
}

# fzf
export FZF_DEFAULT_OPTS='--height 95% --reverse --border'
[ -f ~/.fzf.bash ] && . ~/.fzf.bash

# tmux
if [ $UID -ne 0 ] && [ -z "$TMUX" ]; then
    base_session='auto'
    # Create a new session if it doesn't exist
    tmux has-session -t $base_session || tmux new-session -d -s $base_session
    # Are there any clients connected already?
    client_cnt=$(tmux list-clients | wc -l)
    if [ $client_cnt -ge 1 ]; then
        session_name=$base_session"-"$client_cnt
        tmux new-session -d -t $base_session -s $session_name
        tmux -2 attach-session -t $session_name \; set-option destroy-unattached
    else
        tmux -2 attach-session -t $base_session
    fi
fi

# python
if [ -d ${HOME}/.pyenv ]; then
  export PYENV_ROOT=$HOME/.pyenv
  export PATH=$PATH:$PYENV_ROOT/shims:$PYENV_ROOT/bin
  eval "$(pyenv init -)";
fi

# go
GOROOT="/usr/local/go"
if do_exist $GOROOT/bin/go; then
    export GOPATH="$HOME/go"
    export GOROOT
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

# enhancd
if [ -f $HOME/.config/enhancd/init.sh ]; then
    export ENHANCD_FILTER=fzf
    export ENHANCD_COMMAND=ecd
    source $HOME/.config/enhancd/init.sh
fi

# load
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.bashrc.local ] && . ~/.bashrc.local
[ -f ~/.git-completion.bash ] && source ~/.git-completion.bash
