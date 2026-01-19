# PROJECT KNOWLEDGE BASE

**Generated:** 2026-01-20
**Context:** Rime Input Method Configuration (Squirrel/macOS)

## OVERVIEW
Rime (Squirrel) configuration managed via Ansible/Stow. Handles input methods (Bopomofo, Cangjie, etc.), dictionaries, and UI styling for macOS.

## STRUCTURE
```
.
├── *.schema.yaml       # Input method definitions (logic)
├── *.dict.yaml         # Dictionaries (data)
├── *.custom.yaml       # User overrides (patching)
├── squirrel.custom.yaml # UI styling & app-specific settings
├── installation.yaml   # Device ID & sync settings
├── user.yaml           # User state (last used, build time)
├── build/              # [GENERATED] Compiled binaries/data
├── sync/               # [DATA] Synchronization directory
└── trash/              # Archived/deprecated configs
```

## WHERE TO LOOK
| Task | Location | Notes |
|------|----------|-------|
| **Styling/Theme** | `squirrel.custom.yaml` | Active: `kanagawa_dragon`. Font: `jf-openhuninn-2.0`. |
| **App Exceptions** | `squirrel.custom.yaml` | `app_options` (e.g., disable inline for Chrome/Telegram). |
| **Active Schemas** | `user.yaml` | See `var.schema_access_time` for usage history. |
| **Device ID** | `installation.yaml` | Required for sync. |
| **OpenCC** | `opencc/` | Character conversion configs. |

## CONVENTIONS
- **Patching**: ALWAYS use `*.custom.yaml` files. NEVER edit distribution files directly.
- **Theme**: Custom themes defined in `squirrel.custom.yaml` under `preset_color_schemes`.
- **Sync**: User data syncs to `sync/{installation_id}/`.

## ANTI-PATTERNS (THIS PROJECT)
- **Direct Edits**: Do not edit files in `build/`. They are overwritten on deploy.
- **Lua**: No Lua scripts currently used/detected.
- **Trash**: Do not rely on files in `trash/`; they are deprecated.

## COMMANDS
```bash
# Rime is a service; changes require redeploy from menu bar.
# "Deploy" -> Recompiles schemas and applies custom.yaml changes.
# "Sync" -> Syncs user data to/from sync/ directory.
```

## NOTES
- **Fonts**: Requires `jf-openhuninn-2.0` installed for correct rendering.
- **Large Files**: `*.userdb` and `*.dict.yaml` can be massive; managed by git (mostly).
