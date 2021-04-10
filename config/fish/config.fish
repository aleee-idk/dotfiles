# PATH
set -a PATH ~/dotfiles/scripts

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

# Vi Mode

neofetch
starship init fish | source

