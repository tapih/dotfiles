#! /bin/bash
case $- in
    *i*) ;;
      *) return;;
esac

exists() { type $1 >/dev/null 2>&1; return $?; }

export SHELL=`which bash`
export PATH=$HOME/bin:$PATH
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
[ -n "$(which batcat)" ] && export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
    export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
else
    export VISUAL="nvim"
    export EDITOR="nvim"
fi

stty werase undef
bind '"\C-w": unix-filename-rubout'

set -o noclobber
shopt -s histappend
shopt -s cmdhist
shopt -s globstar
HISTCONTROL=ignoreboth
HISTSIZE=100000
HISTFILESIZE=100000
export HISTTIMEFORMAT="%h %d %H:%M:%S "
export PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"

bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# NOTE: .bashrc.wsl should be read before .bashrc.tmux
if uname -r | grep -i 'microsoft' > /dev/null; then
    [ -f ~/.bashrc_dir/wsl ] && .  ~/.bashrc_dir/wsl
fi
[ -f ~/.bashrc_dir/tmux ] && .  ~/.bashrc_dir/tmux
[ -f ~/.bashrc_dir/langs ] && . ~/.bashrc_dir/langs
[ -f ~/.bashrc_dir/completion ] && . ~/.bashrc_dir/completion

# NOTE: .bashrc.commands should be read after .bashrc.completion
[ -f ~/.bashrc_dir/commands ] && . ~/.bashrc_dir/commands
[ -f ~/.bashrc_dir/prompt ] && . ~/.bashrc_dir/prompt

[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.bashrc.local ] && . ~/.bashrc.local

source "$HOME/.cargo/env"
