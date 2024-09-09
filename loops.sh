#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
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

for i in $@
do
    echo "package to install is: $i"
    apt list --installed | grep $i &>>$LOGFILE
    if [ $? -eq 0 ]
    then 
        echo -e "$i package is already installed....$Y SKIPPING $N"
    else
        apt install $i -y &>> $LOGFILE
        VALIDATE $? "Installing $i"
    fi        
done