#!/bin/bash
read -p "Enter process name: " process

if pgrep "$process" > /dev/null; then
    echo "$process is running"
else
    echo "$process is not running"
fi
