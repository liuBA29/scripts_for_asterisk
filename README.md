# scripts_for_asterisk

This repository contains a collection of useful **Bash** and **Python** scripts for working with Asterisk, focused on automating various tasks.

### 🛠 Technologies Used:
- **Bash Scripting**
- **Linux CLI**
- **Asterisk**
- **sox** (for working with `.wav` files)

### 📂 Scripts:

#### 1. **ftp_upload.sh**
   - **Description**: A Bash script to upload Asterisk monitor files from a local server to an FTP server.
   - **Features**:
     - Creates directories on the FTP server.
     - Uploads files from a local directory.
     - Deletes uploaded files locally.
   - **Usage**:
     ```bash
     bash ftp_upload.sh
     ```

#### 2. **rename_audio_files.sh**
   - **Description**: A script to rename `.wav` files in a directory by their duration using `sox`.
   - **Features**:
     - Scans `.wav` files in a given directory.
     - Renames each file with its duration in the format `HH-MM-SS`.
   - **Usage**:
     ```bash
     bash rename_audio_files.sh
     ```

### 📥 Prerequisites:
- Ensure the following utilities are installed on your system:
   - `sox` for audio file manipulation (for **rename_audio_files.sh**):
     ```bash
     sudo apt-get install sox
     ```

### 📝 How to Use:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/liuBA29/scripts_for_asterisk.git
   cd scripts_for_asterisk
