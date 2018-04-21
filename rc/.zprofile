# determine dotfiles directory path
CURRENT_SCRIPT=${(%):-%N}
READLINK=$(which readlink)

if [[ -n $CURRENT_SCRIPT && -x $READLINK ]]; then
    SCRIPT_PATH=$(readlink -f "$CURRENT_SCRIPT")
    DOTFILES_DIR=$(dirname "$(dirname "$SCRIPT_PATH")")
elif [ -d "$HOME/.dotfiles" ]; then
    DOTFILES_DIR="$HOME/.dotfiles"
else
    echo "Can't not find dotfiles"
    return
fi

# source all separated partial rc files
for DOTFILE in "$DOTFILES_DIR"/system/{alias,env}; do
    [ -f "$DOTFILE" ] && source "$DOTFILE"
done

unset READLINK CURRENT_SCRIPT SCRIPT_PATH DOTFILE
export DOTFILES_DIR
