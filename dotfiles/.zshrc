#! /usr/bin/zsh
#
exists() { type $1 >/dev/null 2>&1; return $?; }

bindkey -e
stty -ixon

setopt no_beep
setopt auto_pushd
setopt noclobber
setopt append_history
setopt share_history
setopt hist_ignore_dups
setopt auto_param_slash
setopt mark_dirs
setopt magic_equal_subst

# === tools ===
[ -d ${HOME}/.antigen ] && touch ${HOME}/.antigen/debug.log && rm -f ${HOME}/.antigen/.lock
[ -f ${HOME}/.antigen.zsh ] && .  ${HOME}/.antigen.zsh
[ -d ${HOME}/.asdf ] && . ${HOME}/.asdf/asdf.sh
[ -f ~/.fzf.zsh ] && . ~/.fzf.zsh
antigen bundle paulirish/git-open
exists starship && eval "$(starship init zsh)"
exists lesspipe && eval "$(SHELL=/bin/sh lesspipe)"
exists bat && export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# === envs ===
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export HISTFILE=${HOME}/.zsh_history
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export SAVEHIST=100000
export HISTFILESIZE=100000
export HISTTIMEFORMAT="%h %d %H:%M:%S "
export ZSH_AUTOSUGGEST_STRATEGY='completion'
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS='--height 90% --reverse --border'
export FZF_COMPLETION_TRIGGER='jj'
export VISUAL="nvim"
export EDITOR="nvim"
export GOPATH="${HOME}/go"
export FLUTTER_ROOT=$(asdf where flutter)
export PATH=${HOME}/bin:/home/linuxbrew/.linuxbrew/bin:${GOPATH}/bin:${HOME}/.pub-cache/bin:/opt/homebrew/bin:${HOME}/.krew/bin:${PATH}

case "$TERM" in
  xterm*)
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

# open tmux on startup
if [ $UID -ne 0 ] && [ -z "$TMUX" ] && [ -z "$SSH_CONNECTION" ]; then
  base_session='auto'
  tmux has-session -t $base_session || tmux new-session -d -s $base_session
  tmux -2 attach-session -t $base_session
fi

# === completion ===
[ -f /usr/share/zsh-completion/zsh_completion ] && . /usr/share/zsh-completion/zsh_completion

# asdf
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit
autoload colors && colors
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^p' history-beginning-search-backward-end
bindkey '^n' history-beginning-search-forward-end

# Disabled because it sometime hangs
# antigen bundle zsh-users/zsh-autosuggestions
#
exists kubectl && . <(kubectl completion zsh) && compdef k=kubectl
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

tcsh-backward-delete-word() {
  local WORDCHARS="${WORDCHARS:s#/#}"
  zle backward-delete-word
}
zle -N tcsh-backward-delete-word
bindkey "^w" tcsh-backward-delete-word

# === function ===

cdls() {
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
        if [ "$(uname 2> /dev/null)" = "Darwin" ]; then
            ls -AG
        else
            ls -A --color=auto
        fi
      fi
    elif [ $lscdmax -ge $nfiles ]; then
      if [ "$(uname 2> /dev/null)" = "Darwin" ]; then
          ls -FG
      else
          ls -F --color=auto
      fi
    else
      echo "$nfiles files in: $(pwd)$reset_color"
    fi
  fi
}

_fzf_compgen_path() {
      fd -HLE.git . "$1"
}

_fzf_compgen_dir() {
      fd --type d -HLE.git . "$1"
}

_fzf_comprun() {
    local command=$1
    shift

    case "$command" in
        cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
        export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
        less)         fzf "$@" --preview 'bat --style=numbers --color=always --line-range :200 {}' ;;
        ssh)          fzf "$@" --preview 'dig {}' ;;
        *)            fzf "$@" ;;
    esac
}

__fzf_ghq__() {
    name=$(ghq list -p | fzf --preview 'tree -C {} | head -200')
    if [ ! -z "${name}" ]; then
        BUFFER="cd $name"
        zle accept-line
    fi
    zle -R -c
}

__fzf_gh_pr__() {
    number=$(gh pr list | fzf --preview "echo {} | awk '{print \$1}' | xargs gh pr view")
    if [ ! -z "${number}" ]; then
        BUFFER="gh pr view ${number}"
        zle accept-line
    fi
    zle -R -c
}

