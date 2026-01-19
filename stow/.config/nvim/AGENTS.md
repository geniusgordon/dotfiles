# NEOVIM CONFIGURATION KNOWLEDGE BASE

**Generated:** 2026-01-20
**Context:** Neovim Configuration (Lua-based)

## OVERVIEW
Modular Neovim configuration managed with **lazy.nvim**. It focuses on a high-performance IDE experience with heavy emphasis on LSP, Treesitter, and AI-assisted coding (Copilot, Windsurf).

## STRUCTURE
```
.
├── init.lua                # Root entry point
└── lua/gordon/
    ├── init.lua            # Main orchestrator (loads all modules)
    ├── lazy.lua            # lazy.nvim bootstrapper
    ├── config/             # High-level feature configurations
    │   ├── lazy.lua        # PLUGIN LIST & specs
    │   ├── remap.lua       # Core keymaps
    │   ├── set.lua         # Vim options (numbers, tabs, etc)
    │   └── lsp.lua         # LSP entry point
    └── lib/                # Implementation logic & complex setups
        ├── lsp/            # Detailed LSP/DAP configurations
        └── ai/             # AI integration logic
```

## WHERE TO LOOK
| Component | Location | Notes |
|-----------|----------|-------|
| **Plugin List** | `lua/gordon/config/lazy.lua` | Define all plugins here. |
| **Keymaps** | `lua/gordon/config/remap.lua` | Global binds; plugin binds in their config. |
| **LSP Config** | `lua/gordon/lib/lsp/` | Mason, LSP servers, and UI tweaks. |
| **Options** | `lua/gordon/config/set.lua` | Standard Vim `set` options. |
| **Autocmds** | `lua/gordon/config/autocmd.lua` | Event-based logic (highlight on yank, etc). |

## CONVENTIONS
- **Atomic Configs**: Each plugin or feature group has its own file in `lua/gordon/config/`.
- **Logic Separation**: Keep `config/` files focused on settings; move complex logic to `lib/`.
- **Lazy Specs**: Use `lazy.nvim` handler patterns (cmd, ft, keys) to minimize startup time.
- **Which-key Integration**: Register descriptions for complex keymaps.

## ANTI-PATTERNS
- **Monolithic Config**: Do not add settings directly to `lua/gordon/init.lua`.
- **Global Pollution**: Prefer local variables over global `vim.g` where possible.
- **Manual Installs**: Use `Mason` or `lazy.nvim` for all dependencies.
