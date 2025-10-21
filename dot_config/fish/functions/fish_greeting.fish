function fish_greeting -d "Catppuccin Frappe Meow 🐾"
    # Catppuccin Frappe palette
    set -l latte (set_color -o F2D5CF)
    set -l flamingo (set_color -o EE99A0)
    set -l mauve (set_color -o CA9EE6)
    set -l sky (set_color -o 99D1DB)
    set -l teal (set_color -o 81C8BE)
    set -l yellow (set_color -o E5C890)
    set -l subtext (set_color -o B5BFE2)
    set -l normal (set_color normal)

    # Catppuccin-inspired kitty
    set -l frappe_cat \
        '
           ╱|、
          (°、。7
           |、 ~~ヽ　
           じしf_,) ノ 
    '
    # System info
    set -l fish_ver (fish --version | awk '{print $3}')
    set -l uptime (uptime | grep -ohe 'up .*' | sed 's/,//g' | awk '{ print $2" "$3 }')

    echo
    echo -e "$mauve Meow from Catppuccin Frappe!$normal"
    echo -e "$flamingo$frappe_cat$normal"
    echo -e "$sky   Shell: $subtext$fish_ver$normal"
    echo -e "$teal   Uptime: $subtext$uptime$normal"
    echo
end
