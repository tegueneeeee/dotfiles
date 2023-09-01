# Unalias ls in case if we already alias ls to exa
unalias ls > /dev/null 2>&1

#  Brew auto completion.
#  Need to call before oh-my-zsh.
if type brew &> /dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

    autoload -Uz compinit
    compinit
fi

source "$HOME/.zshconfig/antigen/antigen.zsh"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo ('s oh-my-zsh).
antigen bundle git
antigen bundle adb
antigen bundle ripgrep
antigen bundle gitignore
antigen bundle pip
antigen bundle command-not-found
antigen bundle asdf
antigen bundle lukechilds/zsh-nvm

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Local plugins.
antigen bundle "$HOME/.zshconfig/plugins"

# Antigen check files
export ANTIGEN_AUTO_CONFIG=false
export ANTIGEN_CHECK_FILES=("$HOME"/.zshrc "$HOME"/.zshconfig/plugins/*)

# Tell Antigen that you're done.
antigen apply

export TERM="xterm-256color"

# Due to the following issue:
# https://github.com/zsh-users/zsh-syntax-highlighting/issues/295
# Syntax highlighting is really slow when pasting long text. This speeds it
# up to just a slight delay
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

# Set language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

# Path
export PATH="$PATH:$HOME/.zshconfig/plugins/bin"
export PATH="$PATH:$HOME/.pub-cache/bin"
export N_PREFIX=$HOME/.n
export PATH=$N_PREFIX/bin:$PATH
export PATH="$PATH:$HOME/.yvm/yvm.sh"
export PATH="$PATH:/opt/homebrew/opt/mysql-client@5.7/bin"
export YVM_DIR=/Users/kimtaekwon/.yvm
[ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh


# startship
eval "$(starship init zsh)"

# fuck
eval "$(thefuck --alias)"

# pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# ignore ctrl + d
setopt ignoreeof

# Alias
alias vi=nvim
alias copypath='pwd | pbcopy' # copy current path to clipboard
alias o='open .'
alias c='clear'
alias ls='exa'
alias cat='bat'
