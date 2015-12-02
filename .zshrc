#! /usr/bin/env zsh

# =====================================================================================================
# 汎用関数
# =====================================================================================================
function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }



# =====================================================================================================
# 基本設定
# =====================================================================================================
if is_exists vim ; then
    export EDITOR=vim
fi

export LANG=ja_JP.UTF-8 #  文字コード
setopt correct # コマンドのスペルミスを指摘
setopt no_beep # ビープ音を鳴らさない
setopt noclobber # 存在するファイルにリダイレクトしない
setopt ignoreeof # C-Dでログアウトしない
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>' # C-wで単語の一部と見なす記号


# PATH汎用設定
# pyenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PATH:$PYENV_ROOT/bin
if is_exists pyenv ; then
  eval "$(pyenv init -)";
  export=$PATH:$PYENV_ROOT/shims
fi

# =====================================================================================================
# 色設定
# =====================================================================================================
# -----
# 256色
# -----
case $TERM in
  "cygwin")
    export LANG=ja_JP.SJIS
    export LC_ALL=C
    export SHELL=`which zsh`
  ;;

  *)
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
    case "$OSTYPE" in
        darwin*)
            export TERM=xterm-256color
        ;;
    esac
  ;;
esac

# dircolorsを利用
case "$OSTYPE" in
    darwin*)
        #if [ ! is_exists gdircolors ] ; then
        #    brew install coreutils
        #fi
        [ -f ~/.dircolors ] && eval $(gdircolors ~/.dircolors) #coreutils required
        ;;
    linux*)
        [ -f ~/.dircolors ] && eval $(dircolors ~/.dircolors)
        ;;
esac

autoload colors
colors

#export LS_COLORS='di=1;34:ln=1;35:so=32:pi=33:ex=1;31:bd=46;34:cd=43;34:su=41;30:tw=42;30:ow=43;30'
#export LSCOLORS=$LS_COLORS

# ----------
# プロンプト
# ----------
zsh_prompt_color='cyan'
function prompt {
  if [ $UID -eq 0 ]; then
    local C_USERHOST="%{$bg[white]$fg[magenta]%}"
    local C_PROMPT="%{$fg[magenta]%}"
  else
    local C_USERHOST="%{$bg[black]$fg[$zsh_prompt_color]%}"
    local C_PROMPT="%{$fg[$zsh_prompt_color]%}"
  fi
  local C_PRE="%{$reset_color%}%{$fg[$zsh_prompt_color]%}"
  local C_CMD="%{$reset_color%}%{$fg[white]%}"
  local C_RIGHT="%{$bg[black]%}%{$fg[white]%}"
  local C_DEFAULT="%{$reset_color%}"
  PROMPT=$C_USERHOST"%S[%n@%m] %~ %s$C_PRE "$1"
#"$C_PROMPT"%# "$C_CMD
  RPROMPT="%S"$C_RIGHT" %D{%d %a} %* %s"$C_CMD
  echo -n -e "\n\n\n\033[3A" # keep a few blank lines at the bottom
}

#PROMPT2="%{${fg[yellow]}%} %_ > %{${reset_color}%}"
#SPROMPT="%{${fg[red]}%}correct: %R -> %r ? [n,y,a,e] %{${reset_color}%}"

prompt ""
POSTEDIT=`echotc se`
setopt prompt_subst # use colors in prompt
unsetopt promptcr



# =====================================================================================================
# 移動
# =====================================================================================================

setopt autocd # ディレクトリ名でcd
setopt autopushd #cd -で履歴を検索して移動:
setopt pushdignoredups #重複除去
setopt pushd_minus # swap '-' and '+' in the context of pushd
setopt noflowcontrol # disable C-S C-Q
setopt print_eightbit # multibyte characters


# 移動用ショートカット設定
if [ $((${ZSH_VERSION%.*}>=4.3)) -eq 1 ]; then
  # directory up on Ctrl-6
  function cdup {
    echo
    cd ..
    echo
    zle reset-prompt
  }
  zle -N cdup
  bindkey '^\^' cdup

  # directory back on Ctrl-O
  function cdback {
    if [ "$(printf '%d' "$BUFFER")" = "$BUFFER" ]; then
      # back N level (reset)
      echo
      builtin cd +$BUFFER
      echo
      BUFFER=''
      zle reset-prompt
    else
      # back 1 level (inline)
      echo
      builtin cd -
      echo
      zle reset-prompt
    fi
  }
  zle -N cdback
  bindkey '^O' cdback
fi



# =====================================================================================================
# 補完
# =====================================================================================================
autoload -Uz compinit
compinit

