# Transferring Cursor Configuration to Other Workstations

You've successfully created a backup of your Cursor configuration in `cursor_config_backup_20250311_154944.tar.gz`. Here's how to transfer and restore it on other workstations:

## Step 1: Transfer the Backup File

Choose one of these methods to transfer the backup file:

### Option A: Using a USB Drive

1. Copy `cursor_config_backup_20250311_154944.tar.gz` to a USB drive
2. Plug the USB drive into the target workstation
3. Copy the file to the target workstation

### Option B: Using Cloud Storage

1. Upload `cursor_config_backup_20250311_154944.tar.gz` to Google Drive, Dropbox, or similar
2. Download it on the target workstation

### Option C: Using SCP (Secure Copy)

If both machines are on the same network:

```bash
# From the target machine
scp username@source_machine:/path/to/cursor_config_backup_20250311_154944.tar.gz .
```

## Step 2: Extract the Backup on the Target Workstation

```bash
# Navigate to where you copied the file
cd /path/to/backup

# Extract the archive
tar -xzf cursor_config_backup_20250311_154944.tar.gz

# Enter the extracted directory
cd cursor_config_backup_20250311_154944
```

## Step 3: Restore the Configuration

1. Make sure Cursor is not running on the target workstation
2. Run the restore script:
   ```bash
   ./restore_cursor_config.sh
   ```

## Step 4: Install Extensions

Follow the instructions in `install_extensions.md` to reinstall your extensions.

## Step 5: Verify the Configuration

1. Start Cursor
2. Check that your settings have been applied
3. Verify that your extensions are working correctly

## Troubleshooting

If you encounter issues:

1. **Missing Directories**: Create them manually:

   ```bash
   mkdir -p ~/.config/Cursor/User
   mkdir -p ~/.cursor
   ```

2. **Permission Issues**: Ensure you have the correct permissions:

   ```bash
   chmod -R u+w ~/.config/Cursor
   chmod -R u+w ~/.cursor
   ```

3. **Different OS**: If transferring between different operating systems (e.g., Linux to Windows), you may need to adjust paths in the settings files.

4. **Extension Compatibility**: Some extensions might not be available or compatible on the target system. Install alternatives if needed.

## Additional Notes

- **Node.js Version**: If you're using MCP tools, make sure to install the same Node.js version on the target workstation
- **GitHub Tokens**: You'll need to re-enter any GitHub tokens or other credentials on the new workstation
- **Project-Specific Settings**: Workspace settings are not included in this backup as they're stored with each project