#!/bin/bash

echo "All variables: $@" - to print all variables
echo "Number of variables passed: $#"
echo "Script Name: $0"
echo "Current working directory: $PWD" caps PWD
echo "Home directory of current user: $HOME"
echo "Which user is running this script: $USER"
echo "Hostname: $HOSTNAME"
echo "Process ID of the current shell script: $$"
echo "Process ID of last background command: $!"
echo "to check the exit status of last command: $?"
