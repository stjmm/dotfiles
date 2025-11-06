#!/usr/bin/env bash

cd "$1"

url=$(git remote get-url origin 2>/dev/null)

if [[ $url == *github.com* ]]; then
    if [[ $url == git@* ]]; then
        url="${url#git@}"
        url="${url/:/\/}"
        url="https://$url"
    fi
    
    xdg-open "$url" > /dev/null 2>&1
else
    tmux display-message "Not a GitHub repository"
fi
