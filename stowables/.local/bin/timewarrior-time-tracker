#!/usr/bin/env bash

CATEGORIES=(
    "WORK"
    "WASTE"
    "ART"
    "STOP"
)

selected=$(printf "%s\n" "${CATEGORIES[@]}" | sk --color="bw" --margin 40% --bind 'q:abort')

if [[ $sk_status -ne 0 || -z "$selected" ]]; then
    exit 0
fi

if [[ "$selected" == "STOP" ]]; then
    timew stop
else
    timew start "$selected"
fi