export LISTMAX=20 # 最大表示数
setopt nolistbeep # 補完候補表示時にビープ音を鳴らさない
setopt auto_pushd # cd -<tab>で以前移動したディレクトリを表示
setopt pushd_ignore_dups # auto_pushdで重複するディレクトリは記録しない
setopt nolistbeep # 曖昧補完でビープしない
setopt autolist # 補完時にリスト表示
setopt listtypes
unsetopt menucomplete # 最初から候補を循環する
setopt automenu # 共通部分を補完しそれ以外を循環する準備
setopt extendedglob # 展開で^とか使う
setopt numericglobsort # 数字展開は数値順
setopt autoparamkeys # 補完後の:,)を削除
fignore=(.o .swp lost+found) # 補完で無視する
#setopt listpacked # compact list on completion # 不安定?
#setopt magicequalsubst # completion after '=' # 不安定?
#setopt auto_list
#setopt auto_menu
#setopt auto_param_keys
#setopt complete_aliases
#setopt list_types
#setopt always_last_prompt
#setopt complete_in_word



# 候補が多い場合は詰めて表示
setopt list_packed
setopt magic_equal_subst

# 大文字小文字を区別しない（大文字を入力した場合は区別する）
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[-_./]=** r:|=*'

# Ctrl-p, Ctrl-Nを有効に
zstyle ':completion:*:default' menu select=1

# 補完候補もLS_COLORSに合わせて色が付くようにする
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# match upper case from lower case, search after -_./
# dir => Dir, _t => some_tmp, long.c => longfilename.c
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[-_./]=** r:|=*'

# smart insert last word
autoload smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match '*([^[:space]][[:alpha]/\\]|[[:alpha:]/\\][^[:space:]])*'
bindkey '^]' insert-last-word



# =====================================================================================================
# 履歴
# =====================================================================================================
HISTFILE=~/.zsh_history
HISTSIZE=100000 # メモリ上に保存される件数（検索できる件数）
SAVEHIST=100000 # ファイルに保存される件数
setopt share_history # 履歴を複数の端末で共有する
setopt hist_ignore_dups # 直前と同じコマンドの場合は履歴に追加しない
setopt hist_ignore_all_dups # 重複するコマンドは古い方を削除する
setopt hist_ignore_space # 先頭がスペースで始まる場合は履歴に追加しない
#setopt append_history # 複数のzshを同時に使用した際に履歴ファイルを上書きせず追加する
#setopt extended_history # 履歴ファイルにzsh の開始・終了時刻を記録する
#setopt hist_verify # ヒストリを呼び出してから実行する間に一旦編集できる状態になる
#setopt hist_save_no_dups # ファイルに書き出すとき古いコマンドと同じなら無視
#setopt histnofunctions
#setopt histnostore
#setopt histreduceblanks

# rootは履歴を残さないようにする
if [ $UID = 0 ]; then
  unset HISTFILE
  SAVEHIST=0
fi

## smart search
# complete from history ignoring leading (sudo, '|', man, which, ..) in current prompt
# only complete in this way if there are some other input than those ignoring patterns
# examples with history:
#  ldconfig
#  make
#  make install
#  less
# case:
#  $ sudo <C-P>  => $ sudo ldconfig
#  $ sudo m<C-P>  => $ sudo make install => $ sudo make
#  $ wget -O - http://.../ | l<C-P> => $ wget -O - http://.../ | less
SMART_SEARCH_HISTORY_PATTERN='(sudo|\||man|which)'
function smart-search-history {
  local trim="$(echo "$LBUFFER" | sed -r "s/^.*${SMART_SEARCH_HISTORY_PATTERN} *//")"
  local old_leader="$(echo "$LBUFFER" | sed -r "/${SMART_SEARCH_HISTORY_PATTERN}/s/(^.*${SMART_SEARCH_HISTORY_PATTERN} *).+?$/\\1/p;d")"
  if [ -n "$trim" ]; then
    LBUFFER="$trim"
    zle $1
    LBUFFER="$old_leader""$LBUFFER"
  else
    zle $1
  fi
}

# 履歴検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end



# =====================================================================================================
# ssh関連
# =====================================================================================================
# ssh-agent wrapper
is_exists lazy-ssh-agent && eval `lazy-ssh-agent setup ssh scp sftp`

# ssh
function print_known_hosts {
  if [ -f $HOME/.ssh/known_hosts ]; then
    cat $HOME/.ssh/known_hosts | tr ',' ' ' | cut -d' ' -f1
  fi
}
_cache_hosts=($(print_known_hosts))

#centosにsshするとviで下記のエラーが出ることがあるので対策
# E437: terminal capability "cm" required
alias ssh='TERM=xterm ssh'
# add "setenv SCREEN=1" in .screenrc
if [ "${SCREEN}x" = "1x" ]; then
  export LANG=C
fi



