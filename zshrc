#! /usr/bin/zsh
#
exists() { type $1 >/dev/null 2>&1; return $?; }

export SHELL=`which zsh`
export PATH=$HOME/bin:$PATH
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export HISTCONTROL=ignoreboth
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTTIMEFORMAT="%h %d %H:%M:%S "
[ -n "$(which bat)" ] && export MANPAGER="sh -c 'col -bx | bat -l man -p'"
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
    export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
else
    export VISUAL="nvim"
    export EDITOR="nvim"
fi

setopt no_beep
setopt auto_pushd
setopt noclobber
setopt append_history
setopt share_history
setopt hist_ignore_dups

stty -ixon

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# NOTE: .zshrc.wsl should be read before .zshrc.tmux
if uname -r | grep -i 'microsoft' > /dev/null; then
    [ -f ~/.zshrc_dir/wsl ] && .  ~/.zshrc_dir/wsl
fi
[ -f ~/.zshrc_dir/tmux ] && .  ~/.zshrc_dir/tmux
[ -f ~/.zshrc_dir/langs ] && . ~/.zshrc_dir/langs
[ -f ~/.zshrc_dir/completion ] && . ~/.zshrc_dir/completion

# NOTE: .zshrc.commands should be read after .zshrc.completion
[ -f ~/.zshrc_dir/commands ] && . ~/.zshrc_dir/commands
[ -f ~/.zshrc_dir/prompt ] && . ~/.zshrc_dir/prompt

[ -f ~/.zsh_aliases ] && . ~/.zsh_aliases
[ -f ~/.zshrc.local ] && . ~/.zshrc.local

