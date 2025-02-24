# Environment variables
export EDITOR=nvim
export VISUAL="$EDITOR"
export PATH=$HOME/.local/bin:$PATH

# this only applies to work
if [ -f "$HOME/.cargo/env" ]; then 
    source "$HOME/.cargo/env"
fi

# Initialize zsh completion
autoload -Uz compinit && compinit

# ---------------------------
# Git completion
# ---------------------------
# If you have git installed and its completions available (Homebrew typically installs these
# into /opt/homebrew/share/zsh/site-functions), make sure that directory is in your fpath.
# For example:
fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
# (Alternatively, if you already have the _git function in your system, this line is optional.)

# ---------------------------
# Kubectl completion
# ---------------------------
# This sources kubectl’s official zsh completion.
if command -v kubectl >/dev/null 2>&1; then
    source <(kubectl completion zsh)
fi

# ---------------------------
# Helm completion
# ---------------------------
# Similarly, load helm’s zsh completion.
if command -v helm >/dev/null 2>&1; then
    source <(helm completion zsh)
fi

# ---------------------------
# fzf integration and autosuggestions
# ---------------------------
# fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source fzf-tab plugin from your dotfiles (stowed to ~/.fzf-tab)
# if [ -f "$HOME/.config/fzf-tab/zsh/fzf-zsh-completion.sh" ]; then
#   source "$HOME/.config/fzf-tab/zsh/fzf-zsh-completion.sh"
# fi

# Optionally, if you have installed the zsh-autosuggestions plugin separately,
# source it here (adjust the path as needed).
if [ -f "$HOME/.zsh-autosuggestions.zsh" ]; then
    source "$HOME/.zsh-autosuggestions.zsh"
fi

