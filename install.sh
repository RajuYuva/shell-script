#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
N="\e[0m"

echo "script started executing at: $TIMESTAMP"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2..... $R faliure $N"
    else
        echo -e "$2......$G Success $N"
    fi        
}

if [ $USERID -ne 0 ]
then
    echo "please run this script with root access"
    exit 1 # manually exits if error comes
else
    echo "you are super user"    
fi


apt install git -y &>> $LOGFILE

VALIDATE $? "Installing Git"

apt install mysql-server -y &>> $LOGFILE

VALIDATE $? "Installing mysql"

apt install dockerr -y &>> $LOGFILE

VALIDATE $? "Installing docker"

