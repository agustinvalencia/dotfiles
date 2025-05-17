if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

export EDITOR=nvim
export VISUAL="$EDITOR"
export PATH=/Users/eaguval/repositories/getting-started/user-scripts/:$PATH
export PATH="$HOME/.cargo/bin/":$PATH

setopt HIST_IGNORE_SPACE

alias ls='eza --color -a '
alias ll='eza --color -l --header --git --icons=always'
alias la='eza --color -l -a --header --git --icons=always'
alias tree='eza --tree --color --icons=always' 

alias zj='zellij'
alias cat='bat'
alias vim='nvim' 

alias cd='z'
alias '..'='z ..'
alias '...'='z ../..'
alias '....'='z ../../..'

alias lg='lazygit'
alias ga='git add .'
alias gs='git status'
alias gpl='git pull'
alias gps='git push'
alias gcm='git commit -m'

alias kube='kubectl'

alias edit-zsh='nvim $HOME/.zshrc'
alias edit-nix='nvim $HOME/nix/flake.nix'
alias edit-zj='nvim $HOME/.config/zellij/config.kdl'

function reload-zsh() {
	source $HOME/.zshrc
}

function reload-nix() {
	darwin-rebuild switch --flake $HOME/nix#mini
}

function stow-sync() {
	cd $HOME/dotfiles/
	stow --restow .
	cd -
}

function files() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
alias fs='files'

eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/catppuccin.json)"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
