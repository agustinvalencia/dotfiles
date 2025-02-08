# Environment variables
export EDITOR=nvim
export VISUAL="$EDITOR"

# this only applies to work
if [ -f "$HOME/.cargo/env" ]; then 
    source "$HOME/.cargo/env"
fi


