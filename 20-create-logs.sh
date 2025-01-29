#!/bin/bash

# Define the log directory
LOG_DIR="/tmp/app-logs"

# Create the log directory if it does not exist
mkdir -p $LOG_DIR

# Create logs with specific timestamps
touch -d 20240404 "$LOG_DIR/script.log"   # Creates a log file dated April 4, 2024
touch -d "2 weeks ago" "$LOG_DIR/error.log"  # Creates a log file dated 2 weeks ago
touch -d "1 month ago" "$LOG_DIR/access.log"  # Creates a log file dated 1 month ago
touch -d "yesterday" "$LOG_DIR/system.log"  # Creates a log file dated yesterday
touch -d "20230101" "$LOG_DIR/old-log.log"  # Creates a log file dated Jan 1, 2023

# List the created log files
ls -lh $LOG_DIR
