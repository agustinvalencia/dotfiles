export PATH=$PATH:/Users/eaguval/.local/bin
export PATH=$PATH:/opt/homebrew/bin
source $ZDOTDIR/.aliases
source $ZDOTDIR/.zshenv

eval "$(zoxide init zsh)"

# arrow history search
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# TUI for file navigator
function files() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# stow sync 
function stow-sync() {
	cd $HOME/dotfiles/
	stow . 
	cd -
}


# prompt line
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/catppuccin.json)"

# Zathura
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"
