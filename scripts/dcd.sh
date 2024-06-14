#!/bin/bash
bash lambda_param.sh
bash re_av.sh
bash rh_av.sh
bash sig_e.sh
bash sig_h.sh
bash re_rh.sh
bash sig_e_sig_h.sh

for input_file in *.out; do
    out=$(echo ${input_file} | cut -d "." -f1)
    output_file=${out}_d_cd.txt
    # Use grep to find the line containing the keyword "overlap" and awk to extract the value
    #overlap_value=$(grep "Spatial overlap:" "$input_file" | cut -d ":" -f2)
   # overlap_value1=$(grep "Electron size" "$input_file" | rev | cut -d " " -f1 | rev)
   # overlap_value2=$(grep "Hole size" "$input_file" | rev | cut -d " " -f1 | rev)
   overlap_value1=${out}_r_eh.txt
   overlap_value2=${out}_sig_eh.txt

  # Check if the overlap value is not empty before storing it in the output file
    if [ -n "$overlap_value1" ] && [ -n "$overlap_value2" ]; then
     # Store the overlap value in the output file
        #overlap_value=$(awk "BEGIN {print $overlap_value1+$overlap_value2}")
        paste "$overlap_value1" "$overlap_value2"| awk '{print $1 - $2}'  > "$output_file"
      #  echo "$input_file: $overlap_value" > "$output_file"
    else
        echo "$input_file: No overlap value found" > "$output_file"
    fi

done


