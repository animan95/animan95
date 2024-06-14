#!/bin/bash

# Specify the output file
#output_file="file_overlap"

# Iterate through each file
for input_file in *.out; do
    out=$(echo ${input_file} | cut -d "." -f1)
    output_file=${out}_lambda.txt
    nroots=$(grep "cis_n_roots" "$input_file" | cut -d " " -f2)
    # Use grep to find the line containing the keyword "overlap" and awk to extract the value
    overlap_value=$(grep -oP 'Lambda\s+=\s+\K\d+\.\d+ \s+\s+\(NTO\)' "$input_file" | grep -oP '\d+\.\d+')

    # Check if the overlap value is not empty before storing it in the output file
    if [ -n "$overlap_value" ]; then
        # Store the overlap value in the output file
        echo "$overlap_value" > "$output_file"
    else
        echo "$input_file: No overlap value found" > "$output_file"
    fi
done

