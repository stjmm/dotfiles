# .zshenv in home

# aliases
alias vim="nvim"
alias l="ls -lh --color=auto --group-directories-first"
alias ls="ls -h --color=auto --group-directories-first"
alias la="ls -lah --color=auto --group-directories-first"
alias grep="grep --color=auto"
alias c="clear"

# modules
zmodload zsh/complist
autoload -U compinit && compinit
autoload -U colors && colors

# zstyle
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33

# opts
setopt autocd
setopt append_history inc_append_history share_history
setopt hist_ignore_dups hist_ignore_space 
setopt auto_menu menu_complete
setopt no_case_glob no_case_match
setopt extended_glob
setopt globdots
setopt interactive_comments

# hist
HISTFILE="$XDG_CACHE_HOME/zsh_history"
HISTSIZE=10000
SAVEHIST=10000
HISTCONTROL=ignoreboth

# binds
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^k" kill-line
bindkey "^j" backward-word
bindkey "^k" forward-word
bindkey "^J" history-search-forward
bindkey "^K" history-search-backward
bindkey "^R" fzf-history-widget
bindkey -e

eval "$(pyenv init --path)"
eval "$(pyenv init -)"
source <(fzf --zsh)

# p10k
source ~/.local/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
# autosuggestions, syntax highlighting, install with package manager first
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# fnm
FNM_PATH="/home/franek/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
