# Cursor Configuration Restoration Guide

This guide provides detailed instructions for restoring your Cursor configuration from a backup. Follow these steps to get your Cursor IDE set up exactly as it was on your original workstation.

## Prerequisites

Before starting the restoration process, ensure you have:

1. The backup archive file (e.g., `cursor_config_backup_20250311_154944.tar.gz`)
2. Cursor IDE installed on the target workstation
3. Terminal/command line access
4. Basic familiarity with command line operations

## Step-by-Step Restoration Process

### 1. Prepare the Backup Archive

First, copy your backup archive to the target workstation using one of these methods:

- **USB Drive**: Copy the file from a USB drive
- **Cloud Storage**: Download from Google Drive, Dropbox, etc.
- **Direct Transfer**: Use SCP or similar tools if both machines are on the same network

### 2. Extract the Backup Archive

Open a terminal and navigate to where you saved the backup archive:

```bash
# Navigate to the directory containing the backup
cd /path/to/backup/location

# Extract the archive
tar -xzf cursor_config_backup_YYYYMMDD_HHMMSS.tar.gz

# Navigate into the extracted directory
cd cursor_config_backup_YYYYMMDD_HHMMSS
```

Replace `YYYYMMDD_HHMMSS` with the actual timestamp in your backup filename.

### 3. Close Cursor

Ensure Cursor is not running before proceeding with the restoration:

```bash
# On Linux/macOS
pkill -x cursor

# On Windows (run in PowerShell)
# Stop-Process -Name "cursor" -ErrorAction SilentlyContinue
```

### 4. Run the Restore Script

Execute the restore script included in the backup:

```bash
# Make the script executable (Linux/macOS only)
chmod +x restore_cursor_config.sh

# Run the restore script
./restore_cursor_config.sh
```

The script will:
- Create necessary directories if they don't exist
- Copy your settings, keybindings, and snippets
- Restore extension configurations
- Restore Cursor startup configuration

### 5. Install Extensions

After restoring your configuration files, you need to reinstall your extensions:

1. Open the `extensions_list.txt` file in the `extensions` directory to see what extensions you had installed
2. Install each extension using one of these methods:

   **Method A: Using Cursor UI**
   - Open Cursor
   - Go to Extensions view (Ctrl+Shift+X or Cmd+Shift+X)
   - Search for each extension by name and install

   **Method B: Using Command Line**
   - For each extension, run:
     ```bash
     cursor --install-extension EXTENSION_ID
     ```
     Replace `EXTENSION_ID` with the extension identifier from the list

### 6. Verify the Restoration

1. Start Cursor
2. Check that your settings have been applied:
   - Theme and appearance
   - Editor preferences
   - Keyboard shortcuts
   - Snippets
3. Verify that your extensions are working correctly

## Troubleshooting

### Common Issues and Solutions

#### Missing Directories
If the restore script fails because directories don't exist:

```bash
# Create the necessary directories manually
mkdir -p ~/.config/Cursor/User
mkdir -p ~/.cursor
```

For Windows:
```powershell
# PowerShell commands
New-Item -Path "$env:APPDATA\Cursor\User" -ItemType Directory -Force
```

#### Permission Issues
If you encounter permission errors:

```bash
# Linux/macOS
chmod -R u+w ~/.config/Cursor
chmod -R u+w ~/.cursor
```

#### Path Differences Between Operating Systems
When transferring between different operating systems, you may need to manually adjust paths in settings files:

- **Linux**: `~/.config/Cursor/`
- **macOS**: `~/Library/Application Support/Cursor/`
- **Windows**: `%APPDATA%\Cursor\`

#### MCP Tools Issues
If you're using MCP tools and they're not working after restoration:

1. Ensure you have the same Node.js version installed:
   ```bash
   # Check current Node.js version
   node -v
   
   # Install NVM if needed
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
   
   # Install and use the correct Node.js version
   nvm install 16  # or whatever version you were using
   nvm use 16
   ```

2. Reinstall the MCP tools:
   ```bash
   npm install -g @agentdeskai/browser-tools-mcp
   ```

## Cross-Platform Restoration

### Linux to Windows

1. Extract the backup on Windows
2. Manually copy:
   - `settings.json` to `%APPDATA%\Cursor\User\`
   - `keybindings.json` to `%APPDATA%\Cursor\User\`
   - `snippets\` to `%APPDATA%\Cursor\User\`
   - Edit paths in settings to use Windows-style paths

### Windows to Linux

1. Extract the backup on Linux
2. Manually copy:
   - `settings.json` to `~/.config/Cursor/User/`
   - `keybindings.json` to `~/.config/Cursor/User/`
   - `snippets/` to `~/.config/Cursor/User/`
   - Edit paths in settings to use Linux-style paths

### macOS to Linux/Windows (or vice versa)

Follow the same pattern as above, adjusting paths accordingly.

## Additional Notes

- **GitHub Tokens**: You'll need to re-enter any GitHub tokens or other credentials
- **Project-Specific Settings**: Workspace settings are not included in this backup
- **Extension Versions**: You might get newer versions of extensions when reinstalling

## Need Help?

If you encounter issues not covered in this guide:

1. Check the [GitHub repository](https://github.com/frank-blueview-ai/cursor-config-backup) for updates
2. Open an issue on GitHub describing your problem
3. Consider contributing your solution back to the project