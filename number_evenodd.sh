#!/bin/bash

#Write a script that checks whether a given number is even or odd.

number=$1
rem=$((number % 2))
if [ $rem -eq 0 ]; then
    echo "given number $number is even"
else
    echo "given number $number is odd"
fi        