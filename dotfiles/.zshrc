#! /usr/bin/zsh
#
function exists() { type $1 >/dev/null 2>&1; return $?; }

function cdls() {
  if ! builtin cd 2>/dev/null $@; then
    echo "cannot cd: $@$reset_color"
    return
  fi
    lscdmax=40
    if [ "$?" -eq 0 ]; then
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

function _fzf_compgen_dir() {
      fd --type d -HLE.git . "$1"
}

function _fzf_comprun() {
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

function __fzf_ghq_command() {
    command=$1
    name=$(ghq list -p | fzf --preview 'tree -C {} | head -200')
    if [ ! -z "${name}" ]; then
        BUFFER="$command $name"
        zle accept-line
    fi
    zle -R -c
}

function __fzf_ghq_cd() {
    __fzf_ghq_command cd
}

function __fzf_ghq_nvim() {
    __fzf_ghq_command nvim
}

function __fzf_lazygit() {
    name=$(ghq list -p | fzf --preview 'tree -C {} | head -200')
    if [ ! -z "${name}" ]; then
        BUFFER="cd $name && lazygit"
        zle accept-line
    fi
    zle -R -c
}

function __zi() {
  zi
  BUFFER="ls"
  zle accept-line
}

# https://dev.classmethod.jp/articles/fzf-original-app-for-git-add/
function __fzf_git_command() {
    command=$1
    local selected
    selected=$(unbuffer git status -s | fzf -m --ansi --preview="echo {} | awk '{print \$2}' | xargs git diff --color" | awk '{print $2}')
    if [[ -n "$selected" ]]; then
        selected=$(echo "$selected" | perl -pe 's/\n/ /g' | perl -pe 's/\s+$//')
        eval "git $command $selected"
        zle accept-line
    fi
    zle -R -c
}

function __fzf_git_add() {
    __fzf_git_command "add"
}

function __fzf_git_restore() {
    __fzf_git_command "restore -s HEAD"
}

function __fzf_git_file() {
    editor=$1
    toplevel=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ -z "${toplevel}" ]

    then
      echo "error: this is not a git repository"
      return 1
    fi

    grep_cmd="git fd --type f -H --exclude '.git' --exclude 'vendor'"
    preview_cmd="bat --style=numbers --color=always --line-range :200 ${toplevel}/{}"
    selected=$(eval $grep_cmd | fzf --preview "$preview_cmd")
    if [ ! -z "${selected}" ]
    then
      BUFFER="${editor:-vim} ${toplevel}/${selected}"
      zle accept-line
    fi
    zle -R -c
}

function __fzf_git_file_nvim() {
    __fzf_git_file nvim
}

function __fzf_git_file_cursor() {
    __fzf_git_file cursor
}

function __fzf_git_dir() {
    toplevel=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ -z "${toplevel}" ]
    then
      echo "error: this is not a git repository"
      return 1
    fi

    grep_cmd="git fd --type d -H --exclude '.git' --exclude 'vendor'"
    preview_cmd="tree -C {} | head -n 200"
    selected=$(eval $grep_cmd | fzf --preview "$preview_cmd")
    if [ ! -z "${selected}" ]
    then
      BUFFER="cd ${toplevel}/${selected}"
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

function __fzf_git_log() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'EOF'
                {}
EOF"
}

# https://sushichan044.hateblo.jp/entry/2025/06/06/003325
function __fzf_git_worktree() {
    # Format of `git worktree list`: path commit [branch]
    local selected_worktree=$(git worktree list | fzf \
        --prompt="worktrees > " \
        --header="Select a worktree to cd into" \
        --preview="echo '📦 Branch:' && git -C {1} branch --show-current && echo '' && echo '📝 Changed files:' && git -C {1} status --porcelain | head -10 && echo '' && echo '📚 Recent commits:' && git -C {1} log --oneline --decorate -10" \
        --preview-window="right:40%" \
        --reverse \
        --border \
        --ansi)

    if [ $? -ne 0 ]; then
        return 0
    fi

    if [ -n "$selected_worktree" ]; then
        local selected_path=${${(s: :)selected_worktree}[1]}

        if [ -d "$selected_path" ]; then
            if zle; then
                # Called from ZLE (keyboard shortcut)
                BUFFER="cd ${selected_path}"
                zle accept-line
            else
                # Called directly from command line
                cd "$selected_path"
            fi
        else
            echo "Directory not found: $selected_path"
            return 1
        fi
    fi

    # Only clear screen if ZLE is active
    if zle; then
        zle clear-screen
    fi
}

