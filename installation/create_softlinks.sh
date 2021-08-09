#!/usr/bin/env bash

set -euo pipefail

cd "$HOME"

echo "Removing symlinks..."
fd -t l -d 1 . "$config_folder" -x unlink {}
fd -t l -d 1 . "$HOME" -x unlink {}
fd -t l -d 1 . "$HOME"/.local/share/fonts/ -x unlink {}

echo "Creating symlinks..."
for var in $HOME/dotfiles/config/*; do ln -s "$var" "$config_folder"; done
for var in $HOME/dotfiles/home/*; do ln -s "$var" "$HOME"; done
for var in $HOME/dotfiles/fonts/*; do ln -s "$var" "$HOME"/.local/share/fonts/; done
