#!/bin/bash
bash dcd.sh
bash osc.sh
bash energy.sh
bash gamma_param.sh
for input_file in *.out; do
    out=$(echo ${input_file} | cut -d "." -f1)
    output_file=${out}_d_tilcd.txt
    # Use grep to find the line containing the keyword "overlap" and awk to extract the value
    #overlap_value=$(grep "Spatial overlap:" "$input_file" | cut -d ":" -f2)
   # overlap_value1=$(grep "Electron size" "$input_file" | rev | cut -d " " -f1 | rev)
   # overlap_value2=$(grep "Hole size" "$input_file" | rev | cut -d " " -f1 | rev)
   overlap_value1=${out}_r_eh.txt
   overlap_value2=${out}_rms_eh_sep.txt

  # Check if the overlap value is not empty before storing it in the output file
    if [ -n "$overlap_value1" ] && [ -n "$overlap_value2" ]; then
     # Store the overlap value in the output file
        #overlap_value=$(awk "BEGIN {print $overlap_value1+$overlap_value2}")
        paste "$overlap_value1" "$overlap_value2"| awk '{print $1 + $2}'  > "$output_file"
      #  echo "$input_file: $overlap_value" > "$output_file"
    else
        echo "$input_file: No overlap value found" > "$output_file"
    fi
en_value=${out}_en.txt
ct_value1=${out}_lambda.txt
ct_value2=${out}_d_cd.txt
ct_value3=$output_file
ct_value4=${out}_gamma.txt
ct_value5=${out}_osc.txt
#paste -d " "   "$label1" "$label2" "$label3" > ${out}_comp.txt
paste -d "	" "$en_value" "$ct_value5" "$ct_value1" "$ct_value2" "$ct_value3" "$ct_value4" >  ${out}_comp.txt
done

