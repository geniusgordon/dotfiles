# ROLES KNOWLEDGE BASE

**Generated:** 2026-01-20
**Context:** Ansible Roles Directory

## OVERVIEW
Task-based roles that implement the modular logic of the dotfiles environment. Each role is designed to be atomic, focusing on a single component's installation, configuration, or state management.

## STRUCTURE
| Role | Responsibility |
|------|----------------|
| **package** | System-level package installation (APT/Homebrew). |
| **nvim** | Neovim plugin manager (Packer) and initial sync. |
| **zsh** | Zsh shell environment and antidote plugin manager. |
| **tmux** | Tmux configuration and session management. |
| **stow** | GNU Stow execution for symlinking dotfiles. |
| **nodejs** | Node.js installation using the `n` manager. |
| **pass** | Password-store setup and browser extension links. |

## WHERE TO LOOK
Every role follows a strict single-file entry point:
- `roles/<role_name>/tasks/main.yml`

This file contains all the logic for that specific role. There are no other configuration files or sub-directories within the roles.

## CONVENTIONS
- **Minimalist Design**: Only `tasks/main.yml` is permitted. Logic must be kept flat and readable.
- **Idempotency**: All tasks must be safe to run multiple times without changing the system state if already correct.
- **Conditional Execution**: Use `when: ansible_distribution == "..."` to handle cross-platform differences (macOS vs. Linux) within the same task file.
- **Direct Logic**: Prefer built-in Ansible modules over shell scripts unless necessary (e.g., nodejs installation).

## ANTI-PATTERNS
- **Standard Role Layout**: Do NOT create `vars/`, `defaults/`, `handlers/`, `meta/`, or `files/` directories.
- **Global Variables**: Avoid defining variables within roles; use environment variables or facts where possible.
- **Nested Includes**: Do not use `import_tasks` or `include_tasks` to split logic. Keep it in `main.yml`.
- **Complex Logic**: If a role requires complex branching or multiple files, reconsider if it should be simplified.
