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

# enhanced cd
cd() {
  if ! builtin cd 2>/dev/null $@; then
    echo "cannot cd: $@$reset_color"
    return
  fi
  if [ "$?" -eq 0 ]; then
    lscdmax=40
    nfiles=$(/bin/ls|wc -l)
    if [ $nfiles -eq 0 ]; then
      if [ "$(/bin/ls -A|wc -l)" -eq 0 ]; then
        echo "no files in: $(pwd)$reset_color"
      else
        echo "only hidden files in: $(pwd)$reset_color"
        ls -A --color=auto
      fi
    elif [ $lscdmax -ge $nfiles ]; then
      ls -F --color=auto
    else
      echo "$nfiles files in: $(pwd)$reset_color"
    fi
  fi
}

# gcd
bind -x '"\C-g": gcd'
gcd() {
    JUMP_TO=$(ghq list -p | fzf)
    [ -z $JUMP_TO ] || cd $JUMP_TO
}

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

# colorize less
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

alias ls='ls -F --color=auto'
alias ll='ls -Flh --color=auto'
alias la='ls -Flha --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias quit='exit'
alias Q='exit'
alias H='cd ~'
alias ..='cd ..'
alias ...='cd ...'
alias ....='cd ....'
alias diff='colordiff'
exists notify-send && alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal ||
    echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
exists nvim && alias nv='nvim'
exists nvim && alias agit='nvim +Agit'
exists w3m && alias w3m='w3m -O ja_JP.UTF-8'
exists gsed && alias sed='gsed'
exists tmux && alias tmux="tmux -2"
exists git && alias g='git'

if exists kubectl ; then
    alias k='kubectl'
    alias kex='kubectl exec -it'
    complete -F __start_kubectl k
    source <(kubectl completion bash)
fi

# fzf
[ -f ~/.fzf.bash ] && . ~/.fzf.bash
export FZF_DEFAULT_OPTS='--height 95% --reverse --border'

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
if [ -x $GOROOT/bin/go ]; then
    export GOPATH="$HOME/go"
    export GOROOT
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

# dart
exists dart && export PATH=$PATH:/usr/lib/dart/bin:${HOME}/.pub-cache/bin
# exists dart && export PATH=${PATH}:${HOME}/dart/flutter/bin
# exists flutter && export ANDROID_HOME=~/Android/Sdk

# prompt
function get_cluster_short() {
    if [ "$1" = "N/A" ]; then
        echo ""
    else
        echo "$1"
    fi
}
KUBE_PS1_NS_ENABLE=false
KUBE_PS1_PREFIX="["
KUBE_PS1_SUFFIX="]"
KUBE_PS1_SYMBOL_USE_IMG=true
KUBE_PS1_SEPARATOR="|"
KUBE_PS1_SYMBOL_COLOR="cyan"
KUBE_PS1_CTX_COLOR="magenta"
KUBE_PS1_CLUSTER_FUNCTION=get_cluster_short

if [ $UID -eq 0 ]; then
    PS1='\e[0;30;45m[\u@\h] \w \]\e[m\]\n%\$ '
else
    if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
        source $HOME/.bash-git-prompt/gitprompt.sh
        GIT_PROMPT_START='\e[0;30;46m[\u@\h] \w \]\e[m\] '
        if [ -f $HOME/.kube-ps1 ]; then
            source $HOME/.kube-ps1
            GIT_PROMPT_END=' $(kube_ps1)\n%\$ '
        else
            GIT_PROMPT_END='\n%\$ '
        fi
    else
        if [ -f $HOME/.kube-ps1 ]; then
            source $HOME/.kube-ps1
            PS1='\e[0;30;45m[\u@\h] \w \]\e[m\] $(kube_ps1)\n%\$ '
        else
            PS1='\e[0;30;45m[\u@\h] \w \]\e[m\]\n%\$ '
        fi
    fi
fi

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
[ -f ~/.bashrc.local ] && . ~/.bashrc.local
