#!/usr/bin/env bash
# Uninstall script for yo command

echo "Uninstalling yo command..."

# Try to find and remove the yo executable
if command -v yo &> /dev/null; then
    YO_PATH=$(which yo)
    echo "Removing yo from $YO_PATH..."
    rm -f "$YO_PATH"
    echo "Removed yo executable."
else
    echo "yo command not found in PATH."
fi

# Clean up configuration files
CONFIG_DIR="$HOME/.config/yo"
if [ -d "$CONFIG_DIR" ]; then
    echo "Removing configuration directory: $CONFIG_DIR"
    rm -rf "$CONFIG_DIR"
    echo "Removed configuration directory."
else
    echo "Configuration directory not found."
fi

# Clean up any existing pip installations
echo "Checking for pip installation..."
pip uninstall -y yo-cmd 2>/dev/null || true

echo "Uninstallation complete."
