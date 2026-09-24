# Neovim Mermaid 與 Markdown Table 插件研究

日期：2026-09-23

## 結論

建議先用兩個插件：

1. Mermaid 與完整 Markdown 預覽：`selimacerbas/markdown-preview.nvim`
2. Markdown table 自動對齊：`Kicamon/markdown-table-mode.nvim`

只有需要 Neovim 內的美化顯示時，才重新啟用 `OXY2DEV/markview.nvim`。

選擇標準：

1. 用最少的插件完成 Mermaid 預覽和 table editing。
2. 避免必要的 Node.js、Mermaid CLI 或圖片終端整合。
3. 優先選擇功能範圍清楚的插件。

## 首選組合

### Mermaid：`selimacerbas/markdown-preview.nvim`

它在瀏覽器預覽完整 Markdown。它也把 Mermaid fenced blocks 顯示為互動 SVG。

優點：

- 支援 Mermaid、Markdown tables、KaTeX 和程式碼高亮。
- 不需要 Node.js、npm 或 Mermaid CLI。
- 使用純 Lua HTTP server。
- 支援放大、平移和 SVG 匯出。
- 支援 `.md`、`.mmd` 和 `.mermaid`。

限制：

- 圖表顯示在瀏覽器，不在 Neovim buffer。
- 預設從 CDN 載入前端程式庫，因此一般使用需要網路。

官方安裝設定：

```lua
{
  "selimacerbas/markdown-preview.nvim",
  dependencies = { "selimacerbas/live-server.nvim" },
  opts = {},
}
```

使用命令：

```vim
:MarkdownPreview
:MarkdownPreviewRefresh
:MarkdownPreviewStop
```

來源：

- [官方 README](https://github.com/selimacerbas/markdown-preview.nvim/blob/main/README.md)
- [GitHub repository API](https://api.github.com/repos/selimacerbas/markdown-preview.nvim)
- [最新 release API](https://api.github.com/repos/selimacerbas/markdown-preview.nvim/releases/latest)

### Table editing：`Kicamon/markdown-table-mode.nvim`

它在輸入 `|` 或離開 Insert mode 時，對齊游標所在的 Markdown table。

優點：

- 功能單一，設定小。
- 沒有外部 dependency 或 build 步驟。
- `:Mtm` 可切換 table mode。
- 支援 left、center 和 right alignment。

官方安裝設定：

```lua
{
  "Kicamon/markdown-table-mode.nvim",
  ft = "markdown",
  config = function()
    require("markdown-table-mode").setup()
  end,
}
```

來源：

- [官方 README](https://github.com/Kicamon/markdown-table-mode.nvim/blob/main/README.md)
- [GitHub repository API](https://api.github.com/repos/Kicamon/markdown-table-mode.nvim)

## 現有設定狀態

- `stow/.config/nvim/lua/gordon/config/lazy.lua:210-213` 已啟用 Markview，並設定 `lazy = false`。
- `stow/.config/nvim/lua/gordon/config/markview.lua:1-8` 使用目前的 `markdown.headings` API。
- `stow/.config/nvim/lua/gordon/config/markview.lua:10` 提供 `<leader>mv` keymap。
- `stow/.config/nvim/lua/gordon/init.lua:37` 在 colorscheme 設定後載入 `gordon.config.markview`。
- `stow/.config/nvim/lua/gordon/config/treesitter.lua:25-26` 安裝 `markdown` 和 `markdown_inline` parsers。
- `stow/.config/nvim/lua/gordon/config/autocmd.lua:59-81` 為 Markdown 啟用 wrap 與 table keymap。

Markview 支援 wrap，但官方仍建議使用 nowrap。

目前 Markview 設定把 `headings` 放在 `markdown` 內：

```lua
require("markview").setup({
  markdown = {
    headings = {
      enable = true,
      shift_width = 2,
    },
  },
})
```

來源：

- [Markview 官方 README](https://github.com/OXY2DEV/markview.nvim/blob/main/README.md)
- [Markview Markdown tables](https://github.com/OXY2DEV/markview.nvim/wiki/Markdown#tables)
- [Markview presets](https://github.com/OXY2DEV/markview.nvim/wiki/Presets)

## 選項比較

| 插件 | 主要用途 | 必要項目 | 對此設定的判斷 | 官方來源 |
| --- | --- | --- | --- | --- |
| `selimacerbas/markdown-preview.nvim` | 完整 Markdown、tables 和 Mermaid browser preview | 瀏覽器、`live-server.nvim` | Mermaid 首選。它用一個 preview 涵蓋整份文件。 | [README](https://github.com/selimacerbas/markdown-preview.nvim/blob/main/README.md) |
| `maureyesdev/mermish.nvim` | Mermaid browser preview | Neovim 0.10+、瀏覽器 | 只預覽 Mermaid，不涵蓋完整 Markdown 文件。 | [README](https://github.com/maureyesdev/mermish.nvim/blob/main/README.md) |
| `lancekrogers/mermaider.nvim` | Mermaid 圖片在終端內顯示 | `image.nvim`、Mermaid CLI | 依賴較多。只有需要 buffer 內圖片時才選。 | [README](https://github.com/lancekrogers/mermaider.nvim/blob/main/README.md) |
| `Kicamon/markdown-table-mode.nvim` | 輸入時自動對齊 table source | 沒有已宣告的外部 dependency | Table editing 首選。它只處理必要功能。 | [README](https://github.com/Kicamon/markdown-table-mode.nvim/blob/main/README.md) |
| `MeanderingProgrammer/render-markdown.nvim` | 在 Neovim 內美化 Markdown 和 tables | Tree-sitter Markdown parsers | 與 Markview 重疊。它不提供 Mermaid SVG rendering。 | [README](https://github.com/MeanderingProgrammer/render-markdown.nvim/blob/main/README.md) |
| `jakewvincent/mkdnflow.nvim` | Table、links、tasks 和 notebook navigation | Neovim 0.9.5+ | 功能完整，但只為 table editing 時範圍過大。 | [Table support](https://github.com/jakewvincent/mkdnflow.nvim/blob/main/README.md#-table-support) |
| `OXY2DEV/markview.nvim` | 在 Neovim 內美化 Markdown 和 tables | Neovim 0.10.3+、Markdown parsers | Repo 已有設定。只有需要 buffer 內顯示時才啟用。 | [README](https://github.com/OXY2DEV/markview.nvim/blob/main/README.md) |

## 最小實作順序

1. 安裝 `selimacerbas/markdown-preview.nvim`。
2. 安裝 `Kicamon/markdown-table-mode.nvim`。
3. 已修正並啟用 Markview，提供 buffer 內預覽。
