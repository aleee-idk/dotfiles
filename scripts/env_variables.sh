#!/usr/bin/env bash

# Defaults
export TERMINAL="kitty"
export EDITOR="lvim"
export BROWSER="librewolf"

# Program Specifics
export QT_QPA_PLATFORMTHEME="qt5ct"
export FLAVOURS_DATA_DIRECTORY="$HOME/dotfiles/config/flavours_data"
export SXHKD_SHELL="bash"
export SUDO_PROMP="\e[0;91mPsw Please!\e[0m "

# Flutter
export JAVA_HOME='/usr/lib/jvm/java-8-openjdk'
# export JAVA_OPTS='-XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee'

# Custom
export wallpapers="$HOME/Pictures/Waifus"

# --- End Definitions Section ---
# check if we are being sourced by another script or shell

[[ "${#BASH_SOURCE[@]}" -gt "1" ]] && { return 0; }

# --- Begin Code Execution Section ---
