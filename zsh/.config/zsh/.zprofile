#!/usr/bin/env bash

# Default programs
export EDITOR="nvim"
export TERM="st"
export TERMINAL="st"
export BROWSER="firefox"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export PATH="$HOME/.cargo/bin:$PATH"
