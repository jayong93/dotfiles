#!/bin/bash

CURRENT_SCRIPT=$0
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"



# apt를 사용해 패키지 설치
xargs -r -a "${DOTFILES_DIR}/install_list" apt install
echo "Installation by apt is done"

# custom installation
find "$DOTFILES_DIR/custom_install" -type f | xargs /bin/sh
echo "Custom installation is done"
