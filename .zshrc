eval "$(zoxide init zsh)"

# Environment variables
export EDITOR=nvim
export VISUAL="$EDITOR"

# arrow history search
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# aliases
alias ls='eza --color'
alias ll='eza -l --color --header --git --icons=always'
alias la='eza -l -a --color --header --git --icons=always'
alias tree='eza --tree --color --icons=always' 
alias vim='nvim' 
alias cd='z'

# prompt line
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/catppuccin.json)"
