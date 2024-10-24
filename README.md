# Smart OneDrive Boot Mount

This script enhances the automatic mounting of a OneDrive account using rclone on system startup. It improves reliability through internet connection checks and an automatic retry mechanism with exponential backoff. The script also enhances user experience by providing desktop notifications about the mounting status and incorporating error handling. These features ensure a more stable OneDrive mounting process with clear user feedback.

> [!IMPORTANT]
> Before using this script, you must configure rclone for your OneDrive account. Follow the guide "[How to Mount OneDrive in Linux Using Rclone](https://www.linuxuprising.com/2018/07/how-to-mount-onedrive-in-linux-using.html)" to set this up. This script requires a working rclone configuration named "onedrive". Verify your rclone setup is functioning correctly before proceeding with this script.

## Setup Guide

### Method 1: Using Command Line

1. Make the script executable:

   ```bash
   chmod +x /path/to/smart-onedrive-boot-mount.sh
   ```

2. Edit your `.bashrc` or `.profile` file:

   ```bash
   nano ~/.bashrc
   ```

   or

   ```bash
   nano ~/.profile
   ```

3. Add the following line at the end of the file:

   ```bash
   /path/to/smart-onedrive-boot-mount.sh &
   ```

4. Save the file and exit the editor.

5. Reload your `.bashrc` or `.profile`:

   ```bash
   source ~/.bashrc
   ```

   or

   ```bash
   source ~/.profile
   ```

### Method 2: Using Startup Applications (Ubuntu 24.04)

1. Open the "Startup Applications" app.

2. Click on "Add".

3. Fill in the details:
   - Name: `Smart OneDrive Boot Mount`
   - Command: `/path/to/smart-onedrive-boot-mount.sh`
   - Comment: `Mounts OneDrive on startup`

4. Click "Add" to save the new startup application.

5. Restart your computer or log out and log back in for the changes to take effect.

> [!NOTE]
> Make sure to replace `/path/to/` with the actual path to where the code is stored.
