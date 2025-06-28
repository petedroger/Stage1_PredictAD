# Stage1_PredictAD
For Windows users: 
Set up a Linux environment suitable for running neuroimaging tools (FSL, ANTs).
Windows PowerShell: 
wsl --update
 wsl --shutdown
 wsl --set-default-version 2
 wsl --install -d Ubuntu-22.04
 
Bash sudo apt update
sudo apt -y upgrade
sudo apt-get install dc python3 bzip2 mesa-utils gedit firefox libgomp1
curl -Ls https://fsl.fmrib.ox.ac.uk/fsldownloads/fslconda/releases/getfsl.sh | sh -s

Please read the output carefully - the following message will be printed when the installation has completed successfully:

FSL successfully installed

If you do not see this message:
Save a copy of all of the text that the installer printed to the terminal

Search in your home directory for a file called fsl_installation_<date>.log (where <date> is a series of numbers representing the current date.

Check the troubleshooting page for some potential solutions.
Send us a message with the above information, and we will try our best to help.
Otherwise, you can verify your installation to make sure that the installation has succeeded.

Download OASIS3:
./download_oasis_scans.sh <input_file.csv> <directory_name> <nitrc_ir_username> T1w

Run delete_invalid.py on VScode to delete sform_code = 0 and qform_code = 0
Bash: fix_orientation_reorient.sh to reorient to standard space using the fslreorient2std tool from FSL.

Bash: conda install -c conda-forge ants

Bash: sudo apt update

Bash: sudo apt install parallel -y

Bash: n4_bias_correction.sh to bias field correction.

Bash: run_bet2_skullstrip.sh to perform skull stripping.

Bash: MNI152_flirt_registration to perform MNI152 standard template registration.

FLSeyes to view MRIs: 
Before installing FSLeyes, you first need to install Python and the wxPython runtime dependencies. Under Ubuntu 24.04, you will need to run the following command:

sudo apt install python3 python3-pip python3-venv \
  curl libegl1 libgl1 libgtk-3-0 libnotify4       \
  libpcre2-32-0 libsdl2-2.0-0 libsm6 libxxf86vm1
  
Then you need to create and activate a virtual environment, and install wxPython and FSLeyes into it. For example, you can use these commands to create and activate a virtual environment:

python -m venv fsleyes-virtualenv
. ./fsleyes-virtualenv/bin/activate
The easiest way to install wxPython on Linux is to use the pre-release wxPython builds available at https://extras.wxpython.org/wxPython4/extras/linux/, e.g.:

wxpyurl=https://extras.wxpython.org/wxPython4/extras/linux/gtk3/ubuntu-24.04
pip install -f  ${wxpyurl} wxpython
Once you have installed wxPython, you can install FSLeyes:

pip install fsleyes

You should now be able to run the fsleyes command.

