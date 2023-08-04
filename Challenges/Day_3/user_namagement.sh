#!/bin/bash

# Function to check if a user already exists
user_exists() {
    id "$1" &>/dev/null
}

# Function to create a new user account
create_account() {
    read -p "Enter the new username: " new_username
    if user_exists "$new_username"; then
        echo "User '$new_username' already exists. Please choose a different username."
        exit 1
    fi

    read -s -p "Enter the password for the new user: " new_password
    echo

    # Create the new user account
    sudo useradd "$new_username" -m -s /bin/bash
    echo "$new_username:$new_password" | sudo chpasswd

    echo "User account '$new_username' successfully created."
}

# Function to delete an existing user account
delete_account() {
    read -p "Enter the username of the account to be deleted: " username
    if ! user_exists "$username"; then
        echo "User '$username' does not exist. Nothing to delete."
        exit 1
    fi

    # Delete the user account
    sudo userdel -r "$username"

    echo "User account '$username' successfully deleted."
}

# Function to reset the password of an existing user account
reset_password() {
    read -p "Enter the username of the account to reset the password: " username
    if ! user_exists "$username"; then
        echo "User '$username' does not exist. Cannot reset password."
        exit 1
    fi

    read -s -p "Enter the new password for '$username': " new_password
    echo

    # Reset the user account password
    echo "$username:$new_password" | sudo chpasswd

    echo "Password for user '$username' successfully reset."
}

# Function to list all user accounts on the system with more detailed information
list_accounts() {
    echo "List of user accounts with detailed information:"
    while IFS=':' read -r username _ uid gid info home shell; do
        echo "Username: $username"
        echo "UID: $uid"
        echo "GID: $gid"
        echo "Full Name: $info"
        echo "Home Directory: $home"
        echo "Shell: $shell"
        echo "--------------------------------"
    done < /etc/passwd
}

# Function to modify user account properties
modify_account() {
    read -p "Enter the username of the account to modify: " username
    if ! user_exists "$username"; then
        echo "User '$username' does not exist. Cannot modify account."
        exit 1
    fi

    # Prompt for the new username
    read -p "Enter the new username (leave blank to keep the same): " new_username

    # Prompt for the new user ID (UID)
    read -p "Enter the new user ID (UID) (leave blank to keep the same): " new_uid

    # Prompt for the new group ID (GID)
    read -p "Enter the new group ID (GID) (leave blank to keep the same): " new_gid

    # Prompt for the new full name (comment/room number)
    read -p "Enter the new full name (comment/room number) (leave blank to keep the same): " new_info

    # Prompt for the new home directory
    read -p "Enter the new home directory (leave blank to keep the same): " new_home

    # Prompt for the new login shell
    read -p "Enter the new login shell (leave blank to keep the same): " new_shell

    # Modify the user account properties based on the provided inputs
    sudo usermod "$username" ${new_username:+"-l $new_username"} \
        ${new_uid:+"-u $new_uid"} \
        ${new_gid:+"-g $new_gid"} \
        ${new_info:+"-c $new_info"} \
        ${new_home:+"-d $new_home"} \
        ${new_shell:+"-s $new_shell"}

    echo "User account '$username' successfully modified."
}

# Function to display usage information
display_usage() {
    echo "Usage: $0 [-c|--create] [-d|--delete] [-r|--reset] [-l|--list] [-m|--modify] [-h|--help]"
    echo "Options:"
    echo "  -c, --create    Create a new user account"
    echo "  -d, --delete    Delete an existing user account"
    echo "  -r, --reset     Reset the password of an existing user account"
    echo "  -l, --list      List all user accounts on the system"
    echo "  -m, --modify    Modify user account properties"
    echo "  -h, --help      Display usage information (this message)"
}

# Main script

# Check if no arguments are provided
if [ $# -eq 0 ]; then
    display_usage
    exit 1
fi

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        -c|--create)
            create_account
            ;;
        -d|--delete)
            delete_account
            ;;
        -r|--reset)
            reset_password
            ;;
        -l|--list)
            list_accounts
            ;;
        -m|--modify)
            modify_account
            ;;
        -h|--help)
            display_usage
            exit 0
            ;;
        *)
            echo "Unknown option: $key"
            display_usage
            exit 1
            ;;
    esac

    shift
done
