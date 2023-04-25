require('nvim-treesitter.configs').setup({
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "comment",
    "cpp",
    "css",
    "diff",
    "dockerfile",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "graphql",
    "html",
    "http",
    "javascript",
    "jsdoc",
    "json",
    "kotlin",
    "latex",
    "lua",
    "passwd",
    "python",
    "ruby",
    "rust",
    "solidity",
    "sql",
    "svelte",
    "swift",
    "terraform",
    "toml",
    "tsx",
    "typescript",
    "lua",
    "vim",
    "vue",
    "yaml",
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})
