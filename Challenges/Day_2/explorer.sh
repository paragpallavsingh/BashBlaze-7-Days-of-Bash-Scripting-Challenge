#!/bin/bash

<<<<<<< HEAD
printf "Day 2 : Script Part 1 : explorer.sh\n"
printf "\nTask 1: Print all files, directories one time, with size in human readable format\n"
ls -lh | awk '{printf " - %s (%s) \n",$9,$5}'
printf "\nTask 2: Do the same thing in a loop until you press q\n"
while true;
do
	printf "\n-------\n"
	ls -lh | awk '{printf " - %s (%s) \n",$9,$5}'
	printf "\n-------\n"
	read -p "Press q to exit, any other key to continue: " option
	if [ "$option" == q ];
	then
		printf "You have pressed $option and come out of the loop\n"
		break
	fi
done

printf "\nDay 2 Script Part 2: Character Counting\n"
while true;
do
	read -p "Enter input: " string
	char_count=$(echo -n "$string" | wc -m)
	printf "Character count: %d\n" "$char_count"
	read -p "Press q to quit, any other key to continue: " option
	if [ "$option" == q ];
	then
		printf "You have pressed $option and come out of the loop\n"
		break
	fi
done
printf "BBye for now! #twsbashblazechallenge rocks\n"
=======
# Part 1: File and Directory Exploration
echo "Welcome to the Interactive File and Directory Explorer!"

while true; do
    # List all files and directories in the current path
    echo "Files and Directories in the Current Path:"
    ls -lh

    # Part 2: Character Counting
    read -p "Enter a line of text (Press Enter without text to exit): " input

    # Exit if the user enters an empty string
    if [ -z "$input" ]; then
        echo "Exiting the Interactive Explorer. Goodbye!"
        break
    fi

    # Calculate and print the character count for the input line
    char_count=$(echo -n "$input" | wc -m)
    echo "Character Count: $char_count"
done
>>>>>>> d838192f38ba443f63e003f94915dc7618887f6b
