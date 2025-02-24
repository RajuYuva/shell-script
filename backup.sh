#!/bin/bash

SOURCE="/home/nagaraju/terraform/practice"
DEST="/home/nagaraju/terraform/practice/backup_$(date +'%Y-%d-%m-%H-%M-%S').tar.gz"

#tar -czf "$DEST" "$SOURCE"

echo "Backup completed: $DEST"

rm -rf $DEST

echo "Removed backup dir: $DEST"

files=$(sudo find /var/log/ -type f -mtime +300 | wc -l)

echo need to remove $files files