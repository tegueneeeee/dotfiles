#!/bin/sh
alias j='z'
alias f='zi'
alias g='lazygit'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

alias m="git checkout master"
alias s="git checkout stable"

alias vim='nvim'
alias ls='exa'
alias ll='ls -l'
alias copypath='pwd | pbcopy' # copy current patht to clipboard
alias o='open .'
alias c='clear'
alias cat='bat'

alias java8='export PATH="$PATH":"/usr/libexec/java_home -v 1.8/bin"'
alias java11='export PATH="$PATH":"/usr/libexec/java_home -v 11/bin"'
