#!/bin/bash

printf "Script 2: Directory Backup with Rotation\n"

# Check if a directory path is provided as a command-line argument
if [ -z "$1" ]; 
then
	echo "Error: Please provide a directory path as an argument."
	exit 1
fi

# Check if the provided path is a valid directory
if [ ! -d "$1" ]; 
then
	echo "Error: The specified path is not a valid directory."
	exit 1
fi


source="$(realpath "$1")"
target="$source/backups"

# Create the backups target directory if it doesn't exist
mkdir -p "$target"

# Create a timestamped folder for the new backup
timestamp="backup_$(date +%Y-%m-%d-%H-%M-%S)"
new_backup="$target/$timestamp"
mkdir "$new_backup"

# Copy all files from the source directory to the backup directory
# Use rsync to avoid copying the backup directory into itself
rsync -a --exclude="$backups/" "$source/" "$new_backup"

# Perform rotation to keep only the last 3 backups
backup_count=$(ls -1 "$target" | wc -l)
num_to_remove=$((backup_count - 3))

if [ $num_to_remove -gt 0 ]; 
then

# Sort backups by timestamp and remove the oldest ones
	ls -1 "$target" | sort | head -n "$num_to_remove" | while read -r backup_rm; do
		rm -rf "$target/$backup_rm"
	done
fi

printf "Backup completed successfully.\n"
