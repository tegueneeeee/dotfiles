set -gx FZF_DEFAULT_COMMAND 'fd --hidden --strip-cwd-prefix --exclude ".git"'
set -gx FZF_DEFAULT_OPTS "\
--layout=reverse --cycle --height=50% --margin=5% --border=double \
--color=bg+:#414559,bg:#303446,spinner:#F2D5CF,hl:#E78284 \
--color=fg:#C6D0F5,header:#E78284,info:#CA9EE6,pointer:#F2D5CF \
--color=marker:#BABBF1,fg+:#C6D0F5,prompt:#CA9EE6,hl+:#E78284 \
--color=selected-bg:#51576D \
--color=border:#737994,label:#C6D0F5"

fzf --fish | source

function fssh -d "Fuzzy-find ssh host via ag and ssh into it"
    ag --ignore-case '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2 | fzf | read -l result; and ssh "$result"
end

function cdf -d "[CDF] Directory Favorite/Bookmark using FZF"
    if not set -q THEOSHELL_CDF_DIR
        echo 'You must provide THEOSHELL_CDF_DIR'
        return 1
    end

    set -l dir (fzf --header="Favorite Directories" < $THEOSHELL_CDF_DIR)
    not test -z $dir; and cd "$dir"
end

function cdf_add -d "[CDF] Add CWD to the directory list"
    if not set -q THEOSHELL_CDF_DIR
        echo 'You must provide THEOSHELL_CDF_DIR'
        return 1
    end

    if not test -e $THEOSHELL_CDF_DIR
        mkdir -p (dirname $THEOSHELL_CDF_DIR)
        touch $THEOSHELL_CDF_DIR
    end

    pwd >>$THEOSHELL_CDF_DIR
end

abbr cdf_edit $EDITOR $THEOSHELL_CDF_DIR
