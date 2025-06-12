#!/usr/bin/env bash
# Cleanup and installation script for yo command

# Repository info
REPO_URL="https://raw.githubusercontent.com/54yyyu/yo-cmd/main/yo"
TEMP_DIR="/tmp/yo-install-$$"

# Clean up any existing installations
echo "Cleaning up any existing installations..."
pip3 uninstall -y yo-cmd 2>/dev/null || true

# Function to install dependencies
install_dependencies() {
    echo "Installing dependencies..."
    # Try different ways to install dependencies
    pip3 install google-generativeai || \
    python3 -m pip install google-generativeai || \
    pip install google-generativeai
}

# Download yo executable
download_yo() {
    echo "Downloading yo executable..."
    mkdir -p "$TEMP_DIR"
    if command -v curl &> /dev/null; then
        curl -fsSL "$REPO_URL" -o "$TEMP_DIR/yo"
    elif command -v wget &> /dev/null; then
        wget -q "$REPO_URL" -O "$TEMP_DIR/yo"
    else
        echo "Error: Neither curl nor wget is available. Please install one of them."
        exit 1
    fi
    
    if [ ! -f "$TEMP_DIR/yo" ]; then
        echo "Error: Failed to download yo executable"
        exit 1
    fi
    
    chmod +x "$TEMP_DIR/yo"
    echo "Downloaded yo executable successfully"
}

# Install to destination
install_to_destination() {
    local dest="$1"
    echo "Installing yo to $dest..."
    cp "$TEMP_DIR/yo" "$dest/"
    chmod +x "$dest/yo"
    echo "Installation complete! You can now use the 'yo' command."
}

# Install directly to system bin
install_system() {
    if [ -w "/usr/local/bin" ]; then
        install_to_destination "/usr/local/bin"
        return 0
    elif [ -w "/usr/bin" ]; then
        install_to_destination "/usr/bin"
        return 0
    fi
    return 1
}

# Install to user bin
install_user() {
    local user_bin="$HOME/.local/bin"
    
    # Create directory if it doesn't exist
    if [ ! -d "$user_bin" ]; then
        mkdir -p "$user_bin"
    fi
    
    install_to_destination "$user_bin"
    
    # Add to PATH if needed
    if [[ ":$PATH:" != *":$user_bin:"* ]]; then
        echo "Adding $user_bin to your PATH..."
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
        
        # Set path for current session
        export PATH="$HOME/.local/bin:$PATH"
        echo "Please restart your shell or run 'source ~/.bashrc' or 'source ~/.zshrc' to update your PATH."
    fi
}

# First try to install dependencies
install_dependencies

# Download the yo executable
download_yo

# Now install the script
if ! install_system; then
    echo "Cannot install to system directories, installing to user directory..."
    install_user
fi

# Cleanup
rm -rf "$TEMP_DIR"

echo ""
echo "To set up your API key, run: yo --api"
echo ""
echo "Try out a simple command: yo show me all files in current directory"

# Verify the installation - Check if yo is now in the PATH
echo ""
echo "Checking installation..."
if command -v yo &> /dev/null; then
    echo "✅ 'yo' command is now available in your PATH."
    which yo
else
    echo "⚠️ 'yo' command is not found in your PATH."
    echo "  You may need to restart your terminal or manually add it to your PATH."
    echo "  Please try running 'source ~/.bashrc' or 'source ~/.zshrc' and try again."
fi
