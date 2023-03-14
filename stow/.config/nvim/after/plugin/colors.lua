-- vim.g.colorscheme = "tokyonight"
vim.g.colorscheme = "catppuccin"
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

require("catppuccin").setup()

function ColorMyPencils()
    -- vim.g.gruvbox_contrast_dark = 'hard'
    -- vim.g.tokyonight_transparent_sidebar = true
    -- vim.g.tokyonight_transparent = true
    vim.opt.background = "dark"

    vim.cmd("colorscheme " .. vim.g.colorscheme)

    local hl = function(thing, opts)
        vim.api.nvim_set_hl(0, thing, opts)
    end

    hl("SignColumn", { bg = "none" })
    hl("GitGutterDelete", { fg = "red", bg = "none" })

    hl("xmlAttrib", { italic = true, fg = "green" })
    hl("typescriptPredefinedType", { link = "String" })
end
ColorMyPencils()
