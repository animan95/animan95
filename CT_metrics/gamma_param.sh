#!/bin/bash

# Specify the output file
#output_file="file_overlap"

# Iterate through each file
for input_file in *.out; do
    out=$(echo ${input_file} | cut -d "." -f1)
    output_file=${out}_gamma.txt
    nroots=$(grep "cis_n_roots" "$input_file" | cut -d " " -f2)
    # Use grep to find the line containing the keyword "overlap" and awk to extract the value
    overlap_value=$(grep -oP 'Delta-r \+ Delta-sigma\s+=\s+\K\d+\.\d+ A\s+\(NTO\)' "$input_file" | grep -oP '\d+\.\d+')
    #overlap_value2=$(grep "^| Gamma.*(Boys)$" "$input_file" | cut -d "=" -f3)
    #overlap_value3=$(grep "^| Gamma.*(NTO)$" "$input_file" | cut -d "=" -f3)

    # Check if the overlap value is not empty before storing it in the output file
    if [ -n "$overlap_value" ]; then
        # Store the overlap value in the output file
        echo "$overlap_value" > "$output_file"
    else
        echo "$input_file: No overlap value found" > "$output_file"
    fi
    #sed -i "1,${nroots}d" ${output_file}
done