function __mux_lazy() {
  command -v tmuxinator >/dev/null || { echo "tmuxinator not found"; return 1; }

  local dir_name branch_name session_name

  dir_name=$(basename "$(pwd)")

  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    branch_name=$(git rev-parse --abbrev-ref HEAD)
    session_name="${dir_name}/${branch_name}"
  else
    session_name="${dir_name}"
  fi

  SESSION_NAME="$session_name" tmuxinator start $1
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
export LC_ALL=en_US.UTF-8
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
export _ZO_FZF_OPTS="${FZF_DEFAULT_OPTS} --preview 'echo {} | cut -f2 | xargs tree -C | head -200'"
# export TERM=xterm-256color
export VISUAL="nvim"
export EDITOR="nvim"
export GOPATH="${HOME}/go"
typeset -U path PATH
export PATH=${GOPATH}/bin:${PATH}
export PATH=${HOME}/.bin::${PATH}
export PATH=/home/linuxbrew/.linuxbrew/bin:${PATH}
export PATH=${HOME}/.pub-cache/bin:${PATH}
export PATH=${HOME}/.krew/bin:${PATH}
export PATH=${HOME}/.local/bin:${PATH}
export PATH=${HOME}/.zsh/git-open:${PATH}
export WORDCHARS="*?_-.[]~&;=!#$%^(){}<>"
# https://github.com/zsh-users/zsh-autosuggestions/issues/254
export KEYTIMEOUT=25
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
exists bat && export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export FLUTTER_ROOT=.fvm/flutter_sdk
export MISE_LOG_LEVEL=error
export GH_BROWSER="'/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe'"
export BROWSER="/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"

# This env tells xdg-open to use Microsoft edge on Windows as a web browser.
# https://stackoverflow.com/questions/66585350/ddev-local-wsl2-how-do-i-get-xdg-open-to-open-a-browser-on-windows-from-wsl2
export BROWSER="powershell.exe /C start"

# load plugins
exists starship && eval "$(starship init zsh)"
exists lesspipe && eval "$(SHELL=/bin/sh lesspipe)"
[ -f /usr/share/zsh-completion/zsh_completion ] && . /usr/share/zsh-completion/zsh_completion
[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] && . ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f ~/.fzf/shell/completion.zsh ] && . ~/.fzf/shell/completion.zsh
[ -f ~/.fzf/shell/key-bindings.zsh ] && . ~/.fzf/shell/key-bindings.zsh
[ -f ~/.zsh/fzf-tab-completion/zsh/fzf-zsh-completion.sh ] && . ~/.zsh/fzf-tab-completion/zsh/fzf-zsh-completion.sh
fpath=(~/.zsh/completion ~/.zsh/docker/cli/contrib/completion/zsh ~/.zsh/task/completion/zsh $fpath)
eval "$(zoxide init zsh)"
if exists mise; then
  eval "$(mise activate zsh)"
fi

# alias
alias '$'=''
alias python='python3'
alias ipython='ipython3'
alias pip='pip3'
alias y2j='yq -p yaml -o json'
alias j2y='yq -p json -o yaml'
alias l2j="jq -Rn '[inputs]'"
alias j2x="yq -p json -o xml"
alias x2j="yq -p xml -o json"
alias cd='cdls'
alias ls='ls -F --color=auto'
alias ll='ls -Flh --color=auto'
alias la='ls -Flha --color=auto'
alias history='history -i'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='colordiff'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias a='alias'
alias q='exit'
alias e='nvim ~/.zshrc'
alias u='. ~/.zshrc'
alias j='cd -'
alias k='kubectl'
alias h='cd $(git rev-parse --show-toplevel 2>/dev/null)'
alias H='cd ~'
alias t='cd ~/t'
alias Y='yazi'
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias g='git'
alias r='grep'
alias d='docker'
alias fig='docker compose'
alias tf="terraform"
alias terrafrom="terraform"
alias c='claude'
alias yolo='claude --dangerously-skip-permissions'
alias v='nvim'
alias V='vim'
# https://unix.stackexchange.com/questions/25327/watch-command-alias-expansion
alias watch='watch '
alias GG="gh dash"
alias myip="curl https://checkip.amazonaws.com/"
exists lazygit && alias G="lazygit"
exists oxker && alias D="oxker"
exists fzf && alias C="fzf | cut -d: -f1 | code - >/dev/null"
exists fzf && alias F="fzf"
exists tl && alias L="tl"
exists xplr && alias E="xplr"
exists k9s && alias K='k9s --readonly'
exists k9s && alias k9s='k9s --readonly'
exists k9s && alias k9sw='k9s'
exists htop && alias T='htop'
exists tmuxinator && alias mux='tmuxinator'
exists tmuxinator && alias X="__mux_lazy lazygit-claude"

[[ "$(uname -r)" = *microsoft* ]] && alias pbcopy='/mnt/c/Tools/win32yank.exe -i'
[[ "$(uname -r)" = *microsoft* ]] && alias y='/mnt/c/Tools/win32yank.exe -i'

# completion
autoload -Uz compinit && compinit -i
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
zle -N __zi
zle -N __fzf_ghq_cd
zle -N __fzf_ghq_nvim
zle -N __fzf_git_file_nvim
zle -N __fzf_git_worktree
zle -N __fzf_git_dir
zle -N __fzf_git_log
zle -N __fzf_git_branch
bindkey '^g' __fzf_ghq_cd
bindkey '^y' __fzf_ghq_nvim
bindkey '^o' __fzf_git_file_nvim
bindkey '^s' __fzf_git_worktree
bindkey '^e' __fzf_git_dir
bindkey '^j' __fzf_git_branch
bindkey '^a' __fzf_git_log
bindkey '^z' __zi

# autoload tmux
TMUX_DEFAULT_SESSION=default
if [ "$TERM_PROGRAM" != "vscode" ]
then
  if [ $UID -ne 0 ] && [ -z "$TMUX" ] && [ -z "$SSH_CONNECTION" ]
  then
    if tmux has-session -t ${TMUX_DEFAULT_SESSION} >/dev/null 2>&1
    then
      tmux -2 attach-session -t ${TMUX_DEFAULT_SESSION}
    else
      tmux -2 new -s ${TMUX_DEFAULT_SESSION}
    fi
  fi
fi

# load other rc files
[ -f ~/.zsh_aliases ] && . ~/.zsh_aliases
[ -f ~/.zshrc.local ] && . ~/.zshrc.local

