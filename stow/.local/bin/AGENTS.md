# CUSTOM UTILITIES

**Generated:** 2026-01-20
**Context:** Custom scripts directory for shell and tool automation.

## OVERVIEW
This directory contains custom utility scripts used to enhance the shell environment and integrate various tools (Claude, Tmux, Fzf). These scripts are symlinked to `~/.local/bin/` via GNU Stow and should be present in the user's `$PATH`.

## STRUCTURE
| Script | Description |
|--------|-------------|
| `claude-statusline.sh` | Formats Claude CLI session metadata (tokens, cost, context) for status lines. |
| `claude-tmux-notify.sh` | Sends macOS notifications for Claude session completion via `terminal-notifier`. |
| `tmux-sessionizer` | A project-aware session manager using `fzf` to jump between workspaces. |

## WHERE TO LOOK
- **AI Integration**: See `claude-*` scripts for logic regarding LLM interaction tracking and notifications.
- **Tmux Workflow**: `tmux-sessionizer` is the core script for managing terminal workspaces across projects.
- **Output Formatting**: `claude-statusline.sh` contains ANSI color codes and `jq` parsing for complex status reporting.

## CONVENTIONS
- **Shebangs**: Every script MUST start with a proper shebang. Prefer `#!/usr/bin/env bash` for portability across macOS and Linux.
- **Executability**: All scripts in this directory must have the executable bit set (`chmod +x`).
- **External Dependencies**: Most scripts rely on external binaries:
  - `jq`: For parsing JSON input (used in Claude scripts).
  - `fzf`: For interactive selection.
  - `terminal-notifier`: For macOS desktop alerts.
  - `tmux`: For session management.

## ANTI-PATTERNS
- **Missing Shebangs**: `claude-tmux-notify.sh` is currently missing a shebang, which can lead to unpredictable execution behavior.
- **Hardcoded Paths**: Avoid absolute paths like `/Users/gordon/`. Use `$HOME` or `~` to ensure scripts work across different machines/users.
- **Implicit Dependencies**: Do not assume a tool is installed without a check if the script is intended to be shared or used in a fresh environment.
