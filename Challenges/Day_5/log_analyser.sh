#!/bin/bash

# Check if the path to the log file is provided as a command-line argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <log_file_path>"
    exit 1
fi

# Extract the log file path from the command-line argument
log_file=$1

# Check if the log file exists
if [ ! -f "$log_file" ]; then
    echo "Error: Log file not found: $log_file"
    exit 1
fi

# Step 2: Count the number of error messages using associative array
declare -A error_counts
while IFS= read -r line; do
    if [[ "$line" =~ ERROR|Failed ]]; then
        error_counts["$line"]=$((error_counts["$line"] + 1))
    fi
done < "$log_file"

# Step 3: Search for lines containing the keyword "CRITICAL" and print those lines along with the line number.
critical_events=$(grep -n "CRITICAL" "$log_file")

# Step 4: Identify the top 5 most common error messages and display them along with their occurrence count.
IFS=$'\n'
sorted_errors=($(printf '%s\n' "${!error_counts[@]}" | sort -nr -k2))
unset IFS
top_5_error_messages=""
for ((i=0; i<5 && i<${#sorted_errors[@]}; i++)); do
    error_msg=${sorted_errors[$i]}
    count=${error_counts["$error_msg"]}
    top_5_error_messages+="Count: $count - Error: $error_msg"$'\n'
done

# Get the current date in the format "YYYY-MM-DD"
current_date=$(date '+%Y-%m-%d')

# Create the summary report file
summary_report="summary_report_$current_date.txt"

# Get the total number of lines in the log file
total_lines=$(wc -l < "$log_file")

# Write the summary report
cat <<EOF > "$summary_report"

Submission Day 5 - by Parag Pallav Singh - Log Analyser 

Summary Report - $current_date

Log file: $log_file

Total lines processed: $total_lines
Total error count: $error_count

Top 5 Error Messages:
$top_5_error_messages

List of Critical Events with Line Numbers:
$critical_events

EOF

echo "Summary report generated: $summary_report"

# Create the archive directory if it doesn't exist
archive_dir="archive_logs"
mkdir -p "$archive_dir"

# Move the processed log file to the archive directory
mv "$log_file" "$archive_dir/"

echo "Log file archived in: $archive_dir"
