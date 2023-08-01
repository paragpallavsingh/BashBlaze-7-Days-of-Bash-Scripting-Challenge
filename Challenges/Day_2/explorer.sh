#!/bin/bash

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
