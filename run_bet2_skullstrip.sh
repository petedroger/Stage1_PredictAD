#!/bin/bash

# ---------- CONFIG ----------
input_dir="/mnt/e/OASIS3_after_N4BiasCorrected"
output_dir="/mnt/e/OASIS3_after_SkullStripped"
mkdir -p "$output_dir"

echo "Starting BET2 Skull Stripping (resumable)..."

# ---------- RUN BET2 ----------
find "$input_dir" -type f -name "*.nii.gz" | while read -r file; do
    rel_path="${file#$input_dir/}"
    subfolder=$(dirname "$rel_path")
    filename=$(basename "$file" .nii.gz)

    out_subdir="$output_dir/$subfolder"
    mkdir -p "$out_subdir"

    mask_file="$out_subdir/${filename}_mask.nii.gz"

    # Skip if already processed
    if [[ -f "$mask_file" ]]; then
        echo "Skipping (already processed): $rel_path"
        continue
    fi

    echo "Processing: $rel_path"
    bet2 "$file" "$out_subdir/${filename}" -m -f 0.5 -v

    # Check if brain mask was successfully created
    if [[ -f "$mask_file" ]]; then
        echo "Skull-stripped: $rel_path"
    else
        echo " Failed to create mask for: $rel_path"
    fi
done

echo "Done! All outputs saved to: $output_dir"


