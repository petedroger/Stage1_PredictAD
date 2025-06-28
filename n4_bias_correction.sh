#!/bin/bash

input_dir="/mnt/e/OASIS3_after_fslreorient2std"

echo " Starting N4 Bias Field Correction using wrapper script..."

find "$input_dir" -type f -name "*.nii.gz" | parallel --jobs 5 ./run_n4_onefile.sh {}
