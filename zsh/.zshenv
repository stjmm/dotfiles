#!/usr/bin/env bash

export EDITOR="nvim"
export TERM="ghostty"
export BROWSER="firefox"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/.zcompdump-$HOST"
export HISTFILE="$XDG_CACHE_HOME/zsh_history"

# Python
export PYENV_ROOT="/opt/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# fnm
export FNM_PATH="$HOME/.local/share/fnm"
[ -d "$FNM_PATH" ] && export PATH="$FNM_PATH:$PATH"

# Android dev
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator

export LANG=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export TZ=Europe/Warsaw
