# Environment variables
export EDITOR=nvim
export VISUAL="$EDITOR"

# arrow history search
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# aliases
alias ll='ls -l --color'
alias la='ls -la --color'
alias vim='nvim' 

# prompt line
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/catppuccin.json)"
