# PROJECT KNOWLEDGE BASE

**Generated:** 2026-01-20
**Context:** Root Dotfiles Repository

## OVERVIEW
Personal dotfiles repository managed with Ansible and GNU Stow. Bootstraps macOS/Linux environments with Zsh, Neovim, Tmux, and dev tools.
**Core Stack:** Ansible (Orchestration), GNU Stow (Symlinks), Zsh (Shell), Lua (Neovim).

## STRUCTURE
```
.
├── bootstrap.yml       # ENTRY POINT: Main Ansible playbook
├── roles/              # Ansible roles (minimalist structure)
├── stow/               # Dotfiles source (symlinked to $HOME)
│   ├── .config/        # XDG configs (nvim, etc)
│   ├── .local/bin/     # Custom scripts
│   ├── .zshrc          # Shell entry point
│   └── Library/Rime/   # Input method config
└── archive/            # Deprecated/Legacy configs
```

## WHERE TO LOOK
| Task | Location | Notes |
|------|----------|-------|
| **Install/Update** | `bootstrap.yml` | Run via `ansible-playbook`. |
| **Shell Aliases** | `stow/.zshrc` | Managed via `antidote` + manual aliases. |
| **Neovim Config** | `stow/.config/nvim/` | Lua-based, lazy.nvim manager. |
| **Scripts** | `stow/.local/bin/` | Custom executables. |
| **Input Method** | `stow/Library/Rime/` | Rime/Squirrel configuration. |
| **Theme Registry** | `stow/.config/themes/` | One `.sh` per theme; `example.sh` is the template. |
| **Switch Theme** | `switch-theme <name>` | Updates Ghostty, tmux (live), persists state. |

## THEME SYSTEM

Active theme stored in `~/.local/state/theme`. On shell start, `.zshrc` reads it, sources the palette `.sh`, and bootstraps generated files if missing.

**Generated files (not stowed):**
- `~/.config/ghostty/theme.conf` — `theme = "..."` for Ghostty
- `~/.config/tmux/active.tmuxtheme` — tmux set-option lines sourced by tmux.conf

**Supported themes:** `catppuccin-mocha`, `tokyonight`, `kanagawa-dragon`

**Adding a new theme (2 files):**
1. Copy `stow/.config/themes/example.sh` → `stow/.config/themes/<name>.sh` — fill palette + `THEME_GHOSTTY_NAME` (verify with `ghostty +list-themes`)
2. Copy `stow/.config/nvim/lua/gordon/lib/theme/example.lua` → `…/theme/<name>.lua` — fill Neovim `ColorPalette`
3. Add `setup_<name>()` and wire into `setup_theme()` in `stow/.config/nvim/lua/gordon/lib/theme/init.lua`
4. Run `switch-theme <name>`

## CONVENTIONS
- **Stow Strategy**: Monolithic `stow/` directory. All files inside map 1:1 to `$HOME`.
- **Ansible Roles**: Minimalist. Only `tasks/main.yml`. No `vars/` or `handlers/`.
- **Package Management**: `homebrew` (macOS) / `apt` (Linux) via `roles/package`.
- **Secrets**: Managed via `pass` (password-store).

## ANTI-PATTERNS (THIS PROJECT)
- **Direct Symlinks**: Do not manually `ln -s`. Use `stow` command or `bootstrap.yml`.
- **Complex Roles**: Do not create full Ansible role structures unless necessary. Keep it simple.
- **Hardcoded Paths**: Use `{{ ansible_env.HOME }}` in playbooks.

## COMMANDS
```bash
# Full Bootstrap
ansible-playbook bootstrap.yml --ask-become-pass

# Manual Stow (Verbose)
stow -v 2 -t ~ stow

# Update Rime (after edit)
/Library/Input\ Methods/Squirrel.app/Contents/MacOS/Squirrel --reload
```

## NOTES
- **Bootstrap Idempotency**: `bootstrap.yml` is safe to re-run.
- **Node.js**: Installed via `n` (using curl|bash pattern - be aware).
