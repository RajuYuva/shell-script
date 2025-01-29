#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
   if [ $1 -ne 0 ]
   then
        echo -e "$2...$R FAILURE $N"
        exit 1
    else
        echo -e "$2...$G SUCCESS $N"
    fi
}

if [ $USERID -ne 0 ]
then
    echo "Please run this script with root access."
    exit 1 # manually exit if error comes.
else
    echo "You are super user."
fi

apt install nginx -y &>>$LOGFILE
VALIDATE $? "Installing nginx"

systemctl enable nginx &>>$LOGFILE
VALIDATE $? "Enabling nginx"

systemctl start nginx &>>$LOGFILE
VALIDATE $? "Starting nginx"

rm -rf /usr/share/nginx/html/* &>>$LOGFILE
VALIDATE $? "Removing existing content"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOGFILE
VALIDATE $? "Downloading frontend code"

cd /usr/share/nginx/html &>>$LOGFILE
unzip /tmp/frontend.zip &>>$LOGFILE
VALIDATE $? "Extracting frontend code"


# Ensure Nginx config directories exist
sudo mkdir -p /etc/nginx/sites-available /etc/nginx/sites-enabled

# Copy Nginx configuration to the correct location
sudo cp /home/ubuntu/expense-shell/expense.conf /etc/nginx/sites-available/expense.conf
VALIDATE $? "Copied expense.conf to /etc/nginx/sites-available/"

# Enable the Nginx site
sudo ln -sf /etc/nginx/sites-available/expense.conf /etc/nginx/sites-enabled/
VALIDATE $? "Enabled expense.conf in Nginx"
#check your repo and path
# mkdir -p /etc/nginx/default.d/ &>>$LOGFILE
# cp /home/ubuntu/expense-shell/expense.conf /etc/nginx/default.d/expense.conf &>>$LOGFILE
# VALIDATE $? "Copied expense conf"

systemctl restart nginx &>>$LOGFILE
VALIDATE $? "Restarting nginx"


##troubleshooting
# mysql> GRANT ALL PRIVILEGES ON transactions.* TO 'expense'@'%' WITH GRANT OPTION;
# Query OK, 0 rows affected (0.03 sec)

# mysql> ALTER USER 'expense'@'%' IDENTIFIED WITH mysql_native_password BY 'ExpenseApp@1';
# Query OK, 0 rows affected (0.02 sec)

# mysql> FLUSH PRIVILEGES;
# Query OK, 0 rows affected (0.00 sec)

# mysql> exit
# Bye
