# Cursor Configuration Backup Tool

A comprehensive tool to backup, restore, and transfer your Cursor IDE configuration across multiple workstations.

## Features

- **Complete Configuration Backup**: Saves all your Cursor settings, keybindings, snippets, and extension configurations
- **Cross-Platform Support**: Works on Linux, macOS, and Windows (with path adjustments)
- **Easy Restoration**: Includes scripts to automate the restoration process
- **Extension Management**: Creates a list of your installed extensions for easy reinstallation
- **Detailed Documentation**: Includes comprehensive instructions for transferring and restoring your configuration

## Quick Start

### Backup Your Configuration

```bash
# Make the script executable
chmod +x backup_cursor_config.sh

# Run the backup script
./backup_cursor_config.sh
```

This will create a timestamped backup archive (e.g., `cursor_config_backup_20250311_154944.tar.gz`).

### Restore Your Configuration

```bash
# Extract the backup archive
tar -xzf cursor_config_backup_YYYYMMDD_HHMMSS.tar.gz

# Navigate to the extracted directory
cd cursor_config_backup_YYYYMMDD_HHMMSS

# Run the restore script
./restore_cursor_config.sh
```

## What's Included in the Backup

- `settings.json`: Your user settings
- `keybindings.json`: Your keyboard shortcuts (if any)
- `snippets/`: Your code snippets (if any)
- `argv.json`: Cursor startup configuration
- `globalStorage/`: Extension settings
- `extensions/`: List of installed extensions

## Transferring to Other Workstations

See [Transfer Instructions](cursor_config_transfer_instructions.md) for detailed steps on transferring your configuration to other workstations.

## MCP Tools Support

If you're using MCP (Model Control Protocol) tools with Cursor, this backup includes:

- Your MCP configuration settings
- A record of the Node.js version you're using (important for compatibility)

Remember to install the same Node.js version on your target workstation for MCP tools to work correctly.

## Customization

You can modify the `backup_cursor_config.sh` script to include additional files or directories in your backup.

## Troubleshooting

If you encounter issues during restoration:

1. Check that Cursor is not running during the restore process
2. Verify that you have the necessary permissions to write to the configuration directories
3. For cross-platform transfers, adjust paths as needed for the target operating system

## License

MIT

## Contributing

Contributions are welcome! Feel free to submit issues or pull requests.