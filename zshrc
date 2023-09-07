# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
antigen bundle autojump
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Load the theme.
antigen theme romkatv/powerlevel10k

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
export PATH="$PATH:$HOME/.pub-cache/bin"
export N_PREFIX=$HOME/.n
export PATH=$N_PREFIX/bin:$PATH
export PATH="$PATH:$HOME/.yvm/yvm.sh"
export PATH="$PATH:/opt/homebrew/opt/mysql-client@5.7/bin"
export YVM_DIR=/Users/kimtaekwon/.yvm
[ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh


# Alia
alias vi='nvim'
alias ll='ls -l'
alias copypaht='pwd | pbcopy' # copy current patht to clipboard
alias o='open .'
alias c='clear'
alias ls='exa'
alias cat='bat'


# fuck
eval "$(thefuck --alias)"

# pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# ignore ctrl + d
setopt ignoreeof

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
