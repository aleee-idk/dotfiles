# PATH
set -a PATH ~/dotfiles/scripts
set -a PATH ~/.local/bin

# Alias

# Pacman
alias paci='sudo pacman -S'
alias pacr='sudo pacman -Rs'
alias pacu='sudo pacman -Syu'

# Yay
alias yay='yay -S'

# create list of directory
alias listdir='exa -la --no-permissions --no-filesize --no-time --no-time --no-user'

# Python
alias py='python'

# Nvim
alias wiki='cd ~/Documents/Notes && nvim -c VimwikiIndex'

# Functions

function save_directory_history --on-variable PWD
set -l filename "$HOME/.dirhistory"
set -l max_dirs 25

# Read file
set file (cat $filename)
# Append new values if not already in there
    if not contains $PWD $file
    set -a file "$PWD"
    end

# Limit history
    while test (count $file) -gt $max_dirs
    set -e file[1]
    end

    printf '%s\n' $file > $filename
    end

# Vi Mode

    neofetch
    starship init fish | source

# Pywah Color Scheme
    cat ~/.cache/wal/sequences &

# Start X at login
    if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
    exec startx -- -keeptty &> /dev/null
    end
    end