__fzf_gh_issue__() {
    number=$(gh issue list | fzf --preview "echo {} | awk '{print \$1}' | xargs gh issue view")
    if [ ! -z "${number}" ]; then
        BUFFER="gh issue view ${number}"
        zle accept-line
    fi
    zle -R -c
}
__fzf_git_cd__() {
    toplevel=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ -z "${toplevel}" ]; then
        echo "error: this is not a git repository"
        return 1
    fi

    # git fd is defined in .gitconfig
    selected=$(git fd --type d | fzf --preview 'tree -C '${toplevel}'/{} | head -200')
    if [ ! -z "${selected}" ]; then
        BUFFER="cd ${toplevel}/${selected}"
        zle accept-line
    fi
    zle -R -c
}

__fzf_git_file__() {
    toplevel=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ -z "${toplevel}" ]; then
        echo "error: this is not a git repository"
        return 1
    fi

    grep_cmd="git fd --type f -H --exclude '.git' --exclude 'vendor'"
    preview_cmd="bat --style=numbers --color=always --line-range :200 ${toplevel}/{}"
    selected=$(eval $grep_cmd | fzf --preview "$preview_cmd")
    if [ ! -z "${selected}" ]; then
        BUFFER="${EDITOR} ${toplevel}/${selected}"
        zle accept-line
    fi
    zle -R -c
}

__fzf_git_grep__() {
    toplevel=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ -z "${toplevel}" ]; then
        echo "error: this is not a git repository"
        return 1
    fi

    grep_cmd="git g --hidden --line-number --no-heading --smart-case -- '%s' || true"
    initial_cmd=$(printf "$grep_cmd" "")
    reload_cmd=$(printf "$grep_cmd" "{q}")
    preview_cmd='echo {} | awk -F: '\''{print "bat --style=numbers --color=always -H=" ($2) " --line-range=" ($2-15>0?$2-15:0) ":" ($2+50) " '${toplevel}'/" $1}'\'' | xargs -L 1 -I VAR sh -c "VAR"'
    selected=$(eval "$initial_cmd" | fzf -d : --nth 3.. --preview-window down:80%:wrap --preview "$preview_cmd" --bind change:reload:"$reload_cmd" | awk -F: '{print $1}')
    if [ ! -z "${selected}" ]; then
        BUFFER="${EDITOR} ${toplevel}/${selected}"
        zle accept-line
    fi
    zle -R -c
}


__fzf_git_branch__() {
    toplevel=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ -z "${toplevel}" ]; then
        echo "error: this is not a git repository"
        return 1
    fi

    branches=$(env IFS='\n' git branch --sort='-committerdate' --format='[%(committerdate:short)] %(refname:short) %(authorname)')
    selected=$(echo "$branches" | fzf --preview "eval 'git show \$(echo '{}' | awk '{print $2}') | bat --color=always --line-range :200'")
    if [ ! -z "${selected}" ]; then
        branch=$(echo ${selected} | cut -d" " -f2)
        BUFFER="git checkout ${branch}"
        zle accept-line
    fi
    zle -R -c
}

# === alias ===

alias cd='cdls'
if [ "$(uname 2> /dev/null)" = "Darwin" ]; then
    alias ls='ls -FG'
    alias ll='ls -FlhG'
    alias la='ls -FlhaG'
else
    alias ls='ls -F --color=auto'
    alias ll='ls -Flh --color=auto'
    alias la='ls -Flha --color=auto'
fi
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='colordiff'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias a='alias'
alias b='__fzf_git_branch__'
alias q='exit'
alias e='nvim ~/.zshrc'
alias E='nvim ~/.nv-ide/init.lua'
alias u='. ~/.zshrc'
alias U='(\cd ~/.nv-ide && git pull origin tapih)'
alias j='cd -'
alias k='kubectl'
alias h='cd $(git rev-parse --show-toplevel 2>/dev/null)'
alias H='cd ~'
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias g='git'
alias G='gh'
alias z='if [ ${HOME}/t = $(pwd) ]; then popd; else mkdir -p ~/t && pushd ~/t; fi'
alias d='docker'
alias t='terraform'
alias fig='docker-compose'
alias v='nvim'
alias agit='nvim +Agit'

zle -N __fzf_ghq__
zle -N __fzf_gh_pr__
zle -N __fzf_gh_issue__
zle -N __fzf_git_file__
zle -N __fzf_git_grep__

bindkey '^g' __fzf_ghq__
bindkey '^o' __fzf_git_file__
bindkey '^j' __fzf_git_grep__

# load other rc files
[ -f ~/.zsh_aliases ] && . ~/.zsh_aliases
[ -f ~/.zshrc.local ] && . ~/.zshrc.local

# === genie ===
if uname -r | grep -q -i 'microsoft'; then
  if [ "`ps -eo pid,cmd | grep systemd | grep -v grep | sort -n -k 1 | awk 'NR==1 { print $1  }'`" != "1"  ]; then
        genie -s
  fi
  export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
  export VTE_CJK_WIDTH=1
fi

