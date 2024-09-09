#!/bin/bash

FILE="This is current script"

echo "Before calling other script, file: $FILE"

echo "pid of the current shell script: $$"

# ./other-script.sh

source ./other-script.sh

echo "after calling other script, file: $FILE"