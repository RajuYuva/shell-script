
# Shell Script Notes

This document serves as a comprehensive guide for shell scripting. It covers coding concepts, variables, functions, loops, conditions, error handling, logging, and more. Use this file as a living document—please contribute additional notes, corrections, or enhancements as needed.

---

## Table of Contents

- [1. Introduction](#1-introduction)
- [2. Basic Coding Concepts](#2-basic-coding-concepts)
- [3. Variables and Arguments](#3-variables-and-arguments)
  - [3.1 Declaring Variables](#31-declaring-variables)
  - [3.2 Using Arguments](#32-using-arguments)
  - [3.3 Confidential Input](#33-confidential-input)
- [4. Data Types and Arrays](#4-data-types-and-arrays)
- [5. Special Variables](#5-special-variables)
- [6. Conditions and Exit Status](#6-conditions-and-exit-status)
- [7. Functions](#7-functions)
- [8. Working with Dates and Time](#8-working-with-dates-and-time)
  - [8.1 Date Format Specifiers](#81-date-format-specifiers)
  - [8.2 Past and Future Dates](#82-past-and-future-dates)
- [9. Logging, Redirections, and Color Codes](#9-logging-redirections-and-color-codes)
  - [9.1 Logging and Redirections](#91-logging-and-redirections)
  - [9.2 Color Codes in Shell Scripts](#92-color-codes-in-shell-scripts)
- [10. Loops](#10-loops)
- [11. Script Robustness and Error Handling](#11-script-robustness-and-error-handling)
  - [11.1 set -e and trap](#111-set---e-and-trap)
  - [11.2 Idempotency](#112-idempotency)
- [12. Invoking and Sourcing Scripts](#12-invoking-and-sourcing-scripts)
- [13. Miscellaneous Utilities and Examples](#13-miscellaneous-utilities-and-examples)
  - [13.1 Deleting Old Logs](#131-deleting-old-logs)
  - [13.2 Useful Commands (top, df, free)](#132-useful-commands)
- [14. Disadvantages of Shell Scripting](#14-disadvantages-of-shell-scripting)
- [15. Conclusion](#15-conclusion)

---

## 1. Introduction

Shell scripting is a powerful way to automate tasks on Unix/Linux systems. This guide covers the basics—from declaring variables and using functions to handling errors and managing logs. It’s intended as a collaborative resource; please add your insights and improvements!

---

## 2. Basic Coding Concepts

- **Shebang:** The very first line of a script tells the system which interpreter to use.
  ```bash
  #!/bin/bash
  ```
  *Note: The shebang must be the first line in your script.*

- **Core Concepts:**  
  - **Variables** – Named storage for data.
  - **Data Types** – Although not strictly enforced, common types include integers, strings, booleans, and arrays.
  - **Functions** – Blocks of reusable code.
  - **Loops and Conditions** – For controlling the flow of execution.

---

## 3. Variables and Arguments

### 3.1 Declaring Variables

Variables in shell scripts do not have spaces around the equals sign.  
Example:
```bash
PERSON1=Sachin
PERSON2=Rahul

echo "$PERSON1:: Hello $PERSON2, How are you?"
```

### 3.2 Using Arguments

You can pass parameters to your script, which are then accessible as `$1`, `$2`, etc.
```bash
# In your script (e.g., shell.sh)
PERSON1=$1
PERSON2=$2

echo "$PERSON1:: Hello $PERSON2, How are you?"
```
*Run with:*
```bash
sh shell.sh raju naga ramesh
```

### 3.3 Confidential Input

To prompt users for sensitive data (without echoing the input), use the `read -s` option.
```bash
read -s USERNAME
read -s PASSWORD

echo "Username is: $USERNAME, Password is: $PASSWORD"
```
*Tip: Always secure sensitive data.*

---

## 4. Data Types and Arrays

Although shell scripting treats most variables as strings, you can work with several types conceptually:
- **Integers, floats, booleans, and strings** (e.g., "true"/"false" or 1/0)
- **Arrays:** Lists of values.
  
Example of an array:
```bash
MOVIES=("RRR" "DjTillu" "murari")
echo "First Movie is: ${MOVIES[0]}"
```

*Note: You can reference variables as `$VARIABLE` or `${VARIABLE}` for clarity.*

---

## 5. Special Variables

Some built-in variables are useful for debugging and scripting:
```bash
echo "All parameters: $@"           # All passed arguments
echo "Number of arguments: $#"        # Count of arguments
echo "Script Name: $0"                # Name of the script
echo "Current directory: $PWD"
echo "Home directory: $HOME"
echo "User running script: $USER"
echo "Hostname: $HOSTNAME"
echo "Script PID: $$"
sleep 60 &
echo "PID of last background command: $!"
```
`$?` gives the exit status of the previous command (0 for success, non-zero for failure).

---

## 6. Conditions and Exit Status

### Conditions

A simple example checking if a number is greater than 20:
```bash
number=$1

if [ $number -gt 20 ]; then
  echo "$number is greater than 20"
else
  echo "$number is less than or equal to 20"
fi
```
*Note: Ensure proper spacing in conditions and correct spelling (e.g., "echo", not "eccho").*

### Exit Status

- **0:** Command succeeded.
- **Non-zero (1-127):** Command failed.
  
Example:
```bash
some_command
if [ $? -ne 0 ]; then
  echo "Command failed"
fi
```

---

## 7. Functions

Functions help reuse code. They accept parameters just like scripts do.
```bash
VALIDATE() {
  if [ $1 -ne 0 ]; then
    echo "$2...FAILURE"
    exit 1
  else
    echo "$2...SUCCESS"
  fi
}

# Call the function with exit status and a message:
VALIDATE $? "Installing MySQL"
```
*Tip: Use functions to encapsulate repeated logic and improve readability.*

---

## 8. Working with Dates and Time

### 8.1 Date Format Specifiers

You can format dates using the `date` command with format specifiers:
- `%Y` – Year (4 digits)  
- `%y` – Year (2 digits)  
- `%m` – Month (01-12)  
- `%d` – Day (01-31)  
- `%H` – Hour (00-23)  
- `%I` – Hour (01-12) in 12-hour format  
- `%M` – Minutes (00-59)  
- `%S` – Seconds (00-59)  
- `%p` – AM/PM  
- `%A` – Full weekday name  
- `%a` – Short weekday name  
- `%B` – Full month name  
- `%b` – Short month name  
- `%D` – Date in mm/dd/yy format  
- `%F` – Full date (YYYY-MM-DD)  
- `%T` – Time (HH:MM:SS)

Example:
```bash
date +%F       # 2025-01-30
date +%T       # 12:45:30
```

### 8.2 Past and Future Dates

Examples:
```bash
# Yesterday's Date:
date -d "yesterday" "+%Y-%m-%d"

# Tomorrow's Date:
date -d "tomorrow" "+%Y-%m-%d"

# 7 Days from Today:
date -d "+7 days" "+%Y-%m-%d"

# 30 Days Ago:
date -d "-30 days" "+%Y-%m-%d"

# First Day of the Current Month:
date "+%Y-%m-01"

# Last Day of the Current Month:
date -d "$(date +%Y-%m-01) +1 month -1 day" "+%Y-%m-%d"
```

Example usage in a backup script:
```bash
#!/bin/bash
timestamp=$(date "+%F-%H-%M-%S")
cp /path/to/file "/backup/file-$timestamp"
echo "Backup created: file-$timestamp"
```

Display current time zone:
```bash
date "+%Z %z"
```
Show time in another time zone:
```bash
TZ="America/New_York" date
```

---

## 9. Logging, Redirections, and Color Codes

### 9.1 Logging and Redirections

Redirecting outputs:
- `>` redirects standard output.
- `2>` redirects error output.
- `&>` redirects both.
- `>>` appends to a file.
- `&>>` appends both stdout and stderr.

Example:
```bash
ls -l &>> output.log
```

*Best Practice:* Persist logs by writing them to a file for later review.

### 9.2 Color Codes in Shell Scripts

You can use ANSI escape sequences to add colors:
```bash
echo -e "\e[31mHello World\e[0m"  # Red text
```

Common color codes:
- **Black:** `\e[30m`
- **Red:** `\e[31m`
- **Green:** `\e[32m`
- **Yellow:** `\e[33m`
- **Blue:** `\e[34m`
- **Magenta:** `\e[35m`
- **Cyan:** `\e[36m`
- **White:** `\e[37m`
- **Reset:** `\e[0m`

Example using variables:
```bash
R="\e[31m"
G="\e[32m"
N="\e[0m"

VALIDATE(){
  if [ $1 -ne 0 ]; then
    echo -e "$2...$R FAILURE $N"
    exit 1
  else
    echo -e "$2...$G SUCCESS $N"
  fi
}
```

---

## 10. Loops

### Basic For Loop
```bash
for i in {1..20}; do
  echo $i
done
```

### Looping Through Script Arguments
```bash
for package in "$@"; do
  echo "Package to install: $package"
done
```
*Run with:*
```bash
bash script.sh mysql docker
```

---

## 11. Script Robustness and Error Handling

### 11.1 Using `set -e` and `trap`

- **set -e:**  
  Exits the script if any command returns a non-zero status.
  ```bash
  set -e
  ```

- **trap:**  
  Capture errors and print useful debugging information.
  ```bash
  failure(){
      echo "Failed at line $1: $2"
  }
  trap 'failure ${LINENO} "$BASH_COMMAND"' ERR
  ```

*Note:* In some cases, `set -e` might be too aggressive, so consider where it best fits in your workflow.

### 11.2 Idempotency

Shell scripts are generally not idempotent by default.  
*Tip:* Always check conditions (e.g., if a user or file already exists) before executing commands that modify state.

---

## 12. Invoking and Sourcing Scripts

There are two ways to call another script:

1. **Using `./script.sh`:**  
   Runs the script in a separate process. Changes (like variable updates) do not affect the calling script.

2. **Using `source ./script.sh` (or `. ./script.sh`):**  
   Runs the script in the current shell. Changes made in the sourced script affect the current shell session.

*Use case:* Source scripts when you need to share environment variables or functions.

---

## 13. Miscellaneous Utilities and Examples

### 13.1 Deleting Old Logs

A common task is to delete log files older than a specified number of days.
```bash
# Find and delete .log files older than 14 days
find /app/logs -name "*.log" -mtime +14 -exec rm {} \;
```

### 13.2 Useful Commands

- **top:** View running processes with CPU and memory usage.
- **df -hT:** Check disk space and file system types.
- **free -m:** Display memory usage in MB.

Example:
```bash
df -hT | grep ext4 | awk '{print $NF}'
```

---

## 14. Disadvantages of Shell Scripting

- **Lack of Idempotency:** Scripts might not behave the same way when run multiple times.
- **Readability:** Complex scripts can become difficult to understand and maintain.
- **Portability:** A script that works on one distribution may not work on another.
- **Error Handling:** Limited built-in error handling means you must manually check exit statuses.
- **Scalability:** Managing many servers with shell scripts can be challenging.

*Note:* Consider using more robust tools (like Ansible or Python) when scaling or handling complex tasks.

---

## 15. Conclusion

Shell scripting is a powerful tool for automation and system management. This guide covers essential concepts, from basic syntax to advanced error handling and logging. Remember to continually update and refine your scripts, and share improvements with your team.

---

