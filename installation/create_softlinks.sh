#!/usr/bin/env bash

set -euo pipefail

cd "$HOME"

[[ ! -e "$HOME/.config" ]] && mkdir -p "$HOME/.config/"
[[ ! -e "$HOME/.local/share/fonts/" ]] && mkdir -p "$HOME/.local/share/fonts/"

echo "Removing symlinks..."
fd -t l -d 1 . "$HOME/.config/" -x unlink {}
fd -t l -d 1 . "$HOME" -x unlink {}
fd -t l -d 1 . "$HOME"/.local/share/fonts/ -x unlink {}

echo "Creating symlinks..."
for var in $HOME/dotfiles/config/*; do 
	pkg=$(basename "$var")
	# if exist and is not a symlink
	if [[ -e "$HOME/.config/$pkg" && ! -h "$HOME/.config/$pkg" ]]; then
		echo "Config for $pkg exist, creating backup ${pkg}.old"
		mv "$HOME/.config/$pkg" "$HOME/.config/${pkg}.old"
	fi
	ln -sf "$var" "$HOME/.config/"
done
for var in $HOME/dotfiles/home/*; do 
	dot_var=${var/dot-/\.}
	pkg=$(basename "$dot_var")
	# if exist and is not a symlink
	if [[ -e "$HOME/$pkg" && ! -h "$HOME/$pkg" ]]; then
		echo "Config for $pkg exist, creating backup ${pkg}.old"
		mv "$HOME/$pkg" "$HOME/${pkg}.old"
	fi
	ln -sf "$var" "$HOME/$pkg"
done
for var in $HOME/dotfiles/fonts/*; do 
	pkg=$(basename "$var")
	# if exist and is not a symlink
	if [[ -e "$HOME/.local/share/fonts/$pkg" && ! -h "$HOME/.local/share/fonts/$pkg" ]]; then
		echo "Font $pkg exist, creating backup ${pkg}.old"
		mv "$HOME/.local/share/fonts/$pkg" "$HOME/.local/share/fonts/${pkg}.old"
	fi
	ln -sf "$var" "$HOME"/.local/share/fonts/
done

echo "Updating font cache..."
fc-cache
