local Remap = require("gordon.keymap")
local nmap = Remap.nmap
local xmap = Remap.xmap
local nnoremap = Remap.nnoremap
local xnoremap = Remap.xnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap

nnoremap("<C-k>", ":call CocActionAsync('diagnosticPrevious')<CR>", { silent = true })
nnoremap("<C-j>", ":call CocActionAsync('diagnosticNext')<CR>", { silent = true })

nnoremap("gd", ":call CocActionAsync('jumpDefinition')<CR>", { silent = true })
nnoremap("gy", ":call CocActionAsync('jumpTypeDefinition')<CR>", { silent = true })
nnoremap("gvd", ":call CocActionAsync('jumpDefinition', 'vsplit')<CR>", { silent = true })
nnoremap("gvy", ":call CocActionAsync('jumpTypeDefinition', 'vsplit')<CR>", { silent = true })
nnoremap("gi", ":call CocActionAsync('jumpImplementation')<CR>", { silent = true })
nnoremap("gr", ":Telescope coc references<CR>", { silent = true })

nnoremap("<leader>rn", ":call CocActionAsync('rename')<CR>", { silent = true })

xmap("<leader>f", "<Plug>(coc-format-selected)", { silent = true })
nmap("<leader>f", "<Plug>(coc-format-selected)", { silent = true })


-- Use K to show documentation in preview window.
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
nmap("K", '<CMD>lua _G.show_docs()<CR>', { silent = true })

-- Remap <C-f> and <C-b> for scroll float windows/popups.
local opts = { silent = true, nowait = true, expr = true }
nnoremap("<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
nnoremap("<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

inoremap("<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
inoremap("<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
inoremap("<CR>", 'coc#pum#visible() ? coc#pum#confirm() : "<CR>"', opts)

vnoremap("<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
vnoremap("<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
