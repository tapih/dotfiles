#! /usr/bin/env zsh

bindkey -e
bindkey '^J' vi-find-next-char
bindkey '^j' vi-find-prev-char

HISTFILE=~/.zsh_history
HISTSIZE=100000 # メモリ上に保存される件数（検索できる件数）
SAVEHIST=100000 # ファイルに保存される件数

autoload -Uz compinit
compinit

export LISTMAX=20 # 最大表示数
export LANG=ja_JP.UTF-8 #  文字コード
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>' # C-wで単語の一部と見なす記号

setopt print_eightbit # 日本語ファイルを表示可能に
setopt correct # コマンドのスペルミスを指摘
setopt no_beep # ビープ音を鳴らさない
setopt noclobber # 存在するファイルにリダイレクトしない
setopt ignoreeof # C-Dでログアウトしない
setopt noflowcontrol # disable C-S C-Q
setopt nolistbeep # 補完候補表示時にビープ音を鳴らさない
#setopt auto_pushd # cd -<tab>で以前移動したディレクトリを表示
#setopt pushd_ignore_dups # auto_pushdで重複するディレクトリは記録しない
setopt nolistbeep # 曖昧補完でビープしない
setopt autolist # 補完時にリスト表示
setopt listtypes
unsetopt menucomplete # 最初から候補を循環する
setopt automenu # 共通部分を補完しそれ以外を循環する準備
setopt extendedglob # 展開で^とか使う
setopt numericglobsort # 数字展開は数値順
setopt autoparamkeys # 補完後の:,)を削除
#setopt listpacked # compact list on completion # 不安定?
setopt magicequalsubst # completion after '='
#setopt auto_list
#setopt auto_menu
#setopt auto_param_keys
#setopt complete_aliases
#setopt list_types
#setopt always_last_prompt
#setopt complete_in_word
#setopt autocd # ディレクトリ名でcd
setopt pushdignoredups #重複除去
setopt pushd_minus # swap '-' and '+' in the context of pushd
setopt list_packed # 候補が多い場合は詰めて表示
setopt magic_equal_subst
setopt share_history # 履歴を複数の端末で共有する
setopt hist_ignore_dups # 直前と同じコマンドの場合は履歴に追加しない
setopt hist_ignore_all_dups # 重複するコマンドは古い方を削除する
setopt hist_ignore_space # 先頭がスペースで始まる場合は履歴に追加しない
setopt append_history # 複数のzshを同時に使用した際に履歴ファイルを上書きせず追加する
setopt extended_history # 履歴ファイルにzsh の開始・終了時刻を記録する
setopt hist_save_no_dups # ファイルに書き出すとき古いコマンドと同じなら無視
#setopt hist_verify # ヒストリを呼び出してから実行する間に一旦編集できる状態になる
#setopt histnofunctions
#setopt histnostore
#setopt histreduceblanks


# 補完で無視する
fignore=(.o .swp lost+found)

# 大文字小文字を区別しない（大文字を入力した場合は区別する）
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[-_./]=** r:|=*'

# Ctrl-p, Ctrl-Nを有効に
zstyle ':completion:*:default' menu select=1

# 補完候補もLS_COLORSに合わせて色が付くようにする
export LS_COLORS='di=1;34:ln=1;35:so=32:pi=33:ex=1;31:bd=46;34:cd=43;34:su=41;30:tw=42;30:ow=43;30'
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 履歴検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


# 256色
export LANG=ja_JP.UTF-8
unset LC_ALL
export LC_MESSAGES=C
export SHELL=`which zsh`
export PATH=$HOME/bin:$PATH
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
  fi
  ;;
esac
[ -f ~/.dircolors ] && eval $(dircolors ~/.dircolors)

autoload -Uz vcs_info
autoload colors
colors

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]%u%c'

precmd(){ vcs_info }

zsh_prompt_color='cyan'
function prompt {
  if [ $UID -eq 0 ]; then
    local C_USERHOST="%{$bg[black]$fg[magenta]%}"
    local C_PROMPT="%{$fg[magenta]%}%%"
  else
    local C_USERHOST="%{$bg[black]$fg[$zsh_prompt_color]%}"
    local C_PROMPT="%{$fg[$zsh_prompt_color]%}$"
  fi
  local C_PRE="%{$reset_color%}%{$fg[$zsh_prompt_color]%}"
  local C_CMD="%{$reset_color%}%{$fg[white]%}"
  local C_DEFAULT="%{$reset_color%}"
  PROMPT=$C_USERHOST"%S[%n@%m] %~ %s$C_PRE"'${vcs_info_msg_0_}'"
#"$C_PROMPT" "$C_CMD
  echo -n -e "\n\n\n\033[3A" # keep a few blank lines at the bottom
}

prompt

setopt prompt_subst # use colors in prompt
unsetopt promptcr



# =====================================================================================================
# ショートカット関連
# =====================================================================================================
case $OSTYPE in
    darwin*)
        alias ls='ls -FG'
        alias ll='ls -FGlh'
        alias la='ls -FGlha'
    ;;
    linux*)
        alias ls='ls -FG --color=auto'
        alias ll='ls -FGlh --color=auto'
        alias la='ls -FGlha --color=auto'
    ;;
    msys*)
        alias ls='ls -FG --color=auto'
        alias ll='ls -FGlh --color=auto'
        alias la='ls -FGlha --color=auto'
    ;;
esac

# cd+ls (lsのエイリアスに依存)
function cd {
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

alias mv='mv -i'
alias rm='rm -i'
alias quit='exit'
alias Q='exit'
alias H='cd ~'
alias ..='cd ..'
alias ...='cd ...'
alias ....='cd ....'
alias -g ...='../../'
alias -g ....='../../../'
alias -g .....='../../../../'
alias -g F='|grep -i'
alias -g GG='|xargs -0 grep -i'
alias -g G='2>&1|grep -i'
alias -g L="2>&1|$PAGER"
alias diff='colordiff'

function do_exist() { type $1 >/dev/null 2>&1; return $?; }
do_exist vim && export EDITOR=vim
do_exist nvim && alias nv='nvim'
do_exist nvim && alias agit='nvim +Agit'
do_exist w3m && alias w3m='w3m -O ja_JP.UTF-8'
do_exist gsed && alias sed='gsed'
do_exist tmux && alias tmux="tmux -2"
do_exist git && alias g='git'
do_exist kubectl && alias k='kubectl'

# fzf
function select-history() {
    BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
    CURSOR=$#BUFFER
}

if do_exist fzf; then
    export FZF_DEFAULT_OPTS='--height 95% --reverse --border'
    zle -N select-history
    bindkey '^r' select-history
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
if [ -e $HOME/.config/enhancd/init.sh ]; then
    export ENHANCD_FILTER=fzf
    export ENHANCD_COMMAND=ecd
    source $HOME/.config/enhancd/init.sh
fi

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
