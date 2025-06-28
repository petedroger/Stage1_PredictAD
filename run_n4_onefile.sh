#!/bin/bash

# Get input file path
input_file="$1"
input_dir="/mnt/e/OASIS3_after_fslreorient2std"
output_dir="/mnt/e/OASIS3_after_N4BiasCorrected"

# Get relative path and construct output path
rel_path="${input_file#$input_dir/}"
out_path="$output_dir/$rel_path"
out_dir=$(dirname "$out_path")

# Skip if already processed
if [[ -f "$out_path" ]]; then
    echo "⏭️ Skipping (already exists): $rel_path"
    exit 0
fi

mkdir -p "$out_dir"

# Activate ANTs environment
source ~/miniconda3/etc/profile.d/conda.sh
conda activate ants

# Run N4 bias correction
echo "🔧 Correcting: $rel_path"
N4BiasFieldCorrection -d 3 -i "$input_file" -o "$out_path"

