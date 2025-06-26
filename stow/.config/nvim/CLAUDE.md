# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Neovim Configuration Architecture

This is a personal Neovim configuration using the Lazy.nvim plugin manager. The configuration follows a modular structure organized around functional areas.

### Core Structure

- `init.lua` - Entry point that loads the `gordon` module
- `lua/gordon/init.lua` - Main configuration loader that requires all modules
- `lua/gordon/lazy.lua` - Lazy.nvim plugin manager setup
- `lua/gordon/config/` - Individual feature configurations
- `lua/gordon/lib/` - Reusable library modules organized by functionality

### Module Organization

The configuration is split into three main areas:

1. **Config modules** (`lua/gordon/config/`): Direct plugin configurations and settings
   - Each file typically corresponds to a specific plugin or feature
   - Examples: `lsp.lua`, `telescope.lua`, `git.lua`, `colors.lua`

2. **Library modules** (`lua/gordon/lib/`): Reusable functionality organized by domain
   - `ai/` - AI integration (Copilot, CopilotChat)
   - `lsp/` - Language Server Protocol setup and configuration
   - `git/` - Git-related functionality
   - `theme/` - Theme and colorscheme management
   - `file-tree/` - File exploration (nvim-tree, oil)
   - `tmux/` - Tmux integration

3. **Plugin definitions** (`lua/gordon/config/lazy.lua`): Lazy.nvim plugin specifications

### Key Plugin Categories

- **LSP**: Mason for LSP server management, nvim-lspconfig, DAP for debugging
- **Completion**: nvim-cmp with multiple sources (LSP, buffer, path, etc.)
- **File Navigation**: Telescope, nvim-tree, oil.nvim, Harpoon
- **Git Integration**: Fugitive, Gitsigns, Diffview, Git Conflict
- **AI**: Copilot.lua, CopilotChat.nvim
- **Testing**: vim-test, vimux
- **Themes**: Catppuccin, Tokyo Night, Kanagawa

## Development Workflow

### Plugin Management
- Uses Lazy.nvim for plugin management
- Plugin specifications are in `lua/gordon/config/lazy.lua`
- Lock file: `lazy-lock.json` tracks exact plugin versions

### Configuration Changes
- Most configurations are in `lua/gordon/config/` directory
- Shared functionality goes in `lua/gordon/lib/` with domain-specific subdirectories
- The main loader (`lua/gordon/init.lua`) requires all necessary modules in dependency order

### LSP Configuration
- LSP setup is modularized in `lua/gordon/lib/lsp/`
- Mason handles LSP server installations
- Custom LSP configurations can be added to `lua/gordon/lib/lsp/lsp.lua`

### Theme Management
- Multiple themes available via `lua/gordon/lib/theme/`
- Theme switching handled in `lua/gordon/config/colors.lua`

## Important Notes

- This configuration assumes macOS/Unix environment (uses tools like tmux-sessionizer)
- Heavy use of Telescope for fuzzy finding
- AI integration with GitHub Copilot
- Database UI integration via vim-dadbod
- Custom CSV handling and LilyPond support for music notation