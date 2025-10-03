autoload -Uz compinit
compinit

if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
    export PATH="$HOME/.cargo/bin/":$PATH
fi

if [ -f "$HOME/.zshenv" ]; then
    . "$HOME/.zshenv"
fi

if [ -d "/Applications/Skim.app/Contents/MacOS/" ]; then
    alias skim="open -a Skim.app"
fi

export EDITOR=nvim
export VISUAL="$EDITOR"
export PATH=/Users/eaguval/repositories/getting-started/user-scripts/:$PATH

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export CC="$(brew --prefix llvm)/bin/clang"
export CXX="$(brew --prefix llvm)/bin/clang++"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

setopt HIST_IGNORE_SPACE

# using arrows to history-complete command
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

alias ls='eza --color -a '
alias ll='eza --color -l -a --header --git --icons=always'
alias la='eza --color -l -a --header --git --icons=always'
alias tree='eza --tree --color --icons=always' 

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
alias imcat='wezterm imgcat'

alias edit-zsh='nvim $HOME/.zshrc'
alias edit-nix='nvim $HOME/nix/flake.nix'
alias edit-zj='nvim $HOME/.config/zellij/config.kdl'

function reload-zsh() {
    echo "Reloading $HOME/.zshrc ... "
	source $HOME/.zshrc
    echo "Done"
}

function reload-nix() {
	sudo darwin-rebuild switch --flake $HOME/nix#mini
}

function stow-sync() {
	cd $HOME/dotfiles/
	stow --restow .
	cd -
}

function kubeconnect() {
  local pod 

  pod=$(kubectl get pods  --no-headers -o custom-columns=":metadata.name" | fzf --header="Select Pod")
  [ -z "$pod" ] && return 1

  kubectl exec -it "$pod" -- /bin/bash
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

# Fix completions for uv run to autocomplete .py files
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
_uv_run_mod() {
    if [[ "$words[2]" == "run" && "$words[CURRENT]" != -* ]]; then
        _arguments '*:filename:_files -g "*.py"'
    else
        _uv "$@"
    fi
}
compdef _uv_run_mod uv

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
