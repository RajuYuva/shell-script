#!/bin/bash


# fruits=("Apple" "Banana" "Orange")

# echo "first fruit is: ${fruits[0]}"
# echo "second fruit is: ${fruits[1]}"
# echo "third fruit is: ${fruits[2]}"
# echo "all fruits are: ${fruits[*]}"

echo "All vars: $@" #print all variable
echo "no of vars: $#" # print number of variables
echo "script name: $0" # print script name
echo "Home dir: $HOME" # print home directory of user
echo "working dir: $PWD" # print user pwd
echo "user: $USER    " # print user name
# echo "Host name: $(hostname)"
echo "Host name: $HOSTNAME" # print host name
echo "process id: $$" # print pid
sleep 30 & # & runs background
echo "pid of lasr background command: $!" # print last background command process id
echo " to check the exit status of previous command: $?" # if it is 0 sucess other than 0 failure
read -p "Enter username:" username
echo "uname is: $username"

#exit 1 = failure exit 0= success exit other than zero (exit 1 manually exit if error comes next commands won't run)

# 1> output.log sucess logs, 2> output.log failure logs, &> output.logs all logs, &>> output.log append logs

echo -e "\e[31m Hello \e[32m World \e[33m nenu \e[34m bagunna \e[35m meru \e[36m ela \e[37m djf \e[38m fine \e[39m \e[40m good"

echo "$(date +%F-%H-%M-%S)"

#touch -d <backdate> <file name> # to create a file with back date

#touch -d 20240401 sample.sh

#find . -name "*.sh"

#find . -name "*.log" -mtime +14 #.log files older than 14 days

#df -hT | grep xfs | awk -F " " '{print $6F}'