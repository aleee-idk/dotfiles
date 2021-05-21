#!/usr/bin/env bash

client=$(awesome-client 'client.focus.title')

echo -e "$client"

"$HOME"/dotfiles/scripts/create_notification.sh "hola"
