# File Integrity Monitor with Email Notifications

This PowerShell script monitors files for changes and sends email notifications to specified recipients when changes are detected. It's particularly useful for ensuring the integrity of critical files and detecting unauthorized modifications.

## Features

- **Continuous Monitoring**: The script continuously monitors files in the specified directory.
- **File Integrity Verification**: It calculates the hash of each file and compares it to a baseline hash stored in a text file (`baseline.txt`) to detect changes.
- **Email Notifications**: When a new file is created or a file is changed, the script sends an email notification to specified recipients.
- **Deleted File Detection**: It detects when a file from the baseline is deleted and notifies the user via email.

## Setup

1. **Installation**: Simply download or clone the repository.
2. **Configuration**: Modify the script to specify the email sender, recipient, SMTP server settings, and the directory to monitor.
3. **Baseline Setup**: Create a baseline text file (`baseline.txt`) containing file paths and their corresponding hash values for the files in the monitored directory.

## Usage

1. Before running the script, ensure you have configured the necessary settings and specified the directory to monitor.
2. Run the script using PowerShell.
3. Any changes detected will be reported in the console and via email notifications.

## Dependencies

- PowerShell 5.0 or higher.

## Example

```powershell
.\FileIntegrityMonitor.ps1
