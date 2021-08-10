#!/usr/bin/env bash

set -euo pipefail

cd "$HOME"

echo "Removing symlinks..."
fd -t l -d 1 . "$HOME/.config/" -x unlink {}
fd -t l -d 1 . "$HOME" -x unlink {}
fd -t l -d 1 . "$HOME"/.local/share/fonts/ -x unlink {}

echo "Creating symlinks..."
for var in $HOME/dotfiles/config/*; do 
	pkg=$(basename "$var")
	# if exist and is not a symlink
	if [[ -e "$HOME/.config/$pkg" && ! -h "$HOME/.config/$pkg" ]]; then
		mv "$HOME/.config/$pkg" "$HOME/.config/${pkg}.old"
	fi
	ln -sf "$var" "$HOME/.config/"
done
for var in $HOME/dotfiles/home/*; do 
	pkg=$(basename "$var")
	# if exist and is not a symlink
	if [[ -e "$HOME/$pkg" && ! -h "$HOME/$pkg" ]]; then
		mv "$HOME/$pkg" "$HOME/${pkg}.old"
	fi
	ln -sf "$var" "$HOME"
done
for var in $HOME/dotfiles/fonts/*; do 
	pkg=$(basename "$var")
	# if exist and is not a symlink
	if [[ -e "$HOME/.local/share/fonts/$pkg" && ! -h "$HOME/.local/share/fonts/$pkg" ]]; then
		mv "$HOME/.local/share/fonts/$pkg" "$HOME/.local/share/fonts/${pkg}.old"
	fi
	ln -sf "$var" "$HOME"/.local/share/fonts/
done

echo "Updating font cache..."
fc-cache
