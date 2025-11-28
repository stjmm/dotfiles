#!/usr/bin/env bash

NORMAL_BG="#15161eD9"
NORMAL_FG="#c0caf5ff"
SELECT_BG="#7aa2f7ff"
SELECT_FG="#15161eff"

FONT="JetBrainsMono Nerd Font 18"

wmenu-run \
    -i \
    -l 10 \
    -N "$NORMAL_BG" \
    -n "$NORMAL_FG" \
    -M "$SELECT_BG" \
    -m "$SELECT_FG" \
    -S "$SELECT_BG" \
    -s "$SELECT_FG" \
    -f "$FONT"
