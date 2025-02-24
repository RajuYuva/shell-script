#!/bin/bash

#Write a script to find the largest of three numbers entered by the user.

num1=$1
num2=$2
num3=$3

read -p "Enter first number: " num1
read -p "Enter first number: " num2
read -p "Enter first number: " num3

if [[ $num1 -ge $num2 && $num1 -ge num3 ]]; then
    echo "larger number is $num1"
elif [[ $num2 -ge $num1 && $num2 -ge num3 ]]; then
    echo "larger number is $num2"
else
    echo "larger number is $num3"
 fi   
