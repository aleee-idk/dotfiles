# PATH
set -a PATH ~/dotfiles/scripts
set -a PATH ~/.local/bin

# Colors

# Leave to the terminal?
# source ~/.config/fish/colors/tokyonight_strom.fish

# Alias

# Thefuck
thefuck --alias | source

# Sudo
function please --wraps sudo --description 'alias sudo = "sudo -v", refresh sudo timeout each time is called'
	sudo -v $argv
end

# Pacman
function paci --wraps pacman --description 'alias paci=pacman -S'
	sudo pacman -S $argv
end
function pacr
	sudo pacman -Rs $argv
end
function pacu
	sudo pacman -Syu $argv
end

# get list of directory
function listdir
	exa -la --no-permissions --no-filesize --no-time --no-time --no-user $argv
end
# Pretty list directories
function ls --wraps exa --description 'alias ls=exa -lh --color=always --icons --git '
	exa -lh --color=always --icons --git $argv
end

# Python
function py
	python $argv
end

# Plugins
fundle plugin 'PatrickF1/fzf.fish'
fundle plugin 'franciscolourenco/done'
fundle plugin 'Gazorby/fish-abbreviation-tips'

fundle init

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
