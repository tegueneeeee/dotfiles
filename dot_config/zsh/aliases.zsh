#!/bin/sh
alias j='z'
alias f='zi'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

alias vi='nvim'
alias vim='nvim'
alias neovim='nvim'
alias g='git'
alias gi='git'
alias c='clear'
alias ls='exa'
alias ll='ls -l'
alias copypath='pwd | pbcopy' # copy current patht to clipboard
alias o='open .'
alias cat='bat'
alias .='cd ..'
alias ..='cd ../..'
alias ...='cd ../../..'
alias ....='cd ../../../..'
alias .....='cd ../../../../..'
alias emu='emulator @$(emulator -list-avds | peco)'
alias emu-ls='avdmanager list avd'
alias simu='open -a Simulator'
alias simu-ls='xcrun simctl list'
