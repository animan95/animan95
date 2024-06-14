#!/bin/bash

# Specify the output file
#output_file="file_overlap"

# Iterate through each file
for input_file in *.out; do
    out=$(echo ${input_file} | cut -d "." -f1)
    output_file=${out}_re_av.txt
    rm $output_file
    # Use grep to find the line containing the keyword "overlap" and awk to extract the value
   # overlap_value=$(grep "<r_e>" "$input_file" | cut -d ":" -f2)
    overlap_value=$(grep -m 15 "<r_e>" "$input_file" | rev | cut -d "[" -f1 | rev)
    cleaned_input=$(echo "$overlap_value" | sed 's/\[//;s/\]//')
    # Check if the overlap value is not empty before storing it in the output file
    if [ -n "$overlap_value" ]; then
        numbers=$(echo "$cleaned_input" | awk -F ', ' '{for (i=1; i<=NF; i++) print $i}')
      # Initialize sum variable
       sum=0
       count=0
      # Loop through each number, square it, and add to the sum
       for num in $numbers; do
           squared=$(awk "BEGIN {print $num*$num}")
           sum=$(awk "BEGIN {print $sum + $squared}")
           count=$(awk "BEGIN {print $count + 1}")
           if  [ "$count" -eq 3 ]; then
               abs_last_number=$(awk "BEGIN {print sqrt($sum)}")
               echo "$abs_last_number" >> "$output_file"
               sum=0
               count=0
           fi
       done

    else
        echo "$input_file: No overlap value found" > "$output_file"
    fi
done


