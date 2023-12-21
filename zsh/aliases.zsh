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
alias flutter='fvm flutter'
alias dart='fvm dart'
alias java8='export JAVA_HOME=$JAVA_8_HOME ; PATH="${JAVA_HOME}/bin:${PATH}"'
alias java11='export JAVA_HOME=$JAVA_11_HOME ; PATH="${JAVA_HOME}/bin:${PATH}"'
alias .='cd ..'
alias ..='cd ../..'
alias ...='cd ../../..'
alias ....='cd ../../../..'
alias .....='cd ../../../../..'
alias emu='emulator @$(emulator -list-avds | peco)'
alias emu-ls='avdmanager list avd'
alias simu='open -a Simulator'
alias simu-ls='xcrun simctl list'
