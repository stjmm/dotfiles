if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz compinit
compinit

zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'

setopt append_history inc_append_history share_history
setopt auto_menu
setopt no_case_glob no_case_match
setopt globdots
setopt extended_glob

HISTSIZE=100000
SAVEHIST=100000
HISTFILE="$XDG_CACHE_HOME/.zsh_histfile"
HISTCONTROL=ignoreboth

alias vim="nvim"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ip="ip --color=auto"
alias ls="ls --color=auto --group-directories-first"
alias la="ls -alF --color=auto --group-directories-first"

bindkey "^j" history-search-forward
bindkey "^k" history-search-backward


# Programs
typeset -U path
path=(
    "$HOME/.local/bin"
    "$HOME/.local/share/fnm"
    "$HOME/local/share/pyenv"
    "$HOME/.cargo/bin"
    $path
)
export PATH

eval "$(fnm env --use-on-cd)"
if command -v pyenv >/dev/null; then
    eval "$(pyenv init -)"
fi

# Plugins
source /usr/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
