# yo - Natural Language to Terminal Commands

A command-line tool that converts natural language descriptions into terminal commands using Google's Gemini API. Perfect for:
- People who don't know terminal commands
- Users who've forgotten specific command syntax
- Anyone who wants to quickly execute commands without memorizing syntax

## Features

- Convert natural language to terminal commands with explanations
- Interactive directory selection for commands that require paths
- Command history with explanations
- Customizable configuration
- Easy API key setup

## Installation

### Prerequisites

- Python 3.6 or higher
- Google Gemini API key (https://aistudio.google.com/app/apikey)

### Quick Install

```bash
# One-line install (recommended)
curl -fsSL https://raw.githubusercontent.com/54yyyu/yo-cmd/main/install.sh | sh
```

Or install via npm
```
npm install -g yo-cmd
```

Or clone and install manually
```
git clone https://github.com/54yyyu/yo-cmd.git
cd yo-cmd
./install.sh
```

The installer will:
1. Clean up any existing installations
2. Install the required dependencies (google-generativeai)
3. Copy the 'yo' executable to a directory in your PATH
4. Make the executable runnable

### Manual Installation

If the automatic installer doesn't work for you:

1. Make sure you have the required dependencies:
   ```bash
   pip install google-generativeai
   ```

2. Copy the 'yo' script to a location in your PATH:
   ```bash
   cp yo ~/.local/bin/  # or another directory in your PATH
   chmod +x ~/.local/bin/yo
   ```

## Uninstallation

To uninstall the tool:

```bash
./uninstall.sh
```

This will:
1. Remove the 'yo' executable from your PATH
2. Delete the configuration directory (~/.config/yo)
3. Clean up any pip installations

## Usage

### Basic Usage

```bash
yo show me all hidden files
# Output: ls -la # Shows all files (including hidden ones) with details
```

### Configure API Key

```bash
yo --api
# Prompts for your Google Gemini API key
```

### View Command History

```bash
yo --history
# Shows previous commands with their explanations
```

### Examples

```bash
# Show disk usage
yo how much space is left on my drive

# Find large files
yo find files larger than 100MB

# Create a new directory
yo make a new folder called projects

# Remove files
yo delete all log files

# Display system information
yo show me system information
```

## Configuration

Configuration is stored in `~/.config/yo/config.json`. You can manually edit this file to change settings like the Gemini model being used.

## License

MIT
