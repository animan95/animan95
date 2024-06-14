#!/bin/bash

# Specify the output file
#output_file="file_overlap"

# Iterate through each file
for input_file in *.out; do
    out=$(echo ${input_file} | cut -d "." -f1)
    output_file=${out}_r_eh.txt
    # Use grep to find the line containing the keyword "overlap" and awk to extract the value
    #overlap_value=$(grep "Spatial overlap:" "$input_file" | cut -d ":" -f2)
   # overlap_value1=$(grep "Electron size" "$input_file" | rev | cut -d " " -f1 | rev)
   # overlap_value2=$(grep "Hole size" "$input_file" | rev | cut -d " " -f1 | rev)
   overlap_value1=${out}_re_av.txt
   overlap_value2=${out}_rh_av.txt
   
  # Check if the overlap value is not empty before storing it in the output file
    if [ -n "$overlap_value1" ] && [ -n "$overlap_value2" ]; then   
     # Store the overlap value in the output file
        #overlap_value=$(awk "BEGIN {print $overlap_value1+$overlap_value2}")
        paste "$overlap_value1" "$overlap_value2"| awk '{print ($1 >= $2) ? $1 - $2 : $2 - $1}'  > "$output_file"
      #  echo "$input_file: $overlap_value" > "$output_file"
    else
        echo "$input_file: No overlap value found" > "$output_file"
    fi

done


