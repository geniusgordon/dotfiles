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

hi StatusLine cterm=reverse ctermfg=black ctermbg=245
hi StatusLineNC ctermfg=black ctermbg=241
hi User1 ctermfg=247 ctermbg=237
hi User2 ctermfg=249 ctermbg=239
hi User3 ctermfg=251 ctermbg=241
hi User4 ctermfg=235 ctermbg=green
hi User5 ctermfg=235 ctermbg=yellow
hi User6 ctermfg=235 ctermbg=red

function! GetLinterStatus(level) abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  if (l:counts.total == 0)
    return a:level == 0 ? ' OK ' : ''
  elseif (l:all_errors == 0)
    return a:level == 1 ? printf(' %d ', all_non_errors) : ''
  else
    return a:level == 2 ? printf(' %d ', all_errors) : ''
  endif
endfunction

function! LinterStatus() abort
  set statusline+=%4*
  set statusline+=%{GetLinterStatus(0)}
  set statusline+=%5*
  set statusline+=%{GetLinterStatus(1)}
  set statusline+=%6*
  set statusline+=%{GetLinterStatus(2)}
endfunction

function! SetupStatusline() abort
  set statusline=%=
  set statusline+=\ %f%m\ "
  set statusline+=%1*\ %3P\ %2l:\%2c\ "
  set statusline+=%2*\ %{strlen(&ft)?&ft:'none'}\ "
  set statusline+=%3*\ %{toupper(g:currentmode[mode()])}\ %0*"
endfunction

call SetupStatusline()

au WinEnter * call SetupStatusline()
au WinLeave * setl statusline=%=\ %f%m\ "
