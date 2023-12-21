export TERM='xterm-256color'
export LANG=en_US.UTF-8
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH":"$ANDROID_HOME/platform-tools"
export PATH="$PATH":"$ANDROID_HOME/tools"
export PATH="$PATH":"$ANDROID_HOME/tools/bin"
export PATH="$PATH":"$ANDROID_HOME/emulator"
export PATH="$PATH":"$ANDROID_HOME/cmdline-tools/latest/bin"
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH":"$HOME/fvm/default/bin"
export PATH="$PATH":"$HOME/.fastlane/bin"
export PATH="$PATH":"$HOME/.maestro/bin"
export PATH="$PATH":"$HOME/.rbenv/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh" # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

export JAVA_8_HOME=$(/usr/libexec/java_home -v 1.8)
export JAVA_11_HOME=$(/usr/libexec/java_home -v 11)

eval "$(zoxide init zsh)"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(rbenv init -)"
