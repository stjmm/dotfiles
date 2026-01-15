if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'

setopt append_history inc_append_history share_history
setopt auto_menu menu_complete
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

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Plugins
source /usr/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
