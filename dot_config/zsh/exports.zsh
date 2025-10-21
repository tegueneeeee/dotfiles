export TERM='xterm-256color'
export LANG=en_US.UTF-8
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_SDK_ROOT="$HOME/Library//Android/sdk"
export PATH="$PATH":"$ANDROID_HOME/platform-tools"
export PATH="$PATH":"$ANDROID_HOME/tools"
export PATH="$PATH":"$ANDROID_HOME/tools/bin"
export PATH="$PATH":"$ANDROID_HOME/emulator"
export PATH="$PATH":"$ANDROID_HOME/cmdline-tools/latest/bin"
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH":"$HOME/.fastlane/bin"
export PATH="$PATH":"$HOME/.maestro/bin"
export GPG_TTY=$(tty)

eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"
