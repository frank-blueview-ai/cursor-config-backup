#!/bin/bash

# Create a backup directory with timestamp
BACKUP_DIR="cursor_config_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Backup user settings
echo "Backing up user settings..."
cp -r ~/.config/Cursor/User/settings.json "$BACKUP_DIR/"
cp -r ~/.config/Cursor/User/keybindings.json "$BACKUP_DIR/" 2>/dev/null || echo "No keybindings.json found"
cp -r ~/.config/Cursor/User/snippets "$BACKUP_DIR/" 2>/dev/null || echo "No snippets directory found"

# Backup extensions list
echo "Backing up extensions list..."
mkdir -p "$BACKUP_DIR/extensions"
ls -la ~/.cursor/extensions > "$BACKUP_DIR/extensions/extensions_list.txt"

# Backup important extensions configurations
echo "Backing up extensions configurations..."
cp -r ~/.config/Cursor/User/globalStorage "$BACKUP_DIR/" 2>/dev/null || echo "No globalStorage directory found"

# Backup Cursor argv.json (contains startup configuration)
echo "Backing up Cursor startup configuration..."
cp ~/.cursor/argv.json "$BACKUP_DIR/" 2>/dev/null || echo "No argv.json found"

# Create a restore script
echo "Creating restore script..."
cat > "$BACKUP_DIR/restore_cursor_config.sh" << 'EOF'
#!/bin/bash

# Check if Cursor is running
if pgrep -x "cursor" > /dev/null; then
    echo "Please close Cursor before restoring configuration"
    exit 1
fi

# Restore user settings
echo "Restoring user settings..."
mkdir -p ~/.config/Cursor/User/
cp -f settings.json ~/.config/Cursor/User/ 2>/dev/null || echo "No settings.json found to restore"
cp -f keybindings.json ~/.config/Cursor/User/ 2>/dev/null || echo "No keybindings.json found to restore"
cp -rf snippets ~/.config/Cursor/User/ 2>/dev/null || echo "No snippets directory found to restore"

# Restore Cursor startup configuration
echo "Restoring Cursor startup configuration..."
mkdir -p ~/.cursor/
cp -f argv.json ~/.cursor/ 2>/dev/null || echo "No argv.json found to restore"

# Restore global storage (extension settings)
echo "Restoring extension settings..."
cp -rf globalStorage ~/.config/Cursor/User/ 2>/dev/null || echo "No globalStorage directory found to restore"

echo "Configuration restored. Please install the extensions listed in extensions/extensions_list.txt"
echo "Restore completed!"
EOF

chmod +x "$BACKUP_DIR/restore_cursor_config.sh"

# Create an extensions installation guide
echo "Creating extensions installation guide..."
cat > "$BACKUP_DIR/install_extensions.md" << 'EOF'
# Installing Cursor Extensions

To install the extensions from your backup, you have two options:

## Option 1: Manual Installation
1. Open Cursor
2. Go to the Extensions view (Ctrl+Shift+X)
3. Search for each extension listed in `extensions_list.txt` and install them

## Option 2: Command Line Installation
For each extension you want to install, run:

```bash
cursor --install-extension EXTENSION_ID
```

Replace EXTENSION_ID with the extension identifier from the list.

## Important Extensions
Here are some important extensions from your backup:
EOF

# Extract and add the most important extensions to the guide
grep -E "ms-python|prettier|eslint|vscode-icons|material-theme" "$BACKUP_DIR/extensions/extensions_list.txt" >> "$BACKUP_DIR/install_extensions.md" 2>/dev/null

# Create a README
echo "Creating README..."
cat > "$BACKUP_DIR/README.md" << 'EOF'
# Cursor Configuration Backup

This directory contains a backup of your Cursor configuration.

## Contents
- `settings.json`: Your user settings
- `keybindings.json`: Your keyboard shortcuts (if any)
- `snippets/`: Your code snippets (if any)
- `argv.json`: Cursor startup configuration
- `globalStorage/`: Extension settings
- `extensions/`: List of installed extensions

## Restoring
1. Copy this backup directory to your new machine
2. Run `./restore_cursor_config.sh` to restore settings
3. Follow instructions in `install_extensions.md` to reinstall your extensions

## Manual Restoration
If the restore script doesn't work, you can manually copy:
- `settings.json` to `~/.config/Cursor/User/`
- `keybindings.json` to `~/.config/Cursor/User/`
- `snippets/` to `~/.config/Cursor/User/`
- `argv.json` to `~/.cursor/`
- `globalStorage/` to `~/.config/Cursor/User/`
EOF

# Create a compressed archive
echo "Creating compressed archive..."
tar -czf "${BACKUP_DIR}.tar.gz" "$BACKUP_DIR"

echo "Backup completed! Your configuration is saved in ${BACKUP_DIR}.tar.gz"
echo "Transfer this file to your other workstations and extract it to restore your configuration."