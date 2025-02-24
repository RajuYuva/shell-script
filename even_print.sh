#!/bin/bash

#Write a shell script to print even numbers from 1 to 20

for i in {1..20}; do
    if (( $i % 2 == 0 )); then
        echo "even numbers: $i"
    fi          
done