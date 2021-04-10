#!/bin/bash

cd ~/.config
lista=$(git ls-tree --full-tree --name-only --full-name HEAD | tr "\n" ",")

echo "${lista[@]}"
