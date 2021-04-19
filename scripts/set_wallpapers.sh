#!/usr/bin/env bash

# Set wallpapers
feh --bg-fill "$@"

# Change colorscheme
wal -nq -i "$1"
