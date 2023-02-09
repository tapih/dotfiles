#! /usr/bin/zsh
#
exists() { type $1 >/dev/null 2>&1; return $?; }

function cdls() {
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

function _fzf_compgen_path() {
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

function __fzf_ghq() {
    name=$(ghq list -p | fzf --preview 'tree -C {} | head -200')
    if [ ! -z "${name}" ]; then
        BUFFER="cd $name"
        zle accept-line
    fi
    zle -R -c
}

function __fzf_git_file() {
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

function __fzf_git_branch() {
  branch=$(
    git branch --sort=-authordate |
      fzf \
        --exit-0 \
        --layout=reverse \
        --info=hidden \
        --no-multi \
        --preview-window="right,65%" \
        --prompt="CHECKOUT BRANCH > " \
        --preview="echo {} | tr -d ' *' | xargs git l --color=always" |
      head -n 1 |
      perl -pe "s/\s//g" |
      perl -pe "s/\*//g" |
      perl -pe "s/remotes\/origin\///g"
  )
  if [[ -n "$branch" ]]; then
    BUFFER="git switch $branch"
    zle accept-line
  fi
}

__fzf_git_log() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'EOF'
                {}
EOF"
}

# vim keybinding
bindkey -v

# setopt
setopt no_beep
setopt auto_pushd
setopt noclobber
setopt append_history
setopt share_history
setopt hist_ignore_all_dups
setopt auto_param_slash
setopt mark_dirs
setopt magic_equal_subst
setopt globdots
setopt no_flow_control

# environment variables
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
export TERM=xterm-256color
export VISUAL="nvim"
export EDITOR="nvim"
export GOPATH="${HOME}/go"
export PATH=${PATH}:${GOPATH}/bin:${HOME}/.pub-cache/bin:${HOME}/.krew/bin:${HOME}/.bin:/home/linuxbrew/.linuxbrew/bin
export WORDCHARS="*?_-.[]~&;=!#$%^(){}<>"
# https://github.com/zsh-users/zsh-autosuggestions/issues/254
export KEYTIMEOUT=25
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
exists bat && export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# load plugins
exists starship && eval "$(starship init zsh)"
exists lesspipe && eval "$(SHELL=/bin/sh lesspipe)"
[ -f ${HOME}/.asdf/asdf.sh ] && . ${HOME}/.asdf/asdf.sh
[ -f /usr/share/zsh-completion/zsh_completion ] && . /usr/share/zsh-completion/zsh_completion
[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] && . ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f ~/.fzf/shell/completion.zsh ] && . ~/.fzf/shell/completion.zsh
[ -f ~/.fzf/shell/key-bindings.zsh ] && . ~/.fzf/shell/key-bindings.zsh
fpath=(~/.zsh/completion ~/.zsh/docker/cli/contrib/completion/zsh $fpath)

# alias
alias cd='cdls'
alias ls='ls -F --color=auto'
alias ll='ls -Flh --color=auto'
alias la='ls -Flha --color=auto'
[[ "$(uname -r)" = *microsoft* ]] && alias pbcopy='/mnt/c/Tools/win32yank.exe'
alias history='history -i'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='colordiff'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias a='alias'
alias b='__fzf_git_branch'
alias l='__fzf_git_log'
alias q='exit'
alias e='nvim ~/.zshrc'
alias u='. ~/.zshrc'
alias j='cd -'
alias k='kubectl'
alias h='cd $(git rev-parse --show-toplevel 2>/dev/null)'
alias H='cd ~'
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias g='git'
alias r='grep'
alias G='gh'
alias z='if [ ${HOME}/t = $(pwd) ]; then popd; else mkdir -p ~/t && pushd ~/t; fi'
alias d='docker'
alias fig='docker-compose'
alias tf="terraform"
alias terrafrom="terraform"
alias c="code ."
alias v='nvim'
alias agit='nvim +Agit'
# https://unix.stackexchange.com/questions/25327/watch-command-alias-expansion
alias watch='watch '

# completion
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit
autoload colors && colors
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select

exists kubectl && . <(kubectl completion zsh) && compdef k=kubectl

# history-search-end
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^p' history-beginning-search-backward-end
bindkey '^n' history-beginning-search-forward-end

# select-bracketed
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

# select-quoted
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

# surround
autoload -Uz surround
zle -N delete-surround surround
zle -N change-surround surround
zle -N add-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround

# vi mode
bindkey -M vicmd 'U' redo

# fzf
zle -N __fzf_ghq
zle -N __fzf_git_file
zle -N __fzf_git_branch
bindkey '^g' __fzf_ghq
bindkey '^o' __fzf_git_file
bindkey '^j' __fzf_git_branch

# autoload tmux
TMUX_DEFAULT_SESSION=$(whoami)
if [ $UID -ne 0 ] && [ -z "$TMUX" ] && [ -z "$SSH_CONNECTION" ]
then
  if tmux has-session -t ${TMUX_DEFAULT_SESSION} >/dev/null 2>&1
  then
    tmux -2 attach-session -t ${TMUX_DEFAULT_SESSION}
  else
    tmux -2 new -s ${TMUX_DEFAULT_SESSION}
  fi
fi

# load other rc files
[ -f ~/.zsh_aliases ] && . ~/.zsh_aliases
[ -f ~/.zshrc.local ] && . ~/.zshrc.local
