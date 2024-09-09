#!/bin/bash

SOURCE_DIRECTORY=/tmp/app-logs
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ -d $SOURCE_DIRECTORY ]
then
    echo -e " $G source directory $SOURCE_DIRECTORY exists $N "
else
    echo -e " $R make sure source directory $SOURCE_DIRECTORY exists $N"  
    exit 1  

fi

FILES=$(find $SOURCE_DIRECTORY -name "*.log" -mtime +14)

echo " Files: $FILES"

while IFS= read -r line
do
    echo "Deleting files: $line"
    rm -rf $line

done <<< $FILES