# =====================================================================================================
# プレクサ関連
# =====================================================================================================
function tmux_automatically_attach_session()
{
    if is_screen_or_tmux_running; then
        ! is_exists 'tmux' && return 1

        if is_tmux_runnning; then
            #echo "${fg_bold[red]} _____ __  __ _   ___  __ ${reset_color}"
            #echo "${fg_bold[red]}|_   _|  \/  | | | \ \/ / ${reset_color}"
            #echo "${fg_bold[red]}  | | | |\/| | | | |\  /  ${reset_color}"
            #echo "${fg_bold[red]}  | | | |  | | |_| |/  \  ${reset_color}"
            #echo "${fg_bold[red]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
            echo "This is on tmux."
        elif is_screen_running; then
            echo "This is on screen."
        fi
    else
        if shell_has_started_interactively && ! is_ssh_running; then
            if ! is_exists 'tmux'; then
                echo 'Error: tmux command not found' 2>&1
                return 1
            fi

            if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
                # detached session exists
                tmux list-sessions
                echo -n "Tmux: attach? (y/N/num) "
                read
                if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
                    tmux attach-session
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
                    tmux attach -t "$REPLY"
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                fi
            fi

            if is_osx && is_exists 'reattach-to-user-namespace'; then
                # on OS X force tmux's default command
                # to spawn a shell in the user's namespace
                tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
                tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
            else
                tmux new-session && echo "tmux created new session"
            fi
        fi
    fi
}
#tmux_automatically_attach_session



# =====================================================================================================
# ショートカット関連
# =====================================================================================================
case $OSTYPE in
    darwin*)
        alias ls='ls -FGh'
        alias ll='ls -FGhl'
        alias la='ls -FGhla'
    ;;
    linux*)
        alias ls='ls -FGh --color=auto'
        alias ll='ls -FGhl --color=auto'
        alias la='ls -FGhla --color=auto'
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
alias ':q'='exit'
alias w3m='w3m -O ja_JP.UTF-8'
if is_exists trash; then
  alias go='trash'
fi
alias T='tail -n 50 -f'
alias psp='ps -F ax'

alias ~='cd ~'
alias ..='cd ..'
alias ...='cd ...'
alias ....='cd ....'
#shortcuts
alias -g ...='../../'
alias -g ....='../../../'
alias -g .....='../../../../'
alias man='man'
alias jman="LC_MESSAGES=$LANG man"
alias -g F='|grep -i'
alias -g GG='|xargs -0 grep -i'
alias -g G='2>&1|grep -i'
alias -g L="2>&1|$PAGER"
alias -g V="2>&1|vim -R -"

# sed -> gsed
if is_exists gsed; then
  alias sed='gsed'
fi

# backup whole directory
function backup {
  D=`pwd|sed -r 's/^.*\/(.*?)$/\1/'`
  F=${D}_`date +%Y%m%d_%H%M`.tar.gz
  if [ -f 'Makefile' ]; then make clean; fi
  (builtin cd ..;
  tar zcvf ${F} $D;
  builtin cd -)
  if [ $# -ge 1 ]; then mv ${F} "$1/"; fi
  echo "saved: ${F}"
}

# backup only right on the current level (no recursion)
function slimbackup {
  D=`pwd|sed -r 's/^.*\/(.*?)$/\1/'`
  F=${D}_`date +%Y%m%d_%H%M`.tar.gz
  if [ -f 'Makefile' ]; then make clean; fi
  (builtin cd ..;
  tar --no-recursion -zcvf ${F} $D/*(^/);
  builtin cd -)
  if [ $# -ge 1 ]; then mv ${F} "$1/"; fi
  echo "saved: ${F}"
}

# measure time.
# usage:
# $ Tic; heavy; Toc
function Tic {
  export LAST_TIC_TIME="$(date +%s)"
  export LAST_TIC_DATE="$(date +%Y/%m/%d\ %H:%M:%S)"
}

function Toc {
  CURRENT_TIME="$(date +%s)"
  CURRENT_DATE="$(date +%Y/%m/%d\ %H:%M:%S)"
  if [ x"$LAST_TIC_TIME" != "x" -a x"$LAST_TIC_DATE" != "x" ]; then
    LAST_TIC_TIME=$LAST_TIC_TIME
    LAST_TIC_DATE=$LAST_TIC_DATE
  else
    echo "Error. run Tic first"
    return
  fi
  DIFF=$(($CURRENT_TIME-$LAST_TIC_TIME))
  SEC=$(($DIFF % 60))
  MIN=$(($DIFF / 60 % 60))
  HOUR=$(($DIFF / 3600))
  echo "elapsed time = $(printf "%02d:%02d:%02d" $HOUR $MIN $SEC)   [$LAST_TIC_DATE] => [$CURRENT_DATE]"
}


function killjobs {
  # kill -9 all suspended jobs
  for pid in $(jobs -dl | sed -r '/^\(/d;s/\[[0-9]+\][ +-]*([0-9]+).*'$1'.*/\1/gp;d'); do
    kill -9 $pid
   done
}

function joblist { ps -l|awk '/^..T/&&NR!=1{print $14}'|sed ':a;$!N;$!b a;;s/\n/,/g' }
function jobnum { ps -l|awk '/^..T/&&NR!=1{print}'|wc -l}



# ローカルのzshrcを読み込む
[ -f ~/.zshrc.local ] && source ~/.zshrc.local


