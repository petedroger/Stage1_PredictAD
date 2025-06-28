import os
import nibabel as nib

# Set the root directory
root_dir = "E:/OASIS3 directory"

deleted_files = []

for root, dirs, files in os.walk(root_dir):
    for file in files:
        if file.endswith(".nii.gz"):
            file_path = os.path.join(root, file)
            try:
                img = nib.load(file_path)
                hdr = img.header
                if hdr['sform_code'] == 0 and hdr['qform_code'] == 0:
                    os.remove(file_path)
                    deleted_files.append(file_path)
                    print(f"🗑️ Deleted: {file_path}")
            except Exception as e:
                print(f"❌ Error processing {file_path}: {e}")

print(f"\n✅ Done! Deleted {len(deleted_files)} files.")
