#!/bin/bash

git_status="$(git status --porcelain)"
modified=($(echo "$git_status" | awk '$1 == "M" {print $1}'))
untracked=($(echo "$git_status" | awk '$1 == "??" {print $1}'))

echo "${modified[@]}"
echo "${untracked[@]}"

echo "There are ${#modified[@]} modified files"
echo "There are ${#untracked[@]} untracked files"


