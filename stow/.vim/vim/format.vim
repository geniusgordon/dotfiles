nmap <leader>f gggqG<C-o><C-o>
au FileType javascript.jsx set formatprg=prettier\ --stdin-filepath=file.js
au FileType css set formatprg=prettier\ --stdin-filepath=file.css
au FileType scss set formatprg=prettier\ --stdin-filepath=file.scss
au FileType html set formatprg=prettier\ --stdin-filepath=file.html
au FileType json set formatprg=prettier\ --stdin-filepath=file.json
au FileType markdown set formatprg=prettier\ --stdin-filepath=file.md
au FileType yaml set formatprg=prettier\ --stdin-filepath=file.yaml
