#!/bin/bash

<<<<<<< HEAD
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
=======
# Function to display usage information and available options
function display_usage {
    echo "Usage: $0 /path/to/source_directory"
}

# Check if a valid directory path is provided as a command-line argument
if [ $# -eq 0 ] || [ ! -d "$1" ]; then
    echo "Error: Please provide a valid directory path as a command-line argument."
    display_usage
    exit 1
fi

# Directory path of the source directory to be backed up
source_dir="$1"

# Function to create a timestamped backup folder
function create_backup {
    local timestamp=$(date '+%Y-%m-%d_%H-%M-%S')  # Get the current timestamp
    local backup_dir="${source_dir}/backup_${timestamp}"

    # Create the backup folder with the timestamped name
    mkdir "$backup_dir"
    echo "Backup created successfully: $backup_dir"
}

# Function to perform the rotation and keep only the last 3 backups
function perform_rotation {
    local backups=($(ls -t "${source_dir}/backup_"* 2>/dev/null))  # List existing backups sorted by timestamp

    # Check if there are more than 3 backups
    if [ "${#backups[@]}" -gt 3 ]; then
        local backups_to_remove="${backups[@]:3}"  # Get backups beyond the last 3
        rm -rf "${backups_to_remove[@]}"  # Remove the oldest backups
    fi
}

# Main script logic
create_backup
perform_rotation
>>>>>>> d838192f38ba443f63e003f94915dc7618887f6b
