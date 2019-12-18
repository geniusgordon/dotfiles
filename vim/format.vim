au FileType python set formatprg=autopep8\ -

" map alt to  because termite is 7bit
set <M-f>=f

nmap <M-f> gggqG<C-o><C-o>

au FileType javascript,typescript,flow,json nmap <M-f> :PrettierAsync<CR>
au FileType css,scss,less nmap <M-f> :PrettierAsync<CR>
au FileType html,vue,angular nmap <M-f> :PrettierAsync<CR>
au FileType graphql,markdown,yaml nmap <M-f> :PrettierAsync<CR>
