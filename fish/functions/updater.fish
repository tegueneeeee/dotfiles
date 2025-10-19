function updater -d "Using fzf to pick and run update commands"
    set -l stuff dotfiles 'Nvim: Lazy' 'Vim: Plug'
    set -a stuff 'Homebrew: Update' 'Homebrew: Cleanup' 'Homebrew: Doctor'

    while true
        # Prompt user and check for C-c and no input
        set selected $(printf "%s\n" $stuff | fzf \
      --reverse --border=rounded --cycle --height=50% \
      --header='[Updater] Choose the update command')
        [ -z $selected ]; and echo '[Updater] Ending the updater...'; and return

        echo '[Updater] ' $selected '...'
        switch $selected
            case dotfiles
                cd ~/.dotfiles/ && git pull && cd - &>/dev/null
            case 'Nvim: Lazy'
                nvim --headless "+Lazy! sync" +qa
            case 'Vim: Plug'
                vim +PlugUpdate
            case 'Homebrew: Update'
                brew update && brew upgrade
                and echo '[Updater] Brew update && upgrade successful'
                or echo '[Updater] Brew update && upgrade failed'
            case 'Homebrew: Cleanup'
                brew autoremove && brew cleanup
                and echo '[Updater] Brew autoremove && cleanup successful'
                or echo '[Updater] Brew autoremove && cleanup failed'
                echo '[Updater] TIP: Perodically `brew untap` unnecessary sources'
            case 'Homebrew: Doctor'
                brew doctor
        end # End switch
    end # End while true
end # End function
