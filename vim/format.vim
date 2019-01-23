let g:prettier#trailing_comma = 'all'
function! SetupPrettier()
  execute 'set formatprg=prettier\ --stdin\ --single-quote\ --trailing-comma='.g:prettier#trailing_comma
endfunction
function! TogglePrettierTrailingComma()
  let g:prettier#trailing_comma = g:prettier#trailing_comma == 'all' ? 'es5' : 'all'
  call SetupPrettier()
  echo 'prettier#trailing_comma:' g:prettier#trailing_comma
endfunction
au FileType javascript call SetupPrettier()
nmap <leader>, :call TogglePrettierTrailingComma()<CR>

au FileType python set formatprg=autopep8\ -

" map alt to  because termite is 7bit
set <M-f>=f
nmap <M-f> gggqG<C-o><C-o>
au FileType javascript nmap <M-f> :PrettierAsync<CR>
