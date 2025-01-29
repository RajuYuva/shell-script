#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
echo "Please enter DB password:"
read  mysql_root_password

VALIDATE(){
   if [ $1 -ne 0 ]
   then
        echo -e "$2...$R FAILURE 🥲🥲🥲❎❎❎❎❎$N"
        exit 1
    else
        echo -e "$2...$G SUCCESS 👍👍👍✅✅✅✅✅✅✅$N"
    fi
}

if [ $USERID -ne 0 ]
then
    echo "Please run this script with root access."
    exit 1 # manually exit if error comes.
else
    echo "You are super user."
fi

# ✅ Step 1: Remove Default Node.js Version (If Installed)
# echo "Checking for existing Node.js installation..."
# if command -v node &>/dev/null; then
#     NODE_VERSION=$(node -v)
#     echo "Existing Node.js version found: $NODE_VERSION"
#     echo "Removing old Node.js version..."
#     apt remove -y nodejs &>>$LOGFILE
#     VALIDATE $? "Removing existing Node.js"
# else
#     echo "No existing Node.js installation found."
# fi

# ✅ Step 2: Install Node.js 20 from Official Repository
echo "Installing Node.js 20..."
curl -fsSL https://deb.nodesource.com/setup_20.x | bash - &>>$LOGFILE
VALIDATE $? "Adding Node.js 20 repository"

apt update &>>$LOGFILE
VALIDATE $? "Updating package lists"

apt install -y nodejs &>>$LOGFILE
VALIDATE $? "Installing Node.js 20"

# ✅ Step 3: Verify Installation
node -v &>>$LOGFILE
VALIDATE $? "Verifying Node.js installation"

node -v

# useradd expense &>>$LOGFILE
# VALIDATE $? "Creating expense user"
id expense &>>$LOGFILE
if [ $? -ne 0 ]
then
    useradd expense &>>$LOGFILE
    VALIDATE $? "Creating expense user"
else
    echo -e "Expense user already created...$Y SKIPPING $N"
fi

mkdir -p /app &>>$LOGFILE
VALIDATE $? "Creating app directory"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOGFILE
VALIDATE $? "Downloading backend code"

cd /app
rm -rf /app/*  # for idompetency
apt update &>>$LOGFILE && apt install -y unzip &>>$LOGFILE
unzip -v &>>$LOGFILE
unzip /tmp/backend.zip &>>$LOGFILE
VALIDATE $? "Extracted backend code"

npm install &>>$LOGFILE
VALIDATE $? "Installing nodejs dependencies"

#check your repo and path
cp /home/ubuntu/expense-shell/backend.service /etc/systemd/system/backend.service &>>$LOGFILE
VALIDATE $? "Copied backend service"

systemctl daemon-reload &>>$LOGFILE
VALIDATE $? "Daemon Reload"

systemctl start backend &>>$LOGFILE
VALIDATE $? "Starting backend"

systemctl enable backend &>>$LOGFILE
VALIDATE $? "Enabling backend"

apt install mysql-server -y &>>$LOGFILE
VALIDATE $? "Installing MySQL Client"

mysql -h db.rajuspace.site -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOGFILE
VALIDATE $? "Schema loading"

systemctl restart backend &>>$LOGFILE
VALIDATE $? "Restarting Backend"


echo -e "$G✅✅✅✅✅Script execution completed successfully! 🤝✅✅✅✅✅✅$N"

