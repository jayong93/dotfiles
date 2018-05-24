# install vim plugins
vim -c PlugInstall -c qa

# add ftp user account to pure-ftpd
USER_FILE="${1}"
USER_FILE_LINES=$(wc ${USER_FILE} | awk '{print $1}')

if [ $USER_FILE_LINES -ne 2 ]; then
    echo "user file should has exactly two lines." 1>&2
    return 1
fi

USER_NAME="$(head -1 ${USER_FILE})"
USER_PW="$(tail -1 ${USER_FILE})"
docker exec -it ftp bash -c "useradd qbtuser -u $(id -u qbtuser)"
docker exec -it ftp bash -c "printf \"%s\n\" ${USER_PW} ${USER_PW} | pure-pw useradd ${USER_NAME} -f /etc/pure-ftpd/passwd/pureftpd.passwd -m -u qbtuser -g $(id -g qbtuser) -d /home/ftpusers"
