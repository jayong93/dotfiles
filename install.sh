#!/bin/bash

if [ ! -z "${1}" ] && [ -f "${1}" ]; then
    FTP_USER_DATA="${1}"
else
    echo "you should give a file which has ftp user name and passwd in each line of itself."
    exit 1
fi
export DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# installation by apt (include zsh)
echo "==========================="
echo "[INFO] Start installation by apt"
echo "==========================="
sudo apt update
xargs -r -a "${DOTFILES_DIR}/install_list" sudo apt install -y --fix-missing
echo "==========================="
echo "[INFO] Installation by apt is done"
echo "==========================="

# add user and group for qbittorrent and the files which is downloaded via it
sudo groupadd qbtuser -g 9999
sudo useradd qbtuser -g qbtuser -s /usr/sbin/nologin

# custom installation (include oh-my-zsh)
for CUSTOM_APP in `find "${DOTFILES_DIR}/custom_install" -type f`; do
    APP_NAME=$(basename "${CUSTOM_APP}")
    APP_NAME=${APP_NAME%.*}
    echo "[INFO] Install $APP_NAME"
    (/bin/bash "${CUSTOM_APP}" &&
        echo "[INFO] ${APP_NAME} has been installed") ||
        echo "[INFO] ${APP_NAME} has been failed installing"
done
echo "==========================="
echo "[INFO] Custom installation is done"
echo "==========================="

# link runcom files
echo "source ${DOTFILES_DIR}/rc/.zprofile" >> ~/.zshrc
ln -sfv "${DOTFILES_DIR}/rc/.vimrc" ~

# do post-process
POST_SCRIPT="${DOTFILES_DIR}/postprocess.sh"
echo "==========================="
echo "[INFO] Do Postprocess"
echo "==========================="
/bin/bash "${POST_SCRIPT}" "${FTP_USER_DATA}"
echo "==========================="
echo "[INFO] Done!"
echo "==========================="
