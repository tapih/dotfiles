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
alias J='cd -'
alias H='cd ~'
alias ..='cd ..'
alias ..='cd ..'
alias ...='cd ...'
alias ....='cd ....'
alias diff='colordiff'
alias mktmp='mkdir t'
exists vim && alias v='vim'
exists nvim && alias v='nvim'
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
    export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi

# fzf
[ -f ~/.fzf.bash ] && . ~/.fzf.bash
export FZF_DEFAULT_OPTS='--height 80% --reverse --border'

__fzf_git__() {
    NAME=$(ghq list -p | fzf --preview 'tree -C {} | head -200')
    [ -z $NAME ] || cd $NAME
}

__fzf_cd__() {
    directories=$(git ls-files $(git rev-parse --show-toplevel) | xargs -n 1 dirname | sort -n | uniq) &&
        selected_dir=$(echo "$directories" | fzf -m --preview 'tree -C {} | head -200') &&
        cd $selected_dir
}

__fzf_file__() {
    files=$(git ls-files $(git rev-parse --show-toplevel)) &&
        selected_file=$(echo "$files" | fzf -m --preview 'head -200 {}') &&
        nvim $selected_file
}

bind -r "\C-g"
bind -r "\C-j"
bind -r "\C-o"
bind -x '"\C-g": __fzf_git__'
bind -x '"\C-j": __fzf_cd__'
bind -x '"\C-o": __fzf_file__'

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
[ -f ~/.bashrc.local ] && . ~/.bashrc.local

# wsl
[ -n "uname -a | grep microsoft" ] && export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0

