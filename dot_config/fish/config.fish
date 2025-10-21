set -x LANG en_US.UTF-8
set -x LANGUAGE $LANG
set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8
set -x LESS -R

if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_vi_key_bindings
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_vi_force_cursor
end

set -x ANDROID_HOME $HOME/Library/Android/sdk

starship init fish | source
