#!/bin/bash

# Task 1: Comments
printf "Task 1: Comments\n\n"
# This is a sample comment. When any line starts with a pound(#) sign in Linux, it is skipped by interpreter

# Task  2: Echo
printf "Task 2: Echo Command\n\n"
echo "BashBlaze Challenges..! initited by @TWS"
echo "submitted day 1"

# Task  3: Variables
printf "\nTask 3: Variables\n\n"
printf "Here's how one can define a variable:\n\n"
name="Parag Pallav Singh"
address="Agra"

# Task 4: Using variables
printf "Task 4: Using Variables\n\n"
printf "We can use a $ sign to use a variable\n"
printf "name and address $name and $address \n\n"

# Task  5: Using Built-in Variables
printf "Task 5: Using buit-in Variables\n\n"
printf "Linux has some built in variables that hold some predefined values\n\n"
echo "Show my bash path - $BASH"
echo "Bash version I am using - $BASH_VERSION"
echo "PID of bash I am running - $$"
echo "My home directory - $HOME"
echo "Where am I currently? - $PWD"
echo "My hostname - $HOSTNAME"

# Task  6: Wildcards
printf "\nTask 6: Using Wildcards\n\n"
printf "Wildcard is a symbol or set of symbols used to substitute any string"
ls -l s* # this give all the files and directories starting with s in current directory

#chmod +x day1_script.sh We will be giving this file executable permission

