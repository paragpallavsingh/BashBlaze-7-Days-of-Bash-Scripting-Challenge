#!/bin/bash

# Welcome to the Mysterious Script Challenge!
# Your task is to unravel the mystery behind this script and understand what it does.
# Once you've deciphered its objective, your mission is to improve the script by adding comments and explanations for clarity.

# DISCLAIMER: This script is purely fictional and does not perform any harmful actions.
# It's designed to challenge your scripting skills and creativity.

# The Mysterious Function
mysterious_function() {
    # Accepts two arguments: input_file and output_file
    local input_file="$1"
    local output_file="$2"
    
    # Step 1: Translate characters using the 'tr' command
    tr 'A-Za-z' 'N-ZA-Mn-za-m' < "$input_file" > "$output_file"

    # Step 2: Reverse the content of the output file and save it to a temporary file.
    rev "$output_file" > "reversed_temp.txt"
    
    printf "reverse temp-->\n"
    cat reversed_temp.txt

    # 
    random_number=$(( ( RANDOM % 10 ) + 1 ))

    # Mystery loop: 
    for (( i=0; i<$random_number; i++ )); do
        # 
        rev "reversed_temp.txt" > "temp_rev.txt"
	printf "$i"
	cat temp_rev.txt
        # 
        tr 'A-Za-z' 'N-ZA-Mn-za-m' < "temp_rev.txt" > "temp_enc.txt"

        # 
        mv "temp_enc.txt" "reversed_temp.txt"
    done

    # Clean up temporary files
    rm "temp_rev.txt"

    # The mystery continues...
    # The script will continue with more operations that you need to figure out!


    # So the mystery ovehere depends upon the number of times encryption has been done to the input string
    # if the number of times encryption has been done is even (random number + 1 (before for loop)), then reversed_temp.txt file will contain the original input string after for loop
    # Similarly, if the number of times encryption has been done is odd (random number + 1 (before for loop)), then reversed.txt will contain the reversed encrypted value after for loop

    # we need to check if randomNumber + 1 is an odd integer, if so, then perform reversal on reversed_temp.txt and then encrypt using ROT-13 to get back the original string
    if [[ $(echo "($random_number + 1) % 2" | bc) -ne 0 ]];then
	    # Perform reversal on reversed_temp.txt file
	    reverse=$(rev "reversed_temp.txt")
	    decryption=$(echo "$reverse" | tr 'A-Za-z' 'N-ZA-Mn-za-m')
	    if [[ $decryption == $(cat $input_file) ]];then
		    # Output will contain same input string
		    echo $decryption > $output_file
	    fi
    else
	    # Total number of encryptions was even, so reversed_temp.txt should contain the original input string
	    decrypted_string=$(cat "reversed_temp.txt")
	    original_string=$(cat $input_file)
	    if [[ $decrypted_string == $original_string ]];then
		    # Output will contain same input string
		    echo $decrypted_string > $output_file
	    fi
    fi
}

# Main Script Execution

# Check if two arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <input_file> <output_file>"
    exit 1
fi

input_file="$1"
output_file="$2"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: Input file not found!"
    exit 1
fi

# Call the mysterious function to begin the process
mysterious_function "$input_file" "$output_file"

# Display the mysterious output
echo "The mysterious process is complete. Check the '$output_file' for the result!"
