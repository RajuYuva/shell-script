#!/bin/bash

set -e

failure(){
    echo "Error occured at $1: Error command: $2"
}

trap 'failure ${LINENO} "$BASH_COMMAND"' ERR

USERID=$(id -u) #ERR

if [ $USERID -ne 0 ]
then
    echo "Please run this script with root access."
    exit 1 # manually exit if error comes.
else
    echo "You are super user."
fi

apt install mysfaffql -y
apt install git -y

echo "is script proceeding?"