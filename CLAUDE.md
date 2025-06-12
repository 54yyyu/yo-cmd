# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

yo-cmd is a Python CLI tool that converts natural language descriptions into terminal commands using Google's Gemini API. The main executable is the `yo` script, which is a Python 3 script that can be installed globally.

## Core Architecture

- **Main executable**: `yo` - A Python 3 script that handles all functionality
- **Dependencies**: Uses `google-generativeai` library for API calls, optional `pyperclip` for clipboard functionality
- **Configuration**: Stores API keys and settings in `~/.config/yo/config.json`
- **History**: Command history stored in `~/.config/yo/history.json`
- **Installation**: Shell scripts (`install.sh`, `uninstall.sh`) handle system-wide installation

## Key Components

### Configuration Management
- `load_config()` and `save_config()` handle API key and model settings
- Default model: `gemini-2.0-flash`
- Config stored in user's home directory under `.config/yo/`

### Command Generation
- `generate_command()` sends prompts to Gemini API
- Strict prompt formatting ensures consistent "command # explanation" output
- Error handling for API failures and invalid responses

### Interactive Features
- Directory selector (`show_directory_selector()`) for commands requiring paths
- Command editing with readline pre-filling
- History management with 100-entry limit

## Installation and Distribution

The tool can be installed via:
1. One-line curl installer (downloads from GitHub)
2. npm global install (via package.json bin field)
3. Manual installation by copying the `yo` script

## Testing and Development

- No formal test suite currently exists
- Manual testing involves running `yo` commands and verifying API integration
- The tool requires a valid Google Gemini API key for functionality

## Common Commands

```bash
# Test the tool
yo list all files

# Configure API key
yo --api

# View command history
yo --history

# Clear history
yo --clear-history

# Use specific model temporarily
yo --model gemini-1.5-flash "show disk usage"
```

## Dependencies

- Python 3.6+ required
- `google-generativeai` library (auto-installed by the tool if missing)
- Optional: `pyperclip` for clipboard functionality