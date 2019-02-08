#!/bin/bash

AUTH_FILE=${1:?"No auth file provided"}
TEXT=${2:?"A text to send is required"}

TOKEN=$(sed '1!d' ${AUTH_FILE})
if [ $? -ne 0 ]; then
    echo "Error: the auth file has not a token" 1>&2
    exit 1
fi
CHAT_ID=$(sed '2!d' ${AUTH_FILE})
if [ $? -ne 0 ]; then
    echo "Error: the auth file has not a chat_id" 1>&2
    exit 1
fi

curl "https://api.telegram.org/bot${TOKEN}/sendMessage?chat_id=${CHAT_ID}&text=${TEXT}"
