#!/bin/bash
# vim:foldmethod=marker

##### Variables ##### {{{
directory=$1
file_manager="ranger"

IFS=',' read -ra protected_directories <<< "$2"

# Ansi color code variables
red="\e[0;91m"
blue="\e[0;94m"
expand_bg="\e[K"
blue_bg="\e[0;104m${expand_bg}"
red_bg="\e[0;101m${expand_bg}"
green_bg="\e[0;102m${expand_bg}"
green="\e[0;92m"
white="\e[0;97m"
bold="\e[1m"
uline="\e[4m"
reset="\e[0m"

max_size=5 # in GB

##### Variables ##### }}}

##### Functions ##### {{{

check_directories() {
	for item in "${protected_directories[@]}"; do
		[[ "$item" =~ $(basename "$1") ]] && return 0
    	done
	return 1
}

check_confirmation() {
	answer="x"
	while [[ ! "$answer" =~ [yYnN] ]]; do
		read -p "$1 [y/N]" -n 1 answer
	done
	echo "$answer"
}

##### Functions ##### }}}

user_id=$(id -u)

# Exit if ran as root
if [[ $user_id == 0 ]]; then
	echo -e "Don't run this script as ${red}root${reset} user!"
	exit 0
fi

cd $directory

# Exit if directory doesn't exist
[[ $? -ne 0 ]] && exit 0

size=$(sudo du -hsc | tail -n1 | awk '($1~/G$/) {print $1}')

echo -e "The $blue${directory}$reset directory size is: $red${size}$reset"

size=$(echo $size | sed 's/[^0-9]//g')

# Exits if filezie is less than size treshold
# if [[ -z "$size" || $size -lt $max_size ]]; then
# 	echo -e "Folder size is less than $red${max_size}G$reset, skipping"
# 	exit 0
# fi


echo "The following directories will be checked and ask for confirmation:"
for item in "${protected_directories[@]}"; do
	echo -e "$green${item}$reset"
done

echo -e "${red_bg}Everything else will be deleted, please backup everthin you need.$reset"

read -p "Press anything to open $file_manager"

answer="x"
while true ; do
	$file_manager "$directory"
	answer="$(check_confirmation "Are you done checking the files?")"
	echo
	[[ "$answer" =~ [yY] ]] && break
done

echo

for file in "$directory"/*; do
	if check_directories "$file"; then
		# Preserve directory, delete content
		echo

		folder_size=$(sudo du -hsc "$file"| tail -n1 | awk '{print $1}')
		echo -e "The $blue${file}$reset directory size is: $red${folder_size}$reset"
		echo

		# answer="$(check_confirmation "Clean $file directory?")"
		# echo 

		# [[ "$answer" =~ [yY] ]] && sudo gio trash -f "$file"/*
	else
		# Delete file/directory
		sudo gio trash -f "$file"
		echo -e "$red${file} deleted!$reset"
	fi

done

echo
new_size=$(sudo du -hsc | tail -n1 | awk '($1~/G$/) {print $1}')
echo -e "The $blue${file}$reset directory size is: $red${new_size}$reset"

new_size=$(echo $new_size | sed 's/[^0-9]//g')
echo -e "$green$((size - new_size))G${reset} saved!"
