#!/bin/env bash

# exit if something fail
set -Eeuo pipefail

check_dependencies fd

cd "$HOME/dotfiles/docker/" || exit

pwd

mapfile -t foo < <(fd -e yml --min-depth 2)

files=()

for f in "${foo[@]}"; do
	files+=("-f ${f#./}")
done

# Check if all volumes are own by normal user, throw notification if not

docker-compose -f docker-compose.yml ${files[@]} up -d
