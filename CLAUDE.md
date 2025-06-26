# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed with Ansible and GNU Stow for deploying configuration files across development environments. The repository contains configuration files for development tools, shell environment, and text editors.

## Core Architecture

### Ansible-based Bootstrap
- **Entry point**: `bootstrap.yml` - Ansible playbook that orchestrates the entire setup
- **Roles structure**: Individual roles in `roles/` directory handle specific tools:
  - `package/` - System package management
  - `stow/` - GNU Stow for symlink management
  - `zsh/` - Oh My Zsh shell configuration
  - `nvim/` - Neovim setup
  - `tmux/` - Terminal multiplexer
  - `nodejs/` - Node.js environment
  - `pass/` - Password manager

### Configuration Management
- **Stow directory**: `stow/` contains all dotfiles that get symlinked to home directory
- **Symlink strategy**: Uses GNU Stow to create symlinks from `stow/` to `$HOME`
- **Version control**: Git tracks changes to dotfiles while respecting user data

## Key Commands

### Bootstrap Environment
```bash
# Full environment setup
ansible-playbook ./bootstrap.yml --ask-become-pass
```

### Manual Stow Operations
```bash
# Link dotfiles (from repository root)
stow stow --target $HOME --verbose=2

# Unlink dotfiles
stow -D stow --target $HOME --verbose=2
```

### Development Tools
- **Editor**: `nvim` (aliased from vim/vi)
- **Terminal**: Uses tmux with custom sessionizer script
- **Shell**: zsh with Oh My Zsh framework
- **Session management**: `tmux-sessionizer` script for project navigation

## Configuration Highlights

### Neovim
- Comprehensive configuration in `stow/.config/nvim/`
- Separate CLAUDE.md file exists for Neovim-specific guidance
- Multiple configuration variants supported via NVIM_APPNAME

### Shell Environment
- Custom zsh configuration with development-focused aliases
- Go, Java, Android, and other development environments configured
- Path management for local binaries and tools

### Project Navigation
- `tmux-sessionizer` script for fuzzy-finding and switching between projects
- Searches in `~/Works/firstory/projects`, `~/Playground`, and home directory
- Automatic tmux session creation and management

## File Structure Patterns

### Stow Directory Layout
```
stow/
├── .config/          # XDG config directory files
├── .local/bin/       # Local executables and scripts
├── .zshrc           # Shell configuration
└── Library/Rime/    # Input method configuration
```

### Archive Directory
- `archive/` contains historical configurations for Linux desktop environments
- Includes i3, polybar, GTK themes, and other Linux-specific configurations
- Not actively maintained but preserved for reference

## Development Workflow

### Making Changes
1. Edit files in `stow/` directory
2. Changes are immediately reflected via symlinks
3. Test configurations in current environment
4. Commit changes to version control

### Adding New Configurations
1. Place new dotfiles in appropriate `stow/` subdirectory
2. Ensure proper directory structure matches target locations
3. Re-run stow command to create new symlinks

## Environment Assumptions

- **OS**: macOS (some configurations may work on Linux)
- **Shell**: zsh with Oh My Zsh
- **Terminal**: Supports tmux and modern terminal features
- **Package manager**: Homebrew (for macOS packages)
- **Development**: Go, Java, Node.js, Android development tools