# STOW KNOWLEDGE BASE

**Context:** Central Dotfiles Source Directory (`stow/`)

## OVERVIEW
The primary staging area for dotfiles, symlinked directly to `$HOME` using GNU Stow.

## STRUCTURE
All files and directories here mirror the structure of your `$HOME` directory:
- `.config/`          -> `$HOME/.config/` (Application-specific settings)
- `.local/bin/`       -> `$HOME/.local/bin/` (User scripts and binaries)
- `.oh-my-zsh/`       -> `$HOME/.oh-my-zsh/` (Zsh framework, custom themes/plugins)
- `.password-store/`  -> `$HOME/.password-store/` (GPG-encrypted secrets)
- `Library/Rime/`     -> `$HOME/Library/Rime/` (macOS Squirrel input method)
- `.zshrc`, `.vimrc`  -> Root dotfiles in `$HOME`

## WHERE TO LOOK
| Component | Path in `stow/` | Description |
|-----------|-----------------|-------------|
| **Zsh Shell** | `.zshrc` | Main shell config, aliases, and init logic. |
| **Neovim** | `.config/nvim/` | Lua-based IDE configuration. |
| **Tmux** | `.config/tmux/` | Terminal multiplexer settings. |
| **Terminal** | `.config/ghostty/` | Modern terminal emulator config. |
| **Input Method** | `Library/Rime/` | Rime/Squirrel schema and dictionary files. |
| **Scripts** | `.local/bin/` | Task automation and helper scripts. |

## CONVENTIONS
- **Leading Dots**: Files that should be hidden in `$HOME` must have a leading dot here (e.g., `.zshrc`).
- **Monolithic Package**: This directory is treated as a single "stow" package named `stow`.
- **Mirroring**: Maintain a 1:1 directory hierarchy relative to `$HOME`.
- **XDG Compliance**: Prefer placing new configurations in `.config/` over root dotfiles.

## ANTI-PATTERNS
- **Manual Symlinking**: Do not use `ln -s` for files in this directory; let Stow handle it.
- **Multiple Packages**: Avoid splitting dotfiles into multiple stow directories (e.g., `stow-nvim/`, `stow-zsh/`).
- **Direct $HOME Edits**: Never modify the symlink in `$HOME`; always edit the source file in `stow/`.
- **Untracked Secrets**: Do not add raw secrets; use `.password-store/` or `.env` files (ignored).
