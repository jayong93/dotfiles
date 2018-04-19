#!/bin/bash

CURRENT_SCRIPT=$0
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# apt를 사용해 패키지 설치 (include zsh)
echo "==========================="
echo "[INFO] Start installation by apt"
echo "==========================="
apt update
xargs -r -a "${DOTFILES_DIR}/install_list" apt install -y --fix-missing
echo "==========================="
echo "[INFO] Installation by apt is done"
echo "==========================="

# custom installation (include oh-my-zsh)
for CUSTOM_APP in `find "$DOTFILES_DIR/custom_install" -type f`; do
    echo "[INFO] Install $(basename "$CUSTOM_APP")"
    (/bin/sh "$CUSTOM_APP" &&
        echo "[INFO] $(basename "$CUSTOM_APP") has been installed") ||
        echo "[INFO] $(basename "$CUSTOM_APP") has been failed installing"
done
echo "==========================="
echo "[INFO] Custom installation is done"
echo "==========================="

ln -sfv "$DOTFILES_DIR/rc/.zprofile" ~
