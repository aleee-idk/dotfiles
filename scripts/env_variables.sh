#!/usr/bin/env bash
export terminal_directory="kitty --detach -d"
export dotfile_folder="$HOME/dotfiles/"
export config_folder="$HOME/.config/"
export wallpapers="$HOME/Nextcloud/principal/Imagenes/Waifus"

export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR="nvim"
export FLAVOURS_DATA_DIRECTORY="$HOME/dotfiles/config/flavours_data"

export SXHKD_SHELL="bash"

export SUDO_PROMP="\e[0;91mPsw Please!\e[0m "

declare -A common_entries
common_entries[dotfiles]="$dotfile_folder"
common_entries[.config]="$config_folder"
common_entries["code project"]="$HOME/Nextcloud/principal/code_projects"
common_entries[bashrc]="$HOME/.bashrc"
common_entries["Cheatsheets"]="$HOME/Documents/Notes/Cheatsheets"

# Clean common_entries array making sure that the files exist
declare -xA common_folders
for i in "${!common_entries[@]}"; do
	if [[ -d ${common_entries["${i}"]} ]]; then
		common_folders["${i}"]="${common_entries[${i}]}"
	fi
done

declare -xA common_files
for i in "${!common_entries[@]}"; do
	if [[ -f ${common_entries["${i}"]} ]]; then
		common_files["${i}"]="${common_entries[${i}]}"
	fi
done

declare -xA recent_folders=$(cat "$HOME/.dirhistory")

# --- End Definitions Section ---
# check if we are being sourced by another script or shell

[[ "${#BASH_SOURCE[@]}" -gt "1" ]] && { return 0; }

# --- Begin Code Execution Section ---

