#!/bin/bash

number=$1

if [ $number -eq 10 ]
then
    echo "given number $number is equal to 10"
else
    echo "given number $number is not equal to 10"    

fi

# -gt, -lt, -eq, -ge greater than or equal to, -le less than or equal to, -ne not equal to