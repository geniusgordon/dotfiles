# Nvim Appearance Polish Design

**Date:** 2026-02-23
**Approach:** Option A — Surface-level polish (no new plugins)

## Goal

Make the existing nvim appearance look intentional and cohesive without changing its fundamental character ("polished but balanced").

## Changes

### 1. Bufferline (`lua/gordon/config/tabline.lua`)

Currently `require("bufferline").setup({})` — zero configuration.

Configure with intent:
- `style_preset = minimal` — no thick powerline separators on tabs
- `separator_style = "thin"` — subtle `|` dividers between buffers
- `diagnostics = "nvim_lsp"` — show error/warn count per buffer
- `show_buffer_close_icons = false`, `show_close_icon = false` — no `×` noise
- `always_show_bufferline = false` — hide when only one buffer open
- NvimTree offset so the tree aligns with the tabline

### 2. Lualine (`lua/gordon/config/statusline.lua`)

- Drop `"progress"` from `lualine_c` — redundant alongside `location`
- Make `encoding` in `lualine_y` conditional: only render when encoding ≠ "utf-8"

### 3. fillchars + WinSeparator

**`lua/gordon/config/set.lua`:**
- Add `eob = " "` to `fillchars` — removes `~` tilde markers at end of buffer

**`lua/gordon/lib/theme/init.lua`:**
- Uncomment and configure `WinSeparator` highlight using `colors.line_dark` — subtle but intentional window split border
