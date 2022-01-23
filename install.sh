#!/bin/bash

cur_dir=$(dirname $0)

if ! which nix-env; then
    # install nix package manager
    sh <(curl -L https://nixos.org/nix/install)
    exec bash "$cur_dir/install.sh"
else
    nix-env -iA nixpkgs.fish
    fish_conf_dir=~/.config/fish/conf.d
    test -d $fish_conf_dir && rm -d $fish_conf_dir

    ln -s "$cur_dir/fish-config/conf.d" $fish_conf_dir

    # start installation process with fish
    fish ./install_impl.fish
fi

