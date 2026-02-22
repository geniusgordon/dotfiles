# Nvim Appearance Polish Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Polish the nvim appearance to look intentional and cohesive across bufferline, statusline, and visual chrome.

**Architecture:** Four targeted file edits — no new plugins, no structural changes. Each edit is isolated and independently verifiable by reloading nvim.

**Tech Stack:** Neovim Lua config, lazy.nvim, lualine.nvim, bufferline.nvim, indent-blankline.nvim

---

### Task 1: Configure bufferline

**Files:**
- Modify: `lua/gordon/config/tabline.lua`

**Step 1: Replace the bare setup call**

Open `lua/gordon/config/tabline.lua`. Current content:
```lua
require("bufferline").setup({})
```

Replace entirely with:
```lua
local bufferline = require("bufferline")
bufferline.setup({
  options = {
    style_preset = bufferline.style_preset.minimal,
    separator_style = "thin",
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    show_buffer_close_icons = false,
    show_close_icon = false,
    always_show_bufferline = false,
    offsets = {
      {
        filetype = "NvimTree",
        text = "Explorer",
        highlight = "Directory",
        separator = true,
      },
    },
  },
})
```

**Step 2: Verify**

Reload nvim. Open 2+ files. Expected:
- Tabs separated by thin `|`, no thick powerline arrows
- No `×` close icons on buffers
- Bufferline hidden when only one buffer open
- NvimTree offset shows "Explorer" label aligned with tabs

**Step 3: Commit**

```bash
git add lua/gordon/config/tabline.lua
git commit -m "feat(ui): configure bufferline with minimal style and lsp diagnostics"
```

---

### Task 2: Tighten lualine

**Files:**
- Modify: `lua/gordon/config/statusline.lua`

**Step 1: Remove `progress`, make `encoding` conditional**

In `lua/gordon/config/statusline.lua`, find `lualine_c` and `lualine_y`:

```lua
-- BEFORE
lualine_c = {
  "filename",
  "location",
  "progress",
},
...
lualine_y = { "encoding" },
```

Change to:
```lua
-- AFTER
lualine_c = {
  "filename",
  "location",
},
...
lualine_y = {
  {
    "encoding",
    cond = function()
      return (vim.bo.fileencoding or vim.o.encoding) ~= "utf-8"
    end,
  },
},
```

**Step 2: Verify**

Reload nvim. Expected:
- Statusline `c` section: filename + line:col only, no trailing percentage
- Statusline `y` section: empty for normal utf-8 files; shows encoding only when opening a non-utf-8 file

**Step 3: Commit**

```bash
git add lua/gordon/config/statusline.lua
git commit -m "feat(ui): remove redundant progress from lualine, make encoding conditional"
```

---

### Task 3: Remove end-of-buffer tildes

**Files:**
- Modify: `lua/gordon/config/set.lua`

**Step 1: Add `eob` to fillchars**

In `lua/gordon/config/set.lua`, find the `vim.opt.fillchars` block:

```lua
-- BEFORE
vim.opt.fillchars = {
  diff = " ",
  fold = " ",
}
```

Change to:
```lua
-- AFTER
vim.opt.fillchars = {
  diff = " ",
  fold = " ",
  eob = " ",
}
```

**Step 2: Verify**

Reload nvim. Open any file. Expected:
- Below the last line of the file, the gutter shows blank space instead of `~` tildes

**Step 3: Commit**

```bash
git add lua/gordon/config/set.lua
git commit -m "feat(ui): remove end-of-buffer tilde markers"
```

---

### Task 4: Enable WinSeparator highlight

**Files:**
- Modify: `lua/gordon/lib/theme/init.lua`

**Step 1: Uncomment the WinSeparator line**

In `lua/gordon/lib/theme/init.lua`, inside `setup_highlights`, find:

```lua
-- vim.api.nvim_set_hl(0, "WinSeparator", { fg = colors.line_dark })
```

Uncomment it:
```lua
vim.api.nvim_set_hl(0, "WinSeparator", { fg = colors.line_dark })
```

**Step 2: Verify**

Reload nvim. Open a vertical split (`:vs`). Expected:
- The vertical divider between windows is a subtle but visible line using `line_dark` color
- Not bright/distracting, but clearly present

**Step 3: Commit**

```bash
git add lua/gordon/lib/theme/init.lua
git commit -m "feat(ui): enable WinSeparator highlight for subtle window borders"
```
