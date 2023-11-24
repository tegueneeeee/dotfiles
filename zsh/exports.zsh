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
export PATH="$PATH":"$HOME/.maestro/bin"

eval "$(zoxide init zsh)"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(rbenv init - zsh)"
