# add docker apt repository
sudo apt update
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# install docker
sudo apt update
sudo apt install -y docker-ce

# install docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# make env file for docker-compose
echo "QBT_UID=$(id -u qbtuser)\nQBT_GID=$(id -g qbtuser)" > ${DOTFILES_DIR}/docker/.env

cd ${DOTFILES_DIR}/docker && sudo docker-compose -d up
