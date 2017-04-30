let g:currentmode = {
    \ 'n'  : 'Normal',
    \ 'no' : 'NO',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V-Line',
    \ '' : 'V-Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S-Line',
    \ '^S' : 'S-Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rv' : 'V-Replace ',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim-Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}

set fillchars=vert:\ ,stl:\ ,stlnc:\ "
set laststatus=2
set noshowmode

hi StatusLine   cterm=reverse ctermfg=235 ctermbg=245
hi StatusLineNC cterm=reverse ctermfg=235 ctermbg=237
hi User1 ctermfg=247 ctermbg=237
hi User2 ctermfg=249 ctermbg=239
hi User3 ctermfg=251 ctermbg=241
au WinEnter * hi User1 ctermfg=247 ctermbg=237
au WinEnter * hi User2 ctermfg=249 ctermbg=239
au WinEnter * hi User3 ctermfg=251 ctermbg=241
au WinLeave * hi User1 ctermfg=245 ctermbg=236
au WinLeave * hi User2 ctermfg=247 ctermbg=238
au WinLeave * hi User3 ctermfg=249 ctermbg=240

set statusline=%=
set statusline+=\ %f%m\ "
set statusline+=%1*\ %3P\ %2l:\%2c\ "
set statusline+=%2*\ %{strlen(&ft)?&ft:'none'}\ "
set statusline+=%3*\ %{toupper(g:currentmode[mode()])}\ %0*"
