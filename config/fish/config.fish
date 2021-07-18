# PATH
set -a PATH ~/dotfiles/scripts
set -a PATH ~/.local/bin

# Colors

# Leave to the terminal?
# source ~/.config/fish/colors/tokyonight_strom.fish

# Alias

# Pacman
alias paci='sudo pacman -S'
alias pacr='sudo pacman -Rs'
alias pacu='sudo pacman -Syu'

# get list of directory
alias listdir='exa -la --no-permissions --no-filesize --no-time --no-time --no-user'
# Pretty list directories
alias ls='exa -l --color=always --icons --git'

# Python
alias py='python'

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

# Start X at login
	if status is-login
	if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
	exec startx -- -keeptty &> /dev/null
	end
	end
