#!/bin/bash

# -------- CONFIGURATION --------
input_dir="/mnt/e/OASIS3_after_SkullStripped"
output_dir="/mnt/e/OASIS3_after_registration"
invalid_list="/mnt/e/CodeREU/invalid_orientation_list"
mni_template="$FSLDIR/data/standard/MNI152_T1_1mm_brain.nii.gz"

mkdir -p "$output_dir"

# Extract only the filenames from the invalid list
invalid_names=()
while IFS= read -r line; do
    invalid_names+=("$(basename "$line")")
done < "$invalid_list"

# -------- REGISTRATION LOOP --------
find "$input_dir" -type f -name "*.nii.gz" | while read -r input_img; do
  rel_path="${input_img#$input_dir/}"
  filename="$(basename "$input_img")"

  # Skip if filename is in the invalid list
  if printf '%s\n' "${invalid_names[@]}" | grep -Fxq "$filename"; then
    echo " Skipping (invalid): $rel_path"
    continue
  fi

  output_img="$output_dir/$rel_path"
  output_affine="${output_img%.nii.gz}_affine.mat"

  # Skip if already registered
  if [[ -f "$output_img" && -f "$output_affine" ]]; then
    echo " Skipping already registered: $rel_path"
    continue
  fi

  mkdir -p "$(dirname "$output_img")"

  flirt -in "$input_img" \
        -ref "$mni_template" \
        -out "$output_img" \
        -omat "$output_affine" \
        -dof 12 \
        -cost corratio

  echo " Registered: $rel_path"
done


