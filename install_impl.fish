set -l cur_dir (dirname (status current-filename))

# set functions path
set --append fish_function_path $cur_dir/fish-config/functions/

# install nvm, node version manageer
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# install packages
nix-env -i (cat $cur_dir/install_list)

# symlink neovim rc
mkdir -p ~/.config/nvim
ln -s $cur_dir/rc/.nvimrc ~/.config/nvim/init.vim

# install vim plug, plugin manager for vim/nvim
sh -c "curl -fLo \"\${XDG_DATA_HOME:-$HOME/.local/share}\"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

echo "Neovim plugins have not been installed. Should install manually." 1>&2

exec fish
