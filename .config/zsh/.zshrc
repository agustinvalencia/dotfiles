export PATH=$PATH:/Users/eaguval/.local/bin
export PATH=$PATH:/opt/homebrew/bin
source $ZDOTDIR/.aliases
source $ZDOTDIR/.zshenv

eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

# Enable history search with up/down arrows
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# TUI for file navigator
function files() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
alias fs='files'

# stow sync
function stow-sync() {
	cd $HOME/dotfiles/
	stow --restow $1
	cd -
}

function reload-nix() {
	darwin-rebuild switch --flake $HOME/nix#mini
}

function reload-zsh() {
	source $HOME/.zshrc
}

# prompt line
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/catppuccin.json)"

# Zathura
#export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"

. "$HOME/.local/bin/env"
