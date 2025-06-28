#!/bin/bash

# ---- Directories ----
input_dir="/mnt/e/OASIS3"
output_dir="/mnt/e/OASIS3_after_fslreorient2std"

mkdir -p "$output_dir"

echo "Reorienting all images in $input_dir to standard orientation using fslreorient2std..."

# ---- Process each .nii or .nii.gz ----
find "$input_dir" -type f \( -name "*.nii" -o -name "*.nii.gz" \) | while read -r file; do
    rel_path="${file#$input_dir/}"
    out_path="$output_dir/$rel_path"
    out_dir=$(dirname "$out_path")
    mkdir -p "$out_dir"

    fslreorient2std "$file" "$out_path"
    echo "Reoriented: $rel_path"
done

echo "Done! All reoriented files saved in: $output_dir"
