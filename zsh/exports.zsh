#/bin/sh
# HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
export LANG=en_US.UTF-8
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export N_PREFIX=$HOME/.n
export PATH=$PATH:$N_PREFIX/bin
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH":"$HOME/fvm/default/bin"
export PATH="$PATH":"$HOME/.local/bin"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"


eval "$(zoxide init zsh)"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
