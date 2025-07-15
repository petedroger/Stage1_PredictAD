# 🧠 Stage1\_PredictAD: Neuroimaging Preprocessing Pipeline

This project provides a step-by-step guide to setting up a Linux-based environment for running essential neuroimaging preprocessing tools including **FSL**, **ANTs**, and **FSLeyes**, and includes custom scripts for operations like **bias field correction**, **skull stripping**, and **registration to MNI152 space**.

---

## 🚠 Step 1: Set Up WSL (for Windows Users Only)

If you're using Windows, you’ll need to set up the **Windows Subsystem for Linux (WSL2)**. Open **PowerShell as Administrator** and run:

```powershell
wsl --update
wsl --shutdown
wsl --set-default-version 2
wsl --install -d Ubuntu-22.04
```

After installation, reboot your machine and launch the Ubuntu terminal.

---

## 🔧 Step 2: Update Your Linux Environment

Once you're inside Ubuntu:

```bash
sudo apt update
sudo apt -y upgrade
```

---

## 🧰 Step 3: Install Required Dependencies

```bash
sudo apt-get install dc python3 python3-pip bzip2 mesa-utils gedit firefox libgomp1
```

---

## 🧠 Step 4: Install FSL (via Conda Wrapper)

```bash
curl -Ls https://fsl.fmrib.ox.ac.uk/fsldownloads/fslconda/releases/getfsl.sh | sh -s
```

You should see:

```
FSL successfully installed
```

If not, check the generated log file `fsl_installation_<date>.log` or visit the [FSL Troubleshooting Page](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation).

---

## 📄 Step 5: Format Files for Compatibility

```bash
sudo apt install dos2unix
dos2unix oasis_scan_download_example
```

---

## 📁 Step 6: Download OASIS3 Dataset

```bash
./download_oasis_scans.sh oasis_scan_download_example /mnt/e/OASIS3 <your_nitrc_ir_username> T1w
```

---

## 🐍 Step 7: Install Miniconda (Conda Environment Manager)

### 7.1 Download and Install Miniconda:

```bash
cd ~
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
```

Accept the license, install to the default path, and initialize Conda.

### 7.2 Activate Conda:

```bash
source ~/miniconda3/etc/profile.d/conda.sh
conda init
```

Test:

```bash
conda --version
```

---

## 🔬 Step 8: Set Up ANTs Environment

```bash
conda create -n ants_env -c conda-forge ants
conda activate ants_env
```

Test:

```bash
N4BiasFieldCorrection --help
```

---

## 💪 Step 9: Run Preprocessing Scripts

### ✅ Reorient to Standard Space

```bash
bash fix_orientation_reorient.sh
```

### ✅ Bias Field Correction

```bash
bash n4_bias_correction.sh
```

### ✅ Skull Stripping

```bash
bash run_bet2_skullstrip.sh
```

### ✅ MNI152 Registration

```bash
bash MNI152_flirt_registration.sh
```

---

## 🔍 Step 10: Install and Use FSLeyes (MRI Viewer)

### 10.1 Install GUI and Python dependencies:

```bash
sudo apt install python3 python3-pip python3-venv \
  curl libegl1 libgl1 libgtk-3-0 libnotify4 \
  libpcre2-32-0 libsdl2-2.0-0 libsm6 libxxf86vm1
```

### 10.2 Create virtual environment:

```bash
python3 -m venv fsleyes-virtualenv
source ./fsleyes-virtualenv/bin/activate
```

### 10.3 Install wxPython (for Ubuntu 24.04):

```bash
wxpyurl=https://extras.wxpython.org/wxPython4/extras/linux/gtk3/ubuntu-24.04
pip install -f ${wxpyurl} wxpython
```

### 10.4 Install FSLeyes:

```bash
pip install fsleyes
```

### 10.5 Launch FSLeyes:

```bash
fsleyes
```

---

## 🧼 Cleanup (Optional)

```bash
rm ~/Miniconda3-latest-Linux-x86_64.sh
```

---

## 🧠 Tips

- Use `conda activate ants_env` before running scripts
- Use `conda deactivate` to exit the environment
- Use `conda info --envs` to view all environments
- If Conda doesn’t initialize on terminal open, add this to `~/.bashrc`:

```bash
source ~/miniconda3/etc/profile.d/conda.sh
```

---

> For questions, please open an issue or contact the repository maintainer.


