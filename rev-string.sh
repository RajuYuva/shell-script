#!/bin/bash

#Write a shell script to reverse a string.

read -p "Enter a string: " str
rev <<< "$str"