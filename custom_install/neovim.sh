# install 'add-apt-repository'
apt install -y software-properties-common

add-apt-repository -y ppa:neovim-ppa/stable
apt-get update
apt-get install -y --fix-missing neovim
