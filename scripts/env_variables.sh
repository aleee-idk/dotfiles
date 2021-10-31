#!/usr/bin/env bash

# Defaults
export TERMINAL="kitty"
export EDITOR="nvim"
export BROSER="librewolf"

# Program Specifics
export QT_QPA_PLATFORMTHEME="qt5ct"
export FLAVOURS_DATA_DIRECTORY="$HOME/dotfiles/config/flavours_data"
export SXHKD_SHELL="bash"
export SUDO_PROMP="\e[0;91mPsw Please!\e[0m "

# Custom
export wallpapers="$HOME/Nextcloud/principal/Imagenes/Waifus"



# --- End Definitions Section ---
# check if we are being sourced by another script or shell

[[ "${#BASH_SOURCE[@]}" -gt "1" ]] && { return 0; }

# --- Begin Code Execution Section ---

