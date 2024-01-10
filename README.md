# PseudoCrypt README

## Overview
This PowerShell script is designed for ransomware simulation to test detection capabilities. It automates the creation of directories and files, encrypts them, and then simulates an exfiltration of data by zipping and renaming files, finally preparing them for transfer via SFTP.

## Prerequisites
- PowerShell 5.1 or later.
- Ensure execution policy allows script execution (consult your organization's policy).

## Setup Instructions
1. **Directory and File Setup**: 
   - The script uses the `MyDocuments` folder as the base directory.
   - Files of size 2.5MB are created for the test.
   - A password for encryption must be set in the `$encryptionPassword` variable.

2. **Encrypt-File Function**: 
   - The script includes a function to encrypt files using AES encryption.
   - The encryption password is used as a key, padded and truncated to meet AES requirements.

3. **File and Directory Creation**:
   - The script generates three subfolders in the base directory.
   - In each subfolder, 100 random data files are created and encrypted.
   - Original files are deleted post-encryption for simulation authenticity.

4. **Data Aggregation**:
   - All encrypted files are compressed into a single ZIP file.
   - The ZIP is then renamed to an ISO file to simulate data packaging for exfiltration.

5. **Data Exfiltration Simulation**:
   - Prepares the ISO file for transfer via SFTP.
   - Update the SFTP server username and IP address in the script accordingly.

## Execution Instructions
1. Modify the script variables as needed (i.e. the `$encryptionPassword`, `user`, and `sftpServerIP`).
2. Run the script in PowerShell.
3. Monitor the output for completion and any errors.

## Disclaimer
- This script is for authorized testing and educational purposes only.
- Ensure you have explicit permission to run this simulation in your environment.

## Troubleshooting
- If you encounter permission issues, verify your PowerShell execution policy and user permissions.
- Ensure the SFTP server details are correctly entered.
