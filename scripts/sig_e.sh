#!/bin/bash

# Specify the output file
#output_file="file_overlap"

# Iterate through each file
for input_file in *.out; do
    out=$(echo ${input_file} | cut -d "." -f1)
    output_file=${out}_sig_e.txt
    # Use grep to find the line containing the keyword "overlap" and awk to extract the value
    #overlap_value=$(grep "Spatial overlap:" "$input_file" | cut -d ":" -f2)
     overlap_value=$(grep -m 15 "Electron size" "$input_file" | rev | cut -d " " -f1 | rev)
    # Check if the overlap value is not empty before storing it in the output file
    if [ -n "$overlap_value" ]; then
        # Store the overlap value in the output file
        echo "$input_file: $overlap_value" > "$output_file"
    else
        echo "$input_file: No overlap value found" > "$output_file"
    fi
done


