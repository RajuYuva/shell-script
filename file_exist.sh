#!/bin/bash

file="13-loops.sh"
file_exist=$(find ~/ -name "$file" 2>/dev/null)
if [ -n "$file_exist" ]; then
    echo "file exists"
else
    echo "file not found"
fi
